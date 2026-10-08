/*
	File: fn_neck_snap_start.sqf
	Author: tylervip
	Public: No

	Description:
		Starts neck snap animation and disables target AI movement/animation.

	Parameter(s):
		_target - [OBJECT]
		_player - [OBJECT]

	Returns: nothing

	Example(s):
		[_target, _player] call vn_mf_fnc_neck_snap_start;
*/
params ["_target", "_player"];

private _emote = selectRandom ["Acts_Executioner_Backhand", "Acts_Executioner_Forehand"];
[_player, _emote] remoteExec ["switchMove"];
[_target, "path"] remoteExec ["disableAI", 2];
[_target, "ANIM"] remoteExec ["disableAI", 2];
//stops plyer from bing stuck in and animation loop
sleep 2;
[_player, ""] remoteExec ["switchMove"];
[_target, "ANIM"] remoteExec ["enableAI", 2];
if (_target getVariable ["vn_mf_tunnel_ai", false]) exitWith {};
[_target, "path"] remoteExec ["enableAI", 2];

