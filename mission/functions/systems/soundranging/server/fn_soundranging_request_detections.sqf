/*
	File: fn_soundranging_request_detections.sqf
	Author: Tylervip
	Public: No

	Description:
		Validates sound-ranging requests, returns recent detections, and arbitrates map guesses.

	Parameter(s):
		_radio - Sound-ranging radio object [OBJECT]
		_caller - Player requesting detections [OBJECT]
		_guessPosition - Optional map guess position [ARRAY]
		_isGuess - True when submitting a map guess [BOOL]

	Returns:
		Nothing
*/
params [
	["_radio", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_guessPosition", [], [[]]],
	["_isGuess", false, [false]]
];

if (!isServer) exitWith {};

if (isNull _caller || {!isPlayer _caller} || {owner _caller isNotEqualTo remoteExecutedOwner}) exitWith {};

if (_isGuess) exitWith {
	private _cooldownUntil = missionNamespace getVariable ["vn_mf_sr_guess_cooldown_until", 0];
	private _validPosition = count _guessPosition >= 2;
	if (_validPosition) then {
		{
			if !(_x isEqualType 0) exitWith {
				_validPosition = false;
			};
		} forEach _guessPosition;
	};

	private _guessError = "";
	if (!alive _caller) then {
		_guessError = "You must be alive to make a sound-ranging guess.";
	};
	if (
		_guessError isEqualTo ""
		&& {(_caller getVariable ["vn_mf_db_player_group", "MikeForce"]) isNotEqualTo "QuarterHorse"}
	) then {
		_guessError = "Only Black Horse operators can use the sound-ranging net.";
	};
	if (
		_guessError isEqualTo ""
		&& {!(_caller getVariable ["vn_mf_soundranging_guess_access", false])}
	) then {
		_guessError = "Request the sound-ranging net from an AN/VRC-12 radio before making a guess.";
	};
	if (_guessError isEqualTo "" && {!_validPosition}) then {
		_guessError = "No valid map position was selected.";
	};

	if (_guessError isNotEqualTo "") exitWith {
		[[], _guessError, _cooldownUntil, [], true, false] remoteExec ["vn_mf_fnc_soundranging_receive_detections", _caller];
	};

	if (serverTime < _cooldownUntil) exitWith {
		[[], "", _cooldownUntil, [], true, false] remoteExec ["vn_mf_fnc_soundranging_receive_detections", _caller];
	};

	_cooldownUntil = serverTime + 60;
	missionNamespace setVariable ["vn_mf_sr_guess_cooldown_until", _cooldownUntil];

	[[], "", _cooldownUntil, [], true, false] remoteExec ["vn_mf_fnc_soundranging_receive_detections", 0];
	[[], "", _cooldownUntil, _guessPosition, true, true] remoteExec ["vn_mf_fnc_soundranging_receive_detections", _caller];
};

private _reply = {
	params ["_player", "_detections", "_message"];
	private _cooldownUntil = missionNamespace getVariable ["vn_mf_sr_guess_cooldown_until", 0];
	[_detections, _message, _cooldownUntil] remoteExec ["vn_mf_fnc_soundranging_receive_detections", _player];
};

if ((_caller getVariable ["vn_mf_db_player_group", "MikeForce"]) isNotEqualTo "QuarterHorse") exitWith {
	[_caller, [], "Only Black Horse operators can access the sound-ranging net."] call _reply;
};

if (!alive _caller) exitWith {
	[_caller, [], "You must be alive to use the sound-ranging net."] call _reply;
};

if (isNull _radio || {!alive _radio} || {(typeOf _radio) isNotEqualTo "vn_b_prop_vrc12"}) exitWith {
	[_caller, [], "This is not a sound-ranging radio."] call _reply;
};

private _building = _radio getVariable ["para_g_building", objNull];
if (
	isNull _building
	|| {(_building getVariable ["para_g_buildclass", ""]) isNotEqualTo "vn_b_prop_vrc12"}
	|| {!(_radio in (_building getVariable ["para_g_objects", []]))}
) exitWith {
	[_caller, [], "This radio is not connected to the sound-ranging net."] call _reply;
};

if !(_building getVariable ["para_g_building_constructed", false]) exitWith {
	[_caller, [], "The sound-ranging radio is not fully built."] call _reply;
};

if !(_building getVariable ["para_s_building_functional", false]) exitWith {
	[_caller, [], "The sound-ranging radio is not functional."] call _reply;
};

if (_caller distance2D _radio > 5) exitWith {
	[_caller, [], "Move closer to the sound-ranging radio."] call _reply;
};

private _cutoff = serverTime - 180;
private _detections = missionNamespace getVariable ["vn_mf_soundranging_detections", []];
_detections = _detections select {(_x # 0) > _cutoff};

_caller setVariable ["vn_mf_soundranging_guess_access", true];
[_caller, _detections, ""] call _reply;
