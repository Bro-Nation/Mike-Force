/*
    File: setup_training_formation_sign_console.sqf
    Author: Spade
    Public: Yes

    Description:
        Adds a formation sign setup action to a control object.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\formations_range\setup_training_formation_sign_console.sqf";
*/

if !(_this isEqualType objNull) exitWith {};
private _target = _this;
if (isNull _target) exitWith {};

_target addAction ["SETUP FORMATION SIGN", {
    params ["_target"];
    [_target] execVM "training\scripts\formations_range\setup_formation_sign_actions.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"];
