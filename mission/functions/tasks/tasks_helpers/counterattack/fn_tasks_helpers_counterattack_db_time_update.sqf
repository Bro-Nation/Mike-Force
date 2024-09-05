/*
	File: fn_tasks_helpers_counterattack_update_db_time.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Persists the time left on a zone's counterattack phase in the profile DB.

	Parameter(s):
		_tds - Task Data Store -- Namespace for storing task info [Object]

	Returns:
		nil

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_update_db_time;

*/

params ["_tds"];

private _startTime = _tds getVariable "startTime";
private _endTime = _startTime + (_tds getVariable "holdDuration");

private _key = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_key;
["SET", _key, _endTime - serverTime] call para_s_fnc_profile_db;

nil;