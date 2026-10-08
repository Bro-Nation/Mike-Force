/*
	File: fn_neck_snap_ai.sqf
	Author: tylervip
	Public: No

	Description:
		Validates and executes a close-range neck snap kill on enemy AI.

	Parameter(s):
		_target - [OBJECT]
		_player - [OBJECT]

	Returns: nothing

	Example(s):
		[_target, _player] call vn_mf_fnc_neck_snap_ai;
*/
params ["_target", "_player"];

_target setDamage 1;
[_player, ""] remoteExec ["switchMove", 0];
