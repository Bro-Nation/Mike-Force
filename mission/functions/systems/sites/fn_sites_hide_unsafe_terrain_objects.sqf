/*
	File: fn_sites_get_unsafe_terrain_objects.sqf
	Author: "DJ" Dijksterhuis"
	Public: No
	
	Description:
		
	
	Parameter(s):
		
	
	Returns:
		
	
	Example(s):
		
*/

private _debug = false;

params ["_sitePos", "_siteRadius", ["_terrainTypesArr", ["ROCK", "ROCKS", "HIDE"]]];

// get the first object only to avoid a nested for loop over every site object
// (leave the terrain object search radius high to capture everything nearby).
private _nearbyTerrainObjs = nearestTerrainObjects [
	_sitePos,
	_terrainTypesArr,
	vn_mf_sites_minimum_distance_between_sites,
	false,
	true
];

if (_debug) then {
	private _markerName = format ["maker-site-%1", [0, 10000] call BIS_fnc_randomInt];
	private _marker = createMarker [_markerName, _sitePos];
	_marker setMarkerAlpha 1;
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_siteRadius, _siteRadius];
	_marker setMarkerBrush "Border";
	_marker setMarkerColor "ColorGreen";

};

_nearbyTerrainObjs apply {

	// use a bounding box to work out the terrain object's radius from maximum x/y dimension.
	// https://community.bistudio.com/wiki/boundingBoxReal

	private _bbr = boundingBoxReal _x;
	private _maxXRadius = abs (((_bbr select 0) select 1) - ((_bbr select 1) select 1));
	private _maxYRadius = abs (((_bbr select 0) select 0) - ((_bbr select 1) select 0));

	private _maxDimensionRadius = (_maxXRadius max _maxYRadius) / 2;

	/*
	can now work out maximum size of the terrain object
	work out if the site intersects with the maximum dimension of the terrain object

	NOTE: For some reason we have to divide siteRadius by 2 to get this correct.
	Otherwise we remove terrain objects that do not intersect with the site's area.
	*/

	private _areaArr = [
		getPos _x, 
		_maxDimensionRadius + (_siteRadius / 2), 
		_maxDimensionRadius + (_siteRadius / 2),  
		0, 
		true
	];

	if (_sitePos inArea _areaArr) then {

		_x hideObjectGlobal true;

		/*
		rocks can have bushes placed on top of them.
		removing the rocks alone leaves the bushes stranded in mid air
		which looks janky as hell.
		so we need to remove any terrain objects on top of this terrain object.
		*/
		private _additionalObjects = nearestTerrainObjects [
			getPos _x,
			[], 
			_maxDimensionRadius,
			false,
			true
		];
		_additionalObjects apply {_x hideObjectGlobal true};

		if (_debug) then {

			diag_log format ["Hid terrain object: obj=%1 pos=%2", _x, getPos _x];

			private _markerName = format ["marker-terrain-object-%1", _x];
			private _marker = createMarkerLocal [_markerName, getPos _x];
			_marker setMarkerAlphaLocal 1;
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [_maxDimensionRadius, _maxDimensionRadius];
			_marker setMarkerBrushLocal "Border";

			_marker setMarkerColor "ColorRed";

		};

	};
};

