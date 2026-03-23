/*
    File: fn_tunnels_subsystem_init.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Initializes the tunnel subsystem by caching all tunnel-related objects
        (teleport points and objective spawn points) placed in the editor.
        This should be called early in server init before sites are generated.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        call vn_mf_fnc_tunnels_subsystem_init
*/

if (!isServer) exitWith {};

// --- Cache teleport points ---
// These are Land_InvisibleBarrier_F objects with names like "inTunnelTeleport_0"
private _teleports = [];
{
    private _name = vehicleVarName _x;
    if (_name find "inTunnelTeleport_" == 0) then {
        _teleports pushBack _x;
    };
} forEach allMissionObjects "Land_InvisibleBarrier_F";

// Sort by name to ensure consistent ordering (0, 1, 2)
_teleports = _teleports apply { [vehicleVarName _x, _x] };
_teleports sort true;
_teleports = _teleports apply { _x select 1 };

missionNamespace setVariable ["vn_mf_tunnel_teleports", _teleports, true];

// --- Cache objective spawn points ---
// These are helper objects with names like "inTunnel_objective_0"
private _objectives = [];
{
    private _name = vehicleVarName _x;
    if (_name find "inTunnel_objective_" == 0) then {
        _objectives pushBack _x;
    };
} forEach allMissionObjects "All";

missionNamespace setVariable ["vn_mf_tunnel_objectives", _objectives, true];

// --- Initialize tracking for used objectives ---
missionNamespace setVariable ["vn_mf_used_tunnel_objectives", [], true];

// --- Initialize tracking for created tunnels ---
missionNamespace setVariable ["vn_mf_tunnels", [], true];

// --- Initialize tracking for used teleports (prevent overlap) ---
missionNamespace setVariable ["vn_mf_used_tunnel_teleports", [], true];

// --- Initialize tunnel AI count tracking ---
missionNamespace setVariable ["vn_mf_tunnel_ai_count", 0, true];

["INFO", format ["Tunnel subsystem initialized: %1 teleports, %2 objectives", count _teleports, count _objectives]] call para_g_fnc_log;

true
