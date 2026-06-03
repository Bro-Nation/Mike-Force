/*
    File: spawn_or_replace_training_water_supply.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Training water supply button entry point.
        Runs on server, removes any previous training water supply instance,
        then spawns a new one.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\water_supply\spawn_or_replace_training_water_supply.sqf"
*/

private _cleanupScript = "training\scripts\water_supply\cleanup_training_water_supply.sqf";
private _spawnScript = "training\scripts\water_supply\spawn_training_water_supply.sqf";

if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\water_supply\spawn_or_replace_training_water_supply.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

[] call compile preprocessFileLineNumbers _cleanupScript;
[] call compile preprocessFileLineNumbers _spawnScript;
