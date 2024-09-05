/*
	File: fn_task_helpers_counterattack_update_hold_time.sqf
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
Prepare the zone -- get everything ready for the counter-attack phase

Parameter: _taskDataStore (_tds)
*/


params ["_tds"];

// set up the next task(s)
// one of "defend_flag + defend_fob" or "defend_fob" or "defend_zone".

// start our timers
_tds setVariable ["startTime", serverTime];
_tds setVariable ["enemyZoneHeldTime", 0];
_tds setVariable ["lastCheck", serverTime];

[_tds getVariable "holdDuration"] call vn_mf_fnc_tasks_helpers_counterattack_notify_attack_time;

// set up the next batch of tasks.
// doing a series of switch-case pushback statements is tidier / more compact
private _next_tasks = [];

private _fob_exists = _tds getVariable ["fob_exists", false];
private _flag_exists = _tds getVariable ["flag_exists", false];

switch (true) do {
	// NOTE -- flag must be built within an established fob
	case (_fob_exists && _flag_exists) : {
		/*
		Set the publicVariable that allows opfor/bluefor to respectively
		lower/raise the flag as part of the hold action.

		do this as late as possible to ensure opfor cannot lower the flag
		before the counterattack timer actually starts.

		NOTE: public variables are bad. but we we need to pass a variable
		out of the task's scope and locality so there is no other option.

		this variable broadcast only happens once -- when we are switching from
		prepare to the actual defend tasks. so it should not severly impact network
		performance as we do not frequently rebroadcast.
		*/
		vn_mf_bn_dc_target_flag = _tds getVariable "flag";
		publicVariable "vn_mf_bn_dc_target_flag";

		_next_tasks pushBack ["defend_flag", getPos (_tds getVariable "flag")];
		_next_tasks pushBack ["defend_fob", _tds getVariable "attackPos"];
	};
	case (_fob_exists) : {
		_next_tasks pushBack ["defend_fob", _tds getVariable "attackPos"];
	};
	default {
		_next_tasks pushBack ["defend_zone", _tds getVariable "attackPos"];
	};
};


_next_tasks;