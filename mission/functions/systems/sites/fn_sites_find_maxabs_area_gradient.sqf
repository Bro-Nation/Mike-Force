/*
    File: fn_sites_find_maxabs_area_gradient.sqf
    Author: @dijksterhuis
    Date: 2023-MAY-13
    Public: No
    
    Description:

    	Sample points within a circular area of a position and
    	calculate the maximum absolute terrain gradients of all
    	terrain gradients i.e. argmax_{G} | g |

		This catches peaks and troughs around a position better
		than the average terrain gradients.

		Average:

		___  ___/\___ ==> 0
		   \/

		Max Abs:

		___  ___/\___ ==> 1
		   \/

    Parameter(s):

        _pos - Location to test
		_radius - Radius to test
		_thetaStep - Rotational steps to take when sampling circle area
    
    Returns:

        The absolute maximum of all sampled gradients within an area [Number]
    
    Example(s):

        [[0,0,0], 100] call vn_mf_fnc_sites_find_maxabs_area_gradient;
        [[1200,30,25], 200, 15] call vn_mf_fnc_sites_find_maxabs_area_gradient;
*/

params ["_pos", "_radius", ["_thetaStep", 5]];

private _centrePosition = _pos;

if (_centrePosition isEqualType objNull) then { 
	_centrePosition = getPosASL _centrePosition;
};

if ((count _centrePosition) isEqualTo 2) then {
	_centrePosition = [
		(_centrePosition select 0),
		(_centrePosition select 1),
		(getTerrainHeightASL _centrePosition)
	];
};

private _centreTerrainHeight = getTerrainHeightASL [
	(_centrePosition select 0),
	(_centrePosition select 1)
];

private _searchPoints = [_centrePosition, _radius, _thetaStep] call vn_mf_fnc_get_circle_area_points;

private _deltaGradients = _searchPoints apply {
	private _deltaPos2D = [(_x select 0),(_x select 1)];
	private _deltaTerrainHeight = getTerrainHeightASL _deltaPos2D;
	atan((_deltaTerrainHeight - _centreTerrainHeight) / (_centrePosition distance2D _deltaPos2D))
};

selectMax (_deltaGradients apply {abs _x});
