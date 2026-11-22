/*
    File: fn_cleanup_tank_dozer.sqf
    Author: Tylervip
    Public: yes

    Removes all attached objects from a bulldozer tank and cleans up their crews/groups.

    Parameter(s):
        0: OBJECT - tank to clean
*/
if (!isServer) exitWith {};

params ["_tank"];
if (isNull _tank) exitWith {};

private _attached = attachedObjects _tank;
{
    if (isNull _x) then {
        continue;
    };

    private _crew = (crew _x) select { !isNull _x };
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
} forEach _attached;
