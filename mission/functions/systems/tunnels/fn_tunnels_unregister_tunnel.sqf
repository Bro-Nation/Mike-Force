/*
    File: fn_tunnels_unregister_tunnel.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Unregisters a tunnel object from the tunnel subsystem and removes its actions.
        Call this when destroying a tunnel to clean up properly.

    Parameter(s):
        _tunnel - The tunnel trapdoor object [OBJECT]

    Returns:
        True if successful [BOOL]

    Example(s):
        [_tunnel] call vn_mf_fnc_tunnels_unregister_tunnel
*/

params ["_tunnel"];

if (isNull _tunnel) exitWith { false };

// Remove enter action from tunnel (though it will be deleted anyway)
private _enterActionId = _tunnel getVariable ["enterActionId", -1];
if (_enterActionId > -1) then {
    _tunnel removeAction _enterActionId;
};

// Remove exit action from teleport
private _exitTeleport = _tunnel getVariable ["exitTeleport", objNull];
if (!isNull _exitTeleport) then {
    // Keep the exitPosition for players who might still be in the tunnel
    // Just clear the linkedTunnel reference
    _exitTeleport setVariable ["linkedTunnel", nil, true];
    // Keep exitActionId for now
};

// Remove from tunnels array
private _tunnels = missionNamespace getVariable ["vn_mf_tunnels", []];
_tunnels = _tunnels - [_tunnel];
missionNamespace setVariable ["vn_mf_tunnels", _tunnels, true];

// Clear tunnel variables
_tunnel setVariable ["exitTeleport", nil, true];
_tunnel setVariable ["siteTeleports", nil, true];
_tunnel setVariable ["enterActionId", nil, true];

true