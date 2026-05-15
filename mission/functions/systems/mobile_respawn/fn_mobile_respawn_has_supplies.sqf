/*
    File: fn_mobile_respawn_has_supplies.sqf
    Author: tylervip
    Public: yes

    Description:
        Checks whether food supplies are available to the APC —
        either in a nearby food crate (within 30m) or in the APC's own cargo.
        Does NOT consume anything.

    Parameter(s):
        _vehicle - The M577 APC to check [OBJECT]

    Returns:
        True if at least 1x ration + 1x canteen are available, false otherwise [BOOL]

    Example(s):
        [myAPC] call vn_mf_fnc_mobile_respawn_has_supplies
*/

params ["_vehicle"];

private _foodClass  = "vn_prop_food_box_01_03";
private _drinkClass = "vn_prop_drink_06";

private _fnc_hasClassInCargo = {
    params ["_obj", "_className"];
    (_className in (itemCargo _obj)) || (_className in (magazineCargo _obj))
};

private _fnc_hasResources = {
    params ["_obj"];
    ([_obj, _foodClass] call _fnc_hasClassInCargo) && ([_obj, _drinkClass] call _fnc_hasClassInCargo)
};

private _nearbyCrates = _vehicle nearEntities [["vn_b_ammobox_supply_02"], 30];
private _sourceCrate = _nearbyCrates select { [_x] call _fnc_hasResources };

if (count _sourceCrate > 0) exitWith { true };

[_vehicle] call _fnc_hasResources
