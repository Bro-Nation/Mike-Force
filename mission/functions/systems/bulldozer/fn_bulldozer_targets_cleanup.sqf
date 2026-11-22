/*
    File: fn_bulldozer_targets_cleanup.sqf
    Author: Tylervip
    Public: yes

    Removes the invisible target objects attached to a bulldozer tank and clears
    any empty target crew groups.

    Parameter(s):
        0: OBJECT - tank whose target list should be cleaned up
*/
params ["_tank"];

if (isNull _tank) exitWith {};

private _targets = _tank getVariable ["invisTargets", []];
if (_targets isEqualTo []) exitWith {};

{
    if (isNull _x) then {
        continue;
    };

    private _crew = crew _x;
    private _groups = [];
    {
        _groups pushBackUnique (group _x);
    } forEach _crew;

    if (!isNull attachedTo _x) then {
        detach _x;
    };

    { deleteVehicle _x } forEach _crew;
    deleteVehicle _x;

    {
        if (!isNull _x && { count units _x == 0 }) then {
            deleteGroup _x;
        };
    } forEach _groups;
} forEach _targets;

_tank setVariable ["invisTargets", [], true];
