/*
	File: fn_tasks_helpers_counterattack_maybe_load_task_time.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Conditionally update the time remaining for the task.

		If the profile DB has data for this zone we've probably
		just had a server restart and need to get the time left
		from the profile db.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns:
		nil

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_maybe_load_task_time;
*/

params ["_tds"];

private _holdTimeRemaining = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_time_get;

// update hold duration. if not previously set the counterattack
// will use the default holdDuration value defined above.
if (_holdTimeRemaining >= 0) then {
	diag_log format [
		"DEBUG: Updating current zone's counterattack time remaining from profile DB: timeS=%1 timeM=%2",
		_holdTimeRemaining,
		_holdTimeRemaining / 60
	];
	_tds setVariable ["holdDuration", _holdTimeRemaining];
};

nil;