# Hold action setup

This folder uses a small wrapper around `BIS_fnc_holdActionAdd` so the same object can be re-used safely without leaving duplicate hold actions behind.

The shared helper is:

- `vn_mf_fnc_action_holdActionAdd`

It adds a unique tracking key per target object so repeated setup calls replace the existing action instead of creating a second one.

## Basic pattern

Use the helper in the same shape as `BIS_fnc_holdActionAdd`, but pass a unique action key as the second argument.

```sqf
[
    _target,                                            // Object the action is attached to
    "vn_mf_action_example",                            // Unique key per object; must be unique for that target
    "Inspect crate",                                   // Title shown in the interaction text
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", // Idle icon
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", // Progress icon
    "player distance _target < 3",                     // Show condition
    "player distance _target < 3 && alive _target",     // Progress condition
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playMove "AinvPknlMstpSnonWnonDnon_healed_1";
    },
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        // Optional progress tick logic
    },
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        // Run when the action completes
    },
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        // Run when the action is interrupted
    },
    [],
    5,                                                  // Duration in seconds
    100,                                                // Priority
    false,                                              // Remove on complete
    false                                               // Show while unconscious
] call vn_mf_fnc_action_holdActionAdd;
```

## Important rules

- The second argument is the action key, not the title.
- Keep the key unique for the target object. Reusing the same key on the same object updates the action instead of creating duplicates.
- The action is attached to whichever object is passed as the first argument, often `player` or a world object.
- Use `remoteExecCall` when a hold action is created on an object that needs to exist on all clients/JIP clients.
- The functions in this folder usually call the helper directly from a local init script or `remoteExecCall` setup script.

## Example from this repo

The repo already uses this pattern in files such as:

- `fn_action_drink_water.sqf`
- `fn_action_gather_BlackBox.sqf`
- `fn_action_capture_player.sqf`

A typical action setup looks like this:

```sqf
[
    player,
    "vn_mf_action_drink_water",
    localize "STR_vn_mf_drink_water",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "(surfaceIsWater screenToWorld [0.5,0.5] && player distance screenToWorld [0.5,0.5] < 3)",
    "player distance screenToWorld [0.5,0.5] < 3",
    { player playMove "AinvPknlMstpSnonWnonDnon_healed_1" },
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_max_progress"];
        // progress logic
    },
    {
        // completion logic
    },
    {},
    [],
    5,
    100,
    false,
    false
] call vn_mf_fnc_action_holdActionAdd;
```

## Why this helper exists

The wrapper keeps the action list clean by:

1. removing the existing action for the same key if it already exists,
2. tracking the key on the target object,
3. storing the new action ID back onto the object.

This prevents duplicate hold actions from piling up after resets, respawns, or object re-use.
