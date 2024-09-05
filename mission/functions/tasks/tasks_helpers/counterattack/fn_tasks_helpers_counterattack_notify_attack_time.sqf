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
Method to Check if the AI are overruning the area etc.

Parameters: _tasDataStore (_tds)
*/

params ["_timeRemaining"];

["CounterAttackImminent", [(_timeRemaining / 60) toFixed 0]] remoteExec ["para_c_fnc_show_notification", 0];
[] call vn_mf_fnc_timerOverlay_removeGlobalTimer;
["Counter Attack", serverTime + _timeRemaining, true] call vn_mf_fnc_timerOverlay_setGlobalTimer;

nil;