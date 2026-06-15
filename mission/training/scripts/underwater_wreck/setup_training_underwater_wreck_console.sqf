/*
    File: setup_training_underwater_wreck_console.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds only the training underwater wreck spawn/replace action to a control object.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\underwater_wreck\setup_training_underwater_wreck_console.sqf"
*/

if !(_this isEqualType objNull) exitWith {};

private _target = _this;

if (isNull _target) exitWith {};

_target addAction ["SPAWN OR REPLACE UNDERWATER WRECKS", {
    0 = [] execVM "training\scripts\underwater_wreck\spawn_or_replace_training_underwater_wreck.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && (([player, 'UDT'] call vn_mf_fnc_player_on_team) || ([player, 'Instructors'] call vn_mf_fnc_player_on_team))"];
