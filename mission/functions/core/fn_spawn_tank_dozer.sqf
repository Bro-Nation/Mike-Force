/*
    File: vn_mf_spawn_tank_dozer.sqf
	Author: Tylervip
	Public: yes

    Spawns a tank with an attached dozer, handles tank destruction, and respawns tank + dozer at the original spawn object.
    [this] spawn vn_mf_fnc_spawn_tank_dozer;
    adds dozer tree-clearing functionality to the tank.
    [_tank] remoteExecCall ["vn_mf_fnc_bulldozer_trees", 0, _tank];
    
*/
if (!isServer) exitWith {};  // only the server creates tanks

params ["_spawnObj"];
if (isNull _spawnObj) exitWith { [] };

// --- Spawn tank ---
private _pos = getPosATL _spawnObj;
private _dir = getDir _spawnObj;
private _tank = createVehicle ["vn_b_armor_m113_01", _pos, [], 0, "CAN_COLLIDE"];
if (isNull _tank) exitWith { [] };
_tank setDir _dir;
_tank enableSimulationGlobal true;
_tank setVariable ["spawnObj", _spawnObj, true];

// --- Spawn indestructible dozer ---
private _dozer = createVehicle ["Land_vn_bulldozer_01_wreck_f", _pos, [], 0, "CAN_COLLIDE"];
_dozer allowDamage false;
_dozer attachTo [_tank, [0, 1, -0.8]];
_dozer setDir 180;

// --- Initialize tree-clearing for all clients ---
[_tank] remoteExecCall ["vn_mf_fnc_bulldozer_trees", 0, _tank];

// --- Server monitor for tank destruction ---
[_spawnObj, _tank, _dozer] spawn {
    params ["_spawnObjLocal", "_tankLocal", "_dozerLocal"];

    waitUntil { isNull _tankLocal || { !alive _tankLocal } };

    sleep 20;  // allow physics/wrecks to settle

    // cleanup dozer
    private _attached = if (isNull _tankLocal) then { [] } else { attachedObjects _tankLocal };
    private _dozerFinal = if ((count _attached) > 0 && {typeOf (_attached select 0) == "Land_vn_bulldozer_01_wreck_f"}) then { _attached select 0 } else { _dozerLocal };

    if (!isNull _dozerFinal) then { detach _dozerFinal; deleteVehicle _dozerFinal; };
    if (!isNull _tankLocal) then { deleteVehicle _tankLocal; };

    sleep 0.5;  // ensure deletion replicates
    [_spawnObjLocal] spawn vn_mf_fnc_spawn_tank_dozer;
};

[_tank, _dozer]