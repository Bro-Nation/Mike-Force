/*
    File: fn_action_radiotap_reveal.sqf
    Author: DJ Dijksterhuis
    
    Description:
        Adds the "hold action" to objects for revealing next closest site(s) on map.
        
        Players must be:
        	- explosive specialist trained
        	- within 5 metres of the radio set
        	- have a wiretap kit in their inventory
        	- not opfor

		See here for more detail on the implementation:
		https://community.bistudio.com/wiki/BIS_fnc_holdActionAdd

    Parameter(s):
        objs - Array - the objects this hold action will be attached to (_this entries)
    
    Returns:
        None
    
    Example(s):
        [obj_1, obj2, obj_3] call vn_mf_fnc_action_radiotap_reveal;
*/

private _actionText = "Wiretap Radio Communications";
private _actionIdleIcon = "custom\holdactions\holdAction_listen_ca.paa";
private _actionProgressIcon = _actionIdleIcon;


private _isNotOpfor = "side player != east";
private _isInRangeOfRadio = "player distance cursorObject < 5";
private _isValidObjectType = "typeOf cursorObject in ['vn_o_prop_t102e_01', 'vn_o_prop_t884_01']";

private _conditionToShow = format [
	"(%1 && %2 && %3)",
	_isNotOpfor, 
	_isInRangeOfRadio, 
	_isValidObjectType
];

// WARN: if changing this make sure you change the logic in _codeOnStart too!!
private _isPlayerExplosiveSpecialist = "player getUnitTrait 'explosiveSpecialist'";
private _isPlayerHasWiretapKit = "'vn_b_item_wiretap' in (backpackItems player)";

private _conditionToProgress = format [
	"(%1 && %2)",
	// "(%1 && %2 && %3)",
	_conditionToShow,
	// _isPlayerExplosiveSpecialist,
	_isPlayerHasWiretapKit
];

private _codeOnStart = {
	// private _playerIsExplosiveSpecialist = player getUnitTrait 'explosiveSpecialist';
	private _playerHasWiretapKit = 'vn_b_item_wiretap' in (backpackItems player);
	if (not _playerHasWiretapKit) exitWith {
	    ["RadioTapFailed", []] remoteExec ["para_c_fnc_show_notification", player];
	};
	if (true) exitWith {
	    ["RadioTapStart", []] remoteExec ["para_c_fnc_show_notification", player];
	};
};
private _codeOnTick = {};
private _codeOnComplete = {
	[cursorObject] remoteExec ["vn_mf_fnc_sites_remoteactions_reveal_radiotap", 2];
	["RadioTapSuccess", []] remoteExec ["para_c_fnc_show_notification", player];
};
private _codeOnInterrupted = {};
private _extraArgsArr = [];
private _actionDurationSeconds = 10;
private _actionPriority = 100;
private _actionRemoveOnComplete = false;
private _showWhenUncon = false;

[
	player,
	_actionText,
	_actionIdleIcon,
	_actionProgressIcon,
	_conditionToShow,
	_conditionToProgress,
	_codeOnStart,
	_codeOnTick,
	_codeOnComplete,
	_codeOnInterrupted,
	_extraArgsArr,
	_actionDurationSeconds,
	_actionPriority,
	_actionRemoveOnComplete,
	_showWhenUncon
] call BIS_fnc_holdActionAdd;
