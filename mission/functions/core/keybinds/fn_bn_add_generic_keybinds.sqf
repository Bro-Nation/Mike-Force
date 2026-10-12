#include "\a3\ui_f\hpp\definedikcodes.inc"

// Keybinds are quality of life/additional to core, nothing in here should be *essential* to mission
// functionality because if CBA isn't present they won't be loaded! - Vanilla matters

if (!hasInterface) exitWith {};

// Bail out if CBA isn't loaded (checks the addon and that the function is compiled)
if (!isClass (configFile >> "CfgPatches" >> "cba_main") || {isNil "CBA_fnc_addKeybind"}) exitWith {
    diag_log "[vn_mf] CBA not detected, keybinds not registered.";
};

private _category = "BN Keybinds - Generic";

// CTRL + X
[
    _category,
    "vn_mf_delete_dead_vehicle_occupants",
    "Delete Bodies from Vic",
    { [] call vn_mf_fnc_delete_dead_vehicle_occupants; },
    {},
    [DIK_X, [false, true, false]]
] call CBA_fnc_addKeybind;

// CTRL + F12 (by default - player can change)
[
    _category,
    "vn_mf_unlock_controls",
    ["Unlock Copilot Controls", "Quickly unlock controls"],
    {
        [player] call vn_mf_fnc_unlock_vehicle_controls;
    },
    {},
    [DIK_L, [false, true, false]]
] call CBA_fnc_addKeybind;