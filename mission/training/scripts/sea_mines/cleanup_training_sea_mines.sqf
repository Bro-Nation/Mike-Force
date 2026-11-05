/*
    File: cleanup_training_sea_mines.sqf
    Author: spade
    Description: Removes mines tracked by the independent training sea mine spawner.
*/

if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\sea_mines\cleanup_training_sea_mines.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

{
    if (!isNull _x) then { deleteVehicle _x; };
} forEach (missionNamespace getVariable ["vn_mf_training_sea_mines", []]);
missionNamespace setVariable ["vn_mf_training_sea_mines", [], true];
