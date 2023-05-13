/*
	File: fn_sites_get_safe_location.sqf
	Author: Cerebral
	Date: 2022-05-21
	Last Update: 2022-05-21
	Public: No
	
	Description:
		Finds and clears an area for the site to spawn at.
	
	Parameter(s): 
		_position 			- 		Rough position of the site (can be within 1000 meters)
		_radius				-		Radius to search
		_waterMode 			- 		0: No water
									1: Can be in both
									2: In water
		_gradientRadius		-		Radius of the location gradient
		_gradientDegrees	-		Degrees of the location gradient
		_terrainObjects		-		Terrain objects to hide (Optional)
									https://community.bistudio.com/wiki/nearestTerrainObjects
	
	Returns: Good position for the site to spawn. [Position3D]
	
	Example(s):
		[[0,0,0], 1, 50, 5, ["TREE", "HIDE", "WATERTOWER", "BUSH"]] call vn_mf_fnc_sites_get_safe_location;
		[[0,0,0], 1, 50, 5] call vn_mf_fnc_sites_get_safe_location;
*/

params ["_position", "_radius", "_waterMode", "_gradientRadius", "_gradientDegrees", "_terrainObjects"];

private _fnc_checkWaterMode = {
	params[ "_waterMode" ];
	private _waterCheck = true;

	switch(_waterMode) do { 
		case 2: { if (surfaceIsWater _finalPosition) then { _waterCheck = false }; };
		case 1: { _waterCheck = false; };
		case 0: { if !(surfaceIsWater _finalPosition) then { _waterCheck = false }; };
		default { _waterCheck = true; };
	};

	_waterCheck
};

private _fnc_noSitesZoneCheck = {
	params["_position"];
	private _result = false;

	{
		if(_position inArea _x) then {
			_result = true;
		};
	} forEach vn_mf_markers_no_sites;

	_result
};

private _hqSites = missionNamespace getVariable ["side_sites_hq",[]];
private _factorySites = missionNamespace getVariable ["side_sites_factory",[]];
private _currentSites = _hqSites + _factorySites;
private _blacklistedSiteAreas  = []; 
{ 
	_blacklistedSiteAreas  append [getPos _x, vn_mf_sites_minimum_distance_between_sites]; 
} forEach _blacklistedSiteAreas;

private _finalPosition = [_position, 0, _radius, 0, _waterMode, 0.5, 0, [_blacklistedSiteAreas], [_position, _position]] call BIS_fnc_findSafePos;
private _radGrad = aCos ([0,0,1] vectorCos (surfaceNormal _finalPosition));
private _areaRadGrad = [_finalPosition, _radius] call vn_mf_fnc_sites_find_maxabs_area_gradient;
private _negativeDegree = _gradientDegrees - (_gradientDegrees * 2); //i'm tired sorry I just want a negative number
private _waterCheck = [_waterMode] call _fnc_checkWaterMode; //preemptively check watermode cause more performant
private _noSitesCheck = [_finalPosition] call _fnc_noSitesZoneCheck;

private _iterations = 0;
while  {(_radGrad > _gradientDegrees) 
		|| _gradientDegrees < _areaRadGrad 
		|| _areaRadGrad < _negativeDegree 
		|| _finalPosition isEqualTo []
		|| _waterCheck
		|| _noSitesCheck
} do { //keep searching
	_finalPosition = [_position, 30, _radius, 0, _waterMode, 0.3, 0, [_blacklistedSiteAreas], [_position, _position]] call BIS_fnc_findSafePos;
	
	_waterCheck = [_waterMode] call _fnc_checkWaterMode;
	_areaRadGrad = [_finalPosition, _radius] call vn_mf_fnc_sites_find_maxabs_area_gradient;
	_noSitesCheck = [_finalPosition] call _fnc_noSitesZoneCheck;
	_radGrad = aCos ([0,0,1] vectorCos (surfaceNormal _finalPosition));

	if((_iterations > 50) && (_iterations % 10 == 0)) then
	{
		_radius = _radius + 100; //expand radius until we find a valid spot
	};

	if(_iterations > 100) exitWith { _position }; //if all else fails revert to original position.
	_iterations = _iterations + 1;
};

if(!(_terrainObjects isEqualTo [])) then 
{
	{
		_x hideObjectGlobal true;
	} forEach (nearestTerrainObjects [_finalPosition, _terrainObjects, _gradientRadius, false, true]);
};

_finalPosition = _finalPosition + [0];
_finalPosition;