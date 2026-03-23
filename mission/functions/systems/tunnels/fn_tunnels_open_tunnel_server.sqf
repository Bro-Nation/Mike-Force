/*
    File: fn_tunnels_open_tunnel_server.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Server-side handler for opening a tunnel.
        Spawns a grenade if the tunnel is trapped, then hides the closed
        trapdoor and reveals the open one.

    Parameter(s):
        _tunnelClosed - The closed trapdoor object [OBJECT]
        _tunnelOpen   - The open trapdoor object [OBJECT]
        _isTrapped    - Whether the trap is active [BOOL]

    Returns:
        Nothing

    Example(s):
        [_tunnelClosed, _tunnelOpen, true] call vn_mf_fnc_tunnels_open_tunnel_server
*/

if (!isServer) exitWith {};

params ["_tunnelClosed", "_tunnelOpen", "_isTrapped"];

// If trap is still active and player didn't disable it, spawn grenade
if (_isTrapped) then {
    private _grenadePos = _tunnelClosed modelToWorld [0, 0, 1];
    "vn_t67_grenade_ammo" createVehicle _grenadePos;
};

// Open the tunnel - hide closed, show open
_tunnelClosed hideObjectGlobal true;
_tunnelOpen hideObjectGlobal false;
