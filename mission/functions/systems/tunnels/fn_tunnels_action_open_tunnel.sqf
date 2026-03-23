/*
    File: fn_tunnels_action_open_tunnel.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds the "Open Tunnel" action to a closed tunnel trapdoor.
        Players can use this action to open the tunnel, triggering any active traps.

    Parameter(s):
        _tunnelClosed - The closed trapdoor object [OBJECT]

    Returns:
        Nothing

    Example(s):
        [_tunnelClosed] call vn_mf_fnc_tunnels_action_open_tunnel
*/

params ["_tunnelClosed"];

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

        // Execute the tunnel opening on the server
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
] call BIS_fnc_holdActionAdd;