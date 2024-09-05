/*
	File: fn_task_helpers_counterattack_init.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		initialise the task.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns:
		Position to set the task marker on.

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_init;
*/

params ["_tds"];

private _marker = _tds getVariable "taskMarker";
private _markerPos = getMarkerPos _marker;
private _prepTime = _tds getVariable ["prepTime", 180];

_marker setMarkerColor "ColorYellow";
_marker setMarkerBrush "DiagGrid";

// default attack position is centre of the zone
private _attackPos = _markerPos;
private _areaSize = markerSize _marker;

// search for candidate FOBs within the zone's area.
private _base_search_area = [_markerPos, _areaSize select 0, _areaSize select 1, 0, false];
private _candidate_bases_to_attack = para_g_bases
	inAreaArray _base_search_area
		apply {[_x getVariable "para_g_current_supplies", _x]}
;

// base with most supplies is likely the main fob
_candidate_bases_to_attack sort false;

// candidate FOBs exist
if ((count _candidate_bases_to_attack) > 0) then {

	diag_log format [
		"Counterattack: Co-Ordinates of FOBs within range of counter attack: %1",
		_candidate_bases_to_attack
			apply {getPos (_x # 1)}
	];

	// get the first FOB from the sorted array
	private _base_to_attack = (_candidate_bases_to_attack # 0 ) # 1;
	// overwrite the default attack position
	_attackPos = getPos _base_to_attack;
	_areaSize = [para_g_max_base_radius, para_g_max_base_radius];

	diag_log format [
		"Counterattack: Suitable FOB for attacking discovered: %1",
		_attackPos
	];

	_tds setVariable ["fob_exists", true];

	private _attackObjective = [_attackPos, 5, 5] call para_s_fnc_ai_obj_request_attack;
	_tds setVariable ["attackObjectives", [_attackObjective]];

	// candidate flags can only exist within the established fob

	private _possibleFlags = nearestObjects [
		[
			_attackPos select 0,
			_attackPos select 1
		],
		[
			"vn_flag_usa",
			"vn_flag_aus",
			"vn_flag_arvn",
			"vn_flag_nz"
		],
		para_g_max_base_radius
	];

	// need to check if they are a paradigm built object!
	private _paraBuiltFlags = _possibleFlags
		select {
			not isNull (_x getVariable ["para_g_building", objNull])
		}
	;

	if (count _paraBuiltFlags > 0) then {

		_tds setVariable ["flag_exists", true];

		/*
		shorten the counterattack duration by 15 minutes
		if this is post server restart this value should get overwritten when
		we run `_taskDataStore getVariable "fnc_update_hold_time")` below
		*/

		private _holdDuration = _tds getVariable "holdDuration";
		private _timerReduction = _tds getVariable "flagTimerReduction";

		_tds setVariable ["holdDuration", _holdDuration - _timerReduction];

		private _flagsWithDistance = _paraBuiltFlags
			apply {[_x distance2D _attackPos, _x]}
		;

		_flagsWithDistance sort true;

		private _flag_to_attack = (_flagsWithDistance # 0 ) # 1;

		_tds setVariable ["flag", _flag_to_attack];
		_tds setVariable ["flag_exists", true];

		diag_log format [
			"Counterattack: Suitable flag discovered: %1",
			getPos _flag_to_attack
		];
	};

} else {
	// no fob -- send a bunch of patrols into the zone
	private _attackObjectives = ([1, 5] call vn_mf_fnc_range)
		apply {
			["circle", [_attackPos, _x * 100], 1, 5] call para_s_fnc_ai_obj_request_patrols;
		}
	;
	_tds setVariable ["attackObjectives", _attackObjectives];
};

diag_log format [
	"Counterattack: Co-ordinates for counter attack target: %1",
	_attackPos
];

private _attackTime = serverTime + _prepTime;

[_tds] call vn_mf_fnc_tasks_helpers_counterattack_maybe_load_task_time;

if (_prepTime > 0) then
{
	["CounterAttackPreparing", ["", (_prepTime / 60) toFixed 0]] remoteExec ["para_c_fnc_show_notification", 0];
	[] call vn_mf_fnc_timerOverlay_removeGlobalTimer;
	["Counterattack In", _attackTime, true] call vn_mf_fnc_timerOverlay_setGlobalTimer;
};

// we'll always have one of the "defend_fob" or "defend_zone" tasks active
// both need a red circle around the area that needs defending as players
// must hold that area to complete the task.
[_tds] call vn_mf_fnc_tasks_helpers_counterattack_area_marker_create;

_tds setVariable ["attackTime", _attackTime];
_tds setVariable ["attackPos", _attackPos];
_tds setVariable ["attackAreaSize", _areaSize];

_markerPos;