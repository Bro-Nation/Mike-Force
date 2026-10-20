/*
	File: fn_soundranging_clear_local_markers.sqf
	Author: Tylervip
	Public: No

	Description:
		Deletes local sound-ranging bearing markers. Confirmed-artillery
		markers remain until their targets are killed or deleted.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!hasInterface) exitWith {};

private _markers = missionNamespace getVariable ["vn_mf_soundranging_markers", []];

{
	deleteMarkerLocal _x;
} forEach _markers;

missionNamespace setVariable ["vn_mf_soundranging_markers", []];
