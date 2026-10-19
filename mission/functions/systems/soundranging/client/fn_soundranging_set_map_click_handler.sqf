/*
	File: fn_soundranging_set_map_click_handler.sqf
	Author: Tylervip
	Public: No

	Description:
		Installs or removes the one-shot map-click handler and starts cooldown
		after a guess click is processed.

	Parameter(s):
		_enabled - True to listen for one click, false to remove the listener [BOOL]

	Returns:
		Nothing
*/
params [["_enabled", false, [false]]];

if (!hasInterface) exitWith {};

private _handlerId = missionNamespace getVariable ["vn_mf_soundranging_map_click_handler_id", -1];
if (_handlerId >= 0) then {
	removeMissionEventHandler ["MapSingleClick", _handlerId];
	missionNamespace setVariable ["vn_mf_soundranging_map_click_handler_id", -1];
};

if (!_enabled) exitWith {};

_handlerId = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_position", "_alt", "_shift"];
	[false] call vn_mf_fnc_soundranging_set_map_click_handler;
	[_position] call vn_mf_fnc_soundranging_map_click;
	["start_cooldown"] call vn_mf_fnc_soundranging_map_button;
}];

missionNamespace setVariable ["vn_mf_soundranging_map_click_handler_id", _handlerId];
