/*
	File: fn_sample_positions_circle.sqf
	Author: @dijksterhuis
	Public: No
	
	Description:
		Get N positions from within a circular area.
	
	Parameter(s):
		_pos -- POSITION/OBJECT: circle centrepoint
		_radius -- FLOAT: radius of circle
		_n_samples -- INTEGER: how many positions to generate
		_type -- [OPTIONAL] STRING: how to do the sample, default 'uniform'
	
	Returns:
		N positions randomly sampled from within the defined circle.
	
	Example(s):
		[getPos player, 10, 4] call vn_mf_fnc_sample_positions_circle;
		[[0, 0, 0], 100, 10, "centered"] call vn_mf_fnc_sample_positions_circle;
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

while {(count _samples) < _n_samples} do {
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

_samples;