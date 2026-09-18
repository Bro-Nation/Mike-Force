
/*
    File: setup_flag_visibility_console.sqf
    Author: Spade
    Public: Yes

    Description:
         Adds a flag visibility console to a control object.
        Instructors can toggle flag_alt_X / flag_suc_X visibility
        between alternating, successive, all, or none.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\flags\setup_flag_visibility_console.sqf";
*/

if !(_this isEqualType objNull) exitWith {};
private _target = _this;
if (isNull _target) exitWith {};

_target addAction ["SETUP FLAG VISIBILITY", {
    params ["_target"];
    [_target] execVM "training\scripts\flags\setup_flag_visibility_actions.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"];
