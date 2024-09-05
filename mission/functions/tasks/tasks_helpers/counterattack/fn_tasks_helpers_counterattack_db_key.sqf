/*
	File: fn_tasks_helpers_counterattack_db_key.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Get the key for the zone where we persist the counterattack time
		remaining.

	Parameter(s):
		_tds - Task Data Store -- Namespace for storing task info [Object]

	Returns:
		nil

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_db_key;

*/

params ["_tds"];
private _zoneName = _tds getVariable "taskMarker";

format ["%1_counterattack_timer", _zoneName];
