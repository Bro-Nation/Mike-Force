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

[
    _tunnelClosed,
    "<t color='#ffc444'>Look for Wires</t>",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "((player getUnitTrait 'scout_multiple') || (player getUnitTrait 'explosiveSpecialist')) && player distance _target < 5",
    "player distance _target < 5",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        private _isTrapped = _target getVariable ["trapActive", false];

        if (_isTrapped) then {
            hint "You found a trip wire! Disable the trap before opening.";
            [_target] remoteExec ["vn_mf_fnc_tunnels_action_disable_trap", 0, _target];
        } else {
            hint "No wires found. Tunnel appears safe.";
        };

        // Sync trap check to all machines
        _target setVariable ["trapChecked", true, true];
    },
    {},
    [],
    4,
    100,
    true,
    false
] call BIS_fnc_holdActionAdd;