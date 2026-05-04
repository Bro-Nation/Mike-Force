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

        // --- Tunnel objects (closed and open) ---
        private _tunnelClosed = ["Land_vn_o_trapdoor_01", _spawnPos] call para_g_fnc_create_vehicle;
        private _tunnelOpen = ["Land_vn_o_trapdoor_02", _spawnPos] call para_g_fnc_create_vehicle;

        // Force exact overlap so swapping visibility does not shift location.
        _tunnelOpen setPosWorld (getPosWorld _tunnelClosed);
        _tunnelOpen setDir (getDir _tunnelClosed);
        _tunnelOpen setVectorDirAndUp [vectorDir _tunnelClosed, vectorUp _tunnelClosed];
        
        _tunnelClosed setVariable ["siteStore", _siteStore, true];
        _tunnelOpen setVariable ["siteStore", _siteStore, true];
        _tunnelClosed setVariable ["linkedOpenTunnel", _tunnelOpen, true];
        _tunnelOpen setVariable ["linkedClosedTunnel", _tunnelClosed, true];
        
        vn_site_objects pushBack _tunnelClosed;
        vn_site_objects pushBack _tunnelOpen;
        
        // Hide the open trapdoor initially
        _tunnelOpen hideObjectGlobal true;
        
        // Register only the open tunnel with subsystem (adds actions and assigns teleport)
        [_tunnelOpen] call vn_mf_fnc_tunnels_register_tunnel;
        
        // Add trap mechanics and open action to the closed trapdoor
        [_tunnelClosed] call vn_mf_fnc_tunnels_add_actions;

        // --- Crate spawning at tunnel objective point ---
        private _crateSpawn = call vn_mf_fnc_tunnels_get_available_objective;
        if (!isNull _crateSpawn) then {
            private _crateSpawnPos = getPosATL _crateSpawn;
            private _crate = [
                selectRandom ["vn_o_ammobox_02"],
                _crateSpawnPos
            ] call para_g_fnc_create_vehicle;

            _crate allowDamage false;
            [_crate] spawn {
                sleep 5;
                (_this select 0) allowDamage true;
            };

            [_crate, _crateSpawnPos] spawn {
                params ["_crate", "_originPos"];
                while {!isNull _crate} do {
                    if ((_crate distance _originPos) > 3) then {
                        _crate allowDamage false;
                        _crate setPosATL _originPos;
                        sleep 1;
                        _crate allowDamage true;
                    };
                    sleep 15;
                };
            };

            _crate setVariable ["exemptFromRadiusCheck", true];
            _crate setVariable ["originSpawnPos", _crateSpawnPos, true];
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
        if (random 1 < 0.5) then {
            _siteStore setVariable ["aiObjectives", [[_spawnPos,1,1] call para_s_fnc_ai_obj_request_ambush]];
        } else {
            _siteStore setVariable ["aiObjectives", [[_spawnPos,1,1] call para_s_fnc_ai_obj_request_defend]];
        };

        // --- Mines ---
        if (random 1 < 0.5) then {
            private _mines = ([3, ceil random 8] call vn_mf_fnc_range) apply {
                private _minePos = _spawnPos getPos [2 + random 10, random 360];
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
