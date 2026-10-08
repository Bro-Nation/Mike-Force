/*
    File: fn_daccong_force_enter_vehicle.sqf
    Author: tylervip
    Public: No

    Description:
    Force a Dac Cong player into a targeted vehicle, even if it is team-locked.

    Parameter(s):
    _vehicle - Vehicle to enter [Object]

    Returns: nothing

    Example(s):
    [_vehicle] call vn_mf_fnc_daccong_force_enter_vehicle;
*/
params [["_vehicle", objNull, [objNull]]];

if (!([player, "DacCong"] call vn_mf_fnc_player_on_team)) exitWith {};
if (isNull _vehicle) exitWith {};
if (!alive _vehicle) exitWith {};
if (!(_vehicle isKindOf "AllVehicles")) exitWith {};

player setVariable ["vn_mf_force_enter_vehicle", _vehicle, false];
player moveInAny _vehicle;

[player, _vehicle] spawn {
    params ["_unit", "_enteredVehicle"];
    uiSleep 0.5;

    _unit setVariable ["vn_mf_force_enter_vehicle", objNull, false];
};
