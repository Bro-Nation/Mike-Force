
/*
    File: fn_sample_positions_in_circle_area.sqf
    Author: @dijksterhuis
    Public: No
	
    Description:

        Sample N points within a circular area from the centrepoint position.

        References:

        https://community.bistudio.com/wiki/Example_Code:_Random_Area_Distribution
        https://sqf.ovh/sqf%20math/2018/05/05/generate-a-random-position.html
	
    Parameter(s): 

        _pos: Centrepoint of the circle.
        _radius: Radius of the circle's area (default: 100)
        _N: Number of positions to sample (default: 100)
        _type: Sampling distributon type (default: "uniform")

    Return(s):

        Aray of positions within the circle's area.
	
    Example(s):

        [[0,0,0]] call vn_mf_fnc_sample_positions_in_circle_area;
        [[0,0,0], 50] call vn_mf_fnc_sample_positions_in_circle_area;c
        [[0,0,0], 50, 200] call vn_mf_fnc_sample_positions_in_circle_area;
        [[0,0,0], 50, 200, "gaussian"] call vn_mf_fnc_sample_positions_in_circle_area;
*/

params [
    "_pos", 
    ["_radius", 100], 
    ["_n_samples", 100],
    ["_type", "uniform"]
];

private _fnc_centered = {
    params ["_p", "_r"];
    _p getPos [random _r, random 360]
};

private _fnc_uniform = {
    params ["_p", "_r"];
    _p getPos [_r * sqrt random 1, random 360]
};

private _fnc_normal = {
    params ["_p", "_r"];
    _p getPos [_r *  random [-1, 0, 1], random 180]
};

private _fnc_normal_inverted_radius = {
    params ["_p", "_r"];
    _p getPos [_r * (1 - abs random [-1, 0, 1]), random 360]
};

private _fnc_normal_inverted_area = {
    params ["_p", "_r"];
    _p getPos [_r * sqrt (1 - abs random [-1, 0, 1]), random 360]
};

private _fnc_ring_area_half = {
    params ["_p", "_r"];
    _p getPos [sqrt ((_r / 2)^2 + random (_r^2 - (_r / 2)^2)), random 360]
};

private _samples = [];

while {(count _samples) <= _n_samples} do {
    switch (_type) do 
    {
        case "uniform": {
            _samples pushBack ([_pos, _radius] call _fnc_uniform);
        };
        case "centered": {
            _samples pushBack ([_pos, _radius] call _fnc_centered);
        };
        case "normal": {
            _samples pushBack ([_pos, _radius] call _fnc_normal);
        };
        case "normal-iradius": {
            _samples pushBack ([_pos, _radius] call _fnc_normal_inverted_radius);
        };
        case "normal-iarea": {
            _samples pushBack ([_pos, _radius] call _fnc_normal_inverted_area);
        };
        case "ring-half": {
            _samples pushBack ([_pos, _radius] call _fnc_ring_area_half);
        };
        default {
            _samples pushBack ([_pos, _radius] call _fnc_uniform);
        };
    };
};

_samples