/*
    File: fn_attachments_server_spawn_dropped_chemlight.sqf
    Author: Legend
    Description:
        Spawns a dropped chemlight at the player’s feet, synced globally.
    Params:
        0: OBJECT - Player dropping the chemlight
        1: STRING - Classname of chemlight to spawn
*/

params ["_unit", "_className"];

if (!isServer) exitWith {};

private _pos = _unit modelToWorld [0, 0.3, -1.1];
private _dropped = _className createVehicle _pos;

private _dir = [[1,0,0], [0,1,0], [0,0,1]] select floor random 3;
private _tilt = [random 1 - 0.5, random 1 - 0.5, random 1 - 0.5];
_dropped setVectorDirAndUp [_dir, _tilt];
