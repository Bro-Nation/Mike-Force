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

params [
	"_position",
	"_radius",
	"_waterMode",
	"_gradientRadius",
	"_gradientDegrees",
	"_terrainObjects"
];

private _fnc_checkWaterMode = {
	params ["_waterMode", "_p"];
	private _waterCheck = true;

	switch(_waterMode) do { 
		case 2: { if (surfaceIsWater _p) then { _waterCheck = false }; };
		case 1: { _waterCheck = false; };
		case 0: { if !(surfaceIsWater _p) then { _waterCheck = false }; };
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

private _fnc_getpos_and_check_valid = {

	params ["_p", "_z_r", "_s_r", "_s_g", "_w", "_blacklist"];

	private _safePosArgs = [_p, 0, _z_r, 0, _w, 0.5, 0, [_blacklist], [_p, _p]];
	private _c = _safePosArgs call BIS_fnc_findSafePos;
	private _searchPoints = [_c, _s_r, 150, "uniform"] call vn_mf_fnc_sample_positions_in_circle_area;
	private _radGrad = aCos ([0,0,1] vectorCos (surfaceNormal _c));
	private _areaRadGrad = [_c, _searchPoints] call vn_mf_fnc_sites_find_maxabs_area_gradient;
	
	private _waterChecks = _searchPoints apply {
		[_w, _x] call _fnc_checkWaterMode;
	};

	// none of the sampled points failed the water check 
	// (check returns true for a good position)
	private _waterCheck = (_waterChecks findIf {_x isEqualTo false} == -1);

	private _noSitesCheck = [_c] call _fnc_noSitesZoneCheck;

	private _debug = false;

	if (_debug) then {
	    _searchPoints apply {
	        private _mark = createMarker ["siteSpawnDebug" + str diag_tickTime + format ["%1", ceil (random 1e8)], _x];
	        _mark setMarkerType "mil_dot";
	        _mark setMarkerColor "ColorBlue";
	    };
	};

	if (
		(_radGrad > _s_g) 
		|| _areaRadGrad > _s_g
		|| _c isEqualTo []
		|| _c isEqualTo [0, 0]
		|| _waterCheck
		|| _noSitesCheck
	) then {
		[false, _c, _areaRadGrad]
	} else {
		[true, _c, _areaRadGrad]
	};
};

private _hqSites = missionNamespace getVariable ["side_sites_hq",[]];
private _factorySites = missionNamespace getVariable ["side_sites_factory",[]];
private _currentSites = _hqSites + _factorySites;
private _blacklistedSiteAreas  = []; 
{ 
	_blacklistedSiteAreas  append [getPos _x, vn_mf_sites_minimum_distance_between_sites]; 
} forEach _blacklistedSiteAreas;

private _iterations = 0;
private _bestPos = _position;
private _bestAreaGrad = 1e8;


// 3.141 km^2 ==> 3m141 m^2 ==> generate 3000 points and search
// instead of generating 256 x 15 points ?

while {true} do {

	private _res = [
		_position,
		_radius,
		_gradientRadius,
		_gradientDegrees,
		_waterMode,
		_blacklistedSiteAreas
	] call _fnc_getpos_and_check_valid;
	
	private _valid = _res select 0;
	private _testPos = _res select 1;
	private _areaGrad = _res select 2;

	if (_valid && _bestAreaGrad > _areaGrad) then {
		_bestAreaGrad = _areaGrad;
		_bestPos = _testPos;
	};

	// expand radius if needed
	// if((_iterations > 50) && (_iterations % 10 == 0)) then
	// {
	// 	_radius = _radius + 100;
	// };
	// after 100 tests return the best observed position so far.
	if(_iterations > 100) exitWith { _bestPos }; 
	_iterations = _iterations + 1;
};

if(!(_terrainObjects isEqualTo [])) then 
{
	{
		_x hideObjectGlobal true;
	} forEach (nearestTerrainObjects [_bestPos, _terrainObjects, _gradientRadius, false, true]);
};

_bestPos = _bestPos + [0];
_bestPos;