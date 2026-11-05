/*
    File: spawn_or_replace_training_sea_mines.sqf
    Author: spade
    Description: Replaces training sea mines at the exact positions of Eden markers.
*/

// One underwater mine at each training_sea_mines_* marker's exact XY position.
// Independent of the water supply system. No automatic respawn.
if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\sea_mines\spawn_or_replace_training_sea_mines.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

private _markers = allMapMarkers select { _x find "training_sea_mines_" == 0 };
if (_markers isEqualTo []) exitWith {
    diag_log "Training sea mines: no training_sea_mines_* markers found.";
};
_markers sort true;

[] call compile preprocessFileLineNumbers "training\scripts\sea_mines\cleanup_training_sea_mines.sqf";

private _mines = [];
private _depthBelowSurface = 2;

{
    private _pos = markerPos _x;
    private _bottom = getTerrainHeightASL _pos;
    if (!(surfaceIsWater _pos) || {_bottom > -1.5}) then {
        diag_log format ["Training sea mines: skipped %1; requires water at least 1.5 m deep.", _x];
    } else {
        // Preserve marker XY; raise the mine only if needed for seabed clearance.
        private _z = (-_depthBelowSurface) max (_bottom + 0.5);
        private _asl = [_pos # 0, _pos # 1, _z];
        // Naval mines must receive their underwater depth at creation.
        // ASLToAGL can turn this into a positive seabed-relative height;
        // repositioning naval mines afterward is unreliable on clients.
        private _mine = createMine ["UnderwaterMine", _asl, [], 0];
        if (!isNull _mine) then {
            _mines pushBack _mine;
            diag_log format ["Training sea mines: spawned at %1 (%2).", _x, _asl];
        } else {
            diag_log format ["Training sea mines: creation failed at %1.", _x];
        };
    };
} forEach _markers;

missionNamespace setVariable ["vn_mf_training_sea_mines", _mines, true];
