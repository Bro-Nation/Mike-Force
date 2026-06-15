/*
    File: stop_engineer_defense.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Stops an active engineer defense phase.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\engineer_defense\stop_engineer_defense.sqf"
*/

if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\engineer_defense\stop_engineer_defense.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

private _isActive = missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false];
if (!_isActive) exitWith {
    ["Engineer defense is not active."] remoteExecCall ["systemChat", 0];
};

[] call compile preprocessFileLineNumbers "training\scripts\engineer_defense\cleanup_engineer_defense.sqf";

["Engineer defense stopped from console."] remoteExecCall ["systemChat", 0];