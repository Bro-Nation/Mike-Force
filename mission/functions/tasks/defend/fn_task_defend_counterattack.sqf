/*
	File: fn_task_counterattack.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to defend a zone against an enemy attack, and clear out nearby entrenchments.
		Uses the state machine task system.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

/*
	Requires Task Variables:
*/

params ["_taskDataStore"];

/*
Constants
*/
_taskDataStore setVariable ["holdDuration", 40 * 60];
_taskDataStore setVariable ["flagTimerReduction", 10 * 60];
_taskDataStore setVariable ["failureDuration", 5 * 60];

/*
Initialise the task

Parameter: _taskDataStore (_tds), with prep_time set as a Variable.
*/
_taskDataStore setVariable ["INIT", {
	params ["_tds"];
	private _taskPos = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_init;
	[[["prepare_zone", _taskPos]]] call _fnc_initialSubtasks;
}];

/*
Prepare the zone -- get everything ready for the counter-attack phase

Parameter: _taskDataStore (_tds)
*/
_taskDataStore setVariable ["prepare_zone", {
	params ["_tds"];

	// wait three minutes (180 seconds)
	if (_tds getVariable "attackTime" > serverTime) exitWith {};

	private _next_tasks = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_prepare_zone;
	["SUCCEEDED", _next_tasks] call _fnc_finishSubtask;
}];


/*
no one built a FOB, so AI are just going to move to the centre of the zone

parameters: _taskDataStore (_tds)
*/
_taskDataStore setVariable ["defend_zone", {
	params ["_tds"];

	private _status = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_defend_area_condition_check;

	if (_status == "FAILED") exitWith {
		["CounterAttackExtended"] remoteExec ["para_c_fnc_show_notification", 0];
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;

		// force reset the DB timer to -1
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_reset;
	};

	if (_status == "SUCCESS") exitWith {
		_tds setVariable ["zoneDefended", true];
		["SUCCEEDED"] call _fnc_finishSubtask;

		// force reset the DB timer to -1
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_reset;
	};

	// still running -- save current time remaining to the profile DB
	[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_update;

}];

/* 
just a duplicate of defend base, but using different config title

parameters: _taskDataStore (_tds)
*/
_taskDataStore setVariable ["defend_fob", {
	params ["_tds"];

	private _status = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_defend_area_condition_check;

	if (_status == "FAILED") exitWith {
		["CounterAttackExtended"] remoteExec ["para_c_fnc_show_notification", 0];
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;

		// force reset the DB timer to -1
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_reset;
	};

	if (_status == "SUCCESS") exitWith {
		_tds setVariable ["zoneDefended", true];
		["SUCCEEDED"] call _fnc_finishSubtask;

		// force reset the DB timer to -1
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_reset;
	};

	// still running -- save current time remaining to the profile DB
	[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_update;

}];

/*
Add the flag objective as a possible failure condition
while also tracking the same AI objective chance as before

parameters: _taskDataStore (_tds)
*/
_taskDataStore setVariable ["defend_flag", {
	params ["_tds"];

	private _flag = _tds getVariable "flag";

	/*
	failure -- flag object has been deleteVehicle'd

	occurs when either 
	- Dac Cong full lowered the flag through the action (deleteVehicle'd)
	- the flag has been hammered out of existence (Bluefor tried to be clever)
	- a zeus has deleted the flag (badAdmin)
	*/

	if (isNull _flag || isNil "vn_mf_bn_dc_target_flag") exitWith {

		call vn_mf_fnc_tasks_helpers_counterattack_reset_flag_vars;

		["CounterAttackExtended"] remoteExec ["para_c_fnc_show_notification", 0];
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;

		// unpersist the tracking of timer
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_reset;
	};
}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_tds"];
	if (_tds getVariable ["zoneDefended", false]) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	params ["_tds"];

	(_tds getVariable "attackObjectives")
		apply {[_x] call para_s_fnc_ai_obj_finish_objective}
	;

	deleteMarker (_tds getVariable ["CircleAreaMarkerName", "activeDefendCircle"]);

	// do this yet again just in case someone tries to complete tasks via commands
	call vn_mf_fnc_tasks_helpers_counterattack_reset_flag_vars;

	// unpersist the tracking of timer
	[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_reset;

}];
