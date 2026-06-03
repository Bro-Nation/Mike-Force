/*
    File: create_training_water_supply_site.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Creates a training-only water supply site with custom teardown that
        explicitly removes spawned sea mines.

    Parameter(s):
        _pos - Position to spawn the site at [ARRAY]

    Returns:
        Created site store [OBJECT]

    Example(s):
        [_somePos] call (compile preprocessFileLineNumbers "training\scripts\water_supply\create_training_water_supply_site.sqf")
*/

params ["_pos"];

[
    "tunnel_watersupply",
    _pos,
    "hq",
    // Setup code
    {
        params ["_siteStore"];

        private _siteId = _siteStore getVariable "site_id";
        private _sitePos = getPos _siteStore;
        private _spawnPos = [_sitePos # 0, _sitePos # 1, (_sitePos # 2) + 3];

        private _tunnelWS = "vn_o_ammobox_02" createVehicle _spawnPos;

        private _markerPos = _spawnPos getPos [10 + random 20, random 360];
        private _supplyMarker = createMarker [format ["Tunnel_WaterSupply_%1", _siteId], _markerPos];
        _supplyMarker setMarkerType "o_installation";
        _supplyMarker setMarkerText "Water Supply";
        _supplyMarker setMarkerAlpha 0;

        private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
        private _markerPartial = createMarker [format ["PartialTunnel_WaterSupply_%1", _siteId], _partialMarkerPos];
        _markerPartial setMarkerType "o_unknown";
        _markerPartial setMarkerAlpha 0;

        [_tunnelWS, true] call para_s_fnc_enable_dynamic_sim;

        private _seaMines = [];

        // Sea mines disabled for training.
        // private _asl = getPosASL _tunnelWS;
        // private _aslZ = _asl # 2;
        // private _depth = 0 - _aslZ;
        // if (_depth >= 5) then {
        //     private _waterSurfaceZ = 0;
        //
        //     for "_i" from 1 to 5 do {
        //         private _mine = objNull;
        //
        //         while {isNull _mine} do {
        //             private _angle = random 360;
        //             private _distance = 10 + random 15;
        //             private _xyOffset = _spawnPos getPos [_distance, _angle];
        //
        //             private _minZ = _waterSurfaceZ - 5;
        //             private _maxZ = _aslZ + 1;
        //             private _mineZ = _minZ + random (_maxZ - _minZ);
        //
        //             private _mineASL = [_xyOffset # 0, _xyOffset # 1, _mineZ];
        //             private _terrainZ = getTerrainHeightASL _mineASL;
        //
        //             if ((_mineZ - _terrainZ) >= 0.5) then {
        //                 _mine = createMine ["UnderwaterMine", _mineASL, [], 0];
        //                 _seaMines pushBack _mine;
        //             };
        //         };
        //     };
        // };

        _siteStore setVariable ["markers", [_supplyMarker]];
        _siteStore setVariable ["partialMarkers", [_markerPartial]];
        _siteStore setVariable ["supplys", [_tunnelWS]];
        _siteStore setVariable ["vehicles", [_tunnelWS]];
        _siteStore setVariable ["objectsToDestroy", [_tunnelWS]];
        _siteStore setVariable ["seaMines", _seaMines];
    },
    // Teardown condition check scheduling
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

        private _seaMines = _siteStore getVariable ["seaMines", []];
        {
            if (!isNull _x) then {
                deleteVehicle _x;
            };
        } forEach _seaMines;

        [_siteStore] call vn_mf_fnc_sites_utils_std_teardown;
    }
] call vn_mf_fnc_sites_create_site;
