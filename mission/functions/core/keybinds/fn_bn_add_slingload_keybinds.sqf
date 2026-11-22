#include "\a3\ui_f\hpp\definedikcodes.inc"

// Keybinds are quality of life/additional to core, nothing in here should be *essential* to mission
// functionality because if CBA isn't present they won't be loaded! - Vanilla matters

if (!hasInterface) exitWith {};

// Bail out if CBA isn't loaded (checks the addon and that the function is compiled)
if (!isClass (configFile >> "CfgPatches" >> "cba_main") || {isNil "CBA_fnc_addKeybind"}) exitWith {
    diag_log "[vn_mf] CBA not detected, keybinds not registered.";
};

private _category = "BN Keybinds - Slingloading";

// END (no modifiers)
[
    _category,
    "vn_mf_extend_ropes",
    "Extend Sling Ropes",
    { [] call vn_mf_fnc_extend_ropes; },
    {},
    [DIK_END, [false, false, false]]
] call CBA_fnc_addKeybind;

// HOME (no modifiers)
[
    _category,
    "vn_mf_shorten_ropes",
    "Shorten Sling Ropes",
    { [] call vn_mf_fnc_shorten_ropes; },
    {},
    [DIK_HOME, [false, false, false]]
] call CBA_fnc_addKeybind;

// SHIFT + HOME
[
    _category,
    "vn_mf_retract_all_ropes",
    "Jettison Cargo/Retract Ropes",
    { [] call vn_mf_fnc_retract_all_ropes; },
    {},
    [DIK_HOME, [true, false, false]]
] call CBA_fnc_addKeybind;

// CTRL + F10
[
    _category,
    "vn_mf_deploy_one_ropes",
    "Deploy One Ropes",
    { [player, 1] call vn_mf_fnc_deploy_helo_ropes;  },
    {},
    [DIK_F10, [false, true, false]]
] call CBA_fnc_addKeybind;

// CTRL + F11
[
    _category,
    "vn_mf_deploy_two_ropes",
    "Deploy Two Ropes",
    { [player, 2] call vn_mf_fnc_deploy_helo_ropes;  },
    {},
    [DIK_F11, [false, true, false]]
] call CBA_fnc_addKeybind;

// CTRL + F12
[
    _category,
    "vn_mf_deploy_three_ropes",
    "Deploy Three Ropes",
    { [player, 3] call vn_mf_fnc_deploy_helo_ropes; },
    {},
    [DIK_F12, [false, true, false]]
] call CBA_fnc_addKeybind;

// SHIFT + 4
[
    _category,
    "vn_mf_release_cargo_via_shortcut",
    "Release Cargo",
    { [] call vn_mf_fnc_release_cargo_via_shortcut; },
    {},
    [DIK_4, [true, false, false]]
] call CBA_fnc_addKeybind;

// CTRL + `
[
    _category,
    "vn_mf_attach_held_ropes",
    "Attach held ropes to object",
    { [] call vn_mf_fnc_attach_held_ropes; },
    {},
    [DIK_GRAVE, [false, true, false]]
] call CBA_fnc_addKeybind;

// ` 
[
    _category,
    "vn_mf_pickup_nearest_ropes",
    "Pick up nearest ropes",
    { [] call vn_mf_fnc_pickup_nearest_ropes; },
    {},
    [DIK_GRAVE, [false, false, false]]
] call CBA_fnc_addKeybind;

