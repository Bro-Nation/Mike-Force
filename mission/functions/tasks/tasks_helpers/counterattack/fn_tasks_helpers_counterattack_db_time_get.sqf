/*
	File: fn_tasks_helpers_counterattack_get_db_time.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Persists the time left on a zone's counterattack phase in the profile DB.

	Parameter(s):
		_tds - Task Data Store -- Namespace for storing task info [Object]

	Returns:
		nil

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_get_db_time;

*/

params ["_tds"];

private _key = [_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_key;
["GET", _key, -1] call para_s_fnc_profile_db params ["", "_value"];

_value;