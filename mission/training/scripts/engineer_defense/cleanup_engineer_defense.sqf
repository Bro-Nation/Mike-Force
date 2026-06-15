/*
    File: cleanup_engineer_defense.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Resets engineer defense training runtime state.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] call compile preprocessFileLineNumbers "training\scripts\engineer_defense\cleanup_engineer_defense.sqf"
*/

if (!isServer) exitWith {};

private _enemyUnits = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_units", []];
private _enemyGroup = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_group", grpNull];
private _enemyGroups = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_groups", []];

{
    if (!isNull _x) then {
        deleteVehicle _x;
    };
} forEach _enemyUnits;

if (!isNull _enemyGroup) then {
    {
        if (!isNull _x) then {
            deleteVehicle _x;
        };
    } forEach units _enemyGroup;
    deleteGroup _enemyGroup;
};

{
    if (!isNull _x) then {
        {
            if (!isNull _x) then {
                deleteVehicle _x;
            };
        } forEach units _x;
        deleteGroup _x;
    };
} forEach _enemyGroups;

missionNamespace setVariable ["vn_mf_training_engineer_defense_active", false, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_target", objNull, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_end_time", -1, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_units", [], true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_group", grpNull, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_groups", [], true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_last_spawn_center", [], true];