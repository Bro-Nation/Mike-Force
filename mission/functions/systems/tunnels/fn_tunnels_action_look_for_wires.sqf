/*
    File: fn_tunnels_action_look_for_wires.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds the "Look for Wires" action to a closed tunnel trapdoor.
        Players can use this action to detect if the tunnel is trapped.

    Parameter(s):
        _tunnelClosed - The closed trapdoor object [OBJECT]

    Returns:
        Nothing

    Example(s):
        [_tunnelClosed] call vn_mf_fnc_tunnels_action_look_for_wires
*/

params ["_tunnelClosed"];

_tunnelClosed addAction [
    "Look for Wires",
    {
        params ["_target", "_caller", "_actionId"];
        private _isTrapped = _target getVariable ["trapActive", false];

        if (_isTrapped) then {
            hint "You found a trip wire! Disable the trap before opening.";
            [_target] call vn_mf_fnc_tunnels_action_disable_trap;
        } else {
            hint "No wires found. Tunnel appears safe.";
        };

        _target setVariable ["trapChecked", true, true];
        _target removeAction _actionId;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "true", //maybe only show for spike teams from team.hpp or if player has explosiveSpecialist trait?
    5
];