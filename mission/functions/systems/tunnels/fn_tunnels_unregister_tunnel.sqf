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

// Remove hold-actions created for this tunnel.
private _tunnelHoldActionKeys = _tunnel getVariable ["vn_mf_holdActionKeys", []];
{
    private _actionId = _tunnel getVariable [_x, -1];
    if (_actionId isEqualType 0 && {_actionId > -1}) then {
        [_tunnel, _actionId] call BIS_fnc_holdActionRemove;
    };
    _tunnel setVariable [_x, nil, false];
} forEach +_tunnelHoldActionKeys;
_tunnel setVariable ["vn_mf_holdActionKeys", [], false];

// Remove exit action from teleport
private _exitTeleport = _tunnel getVariable ["exitTeleport", objNull];
if (!isNull _exitTeleport) then {
    private _exitHoldActionKeys = _exitTeleport getVariable ["vn_mf_holdActionKeys", []];
    {
        private _actionId = _exitTeleport getVariable [_x, -1];
        if (_actionId isEqualType 0 && {_actionId > -1}) then {
            [_exitTeleport, _actionId] call BIS_fnc_holdActionRemove;
        };
        _exitTeleport setVariable [_x, nil, false];
    } forEach +_exitHoldActionKeys;
    _exitTeleport setVariable ["vn_mf_holdActionKeys", [], false];

    // Hide exit action on all connected clients via show condition
    _exitTeleport setVariable ["tunnelActive", false, true];

    // Clear JIP entry so late joiners don't get the stale action
    private _jipId = _exitTeleport getVariable ["exitJipId", ""];
    if (_jipId != "") then {
        remoteExec ["", _jipId];
        _exitTeleport setVariable ["exitJipId", nil, true];
    };
    
    // Keep the exitPosition for players who might still be in the tunnel
    // Just clear the linkedTunnel reference
    _exitTeleport setVariable ["linkedTunnel", nil, true];

    // Release teleport back to available pool
    private _usedTeleports = missionNamespace getVariable ["vn_mf_used_tunnel_teleports", []];
    _usedTeleports = _usedTeleports - [_exitTeleport];
    missionNamespace setVariable ["vn_mf_used_tunnel_teleports", _usedTeleports, true];
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