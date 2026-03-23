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

// Add individual actions on all clients (not server)
[_tunnelClosed] remoteExec ["vn_mf_fnc_tunnels_action_look_for_wires", 0, _tunnelClosed];
[_tunnelClosed] remoteExec ["vn_mf_fnc_tunnels_action_open_tunnel", 0, _tunnelClosed];