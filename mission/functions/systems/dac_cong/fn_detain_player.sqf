/*
    File: fn_detain_player.sqf
    Author: "DJ" Dijksterhuis
    Public: No

    Description:
	Detain target player (strip them of gear) but *do not* send them to the cages.

    Parameter(s): _target - [PLAYER]

    Returns: nothing

    Example(s):
	[_target] call vn_mf_fnc_detain_player;
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

private _message = format ["%1 has detained %2!", name _player, name _target];
private _nearbyCages = nearestObjects [getPos _target, ["Logic"], 10, false];

if(_player getVariable 'vn_mf_side' == east) then {
	["POWCapturedRed", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];
} else {
	private _cage = selectRandom vn_dc_cages;
	["POWCapturedBlue", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];
};


