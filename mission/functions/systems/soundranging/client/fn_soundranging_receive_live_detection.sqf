/*
	File: fn_soundranging_receive_live_detection.sqf
	Author: Tylervip
	Public: No

	Description:
		Refreshes bearing markers on an open sound-ranging map when artillery fires.

	Parameter(s):
		_detection - Latest target detection [ARRAY]

	Returns:
		Nothing
*/
params [["_detection", [], [[]]]];

if (!hasInterface) exitWith {};
if (remoteExecutedOwner isNotEqualTo 2) exitWith {};
if !(missionNamespace getVariable ["vn_mf_soundranging_map_active", false]) exitWith {};

[[_detection]] call vn_mf_fnc_soundranging_update_bearing_markers;
