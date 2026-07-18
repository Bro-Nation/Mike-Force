/*
	File: fn_neck_snap_interrupt.sqf
	Author: tylervip
	Public: No

	Description:
		Restores player animation and re-enables target AI state when neck snap is interrupted.

	Parameter(s):
		_target - [OBJECT]
		_player - [OBJECT]

	Returns: nothing

	Example(s):
		[_target, _player] call vn_mf_fnc_neck_snap_interrupt;
*/
params ["_target", "_player"];

[_player, ""] remoteExec ["switchMove"];
[_target, "ANIM"] remoteExec ["enableAI", 2];
if (_target getVariable ["vn_mf_tunnel_ai", false]) exitWith {};
[_target, "path"] remoteExec ["enableAI", 2];
