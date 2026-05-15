/*
    File: fn_mobile_respawn_consume.sqf
    Author: tylervip
    Public: yes

    Description:
        Consumes 1x MCI Ration Box and 1x Canteen 2L as the cost of a respawn.
        Checks nearby food crates (within 30m) first, then falls back to the
        APC's own cargo.

    Parameter(s):
        _vehicle - The M577 APC to consume resources from/near [OBJECT]

    Returns:
        True if resources were found and consumed, false if none available [BOOL]

    Example(s):
        [myAPC] call vn_mf_fnc_mobile_respawn_consume
*/

if (!isServer) exitWith { false };

params ["_vehicle"];

private _foodClass  = "vn_prop_food_box_01_03";
private _drinkClass = "vn_prop_drink_06";

private _fnc_hasClassInCargo = {
    params ["_obj", "_className"];
    (_className in (itemCargo _obj)) || (_className in (magazineCargo _obj))
};

// Helper: check if an object has at least 1 of each item
private _fnc_hasResources = {
    params ["_obj"];
    ([_obj, _foodClass] call _fnc_hasClassInCargo) && ([_obj, _drinkClass] call _fnc_hasClassInCargo)
};

// Helper: remove 1x of an item class from item cargo by rebuilding the list
private _fnc_removeOneFromItemCargo = {
    params ["_obj", "_item"];
    private _items = itemCargo _obj;
    private _idx = _items find _item;
    if (_idx < 0) exitWith {};
    _items deleteAt _idx;
    clearItemCargoGlobal _obj;
    { _obj addItemCargoGlobal [_x, 1] } forEach _items;
};

// Helper: remove 1x of a class from magazine cargo by rebuilding the list
private _fnc_removeOneFromMagazineCargo = {
    params ["_obj", "_mag"];
    private _mags = magazineCargo _obj;
    private _idx = _mags find _mag;
    if (_idx < 0) exitWith {};
    _mags deleteAt _idx;
    clearMagazineCargoGlobal _obj;
    { _obj addMagazineCargoGlobal [_x, 1] } forEach _mags;
};

private _fnc_removeOneClass = {
    params ["_obj", "_className"];
    if (_className in (itemCargo _obj)) exitWith {
        [_obj, _className] call _fnc_removeOneFromItemCargo;
    };
    if (_className in (magazineCargo _obj)) exitWith {
        [_obj, _className] call _fnc_removeOneFromMagazineCargo;
    };
};

// Priority 1 — nearby food crates within 30m
private _nearbyCrates = _vehicle nearEntities [["vn_b_ammobox_supply_02"], 30];
private _sourceCrate = _nearbyCrates select { [_x] call _fnc_hasResources };

if (count _sourceCrate > 0) then {
    private _crate = _sourceCrate select 0;
    [_crate, _foodClass]  call _fnc_removeOneClass;
    [_crate, _drinkClass] call _fnc_removeOneClass;
    true
} else {
    // Priority 2 — APC own inventory
    if ([_vehicle] call _fnc_hasResources) then {
        [_vehicle, _foodClass]  call _fnc_removeOneClass;
        [_vehicle, _drinkClass] call _fnc_removeOneClass;
        true
    } else {
        false
    };
};
