/*
	File: fn_tasks_helpers_counterattack_area_marker_delete.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Create a red area circle indicating the area that players need to hold.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_area_marker_delete;
*/

params ["_tds"];

deleteMarker (_tds getVariable ["CircleAreaMarkerName", "activeDefendCircle"]);


nil;