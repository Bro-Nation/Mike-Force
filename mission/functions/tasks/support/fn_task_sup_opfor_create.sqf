/*
    File: fn_task_sup_opfor_create.sqf
	Author: Legend
    Public: No

    Description:
        Support task for creating OPFOR units.
		Uses the state machine task system.

    Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

    Returns: nothing

    Example(s):
        Not directly called.
*/

/*
 * Task Parameters:
 *    unitType - "foot", "armor", "rotary", "fixed"
 *    size - "squad", "platoon", "company" for foot; "single", "duo", "column" for armor; etc.
 *    cost - number of sandbags
 * Subtask Parameters:
 * 	  None
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	// First subtask: wait for tower to be built and notify
	[[["wait_for_tower"]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["wait_for_tower", {
	params ["_taskDataStore"];

	if (missionNamespace getVariable ["vn_mf_coms_tower_built_in_ao", false]) exitWith {
		["SUCCEEDED", [["create_units"]]] call _fnc_finishSubtask;
	};
	private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
	private _aoMarker = _activeZones param [0, ""];
	if !(_aoMarker in allMapMarkers) exitWith {};
	private _aoRadius = getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100;

	private _towersInAO = nearestObjects [
		getMarkerPos _aoMarker,
		["Land_vn_ttowersmall_2_f"],
		_aoRadius
	];

	private _builtTowerIdx = _towersInAO findIf {!isNull (_x getVariable ["para_g_building", objNull]) && (_x getVariable ["para_g_building", objNull] getVariable ["para_g_building_constructed", false])};

	if (_builtTowerIdx > -1) then {
		["SUCCEEDED", [["create_units"]]] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["create_units", {
	params ["_taskDataStore"];

	private _unitType = _taskDataStore getVariable "unitType";
	private _size = _taskDataStore getVariable "size";
	private _destination = _taskDataStore getVariable ["supportRequestPos", [0,0,0]];
	if (_destination isEqualTo [0,0,0]) then {
		_destination = _taskDataStore getVariable ["destination", [0,0,0]];
	};
	if (_destination isEqualTo [0,0,0]) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	// Get tower position
	private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
	private _aoMarker = _activeZones param [0, ""];
	if !(_aoMarker in allMapMarkers) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};
	private _aoCenter = markerPos _aoMarker;
	private _aoRadius = getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100;
	private _towersInAO = nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f"], _aoRadius];
	if (count _towersInAO == 0) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};
	private _tower = _towersInAO select 0;
	private _towerPos = getPos _tower;
	private _spawnPos = [_towerPos, 80, 180, 5, 0, 0.5, 0, [], [_towerPos, _towerPos]] call BIS_fnc_findSafePos;

	if (_spawnPos isEqualTo _towerPos) then {
		_spawnPos = _towerPos getPos [120, random 360];
	};

	// Ensure spawn is not too close to alive players.
	private _players = allPlayers select {alive _x};
	private _minDistToPlayer = 125;
	for "_i" from 0 to 10 do {
		if ((_players findIf {_x distance2D _spawnPos < _minDistToPlayer}) isEqualTo -1) exitWith {};
		private _candidate = [_towerPos, 100, 220, 5, 0, 0.5, 0, [], [_towerPos, _towerPos]] call BIS_fnc_findSafePos;
		if !(_candidate isEqualTo _towerPos) then {
			_spawnPos = _candidate;
		};
	};

	if ((_players findIf {_x distance2D _spawnPos < _minDistToPlayer}) > -1) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	private _pickFromPool = {
		params ["_pool", "_count"];
		private _res = [];
		for "_i" from 1 to _count do {
			_res pushBack selectRandom _pool;
		};
		_res
	};

	private _groundTroopPool = [
		"vn_o_men_nva_dc_01",
		"vn_o_men_nva_dc_02",
		"vn_o_men_nva_dc_03",
		"vn_o_men_nva_dc_04",
		"vn_o_men_nva_dc_05",
		"vn_o_men_nva_dc_06",
		"vn_o_men_nva_dc_07",
		"vn_o_men_nva_dc_08",
		"vn_o_men_nva_dc_09",
		"vn_o_men_nva_dc_10",
		"vn_o_men_nva_dc_11",
		"vn_o_men_nva_dc_12",
		"vn_o_men_nva_dc_13",
		"vn_o_men_nva_dc_14",
		"vn_o_men_nva_dc_15",
		"vn_o_men_nva_dc_16",
		"vn_o_men_nva_dc_17",
		"vn_o_men_nva_dc_18"
	];

	private _armorPool = [
		"vn_o_armor_m41_02_vcmf",
		"vn_o_armor_t54b_01_vcmf",
		"vn_o_armor_pt76a_01",
		"vn_o_armor_type63_01"
	];

	private _rotaryPool = [
		"vn_o_air_mi2_04_06",
		"vn_o_air_mi2_04_04",
		"vn_o_air_mi2_04_02"
	];

	private _fixedPool = [
		"vn_o_air_mig21_cap",
		"vn_o_air_mig19_cap"
	];

	// Define unit compositions 
	private _unitConfigs = createHashMapFromArray [
		["foot", createHashMapFromArray [
			["squad", [_groundTroopPool, 10] call _pickFromPool],
			["platoon", [_groundTroopPool, 50] call _pickFromPool],
			["company", [_groundTroopPool, 100] call _pickFromPool],
			// Backward-compatible aliases
			["unit", [_groundTroopPool, 50] call _pickFromPool],
			["battalion", [_groundTroopPool, 100] call _pickFromPool]
		]],
		["armor", createHashMapFromArray [
			["single", [_armorPool, 1] call _pickFromPool],
			["duo", [_armorPool, 2] call _pickFromPool],
			["column", [_armorPool, 3] call _pickFromPool]
		]],
		["rotary", createHashMapFromArray [
			["single", [_rotaryPool, 1] call _pickFromPool],
			["section", [_rotaryPool, 2] call _pickFromPool],
			["flight", [_rotaryPool, 3] call _pickFromPool]
		]],
		["fixed", createHashMapFromArray [
			["single", [_fixedPool, 1] call _pickFromPool],
			["element", [_fixedPool, 2] call _pickFromPool],
			["squadron", [_fixedPool, 3] call _pickFromPool]
		]]
	];

	private _units = (_unitConfigs get _unitType) get _size;
	if (isNil "_units" || {_units isEqualTo []}) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	private _group = createGroup east;

	if (_unitType isEqualTo "foot") then {
		{
			private _unit = _group createUnit [_x, _spawnPos, [], 10, "NONE"];
			_unit setSkill 0.5;
		} forEach _units;
	} else {
		{
			private _vehPos = _spawnPos findEmptyPosition [5, 40, _x];
			if (_vehPos isEqualTo []) then {
				_vehPos = _spawnPos;
			};
			private _veh = createVehicle [_x, _vehPos, [], 0, "NONE"];
			createVehicleCrew _veh;
			{_x setSkill 0.5; _x joinSilent _group;} forEach crew _veh;
		} forEach _units;
	};

	// Command to move to destination
	_group move _destination;

	// Wait for arrival or timeout
	[_group, _destination] spawn {
		params ["_group", "_destination"];
		private _timeout = time + 300; // 5 minutes
		waitUntil {sleep 10; (leader _group) distance _destination < 50 || time > _timeout || {alive _x} count units _group == 0};
		if ({alive _x} count units _group > 0) then {
			// Arrived, perhaps patrol or something
			[_group, _destination, 200] call BIS_fnc_taskPatrol;
		};
	};

	["SUCCEEDED"] call _fnc_finishSubtask;
	["SUCCEEDED"] call _fnc_finishTask;
}];