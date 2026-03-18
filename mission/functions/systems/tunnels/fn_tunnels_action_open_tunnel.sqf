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

_tunnelClosed addAction [
    "Open Tunnel",
    {
        params ["_target", "_caller", "_actionId"];
        private _tunnelOpen = _target getVariable ["linkedOpenTunnel", objNull];
        if (isNull _tunnelOpen) exitWith {};

        private _isTrapped = _target getVariable ["trapActive", false];

        // If trap is still active and player didn't disable it, spawn grenade
        if (_isTrapped) then {
            private _grenadePos = _target modelToWorld [0, 0, 1];
            private _grenade = "vn_t67_grenade_ammo" createVehicle _grenadePos;
            hint "The tunnel was booby-trapped!";
        };

        // Open the tunnel regardless
        _target hideObjectGlobal true;
        _tunnelOpen hideObjectGlobal false;

        // Remove all remaining actions from the closed trapdoor
        removeAllActions _target;
    },
    nil,
    1,
    true,
    true,
    "",
    "true",
    5
];