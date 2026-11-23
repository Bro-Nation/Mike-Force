/*
    File: eh_InventoryOpened.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Inventory Opened Event Handler.

    Parameter(s):
        _unit - Description [DATATYPE, defaults to DEFAULTVALUE]
        _container - Description [DATATYPE, defaults to DEFAULTVALUE]

    Returns: nothing

    Example(s):
	    Not called directly.
*/

params [
    "_unit",
    "_container"
];

private _activeGroundInventory = uiNamespace getVariable ["vn_mf_active_ground_inventory", objNull];
private _activeContainerInventory = uiNamespace getVariable ["vn_mf_active_container_inventory", objNull];

if !(isNull _container) then {
    if (_container isKindOf "GroundWeaponHolder") then {
        _activeGroundInventory = _container;
    } else {
        _activeContainerInventory = _container;
    };
};

if (isNull _activeGroundInventory) then {
    _activeGroundInventory = [_unit] call vn_mf_fnc_inventory_ground_holder;
};

uiNamespace setVariable ["vn_mf_active_inventory_container", _activeContainerInventory];
uiNamespace setVariable ["vn_mf_active_ground_inventory", _activeGroundInventory];
uiNamespace setVariable ["vn_mf_active_container_inventory", _activeContainerInventory];

// Initialize armor UI
["init", _this] spawn vn_mf_fnc_armor_calc;
