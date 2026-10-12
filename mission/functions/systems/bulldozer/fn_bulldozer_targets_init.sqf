/*
    File: fn_bulldozer_targets_init.sqf
    Author: Tylervip
    Public: yes

    Creates the invisible target vehicles attached to a bulldozer tank and keeps
    their crew aligned to whoever is in the vehicle.

    Parameter(s):
        0: OBJECT - tank
        1: ARRAY - optional position to spawn targets at; defaults to tank position

    Returns:
        ARRAY - created target objects
*/
params ["_tank", ["_spawnPos", []]];

if (isNull _tank) exitWith { [] };

private _targetPos = if (_spawnPos isEqualTo []) then { getPosATL _tank } else { _spawnPos };
_tank setVariable ["vn_mf_bulldozer_target_pos", _targetPos, true];

_tank addEventHandler ["GetIn", {
    params ["_vehicle", "_role", "_unit", "_turret"];

    if (!isServer) exitWith {};
    if (isNull _vehicle || { isNull _unit }) exitWith {};
    if (!alive _vehicle) exitWith {};

    private _cleanupEHSet = _unit getVariable ["vn_mf_bulldozer_last_alive_cleanup_eh", false];
    if !(_cleanupEHSet) then {
        _unit addEventHandler ["Killed", {
            params ["_unit"];
            private _vehicle = vehicle _unit;
            if (isNull _vehicle) exitWith {};
            [_vehicle] call vn_mf_fnc_bulldozer_targets_cleanup_if_last_alive;
        }];
        _unit setVariable ["vn_mf_bulldozer_last_alive_cleanup_eh", true, false];
    };

    private _side = side group _unit;
    if (_side == sideUnknown) exitWith {};

    private _targets = _vehicle getVariable ["invisTargets", []];
    if (_targets isEqualTo []) then {
        private _pos = _vehicle getVariable ["vn_mf_bulldozer_target_pos", getPosATL _vehicle];
        [_vehicle, _side, _pos] call vn_mf_fnc_bulldozer_targets_create;
    } else {
        [_vehicle, _side] call vn_mf_fnc_bulldozer_targets_sync;
    };
}];

_tank addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];

    if (!isServer) exitWith {};
    if (isNull _vehicle) exitWith {};

    [_vehicle] call vn_mf_fnc_bulldozer_targets_cleanup_if_last_alive;
}];