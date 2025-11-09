/*
    vn_mf_spawn_tank_dozer
    Spawns a tank with an attached dozer, handles tank destruction, and respawns tank + dozer at the original spawn object.
*/

params ["_spawnObj"];

if (isNull _spawnObj) exitWith { [] };

// --- Spawn tank ---
private _pos = getPosATL _spawnObj;
private _dir = getDir _spawnObj;
private _tank = createVehicle ["vn_b_armor_m113_01", _pos, [], 0, "CAN_COLLIDE"];
if (isNull _tank) exitWith { [] };
_tank setDir _dir;
_tank enableSimulationGlobal true;

// Store spawn object on tank for respawn reference
_tank setVariable ["spawnObj", _spawnObj, true];

// --- Spawn indestructible dozer and attach ---
private _dozer = createVehicle ["Land_vn_bulldozer_01_wreck_f", _pos, [], 0, "CAN_COLLIDE"];
if (isNull _dozer) exitWith { [] };
_dozer allowDamage false;
_dozer attachTo [_tank, [0, 1, -0.8]];
_dozer setDir 180;

// --- Initialize tree-clearing function ---
[_tank] call vn_mf_fnc_bulldozer_trees;

// --- Handle tank destruction ---
_tank addEventHandler ["Killed", {
    params ["_veh", "_killer", "_instigator"];

    // Get the spawn object from the tank
    private _spawnObj = _veh getVariable ["spawnObj", objNull];
    if (isNull _spawnObj) exitWith {};

    // Expect exactly one attached dozer
    private _attached = attachedObjects _veh;
    private _dozer = if ((count _attached) > 0 && {typeOf (_attached select 0) == "Land_vn_bulldozer_01_wreck_f"}) then { _attached select 0 } else { objNull };

    // If no dozer for some reason, do nothing
    if (isNull _dozer) exitWith {};

    // Capture context and perform cleanup + respawn
    [_dozer, _veh, _spawnObj] spawn {
        params ["_dozerLocal", "_vehLocal", "_spawnObjOuter"];
        sleep 20;
        private _posDel = getPosATL _vehLocal;
        detach _dozerLocal;
        deleteVehicle _dozerLocal;
        deleteVehicle _vehLocal;

        // Respawn tank and dozer at original spawn object
        [_spawnObjOuter] spawn vn_mf_fnc_spawn_tank_dozer;
    };
}];

[_tank, _dozer]