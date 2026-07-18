/*
    File: fn_release_from_arrest_player.sqf
    Author: Duke Lawrence
    Public: No

    Description:
	Releases target player from surrender animation.

    Parameter(s): _target - [PLAYER]

    Returns: nothing

    Example(s):
	[_target] call vn_mf_fnc_release_from_arrest_player;
*/
params ["_target", "_player"];

if !(isPlayer _target) exitWith {};

{
    player setVariable ['isArrested', 'false', true];
    [player, false] call vn_mf_fnc_toggle_captive;
	action ["CancelAction", player];
} remoteExec ["call", _target];

/*
private _message = format ["%1 has freed %2!", name _player, name _target];

if(_player getVariable 'vn_mf_side' == east) then {
	private _cage = selectRandom vn_mf_cages;
	["POWCapturedRed", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];
} else {
	private _cage = selectRandom vn_dc_cages;
	["POWCapturedBlue", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];
};
*/