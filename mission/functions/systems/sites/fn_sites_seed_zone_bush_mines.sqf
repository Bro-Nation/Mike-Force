/*
    File: fn_sites_seed_zone_bush_mines.sqf
    Author: S. "Scoop" Cooper + Tylervip
    Public: Yes

    Description:
        Seeds punji traps inside AO based on zone marker.
        Same parameter style & behavior as road mine seeding.
        Server-only, idempotent per zone — returns array of traps.

    Params:
        _zone       - Zone marker name [STRING]
        _maxTraps   - [OPTIONAL] max traps to place (default 75)
        _minSpacing - [OPTIONAL] min spacing in meters between mines (default 8)
        _debug      - [OPTIONAL] debug markers (default false)
*/

params ["_zone", ["_maxTraps",75], ["_minSpacing",8], ["_debug",false]];
if (!isServer) exitWith { [] };

// Prevent re-seeding same zone
private _seedKey = format ["bn_bush_mines_seeded_%1", _zone];
if (missionNamespace getVariable [_seedKey,false]) exitWith { [] };
missionNamespace setVariable [_seedKey,true];

// Get center & radius exactly like road mines
private _center = getMarkerPos _zone;
private _radius = missionNamespace getVariable [
    "vn_mf_bn_s_zone_radius",
    getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius")
];

// find trees + bushes in AO
private _bushes = nearestTerrainObjects [_center, ["tree","bush"], _radius, false];
if (_bushes isEqualTo []) exitWith { [] };

private _traps = [
    "vn_mine_punji_02",
    "vn_mine_punji_01",
    "vn_mine_cartridge_range"
];

// randomize selection
private _list = _bushes call BIS_fnc_arrayShuffle;

private _spawned = [];
private _i = 0;

while {count _spawned < _maxTraps && _i < count _list} do {

    private _b = _list select _i;
    private _p = getPosATL _b;

    // spacing control
    if (_spawned findIf {_p distance2D _x < _minSpacing} == -1) then {

        private _trapType = selectRandom _traps;
        private _minePos = _p findEmptyPosition [1.5,12,_trapType];

        // only proceed if a valid position was found
        if (_minePos isNotEqualTo []) then {

            // skip if the position is in water
            if !(surfaceIsWater _minePos) then {

                _minePos set [2,0];  // flatten to ground
                private _mine = createMine [_trapType, _minePos, [], 0];
                _spawned pushBack _mine;

                // debug marker
                if (_debug) then {
                    private _m = createMarker [
                        format ["Trap_dbg_%1", diag_tickTime + random 1e5],
                        _minePos
                    ];
                    _m setMarkerType "mil_triangle";
                    _m setMarkerColor "ColorGreen";
                    _m setMarkerText format ["Trap #%1", count _spawned];
                };
            };
        };
    };
    _i = _i + 1;
};

// auto cleanup support
if (_spawned isNotEqualTo []) then {
    if (isNil "vn_site_objects") then { vn_site_objects = []; };
    vn_site_objects append _spawned;
};

["INFO", format ["Bush Mines: seeded %1 traps in zone %2", count _spawned,_zone]] call para_g_fnc_log;

_spawned
