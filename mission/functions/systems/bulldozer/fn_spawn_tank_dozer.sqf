/*
    File: fn_spawn_tank_dozer.sqf
    Author: Tylervip
    modified: TernaryOperator
    Public: yes

    description:
        Spawns an M113 with an attached dozer blade and invisible AI targets, enables
        tree clearing on all clients, and respawns everything at the spawn object after destruction.

    Parameter(s):
        0: OBJECT - spawn object (position/direction source)

    Returns:
        ARRAY - [tank, dozer, invisible targets] (empty array on failure)

    Example:
        [this] call vn_mf_fnc_spawn_tank_dozer;
*/
if (!isServer) exitWith {};  // only the server creates tanks

params ["_spawnObj"];
if (isNull _spawnObj) exitWith { [] };

private _pos = getPosATL _spawnObj;
private _dir = getDir _spawnObj;
private _tank = createVehicle ["vn_b_armor_m113_01", _pos, [], 0, "CAN_COLLIDE"];
if (isNull _tank) exitWith { [] };
_tank setDir _dir;
_tank enableSimulationGlobal true;
_tank setVariable ["spawnObj", _spawnObj, true];

// Indestructible dozer blade
private _dozer = createSimpleObject ["Land_vn_bulldozer_01_wreck_f", _pos];
_dozer allowDamage false;
_dozer attachTo [_tank, [0, 1, -0.8]];
_dozer setDir 180;
_dozer enableSimulationGlobal false;

// Invisible targets so AI can see/engage the tank
private _targets = [_tank, _pos] call vn_mf_fnc_bulldozer_targets_init;

// Tree clearing on all clients (JIP-tied to the tank)
[_tank] remoteExecCall ["vn_mf_fnc_bulldozer_trees", 0, _tank];

// When the tank dies or is deleted: clean up all attached objects, then delete the tank and respawn once
[
    {
        params ["_spawnObjLocal", "_tankLocal", "_dozerLocal", "_targetsLocal"];
        !(_tankLocal getVariable ["vn_mf_bulldozer_respawnQueued", false]) && { isNull _tankLocal || { !alive _tankLocal } }
    },
    {
        params ["_spawnObjLocal", "_tankLocal", "_dozerLocal", "_targetsLocal"];

        if (!isNull _tankLocal) then {
            _tankLocal setVariable ["vn_mf_bulldozer_respawnQueued", true, true];
            [_tankLocal] call vn_mf_fnc_cleanup_tank_dozer;
        };

        [
            {
                params ["_spawnObjLocal", "_tankLocal"];

                if (!isNull _tankLocal) then { deleteVehicle _tankLocal; };

                // Spawn object gone: nothing to respawn at
                if (isNull _spawnObjLocal) exitWith {};

                [
                    { [_this] call vn_mf_fnc_spawn_tank_dozer; },
                    _spawnObjLocal,
                    0.5
                ] call CBA_fnc_waitAndExecute;
            },
            [_spawnObjLocal, _tankLocal],
            20
        ] call CBA_fnc_waitAndExecute;
    },
    [_spawnObj, _tank, _dozer, _targets]
] call CBA_fnc_waitUntilAndExecute;

[_tank, _dozer, _targets]

