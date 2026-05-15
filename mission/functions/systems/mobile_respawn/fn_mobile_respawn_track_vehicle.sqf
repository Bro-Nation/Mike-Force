/*
    File: fn_mobile_respawn_track_vehicle.sqf
    Author: tylervip
    Public: yes

    Description:
        Adds supported M577 vehicles to the mobile respawn tracking list.

    Parameter(s):
        _vehicle - Vehicle to evaluate for tracking [Object]

    Returns: nothing

    Example(s): none
*/

params ["_vehicle"];

if ((typeOf _vehicle) find "vn_b_armor_m577_01" == 0) then {
    vn_mf_m577_tracked_vehicles = (missionNamespace getVariable ["vn_mf_m577_tracked_vehicles", []]) + [_vehicle];
    [_vehicle] call vn_mf_fnc_mobile_respawn_add_supplies;
};
