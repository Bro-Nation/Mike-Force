/*
	File: fn_check_side.sqf
	Author: Cerebral
	Public: No
	
	Description:
		Tests if a player is within a given radius of a position.
		Implement as a function, so we can optimise it easily later.
	
	Parameter(s):
		_player - Callee [OBJECT];
		_target - Target player [OBJECT];
	
	Returns:
		False if a player is not on the same side [Boolean]
	
	Example(s):
		[_player, _target] call vn_mf_fnc_check_side;
*/

params ["_player", "_target"];

private _playerSide = side _player;
private _targetTeam = side _target;

if (_targetSide == civilian) exitWith
{
	true
};

if (_playerSide == east && _targetTeam != east) exitWith
{
	false
};

if (_playerSide != east && _targetTeam == east) exitWith //i'm sure there's a better way of handling this
{														 //will fix later
	false
};

true
