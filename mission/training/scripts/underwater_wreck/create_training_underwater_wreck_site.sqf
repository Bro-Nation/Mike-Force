/*
    File: create_training_underwater_wreck_site.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Creates a training-only underwater wreck site with teardown that
        removes all spawned objects and restores hidden vegetation.

    Parameter(s):
        _pos - Position where the underwater wreck site is created [ARRAY]

    Returns:
        Created site store [OBJECT]

    Example(s):
        [_somePos] call (compile preprocessFileLineNumbers "training\scripts\underwater_wreck\create_training_underwater_wreck_site.sqf")
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

        private _spawnPos = [_sitePos # 0, _sitePos # 1, getTerrainHeightASL _sitePos];

        private _boat = createVehicle [
            "land_vn_boat_06_wreck",
            _spawnPos,
            [],
            0,
            "CAN_COLLIDE"
        ];
        _boat setDir -92.423;

        private _bb = boundingBoxReal _boat;
        private _minZ = (_bb # 0) # 2;

        private _z = _spawnPos # 2;
        for "_i" from 0 to 40 do {
            _boat setPosASL [_spawnPos # 0, _spawnPos # 1, _z];
            if ((_z + _minZ) > (getTerrainHeightASL _sitePos)) exitWith {};
            _z = _z + 0.1;
        };

        private _normal = surfaceNormal [_sitePos # 0, _sitePos # 1];
        _boat setVectorUp _normal;

        private _wall = createVehicle [
            "Land_HistoricalPlaneDebris_04_F",
            getPos _boat,
            [],
            0,
            "CAN_COLLIDE"
        ];
        _wall enableSimulation false;
        _wall allowDamage false;
        _wall attachTo [_boat, [-2.7, -3.3, 1.8]];
        [_wall, 112, 0, 0] call BIS_fnc_setPitchBank;

        private _blackbox = createVehicle [
            "Land_vn_mutt_vysilacka",
            getPos _boat,
            [],
            0,
            "CAN_COLLIDE"
        ];
        _blackbox enableSimulation false;
        _blackbox allowDamage false;
        _blackbox attachTo [_boat, [1.7, -4, 2.4]];

        private _markerPos = _spawnPos getPos [10 + random 20, random 360];
        private _marker = createMarker [format ["TrainingUnderwaterWreck_%1", _siteId], _markerPos];
        _marker setMarkerType "o_installation";
        _marker setMarkerText "Boat Wreck";
        _marker setMarkerAlpha 0;

        private _partialPos = _spawnPos getPos [10 + random 40, random 360];
        private _partialMarker = createMarker [format ["PartialTrainingUnderwaterWreck_%1", _siteId], _partialPos];
        _partialMarker setMarkerType "o_unknown";
        _partialMarker setMarkerAlpha 0;

        private _nearbyVegetation = nearestTerrainObjects [
            getPos _wall,
            ["TREE", "SMALL TREE", "BUSH"],
            10,
            false,
            true
        ];
        {
            _x hideObjectGlobal true;
        } forEach _nearbyVegetation;

        _siteStore setVariable ["markers", [_marker]];
        _siteStore setVariable ["partialMarkers", [_partialMarker]];
        _siteStore setVariable ["objectsToDestroy", [_wall, _blackbox, _boat]];
        _siteStore setVariable ["hiddenVegetation", _nearbyVegetation];
        _siteStore setVariable ["vehicles", [_boat, _blackbox]];
    },
    // Periodic teardown check
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

        private _hiddenVegetation = _siteStore getVariable ["hiddenVegetation", []];
        {
            if (!isNull _x) then {
                _x hideObjectGlobal false;
            };
        } forEach _hiddenVegetation;

        [_siteStore] call vn_mf_fnc_sites_utils_std_teardown;
    }
] call vn_mf_fnc_sites_create_site;
