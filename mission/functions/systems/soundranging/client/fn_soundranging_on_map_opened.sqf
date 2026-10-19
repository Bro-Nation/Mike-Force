/*
	File: fn_soundranging_on_map_opened.sqf
	Author: Tylervip
	Public: No

	Description:
		Shows the sound-ranging map UI when the map opens.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["vn_mf_soundranging_map_active", false]) exitWith {};

["show"] call vn_mf_fnc_soundranging_map_button;
