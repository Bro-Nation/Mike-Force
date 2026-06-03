/*
    File: spawn_or_replace_training_underwater_wreck.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Training underwater wreck button entry point.
        Runs on server, removes any previous training underwater wreck instances,
        then spawns new ones.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\underwater_wreck\spawn_or_replace_training_underwater_wreck.sqf"
*/

private _cleanupScript = "training\scripts\underwater_wreck\cleanup_training_underwater_wreck.sqf";
private _spawnScript = "training\scripts\underwater_wreck\spawn_training_underwater_wreck.sqf";

if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\underwater_wreck\spawn_or_replace_training_underwater_wreck.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

[] call compile preprocessFileLineNumbers _cleanupScript;
[] call compile preprocessFileLineNumbers _spawnScript;
