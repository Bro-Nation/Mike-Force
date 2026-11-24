/*
    File: setup_training_sea_mines_console.sqf
    Author: spade
    Description: Adds the independent training sea mine spawn and clear actions.
*/

// Eden object init:
// this execVM "training\scripts\sea_mines\setup_training_sea_mines_console.sqf";
if (!hasInterface || {!(_this isEqualType objNull)} || {isNull _this}) exitWith {};
private _target = _this;

[
    _target,
    "vn_mf_training_action_spawn_sea_mines",
    "SPAWN OR REPLACE SEA MINES", {
    [] execVM "training\scripts\sea_mines\spawn_or_replace_training_sea_mines.sqf";
}, nil, 5, true, true, "", "(_this distance _target < 5) && ([_this, 'Instructors'] call vn_mf_fnc_player_on_team)"
] call vn_mf_fnc_action_addAction;

[
    _target,
    "vn_mf_training_action_clear_sea_mines",
    "CLEAR TRAINING SEA MINES", {
    [] execVM "training\scripts\sea_mines\cleanup_training_sea_mines.sqf";
}, nil, 4, true, true, "", "(_this distance _target < 5) && ([_this, 'Instructors'] call vn_mf_fnc_player_on_team)"
] call vn_mf_fnc_action_addAction;
