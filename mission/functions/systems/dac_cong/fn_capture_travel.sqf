/*
    File: fn_capture_travel.sqf
    Author: Legend
    Public: No

    Description:
	Capture target player and strip/send them to the cages with the DAC.

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
	removeGoggles player;
	removeHeadgear player;
	removeAllWeapons player;
	removeVest player;
	removeBackpack player;
	//temporarily moved aside player forceAddUniform "vn_o_uniform_nva_army_01_01" (selectRandom ["vn_b_uniform_macv_01_01","vn_b_uniform_macv_01_02","vn_b_uniform_macv_01_03","vn_b_uniform_macv_01_04","vn_b_uniform_macv_01_05","vn_b_uniform_macv_01_06"])
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";

} remoteExec ["call", _target];

private _message = format ["%1 disappeared into the tunnels, taking %2 with them!", name _player, name _target];
private _nearbyCages = nearestObjects [getPos _target, ["Logic"], 10, false];
if (count _nearbyCages != 0) exitWith {
	["CagesTooClose", ["Prisoner is already captured!"]] remoteExec ["para_c_fnc_show_notification", _player];
};

	private _cage = selectRandom vn_mf_cages;
	["POWCapturedByOpfor", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];

	_target setPosASL _cage;

_player setPosASL (getMarkerPos "mf_dc_respawn_tunnel_1_nw");


