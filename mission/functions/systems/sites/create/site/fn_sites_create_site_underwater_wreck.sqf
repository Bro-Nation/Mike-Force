/*
    File: fn_sites_create_site_underwater_wreck.sqf
    Author: Tylervip
    Public: yes

    Description:
        Creates an underwater wreck site objective using a submerged wreck,
        debris, and radio object. Uses the standard site framework.

    Parameter(s):
        _pos - Position where the underwater wreck site is created

    Returns:
        Function reached the end [BOOL]

    Example:
        [markerPos "wreck_site_1"] call vn_mf_fnc_sites_create_site_underwater_wreck;
*/
params ["_pos"];

[
    "underwater_wreck",
    _pos,
    "hq",
    // Setup Code
    {
        params ["_siteStore"];
        private _siteId = _siteStore getVariable "site_id";
        private _sitePos = getPos _siteStore;

        // --- Spawn boat on seabed ---
        private _spawnPos = [_sitePos # 0, _sitePos # 1, getTerrainHeightASL _sitePos];
        private _boat = createVehicle [
            "land_vn_boat_06_wreck",
            _spawnPos,
            [],
            0,
            "CAN_COLLIDE"
        ];

        // setup heading (initial)
        _boat setDir -92.423;

        // --- Plane debris ---
        private _wallOffset = [-2.7, -3.3, 1.8];
        private _wall = createVehicle [
            "Land_HistoricalPlaneDebris_04_F",
            getPos _boat,
            [],
            0,
            "CAN_COLLIDE"
        ];
        _wall enableSimulation false;
        _wall attachTo [_boat, _wallOffset];
        [_wall, 112, 0, 0] call BIS_fnc_setPitchBank;
        _wall enableSimulation true;

        // --- Radio ---
        private _radioOffset = [1.7, -4, 2.4];
        private _radio = createVehicle [
            "Land_vn_mutt_vysilacka",
            getPos _boat,
            [],
            0,
            "CAN_COLLIDE"
        ];
        _radio enableSimulation false;
        _radio attachTo [_boat, _radioOffset];
        _radio enableSimulation true;

		// --- FINAL BOAT ORIENTATION & ALIGNMENT ---

		// spawn temporary box at the spawn position
		private _box = "vn_o_ammobox_02" createVehicle _spawnPos;
		_box enableSimulation true;
		_box setDamage 1;
		_box setDir random 360;

		// move boat onto the box
		_boat enableSimulation false;
		_boat setPos getPos _box;
		_boat setDir getDir _box;

		// align boat to terrain slope
		private _terrainNormal = surfaceNormal [_spawnPos # 0, _spawnPos # 1];
		_boat setVectorUp _terrainNormal;

		// re-enable simulation
		_boat enableSimulation true;

		// delete the temporary box
		deleteVehicle _box;

        // --- Markers ---
        private _markerPos = _spawnPos getPos [10 + random 20, random 360];
        private _marker = createMarker [format ["UnderwaterWreck_%1", _siteId], _markerPos];
        _marker setMarkerType "o_installation";
        _marker setMarkerText "Boat Wreck";
        _marker setMarkerAlpha 0;

        private _partialPos = _spawnPos getPos [10 + random 40, random 360];
        private _partialMarker = createMarker [format ["PartialUnderwaterWreck_%1", _siteId], _partialPos];
        _partialMarker setMarkerType "o_unknown";
        _partialMarker setMarkerAlpha 0;

        // --- AI Stuff ---

        // --- Store site data ---
        _siteStore setVariable ["markers", [_marker]];
        _siteStore setVariable ["partialMarkers", [_partialMarker]];
        _siteStore setVariable ["vehicles", [_boat]];
        _siteStore setVariable ["objectsToDestroy", [_wall]];
    },
    // Teardown condition check
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

true;
