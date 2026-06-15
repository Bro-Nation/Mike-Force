/*
    File: setup_training_engineer_range_console.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds an action to clean objects inside marker Engineer.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\engineer_range\setup_training_engineer_range_console.sqf"
*/

if !(_this isEqualType objNull) exitWith {};

private _target = _this;

if (isNull _target) exitWith {};

_target addAction ["CLEAN ENGINEER RANGE", {
    params ["_target"];

    [_target] execVM "training\scripts\engineer_range\cleanup_engineer_range.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"];