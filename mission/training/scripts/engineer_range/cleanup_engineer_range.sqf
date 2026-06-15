/*
    File: cleanup_engineer_range.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Deletes mission objects inside marker Engineer while keeping the console object intact.

    Parameter(s):
        _consoleObject - Console object to keep [OBJECT, defaults to objNull]

    Returns:
        Nothing

    Example(s):
        [_this select 0] execVM "training\scripts\engineer_range\cleanup_engineer_range.sqf"
*/

params [["_consoleObject", objNull, [objNull]]];

if (!isServer) exitWith {
    [[_consoleObject], {
        params ["_serverConsoleObject"];

        [_serverConsoleObject] execVM "training\scripts\engineer_range\cleanup_engineer_range.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

private _markerName = "Engineer";

if !(markerShape _markerName in ["RECTANGLE", "ELLIPSE"]) exitWith {
    ["Engineer range marker 'Engineer' is missing or invalid."] remoteExecCall ["systemChat", 0];
};

private _objectsToDelete = allMissionObjects "" select {
    !isNull _x
    && {_x inArea _markerName}
    && {crew _x isEqualTo []}
    && {!(_x isKindOf "Man")}
    && {_x != _consoleObject}
};

{
    deleteVehicle _x;
} forEach _objectsToDelete;

private _cleanupMessage = "Engineer range cleaned.";
[_cleanupMessage] remoteExecCall ["systemChat", 0];