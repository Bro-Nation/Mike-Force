/*
	File: fn_sites_objmapper_dynamic_grass.sqf
	Author: "DJ" dijksterhuis
	Public: No
	
	Description:
		Spawns in objects for site generation with BIS_fnc_objectsMapper.

		If the object is a type of "Land_vn_elephant_grass_01" then set the 
		badChance randomisation parameter to make sites more dynamic.
	
	Parameter(s): 
		_composition_arr: array of all object to spawn with BIS_fnc_objectsMapper
		_grassBadChance: random chance of *not* spawning "Land_vn_elephant_grass_01" objects
	
	Returns: all objects spawned in by object mapper BIS_fnc_objectsMapper
	
	Example(s):
		call vn_mf_fnc_action_destroy_respawn;
*/

params ["_composition_arr", ["_grassBadChance", 0.4]];

if !(_composition_arr isEqualType []) exitWith { [] };

private _grass_arr = _composition_arr select { ((_x select 0) isEqualTo "Land_vn_elephant_grass_01" ) };
private _non_grass_arr = _composition_arr select { !((_x select 0) isEqualTo "Land_vn_elephant_grass_01" ) };

private _randomAngle = [0,360] call BIS_fnc_randomInt;
private _grass_objs = [];
private _non_grass_objs = [];

if !(_grass_arr isEqualTo []) then {
    _grass_objs = [_position, _randomAngle, _grass_arr, _grassBadChance] call BIS_fnc_objectsMapper;
};

if !(_non_grass_arr isEqualTo []) then {
    _non_grass_objs = [_position, _randomAngle, _non_grass_arr, 0] call BIS_fnc_objectsMapper;
};

_grass_objs + _non_grass_objs