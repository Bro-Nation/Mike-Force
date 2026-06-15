/*
    File: setup_training_engineer_defense_console.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds an action to assign engineer defense start/stop actions to a flag in marker Engineer.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\engineer_defense\setup_training_engineer_defense_console.sqf"
*/

if !(_this isEqualType objNull) exitWith {};

private _target = _this;

if (isNull _target) exitWith {};

_target addAction ["SETUP ENGINEER DEFENSE", {
    0 = [] execVM "training\scripts\engineer_defense\setup_engineer_defense_flag_actions.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"];
