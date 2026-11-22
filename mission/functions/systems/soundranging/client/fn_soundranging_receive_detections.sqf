/*
	File: fn_soundranging_receive_detections.sqf
	Author: Tylervip
	Public: No

	Description:
		Displays received bearings, synchronizes the guess cooldown, and opens the map.

	Parameter(s):
		_detections - Recent sound-ranging detections [ARRAY]
		_error - Error message from the server [STRING]
		_cooldownUntil - Server cooldown deadline [NUMBER]
		_guessPosition - Accepted map guess position [ARRAY]
		_stateOnly - True when only applying guess state [BOOL]
		_acceptedGuess - True when the server accepted this client's guess [BOOL]

	Returns:
		Nothing
*/
params [
	["_detections", [], [[]]],
	["_error", "", [""]],
	["_cooldownUntil", 0, [0]],
	["_guessPosition", [], [[]]],
	["_stateOnly", false, [false]],
	["_acceptedGuess", false, [false]]
];

if (!hasInterface) exitWith {};
if (remoteExecutedOwner isNotEqualTo 2) exitWith {};

["sync_cooldown", _cooldownUntil] call vn_mf_fnc_soundranging_map_button;

if (_stateOnly) exitWith {
	if (_error isNotEqualTo "") then {
		hint _error;
	};
	if (_acceptedGuess) then {
		[_guessPosition] call vn_mf_fnc_soundranging_map_click;
	};
};

if (_error isNotEqualTo "") exitWith {
	missionNamespace setVariable ["vn_mf_soundranging_map_active", false];
	["hide"] call vn_mf_fnc_soundranging_map_button;
	[] call vn_mf_fnc_soundranging_clear_local_markers;
	hint _error;
};

[] call vn_mf_fnc_soundranging_clear_local_markers;

private _markers = [_detections] call vn_mf_fnc_soundranging_update_bearing_markers;
missionNamespace setVariable ["vn_mf_soundranging_map_active", true];
[] call vn_mf_fnc_soundranging_update_tower_markers;

private _confirmedMarkers = missionNamespace getVariable ["vn_mf_soundranging_confirmed_markers", []];
{
	_x setMarkerAlphaLocal 1;
} forEach _confirmedMarkers;

[false] call vn_mf_fnc_soundranging_set_map_click_handler;
missionNamespace setVariable ["vn_mf_sr_guess_armed", false];
openMap true;
["show"] call vn_mf_fnc_soundranging_map_button;

if (_markers isEqualTo []) then {
	hint parseText "<t size='1.2'>Sound Ranging Net</t><br/><br/>No recent artillery bearings are available.<br/>Bearings remain available for three minutes after a shot.";
} else {
	hint parseText "<t size='1.2'>Sound Ranging Net</t><br/><br/>Orange arrows show bearings from each tower.<br/>Estimate where the bearings cross; no intersection is marked automatically.<br/><br/>Click near a suspected artillery piece (within 25 m) to check it.";
};
