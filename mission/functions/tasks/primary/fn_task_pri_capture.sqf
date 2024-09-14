/*
	File: fn_task_pri_capture.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to take over a zone - clearing enemy forces out of it.
		Uses the state machine task system.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

/*
 * Task Parameters:
 *    None
 * Subtask Parameters:
 * 	  None
 * Runtime Parameters:
 *    None
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _zone = _taskDataStore getVariable "taskMarker";
	private _zonePosition = getMarkerPos _zone;

	// change the zone's hexagon colour and shading
	_zone setMarkerColor "ColorRed";
	_zone setMarkerBrush "DiagGrid";
	_zone setMarkerAlpha 0.45;

	private _areaMarkerSize = vn_mf_bn_s_zone_radius + 100;

	// custom BN: yellow circle around the AO
	private _areaMarker = createMarker ["activeZoneCircle", _zonePosition];
	_areaMarker setMarkerShape "ELLIPSE";
	_areaMarker setMarkerSize [_areaMarkerSize, _areaMarkerSize];
	_areaMarker setMarkerAlpha 1;
	_areaMarker setMarkerBrush "Border";
	_areaMarker setMarkerColor "ColorYellow";

	private _hqPosition = missionNamespace getVariable ["hqPosition", _zoneposition];
	private _factoryPosition = missionNamespace getVariable ["factoryPosition", _zoneposition];
	_taskDataStore setVariable ["startTime", serverTime];
	_taskDataStore setVariable ["hq_sites_destroyed", false];
	_taskDataStore setVariable ["factory_sites_destroyed", false];

	private _initialTasks = [
		["destroy_hq_sites", _zonePosition getPos [100, 0]],
		["destroy_factory_sites", _zonePosition getPos [100, 90]],
		["build_fob", _zonePosition getPos [100, 180]]
	];

	[_initialTasks] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["destroy_hq_sites", {
	params ["_taskDataStore"];

	private _side_sites_hq = missionNamespace getVariable ["side_sites_hq", []];

	// check each hq site to see if it's been destroyed
	{
		if (isNull _x || !(alive _x)) then
		{
			//remove from list
			_side_sites_hq deleteAt _forEachIndex;
		}
	} forEach _side_sites_hq;

	private _numberOfSites = count _side_sites_hq;
	if (_numberOfSites == 0) exitWith
	{
		_taskDataStore setVariable ["hq_sites_destroyed", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

// TODO: @dijksterhuis: All references to factory need cleaning up at a later date
// https://github.com/Bro-Nation/Mike-Force/pull/400
_taskDataStore setVariable ["destroy_factory_sites", {
	params ["_taskDataStore"];

	// TODO: @dijksterhuis: All references to factory need cleaning up at a later date
	// https://github.com/Bro-Nation/Mike-Force/pull/400
	private _side_sites_factory = missionNamespace getVariable ["side_sites_factory", []];

	//check each site to see if it's destroyed
	{
		if (isNull _x || !(alive _x)) then
		{
			//remove from list
			_side_sites_factory deleteAt _forEachIndex;
		};
	} forEach _side_sites_factory;

	private _numberOfSites = count _side_sites_factory;
	if (_numberOfSites == 0) exitWith
	{
		_taskDataStore setVariable ["factory_sites_destroyed", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["build_fob", {
        params ["_taskDataStore"];

        private _possibleBases = para_g_bases inAreaArray [
		getMarkerPos (_taskDataStore getVariable "taskMarker"),
		selectMax ((getMarkerSize "activeZoneCircle") apply {abs _x}),
		selectMax ((getMarkerSize "activeZoneCircle") apply {abs _x}),
		0
	];

        if !(_possibleBases isEqualTo []) then {
		_taskDataStore setVariable ["fob_built", true];
		/*
		for some reason the AGL conversion for FOB positions
		places them 200m AGL.... which is greater than the
		maximum radius of bases...

		so use 2D positions instead for later nearestObjects
		*/
		private _fobPos3DASL = getPos (_possibleBases select 0);

		_taskDataStore setVariable ["fob", _possibleBases select 0];
		_taskDataStore setVariable ["fob_position_2d", [_fobPos3DASL select 0, _fobPos3DASL select 1]];

		private _nextTasks = [
			["build_respawn", (_taskDataStore getVariable "fob_position_2d") getPos [50, 0]],
			["build_flag", (_taskDataStore getVariable "fob_position_2d") getPos [50, 90]],
			["build_landing_pad", (_taskDataStore getVariable "fob_position_2d") getPos [50, 180]],
			["build_rearm_resupply", (_taskDataStore getVariable "fob_position_2d") getPos [50, 270]]
		];

                ["SUCCEEDED", _nextTasks] call _fnc_finishSubtask;
        };
}];

_taskDataStore setVariable ["_fnc_have_built_buildings", {
	params ["_tds", "_types"];

	private _candidates = nearestObjects [
		_tds getVariable "fob_position_2d",
		_types,
		para_g_max_base_radius
	];

	/*
	need to check if they are a paradigm built object!
	otherwise the objective disappears in places like MSS leghorn
	once FOB is built

	the para_g_building variable is a simple object assigned to
	the actual arma object, housing all the paradigm building variables.
	*/

	private _para_built_object_first_idx = _candidates findIf {not isNull (_x getVariable ["para_g_building", objNull])};

	(_para_built_object_first_idx > -1)
}];


_taskDataStore setVariable ["build_respawn", {
	params ["_tds"];

	private _building_types = [
		"Land_vn_guardhouse_01",
		"Land_vn_b_trench_bunker_01_01",
		"Land_vn_hootch_01_01"
	];
	private _building_exists = [_tds, _building_types] call (_tds getVariable "_fnc_have_built_buildings");

	if (_building_exists) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["build_landing_pad", {
	params ["_tds"];

	private _building_types = ["Land_vn_b_helipad_01"];
	private _building_exists = [_tds, _building_types] call (_tds getVariable "_fnc_have_built_buildings");

	if (_building_exists) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["build_rearm_repair_refuel", {
	params ["_tds"];

	private _building_types = [
		"vn_b_ammobox_supply_07",
		"vn_b_ammobox_supply_08",
		"vn_b_ammobox_supply_09",
		"Land_vn_usaf_fueltank_75_01"
	];
	private _building_exists = [_tds, _building_types] call (_tds getVariable "_fnc_have_built_buildings");

	if (_building_exists) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["build_flag", {
	params ["_tds"];

	private _building_types = [
		"vn_flag_usa",
		"vn_flag_aus",
		"vn_flag_arvn",
		"vn_flag_nz"
	];
	private _building_exists = [_tds, _building_types] call (_tds getVariable "_fnc_have_built_buildings");

	if (_building_exists) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];


_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	if (
		_taskDataStore getVariable ["hq_sites_destroyed", false]
		&& _taskDataStore getVariable ["factory_sites_destroyed", false]
	) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	deleteMarker "activeZoneCircle";
}];
