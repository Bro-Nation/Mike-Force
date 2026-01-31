/*
    File: fn_tunnels_register_tunnel.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Registers a tunnel object with the tunnel subsystem and assigns it a teleport exit.
        Also adds the Enter/Exit actions.

    Parameter(s):
        _tunnel - The tunnel trapdoor object [OBJECT]

    Returns:
        True if successful [BOOL]

    Example(s):
        [_tunnel] call vn_mf_fnc_tunnels_register_tunnel
*/

params ["_tunnel"];

if (isNull _tunnel) exitWith { systemChat "ERROR: Tunnel is null!"; false };

private _tunnels = missionNamespace getVariable ["vn_mf_tunnels", []];
private _tunnelIndex = count _tunnels;
_tunnels pushBack _tunnel;
missionNamespace setVariable ["vn_mf_tunnels", _tunnels, true];

// Get cached teleports
private _teleports = call vn_mf_fnc_tunnels_get_teleports;

if (_teleports isEqualTo []) exitWith {
    systemChat "ERROR: No tunnel teleports found!";
    false
};

// Assign a teleport exit (cycle through available teleports)
private _exitTeleport = _teleports select (_tunnelIndex mod (count _teleports));
_tunnel setVariable ["exitTeleport", _exitTeleport, true];
_tunnel setVariable ["siteTeleports", _teleports, true];
_exitTeleport setVariable ["linkedTunnel", _tunnel, true];
_exitTeleport setVariable ["exitPosition", getPosATL _tunnel, true];

// --- Enter Tunnel action ---
private _actionId1 = _tunnel addAction [
    "Enter Tunnel",
    {
        params ["_target", "_caller"];
        private _exitTeleport = _target getVariable ["exitTeleport", objNull];
        
        if (isNull _exitTeleport) exitWith { hint "No tunnel exit assigned"; };
        
        _caller setPosATL (getPosATL _exitTeleport vectorAdd [0,0,-3]);
    },
    nil, 1, true, true, "", "true"
];
_tunnel setVariable ["enterActionId", _actionId1, true];

// --- Exit Tunnel action (on the teleport point inside) ---
// Remove any existing exit action first
private _existingActionId = _exitTeleport getVariable ["exitActionId", -1];
if (_existingActionId > -1) then {
    _exitTeleport removeAction _existingActionId;
};

private _actionId2 = _exitTeleport addAction [
    "Exit Tunnel",
    {
        params ["_target", "_caller"];
        private _source = _target getVariable ["linkedTunnel", objNull];
        if (!isNull _source) then {
            _caller setPosATL getPosATL _source;
        } else {
            private _exitPos = _target getVariable ["exitPosition", []];
            if (_exitPos isNotEqualTo []) then {
                _caller setPosATL _exitPos;
            } else {
                hint "No tunnel exit available";
            };
        };
    },
    nil, 1, true, true, "", "_target distance _this < 10"
];
_exitTeleport setVariable ["exitActionId", _actionId2, true];

true
