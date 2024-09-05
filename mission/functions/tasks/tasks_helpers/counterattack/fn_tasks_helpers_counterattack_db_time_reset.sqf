/*
	File: fn_tasks_helpers_counterattack_reset_db_time.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		De-persists the tracking of how long a counterattack phase has left.

	Parameter(s):
		_tds - Task Data Store -- Namespace for storing task info [Object]

	Returns:
		nil

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_reset_db_time;

*/

params ["_tds"];

private _key = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_key;
["DEL", _key] call para_s_fnc_profile_db;

nil;