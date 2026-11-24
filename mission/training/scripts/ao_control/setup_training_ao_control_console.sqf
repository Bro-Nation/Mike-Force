/*
    File: setup_training_ao_control_console.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds AO selection actions to a control object.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\ao_control\setup_training_ao_control_console.sqf"
*/

if !(_this isEqualType objNull) exitWith {};

private _target = _this;

if (isNull _target) exitWith {};

[
    _target,
    "vn_mf_training_action_active_ao_tam_pep",
    "SET ACTIVE AO: TAM PEP", {
    params ["", "", "", "_zoneMarker"];
    [_zoneMarker] execVM "training\scripts\ao_control\switch_active_training_ao.sqf";
}, "zone_tam_pep", 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"
] call vn_mf_fnc_action_addAction;

[
    _target,
    "vn_mf_training_action_active_ao_can_tho",
    "SET ACTIVE AO: CAN THO", {
    params ["", "", "", "_zoneMarker"];
    [_zoneMarker] execVM "training\scripts\ao_control\switch_active_training_ao.sqf";
}, "zone_can_tho", 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"
] call vn_mf_fnc_action_addAction;

[
    _target,
    "vn_mf_training_action_active_ao_hanoi_city",
    "SET ACTIVE AO: HANOI CITY", {
    params ["", "", "", "_zoneMarker"];
    [_zoneMarker] execVM "training\scripts\ao_control\switch_active_training_ao.sqf";
}, "zone_hanoi_city", 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"
] call vn_mf_fnc_action_addAction;
