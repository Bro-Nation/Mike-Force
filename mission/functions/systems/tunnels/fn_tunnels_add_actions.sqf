/*
    File: fn_tunnels_add_actions.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds trap mechanics and open actions to a closed tunnel trapdoor.
        Sets up the trap state and delegates to individual action functions.

    Parameter(s):
        _tunnelClosed - The closed trapdoor object [OBJECT]

    Returns:
        Nothing

    Example(s):
        [_tunnelClosed] call vn_mf_fnc_tunnels_add_actions
*/

params ["_tunnelClosed"];

private _tunnelOpen = _tunnelClosed getVariable ["linkedOpenTunnel", objNull];
if (isNull _tunnelOpen) exitWith {};

// Randomly decide if this tunnel is trapped (75% chance)
private _isTrapped = random 1 < 0.75;
_tunnelClosed setVariable ["trapActive", _isTrapped, true];
_tunnelClosed setVariable ["trapChecked", false, true];

// Unique JIP IDs so actions persist for players who join later
private _jipWires = format ["tunnels_wires_%1", netId _tunnelClosed];
private _jipOpen  = format ["tunnels_open_%1", netId _tunnelClosed];
private _jipEnter = format ["tunnels_enter_%1", netId _tunnelClosed];

// --- Look for Wires action (scouts/explosive specialists only) ---
// Condition uses trapChecked variable so action auto-hides on all clients once checked
[
    _tunnelClosed,
    "<t color='#ffc444'>Look for Wires</t>",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "((player getUnitTrait 'scout_multiple') || (player getUnitTrait 'explosiveSpecialist')) && !(_target getVariable ['trapChecked', false]) && player distance _target < 5",
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

        // Setting this to true hides this action on all clients via the show condition
        _target setVariable ["trapChecked", true, true];
    },
    {},
    [],
    4,
    100,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _jipWires];

// --- Open Tunnel action ---
[
    _tunnelClosed,
    "Open Tunnel",
    "custom\holdactions\holdAction_interact_ca.paa",
    "custom\holdactions\holdAction_interact_ca.paa",
    "player distance _target < 5",
    "player distance _target < 5",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        private _tunnelOpen = _target getVariable ["linkedOpenTunnel", objNull];
        if (isNull _tunnelOpen) exitWith {};

        private _isTrapped = _target getVariable ["trapActive", false];

        [_target, _tunnelOpen, _isTrapped] remoteExecCall ["vn_mf_fnc_tunnels_open_tunnel_server", 2];
        
        if (_isTrapped) then {
            hint "The tunnel was booby-trapped!";
        } else {
            hint "Tunnel opened.";
        };
    },
    {},
    [],
    3,
    100,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _jipOpen];

// --- Enter Tunnel action (DacCong team only) ---
[
    _tunnelClosed,
    "(DAC)Enter Tunnel",
    "\a3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa",
    "\a3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa",
    "player distance _target < 5 && ([player, 'DacCong'] call vn_mf_fnc_player_on_team)",
    "player distance _target < 5 && ([player, 'DacCong'] call vn_mf_fnc_player_on_team)",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        private _linkedTunnel = _target getVariable ["linkedOpenTunnel", objNull];
        if (isNull _linkedTunnel) exitWith { hint "No linked tunnel found"; };
        
        private _exitTeleport = _linkedTunnel getVariable ["exitTeleport", objNull];
        if (isNull _exitTeleport) exitWith { hint "No tunnel exit assigned"; };
        // Teleport player to exit point and set freefall height for safe landing
        _caller setUnitFreefallHeight 32000;
        _caller setPosATL (getPosATL _exitTeleport vectorAdd [0,0,-3]);
    },
    {},
    [],
    2,
    100,
    false,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _jipEnter];