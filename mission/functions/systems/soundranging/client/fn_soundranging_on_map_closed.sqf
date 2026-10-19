/*
	File: fn_soundranging_on_map_closed.sqf
	Author: Tylervip
	Public: No

	Description:
		Removes local sound-ranging bearing and confirmed-gun markers when the map closes.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["vn_mf_soundranging_map_active", false]) exitWith {};

missionNamespace setVariable ["vn_mf_soundranging_map_active", false];
[false] call vn_mf_fnc_soundranging_set_map_click_handler;

private _playerMarkers = missionNamespace getVariable ["vn_mf_soundranging_markers", []];
{
	deleteMarkerLocal _x;
} forEach _playerMarkers;
vn_mf_soundranging_markers = [];

private _confirmedMarkers = missionNamespace getVariable ["vn_mf_soundranging_confirmed_markers", []];
{
	deleteMarkerLocal _x;
} forEach _confirmedMarkers;
vn_mf_soundranging_confirmed_markers = [];
