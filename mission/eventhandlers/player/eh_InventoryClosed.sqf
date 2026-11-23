/*
    File: eh_InventoryClosed.sqf
    Author: Tylervip
    Public: No

    Description:
        Clears tracked inventory state when the player closes the inventory UI.

    Parameter(s):
        _unit - Player unit that closed the inventory [OBJECT]
        _container - Container that was previously open [OBJECT]

    Returns:
        Nothing
*/

params [
    "_unit",
    "_container"
];

uiNamespace setVariable ["vn_mf_active_inventory_container", objNull];
uiNamespace setVariable ["vn_mf_active_ground_inventory", objNull];
uiNamespace setVariable ["vn_mf_active_container_inventory", objNull];

vn_mf_targetContainer = objNull;
vn_mf_secondaryContainer = objNull;
