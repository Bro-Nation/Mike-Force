/*
    File: fn_sites_create_site_tunnel.sqf
    Author: Tylervip
    Public: yes

    Description:
        Creates a new Tunnel site in the given location with crates and tunnel teleports.
        Each tunnel site now uses its own teleport points, so Enter Tunnel always goes to a site-specific teleport.

    Parameter(s):
        _pos - Position to spawn the Tunnel site at

    Returns:
        Function reached the end [BOOL]

    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_site_tunnel
*/

params ["_pos"];

[
    "tunnel",
    _pos,
    "hq",
    // Setup Code
    {
        params ["_siteStore"];
        private _siteId = _siteStore getVariable "site_id";
        private _spawnPos = getPos _siteStore;

        // --- Tunnel object ---
        private _tunnel = ["Land_vn_o_trapdoor_01", _spawnPos] call para_g_fnc_create_vehicle;
        _tunnel setVariable ["siteStore", _siteStore, true];
        vn_site_objects pushBack _tunnel;

        // --- Register tunnel with subsystem (adds actions and assigns teleport) ---
        [_tunnel] call vn_mf_fnc_tunnels_register_tunnel;

        // --- Crate spawning at tunnel objective point ---
        private _crateSpawn = call vn_mf_fnc_tunnels_get_available_objective;
        if (!isNull _crateSpawn) then {
            private _crate = [
                selectRandom ["Land_vn_pavn_weapons_stack1","Land_vn_pavn_weapons_stack2","Land_vn_pavn_weapons_stack3"],
                getPosATL _crateSpawn
            ] call para_g_fnc_create_vehicle;

            _crate setVariable ["exemptFromRadiusCheck", true];
            vn_site_objects pushBack _crate;
            _siteStore setVariable ["objectsToDestroy", [_crate], true];
        } else {
            systemChat "No available tunnel objective spots for crate spawn";
        };

        // --- Markers ---
        private _tunnelMarker = createMarker [format ["Tunnel_%1", _siteId], _spawnPos getPos [10 + random 20, random 360]];
        _tunnelMarker setMarkerType "o_installation";
        _tunnelMarker setMarkerText "Tunnel";
        _tunnelMarker setMarkerAlpha 0;

        private _partialMarker = createMarker [format ["PartialTunnel_%1", _siteId], _spawnPos getPos [10 + random 40, random 360]];
        _partialMarker setMarkerType "o_unknown";
        _partialMarker setMarkerAlpha 0;

        _siteStore setVariable ["markers",[_tunnelMarker]];
        _siteStore setVariable ["partialMarkers",[_partialMarker]];

        // --- AI Objectives ---
        if (random 1 < 0.7) then {
            _siteStore setVariable ["aiObjectives", [[_spawnPos,1,1] call para_s_fnc_ai_obj_request_ambush]];
        } else {
            _siteStore setVariable ["aiObjectives", [[_spawnPos,1,1] call para_s_fnc_ai_obj_request_defend]];
        };

        // --- Mines ---
        if (random 1 < 0.5) then {
            private _mines = ([3, ceil random 8] call vn_mf_fnc_range) apply {
                private _minePos = _spawnPos getPos [random 10, random 360];
                createMine ["vn_mine_punji_02", _minePos, [], 0]
            };
            vn_site_objects append _mines;
        };

    },
    // Teardown condition check code
    {
        15 call _fnc_periodicallyAttemptTeardown;
    },
    // Teardown condition
    {
        params ["_siteStore"];
        [_siteStore] call vn_mf_fnc_sites_utils_std_check_teardown;
    },
    // Teardown code
    {
        params ["_siteStore"];
        [_siteStore] call vn_mf_fnc_sites_utils_std_teardown;
    }
] call vn_mf_fnc_sites_create_site;
