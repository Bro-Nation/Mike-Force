/*
    File: fn_bulldozer_targets_cleanup_if_last_alive.sqf
    Author: Tylervip
    Public: yes

    Checks whether the bulldozer has any alive crew left. If not, removes the
    attached invisible targets and clears the vehicle's target variable.

    Parameter(s):
        0: OBJECT - tank

    Returns:
        BOOLEAN - true when cleanup was triggered, false otherwise
*/
params ["_vehicle"];

if (isNull _vehicle) exitWith { false };
if (!isServer) exitWith { false };

private _aliveCrew = (crew _vehicle) select {
    !isNull _x && { alive _x }
};

if !(_aliveCrew isEqualTo []) exitWith { false };

[_vehicle] call vn_mf_fnc_bulldozer_targets_cleanup;
true
