/*
    File: fn_inventory_ground_holder.sqf
    Author: Tylervip
    Public: No

    Description:
        Finds a nearby ground holder, optionally creating one.

    Parameter(s):
        _unit - Unit to anchor the ground holder to [OBJECT]
        _create - Create a holder if none exists [BOOL]

    Returns:
        Ground holder object [OBJECT]
*/

params [
    ["_unit", objNull, [objNull]],
    ["_create", false, [false]]
];

if (isNull _unit) exitWith { objNull };

private _nearby = nearestObjects [_unit, ["GroundWeaponHolder", "WeaponHolder", "WeaponHolderSimulated"], 2];
if !(_nearby isEqualTo []) exitWith { _nearby select 0 };

if (!_create) exitWith { objNull };

private _holder = createVehicle ["GroundWeaponHolder_Scripted", getPosATL _unit, [], 0, "CAN_COLLIDE"];
if !(isNull _holder) then {
    _holder setPosATL (getPosATL _unit);
    diag_log format ["[vn_mf_fnc_inventory_ground_holder] created holder: unit=%1 holder=%2 type=%3", _unit, _holder, typeOf _holder];
} else {
    diag_log format ["[vn_mf_fnc_inventory_ground_holder] failed to create holder for %1", _unit];
};

_holder
