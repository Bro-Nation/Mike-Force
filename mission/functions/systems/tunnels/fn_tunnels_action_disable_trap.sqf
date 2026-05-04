/*
    File: fn_tunnels_action_disable_trap.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds the "Disable Trap" action to a closed tunnel trapdoor.
        Players can use this action to safely disarm a detected trap.
        Action auto-hides on all clients when trapActive is set to false.

    Parameter(s):
        _tunnelClosed - The closed trapdoor object [OBJECT]

    Returns:
        Nothing

    Example(s):
        [_tunnelClosed] call vn_mf_fnc_tunnels_action_disable_trap
*/

params ["_tunnelClosed"];

[
    _tunnelClosed,
    "<t color='#ff4444'>Disable Trap</t>",
    "\a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_takemine_ca.paa",
    "\a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_takemine_ca.paa",
    "((player getUnitTrait 'explosiveSpecialist') && (('vn_b_item_toolkit' in (backpackItems player)) || ('vn_b_item_trapkit' in (backpackItems player)) || ('MineDetector' in (backpackItems player)) || ('vn_b_item_toolkit' in (vestItems player)) || ('vn_b_item_trapkit' in (vestItems player)) || ('MineDetector' in (vestItems player)) || ('vn_b_item_toolkit' in (uniformItems player)) || ('vn_b_item_trapkit' in (uniformItems player)) || ('MineDetector' in (uniformItems player)))) && (_target getVariable ['trapActive', false]) && player distance _target < 5",
    "player distance _target < 5",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        // Setting trapActive to false hides this action on all clients via the show condition
        _target setVariable ["trapActive", false, true];
        hint "Trap disabled. Safe to open.";
    },
    {},
    [],
    8,
    100,
    true,
    false
] call BIS_fnc_holdActionAdd;