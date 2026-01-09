/*
    File: fn_action_BlackBox.sqf
    Author: tylervip
	inspired: by DJ Dijksterhuis
    
    Description:
        Adds the "hold action" to objects for revealing next closest site(s) on map.
        
        Players must be:
        	- explosive specialist trained
        	- within 5 metres of the blackbox
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

private _actionText = "Gather blackbox";
private _actionIdleIcon = "custom\holdactions\holdAction_listen_ca.paa";
private _actionProgressIcon = _actionIdleIcon;

private _isNotOpfor = "side player != east";
private _isInRangeOfRadio = "player distance cursorObject < 5";
private _isValidObjectType = "typeOf cursorObject in ['Land_vn_mutt_vysilacka']";

private _conditionToShow = format [
	"(%1 && %2 && %3)",
	_isNotOpfor,
	_isInRangeOfRadio,
	_isValidObjectType
];

private _conditionToProgress = _conditionToShow;

private _codeOnStart = {
	["BlackBoxStart", []] remoteExec ["para_c_fnc_show_notification", player];
};

private _codeOnTick = {};

private _codeOnComplete = {
	[cursorObject] remoteExec ["vn_mf_fnc_sites_remoteactions_reveal_radiotap", 2];
	["BlackBoxSuccess", []] remoteExec ["para_c_fnc_show_notification", player];
};

private _codeOnInterrupted = {};

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
	[],
	10,
	100,
	false,
	false
] call BIS_fnc_holdActionAdd;
