/*
    File: fn_supply_cleanup.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Deletes nearby supply boxes around a dumpster.

    Example:
        [_target] call vn_mf_fnc_supply_cleanup;
*/

params ["_target"];

private _count = 0;
private _nearby = _target nearObjects ["All", 7];

{
    if (_x isKindOf "ReammoBox_F") then {
        deleteVehicle _x;
        _count = _count + 1;
    };
} forEach _nearby;