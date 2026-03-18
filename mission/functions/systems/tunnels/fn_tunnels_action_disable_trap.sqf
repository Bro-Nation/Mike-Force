/*
    File: fn_tunnels_action_disable_trap.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds the "Disable Trap" action to a closed tunnel trapdoor.
        Players can use this action to safely disarm a detected trap.

    Parameter(s):
        _tunnelClosed - The closed trapdoor object [OBJECT]

    Returns:
        Nothing

    Example(s):
        [_tunnelClosed] call vn_mf_fnc_tunnels_action_disable_trap
*/

params ["_tunnelClosed"];

_tunnelClosed addAction [
    "<t color='#ff4444'>Disable Trap</t>",
    {
        params ["_target", "_caller", "_actionId"];
        _target setVariable ["trapActive", false, true];
        _target removeAction _actionId;
        hint "Trap disabled. Safe to open.";
    },
    nil,
    2,
    true,
    true,
    "",
    "true", //need a in inventory check here to only show if player has tool kit or knife 
    5
];