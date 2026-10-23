/*
    fn_sling_summary.sqf

    Author: TernaryOperator

    Prints a one-line summary of the Advanced Sling Loading (ASL) ropes and cargo
    on the vehicle the given player is in (or, if on foot, the nearest ASL
    helicopter within 20 m), using systemChat on that player's
    machine only.

    Params:
        _player          (OBJECT) - player to show the summary to
                                   Default: player
        _action          (STRING) - label placed at the start of the message,
                                   e.g. "shorten" or "extend"
                                   Default: "" (no prefix)

    Returns:
        NOTHING - the result is shown via systemChat, not returned

    Behaviour:

        Output example (one single systemChat line):

            shorten: Rope 1: Huron | Rope 2: None

        Every deployed rope set is listed as "Rope N: <cargo>".
        Rope sets with nothing attached show "None" as the cargo.
        N is the rope slot (1 = first/front slot).
        Cargo is shown by its config displayName, falling back to its classname.

        Not in a vehicle and no ASL helicopter within 20 m
                          -> "Sling summary: not in a vehicle"
        On foot within 20 m of an ASL helicopter
                          -> summary of that helicopter's ropes
        No ropes deployed -> "Sling summary: no ropes deployed"

    IMPORTANT:

        The summary is only ever shown to _player. If the function is not local to
        that player, it re-executes itself on the player's machine so nobody else
        sees the message.

        Reads the "ASL_Ropes" and "ASL_Cargo" variables set by Advanced Sling Loading.

    Usage:

        [player, "action"] call vn_mf_fnc_sling_summary; // when local
        [_somePlayer, "extend"] remoteExecCall ["vn_mf_fnc_sling_summary", _somePlayer];  // from the server

    Locality:

        Safe to call on any machine. Does nothing on machines without an interface
        (e.g. a dedicated server) after forwarding.
*/

params [["_player", player, [objNull]], ["_action", "", [""]]];

if (isNull _player) exitWith {};

// Run on the target player's machine so systemChat is local to them
if (!local _player) exitWith {
	[_player, _action] remoteExecCall [_fnc_scriptName, _player];
};

if (!hasInterface) exitWith {};

private _vehicle = vehicle _player;

// On foot: summarise the nearest ASL helicopter within 20 m, if there is one
// (silent lookup so we never spam "No ASL Support" messages from a read-only summary)
if (_vehicle isEqualTo _player) then {
    private _nearHeli = [_player, true, true] call vn_mf_fnc_valid_state_for_asl;

    if (!isNull _nearHeli) then {
        _vehicle = _nearHeli;
    };
};

// Optional action label placed at the start of the message
private _prefix = if (_action isEqualTo "") then { "" } else { _action + ": " };

if (_vehicle isEqualTo _player) exitWith {
	systemChat (_prefix + "Sling summary: not in a vehicle");
};

private _allRopes = _vehicle getVariable ["ASL_Ropes", []];
private _allCargo = _vehicle getVariable ["ASL_Cargo", []];
private _parts = [];

{
	private _ropes = _x;
	private _cargo = _allCargo param [_forEachIndex, objNull];

	// Any deployed rope set is listed, with or without cargo
	if (count _ropes > 0) then {
		if (isNull _cargo) then {
			_parts pushBack format ["Rope %1: None", _forEachIndex + 1];
		} else {
			// Human readable cargo name from config, falling back to classname
			private _cargoName = getText (configOf _cargo >> "displayName");
			if (_cargoName isEqualTo "") then { _cargoName = typeOf _cargo; };

            // Some of the human readable names for objects are stupidly long, cap them at 16 plus ...
            if (count _cargoName > 16) then {
                _cargoName = (_cargoName select [0, 16]) + "...";
            };

			_parts pushBack format ["Rope %1: %2", _forEachIndex + 1, _cargoName];
		};
	};
} forEach _allRopes;

if (_parts isEqualTo []) then {
	systemChat (_prefix + "Sling summary: no ropes deployed");
} else {
	// Single systemChat message with all ropes concatenated
	systemChat (_prefix + (_parts joinString " | "));
};