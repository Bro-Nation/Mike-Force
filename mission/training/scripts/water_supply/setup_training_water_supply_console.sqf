/*
    File: setup_training_water_supply_console.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds only the training water supply spawn/replace action to a control object.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\water_supply\setup_training_water_supply_console.sqf"
*/

if !(_this isEqualType objNull) exitWith {};

private _target = _this;

if (isNull _target) exitWith {};

_target addAction ["SPAWN OR REPLACE WATER SUPPLY", {
    0 = [] execVM "training\scripts\water_supply\spawn_or_replace_training_water_supply.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"];
