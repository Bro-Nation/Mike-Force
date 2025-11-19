/*
    File: fn_sites_seed_zone_road_mines.sqf
    Author: Legend
    Public: No

    Description:
        Seed TM-57 AT mines on road positions inside the AO defined by _zone.
        Uses the AO’s marker center and vn_mf_bn_s_zone_radius.
        Appends mines to vn_site_objects so AO completion deletes them.
        Server-only and idempotent per zone.

    Params:
        _zone        - Zone marker name [STRING]
        _maxMines    - [OPTIONAL] max mines to place (default 10)
        _minSpacing  - [OPTIONAL] min spacing in meters between mines (default 100)
        _debug       - [OPTIONAL] show debug markers (default false)

    Returns: array of created mine objects
*/
params ["_zone", ["_maxMines",10], ["_minSpacing",100], ["_debug",false]];

if (!isServer) exitWith { [] };

// Idempotence per zone (covers retries during Prepare)
private _seedKey = format ["bn_road_mines_seeded_%1", _zone];
if (missionNamespace getVariable [_seedKey, false]) exitWith { [] };
missionNamespace setVariable [_seedKey, true];

// AO center & radius (same as sites_generate / Prepare use)
private _center = getMarkerPos _zone;
private _radius = missionNamespace getVariable [
    "vn_mf_bn_s_zone_radius",
    getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius")
];

// Collect road objects within search circle, then hard-filter to inside AO
private _roads = _center nearRoads _radius;
if (_roads isEqualTo []) exitWith { [] };

// Hlper: in-AO  check — mirrors teardown utils pattern
private _inAO = {
    params ["_p", "_c", "_r"];
    count ([_p] inAreaArray [_c, _r, _r, 0, false]) > 0
};

private _candidates = _roads select { (getPosATL _x) call { [_this, _center, _radius] call _inAO } };
if (_candidates isEqualTo []) exitWith { [] };

// Pick up to _maxMines with ≥ _minSpacing betwen picks only
private _shuffledCandidates = (_candidates) call BIS_fnc_arrayShuffle;
private _picked = [];
private _index = 0;

while { (count _picked < _maxMines) && (_index < count _shuffledCandidates) } do {
    private _candidate = _shuffledCandidates select _index;
    private _p = getPosATL _candidate;

    // Only add candidate if it meets spacing criteria against already pcked positions
    if (_picked findIf { _p distance2D _x < _minSpacing } == -1) then {
        _picked pushBack _p;
    };

    _index = _index + 1;
};

// Place mines
private _mineType = if (isClass (configFile >> "CfgAmmo" >> "vn_mine_tm57")) then {"vn_mine_tm57"} else {"ATMine"};
private _spawned = _picked apply { createMine [_mineType, _x, [], 0] };

// Register for AO-flip
if (_spawned isNotEqualTo []) then {
    if (isNil "vn_site_objects") then { vn_site_objects = []; };
    vn_site_objects append _spawned;
};

// Optional debug
if (_debug) then {
    {
        private _m = createMarker [format["mine_dbg_%1", _forEachIndex + round random 1e6], _x];
        _m setMarkerType "mil_dot";
        _m setMarkerColor "ColorRed";
        _m setMarkerText format["TM-57 #%1", _forEachIndex + 1];
    } forEach _picked;
};

["INFO", format ["RoadMines: seeded %1 mines in zone %2", count _spawned, _zone]] call para_g_fnc_log;

_spawned
