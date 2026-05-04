/*
    File: fn_tunnels_spawn_objective_ai.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Spawns tunnel AI units at mission start on tunnel AI spawn points.
        Independent from Paradigm AI count.
        Should be called once during mission initialization.

    Parameter(s):
        _count - Number of AI units to spawn [NUMBER]

    Returns:
        Array of spawned units [ARRAY]

    Example(s):
        private _units = [20] call vn_mf_fnc_tunnels_spawn_objective_ai
*/

params [["_count", 20]];

if (!isServer) exitWith { [] };

private _spawnedUnits = [];
private _unitTypes = [
    "vn_o_men_nva_dc_01", //ak
    "vn_o_men_nva_dc_04", //ak
    "vn_o_men_nva_dc_08", //ppsh
    "vn_o_men_nva_dc_09", //ppsh
    "vn_o_men_nva_dc_11"  //rpd
];

// Create single group for all tunnel AI
private _group = createGroup [east, true];

// Get tunnel objectives as spawn locations
private _tunnelObjectives = missionNamespace getVariable ["vn_mf_tunnel_objectives", []];

// Collect all available building positions near objectives
private _allBuildingPositions = [];
{
    private _objectivePos = getPosATL _x;
    private _nearbyObjects = nearestObjects [_objectivePos, [], 10];
    {
        // Skip buildings
        if ((toLower (typeOf _x)) find "platform" == -1) then {
            private _positions = [_x] call BIS_fnc_buildingPositions;
            _allBuildingPositions append _positions;
        };
    } forEach _nearbyObjects;
} forEach _tunnelObjectives;

// Spawn units distributed across building positions
for "_i" from 1 to _count do {
    private _spawnPos = if (count _allBuildingPositions > 0) then {
        _allBuildingPositions select floor(random count _allBuildingPositions)
    } else {
        getPosATL (selectRandom _tunnelObjectives)
    };
    
    private _unitType = selectRandom _unitTypes;
    private _unit = _group createUnit [_unitType, _spawnPos, [], 0, "NONE"];
    
    _unit setPosATL _spawnPos;
    
    _unit setVariable ["vn_mf_tunnel_ai", true, true];
    _unit setSkill ["aimingAccuracy", 0.25];
    _unit disableAI "PATH";
    _unit setUnitFreefallHeight 32000;
    _spawnedUnits pushBack _unit;

    // Remove all throwable items from the unit dynamically
        {
            if (isThrowable (_x select 0)) then {
                _unit removeMagazines (_x select 0);
            };
        } forEach magazinesAmmoFull _unit;
    
    // Remove all mines from the unit
    {
        _unit removeMagazines _x;
    } forEach (magazines _unit select { _x find "Mine" != -1 || _x find "mine" != -1 });
        
    // Add killed event handler for cleanup
    _unit addEventHandler ["Killed", {
        params ["_unit", "_killer"];
        [_unit] spawn {
            private _grp = group (_this select 0);
            sleep 60;
            deleteVehicle (_this select 0);
            if (count units _grp == 0) then {
                deleteGroup _grp;
            };
        };
    }];
};


missionNamespace setVariable ["vn_mf_tunnel_ai_count", count _spawnedUnits, true];
missionNamespace setVariable ["vn_mf_tunnel_ai_units", _spawnedUnits, true];

["INFO", format ["Spawned %1 tunnel AI units at AO start", count _spawnedUnits]] call para_g_fnc_log;

_spawnedUnits
