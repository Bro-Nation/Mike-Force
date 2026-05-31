/*
    File: setup_training_tunnel_console.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds only the training tunnel spawn/replace action to a control object.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        this execVM "training\scripts\tunnel\setup_training_tunnel_console.sqf"
*/

if !(_this isEqualType objNull) exitWith {};

private _target = _this;

if (isNull _target) exitWith {};

_target addAction ["SPAWN NEW TUNNEL", {
    0 = [] execVM "training\scripts\tunnel\spawn_or_replace_training_tunnel.sqf";
}, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)"];
