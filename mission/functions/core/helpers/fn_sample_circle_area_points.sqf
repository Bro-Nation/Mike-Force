
/*
    File: fn_sample_circle_area_points.sqf
    Author: @dijksterhuis
    Public: No
	
    Description:

        Generate a bunch of sampled points around circle area
        based on the provided centrepoint position.
	
    Parameter(s): 

        _pos: Centrepoint
        _radius: radius of the circle
        _thetaStep: step by this angle amount through the circle

    Return(s):

        Aray of positions within the circle's area.
	
    Example(s):

        [[0,0,0]] call vn_mf_fnc_sample_circle_area_points;
        [[0,0,0], 100] call vn_mf_fnc_sample_circle_area_points;
        [[0,0,0], 100, 15] call vn_mf_fnc_sample_circle_area_points;
*/


params ["_pos", ["_radius", 50], ["_thetaStep", 5]];

private _center = _pos;

private _unitCircleAngles = [];
for [
	{ private _theta = 0 }, 
	{ _theta < 360 }, 
	{ _theta = _theta + _thetaStep }
] do {
	_unitCircleAngles pushBack _theta
};

private _crossSectionSteps = [8, 7, 6, 5, 4, 3, 2, 1] apply {_radius * (_x / 8)};

private _positions = [];

_crossSectionSteps apply {
	private _step = _x;
	_unitCircleAngles apply {
		private _dir = _x;
		private _p = _center getPos [_step, _dir];
		_positions pushBack _p;
	};
};

_positions;
