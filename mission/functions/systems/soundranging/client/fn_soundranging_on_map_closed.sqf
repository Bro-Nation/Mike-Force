/*
	File: fn_soundranging_on_map_closed.sqf
	Author: Tylervip
	Public: No

	Description:
		Removes local sound-ranging markers and the guess button when the map closes.
		Leaves the guess cooldown active.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!hasInterface) exitWith {};

missionNamespace setVariable ["vn_mf_soundranging_map_active", false];
["hide"] call vn_mf_fnc_soundranging_map_button;
[] call vn_mf_fnc_soundranging_clear_local_markers;
