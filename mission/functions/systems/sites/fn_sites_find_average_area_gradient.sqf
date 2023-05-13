/*
    File: fn_sites_find_area_gradient.sqf
    Author: Cerebral
    Date: 2022-05-22
    Last Update: 2022-05-22
    Public: No
    
    Description:
        Tests a position's gradient and returns it's average gradient.
    
    Parameter(s):
        _pos - Location to test
		_areaRadius - Radius to test
    
    Returns:
        Average of the area's gradient [Number]
    
    Example(s):
        [0,0,0] call vn_mf_fnc_sites_find_area_gradient;
        [1200,30,25] call vn_mf_fnc_sites_find_area_gradient;
*/

params ["_pos", "_areaRadius"];

private _surroundGradients = [];
{
	private _gradientPosition = _finalPosition;
	if (_gradientPosition isEqualType objNull) then { _gradientPosition = getPosASL _gradientPosition };
	if ((count _gradientPosition) isEqualTo 2) then {
		_gradientPosition = [(_gradientPosition select 0),(_gradientPosition select 1),(getTerrainHeightASL _gradientPosition)];
	};
	private _deltaPosition = _gradientPosition getPos [_gradientRadius, _x]; 
	_gradientPosition = getTerrainHeightASL [(_gradientPosition select 0),(_gradientPosition select 1)];
	_deltaPosition = getTerrainHeightASL [(_deltaPosition select 0),(_deltaPosition select 1)];
	_surroundGradients pushBack (atan((_deltaPosition - _gradientPosition) / _gradientRadius));
} forEach [0, 45, 90, 135, 180, 225, 270, 315]; // unit circle :P

private _radAreaGrad = 0;
{
	if (_x < 0) then {
		_radAreaGrad = _radAreaGrad + (0 - _x);
	} else {
		_radAreaGrad = _radAreaGrad + _x;
	};
} forEach _surroundGradients;

(_radAreaGrad / (count _surroundGradients));
