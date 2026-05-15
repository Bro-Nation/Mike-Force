/*
    File: fn_mobile_respawn_add_supplies.sqf
    Author: tylervip
    Public: yes

    Description:
        Adds mobile respawn food supplies to a vehicle.

    Parameter(s):
        _vehicle - Vehicle to add supplies to [Object]

    Returns: nothing

    Example(s): none
*/

params ["_vehicle"];

_vehicle addItemCargoGlobal ["vn_prop_food_box_01_03", 5];
_vehicle addItemCargoGlobal ["vn_prop_drink_06", 5];
