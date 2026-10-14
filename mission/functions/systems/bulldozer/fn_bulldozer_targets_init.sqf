/*
    File: fn_bulldozer_targets_init.sqf
    Author: Tylervip
    Public: yes

    Creates the invisible target vehicles attached to a bulldozer tank and keeps
    their crew aligned to whoever is in the vehicle.

    Why: the M113 has no crew of its own, so AI cannot "see" it as a valid target.
    The invisible armed-side targets give AI something to detect and engage.

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

    // Store the EH id so it can be removed on GetOut (prevents stacking)
    private _ehId = _unit getVariable ["vn_mf_bulldozer_last_alive_cleanup_eh", -1];
    if (_ehId < 0) then {
        _ehId = _unit addEventHandler ["Killed", {
            params ["_unit"];
            private _vehicle = vehicle _unit;
            if (isNull _vehicle) exitWith {};
            [_vehicle] call vn_mf_fnc_bulldozer_targets_cleanup_if_last_alive;
        }];
        _unit setVariable ["vn_mf_bulldozer_last_alive_cleanup_eh", _ehId, false];
    };

    private _side = side group _unit;
    if (_side == sideUnknown) exitWith {};

    if (!alive _vehicle) exitWith {};

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

    if (!isNull _unit) then {
        private _ehId = _unit getVariable ["vn_mf_bulldozer_last_alive_cleanup_eh", -1];
        if (_ehId >= 0) then {
            _unit removeEventHandler ["Killed", _ehId];
            _unit setVariable ["vn_mf_bulldozer_last_alive_cleanup_eh", -1, false];
        };
    };

    [_vehicle] call vn_mf_fnc_bulldozer_targets_cleanup_if_last_alive;
}];