/*
    File: fn_bulldozer_targets_sync.sqf
    Author: Tylervip
    Public: yes

    Syncs the crew of an attached bulldozer invisible target list to the provided side.

    Parameter(s):
        0: OBJECT - tank whose targets should be synced
        1: SIDE - side to assign to target crews
*/
params ["_tankToSync", "_sideToUse"];

if (isNull _tankToSync || { _sideToUse == sideUnknown }) exitWith {};

private _targetList = _tankToSync getVariable ["invisTargets", []];
if (_targetList isEqualTo []) exitWith {};

{
    if (isNull _x) then {
        continue;
    };

    private _crew = crew _x;
    if (_crew isEqualTo []) then {
        continue;
    };

    private _oldGroups = [];
    {
        _oldGroups pushBackUnique (group _x);
    } forEach _crew;

    private _newGroup = createGroup [_sideToUse, true];
    {
        if (alive _x) then {
            [_x] joinSilent _newGroup;
        };
    } forEach _crew;

    {
        if (!isNull _x && { count units _x == 0 }) then {
            deleteGroup _x;
        };
    } forEach _oldGroups;
} forEach _targetList;
