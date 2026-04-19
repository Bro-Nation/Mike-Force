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

// Get cached teleports FIRST
private _teleports = call vn_mf_fnc_tunnels_get_teleports;

if (_teleports isEqualTo []) exitWith {
    systemChat "ERROR: No tunnel teleports found!";
    false
};

// Assign an available teleport exit (no overlap) BEFORE adding to list
private _exitTeleport = call vn_mf_fnc_tunnels_get_available_teleport;
if (isNull _exitTeleport) exitWith {
    systemChat "ERROR: Not enough teleports for all tunnels!";
    false
};

// --- Only add tunnel to list after validating we have a teleport ---
private _tunnels = missionNamespace getVariable ["vn_mf_tunnels", []];
_tunnels pushBack _tunnel;
missionNamespace setVariable ["vn_mf_tunnels", _tunnels, true];
_tunnel setVariable ["exitTeleport", _exitTeleport, true];
_tunnel setVariable ["siteTeleports", _teleports, true];
_exitTeleport setVariable ["linkedTunnel", _tunnel, true];
_exitTeleport setVariable ["exitPosition", getPosATL _tunnel, true];

// --- Enter Tunnel action ---
[
    _tunnel,
    "Enter Tunnel",
    "\a3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa",
    "\a3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa",
    "player distance _target < 5",
    "player distance _target < 5",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        private _exitTeleport = _target getVariable ["exitTeleport", objNull];
        
        if (isNull _exitTeleport) exitWith { hint "No tunnel exit assigned"; };
        // Teleport player to exit point and set freefall height for safe landing
        _caller setVariable ["inTunnel", true, true];
        _caller setVariable ["tunnelExitTeleport", _exitTeleport, true];
        _caller setUnitFreefallHeight 32000;
        _caller setPosATL (getPosATL _exitTeleport vectorAdd [0,0,-3]);
    },
    {},
    [],
    2,
    100,
    false,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _tunnel];

// --- Exit Tunnel action (on the teleport point inside) ---
private _jipExit = format ["tunnels_exit_%1", netId _exitTeleport];
[
    _exitTeleport,
    "Exit Tunnel",
    "\a3\ui_f\data\igui\cfg\actions\ladderup_ca.paa",
    "\a3\ui_f\data\igui\cfg\actions\ladderup_ca.paa",
    "(_target getVariable ['tunnelActive', false]) && player distance _target < 10",
    "player distance _target < 10",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        private _source = _target getVariable ["linkedTunnel", objNull];
        if (!isNull _source) then {
            _caller setPosATL getPosATL _source;
            _caller setUnitFreefallHeight 100;
            _caller setVariable ["inTunnel", false, true];
        } else {
            private _exitPos = _target getVariable ["exitPosition", []];
            if (_exitPos isNotEqualTo []) then {
                _caller setPosATL _exitPos;
                _caller setUnitFreefallHeight 100;
                _caller setVariable ["inTunnel", false, true];
            } else {
                hint "No tunnel exit available";
            };
        };
    },
    {},
    [],
    2,
    100,
    false,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _jipExit];

// Store the JIP ID so it can be cleared on cleanup
_exitTeleport setVariable ["exitJipId", _jipExit, true];
_exitTeleport setVariable ["tunnelActive", true, true];

// --- Add drop grenade actions here (WIP) ---

true
