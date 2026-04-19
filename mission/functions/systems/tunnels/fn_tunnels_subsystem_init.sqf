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

// --- Cache tunnel re-entry points ---
// These are Land_vn_infostand_v2_f objects with names like "tunnelReentry_0"
private _reentryPoints = [];
{
    private _name = vehicleVarName _x;
    if (_name find "tunnelReentry_" == 0) then {
        _reentryPoints pushBack _x;
    };
} forEach allMissionObjects "Land_vn_infostand_v2_f";

missionNamespace setVariable ["vn_mf_tunnel_reentry_points", _reentryPoints, true];

// --- Initialize tracking for used objectives ---
missionNamespace setVariable ["vn_mf_used_tunnel_objectives", [], true];

// --- Initialize tracking for created tunnels ---
missionNamespace setVariable ["vn_mf_tunnels", [], true];

// --- Initialize tracking for used teleports (prevent overlap) ---
missionNamespace setVariable ["vn_mf_used_tunnel_teleports", [], true];

// --- Initialize tunnel AI count tracking ---
missionNamespace setVariable ["vn_mf_tunnel_ai_count", 0, true];

// --- Add re-entry actions to tunnel reentry points ---
[_reentryPoints] call vn_mf_fnc_tunnels_add_reentry_actions;

// --- Start fallout detection loop ---
[] spawn vn_mf_fnc_tunnels_fallout_detection;

["INFO", format ["Tunnel subsystem initialized: %1 teleports, %2 objectives, %3 reentry points", count _teleports, count _objectives, count _reentryPoints]] call para_g_fnc_log;

true
