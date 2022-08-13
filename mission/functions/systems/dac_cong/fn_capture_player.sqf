/*
    File: fn_capture_player.sqf
    Author: Cerebral
    Public: No

    Description:
	Capture target player and strip/send them to the cages.

    Parameter(s): _target - [PLAYER]

    Returns: nothing

    Example(s):
	[_target] call vn_mf_fnc_capture_player;
*/
params ["_target", "_player"];

if !(isPlayer _target) exitWith {};

{
	removeAllAssignedItems player;
	removeAllItems player;
	removeAllContainers player;
	removeGoggles player;
	removeHeadgear player;
	removeAllWeapons player;
	player forceAddUniform (selectRandom ["vn_o_uniform_nva_army_01_02","vn_o_uniform_nva_army_02_01","vn_o_uniform_nva_army_01_01","vn_o_uniform_nva_army_03_02","vn_o_uniform_nva_army_02_02","vn_o_uniform_nva_army_03_01"]);
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
	player addItem "FirstAidKit";
} remoteExec ["call", _target];

private _message = format ["%1 has captured %2!", name _player, name _target];
private _nearbyCages = nearestObjects [getPos _target, ["Logic"], 10, false];
if (count _nearbyCages != 0) exitWith {
	["CagesTooClose", ["Prisoner is already captured!"]] remoteExec ["para_c_fnc_show_notification", _player];
};

if(_player getVariable 'vn_mf_side' == east) then {
	private _cage = selectRandom vn_mf_cages;
	["POWCapturedRed", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];

	_target setPosASL _cage;
} else {
	private _cage = selectRandom vn_dc_cages;
	["POWCapturedBlue", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];

	_target setPosASL _cage;
};


