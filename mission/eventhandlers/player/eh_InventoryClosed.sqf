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

if (isNil "vn_mf_inventory_move_debug") then {
    vn_mf_inventory_move_debug = false;
};

if (vn_mf_inventory_move_debug) then {
    diag_log format ["[vn_mf_fnc_inventory_closed] unit=%1 container=%2", name _unit, _container];
};
