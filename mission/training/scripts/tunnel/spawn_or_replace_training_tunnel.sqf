/*
    File: spawn_or_replace_training_tunnel.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Training tunnel button entry point.
        Runs on server, removes any previous training tunnel instance,
        then spawns a new one.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\tunnel\spawn_or_replace_training_tunnel.sqf"
*/

private _cleanupScript = "training\scripts\tunnel\cleanup_training_tunnel.sqf";
private _spawnScript = "training\scripts\tunnel\spawn_training_tunnel.sqf";

if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\tunnel\spawn_or_replace_training_tunnel.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

[] call compile preprocessFileLineNumbers _cleanupScript;
[] call compile preprocessFileLineNumbers _spawnScript;