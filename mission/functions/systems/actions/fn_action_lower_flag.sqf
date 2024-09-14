/*
	File: fn_action_lower_flag.sqf
	Author: "DJ" dijksterhuis
	Public: No
	
	Description:
		Dac Cong players can approach a mission critical (player built)
		flag in a base and then lower it, causing a mission objective
		to fail.

		WARNING: This is attached to **PLAYERS**, running in **player** locality.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_lower_flag;
*/

private _actionText = format ["<t color='#FF0000'>%1</t>", "Lower Flag"];
private _actionIdleIcon = "custom\holdactions\holdAction_interact_ca.paa";
private _actionProgressIcon = "custom\holdactions\holdAction_danger_ca.paa";

private _isOpfor = "side player isEqualTo east";
private _isInRangeOf = "player distance cursorObject < 5";
private _validFlagsArr = "['vn_flag_usa', 'vn_flag_aus', 'vn_flag_arvn', 'vn_flag_nz']";
private _isValidObjectType = format [
	"typeOf cursorObject in %1",
	_validFlagsArr
];

/*
vn_mf_bn_dc_target_flag is publicVariable'd when the flag is built
within the fn_task_pri_capture code

we need to do this otherwise dac cong could be lowering the wrong flag.
need to use a publicVar, else we'd need to remoteExec constantly as part 
of condition to show... but mike force hold actions are attached to the PLAYER
which means constantly running remoteExec's whenever a player is looking at ANYTHING.
*/
private _isObjectiveFlag = "!(isNil 'vn_mf_bn_dc_target_flag') && (cursorObject isEqualTo vn_mf_bn_dc_target_flag)";

private _conditionToShow = format [
        "(%1 && %2 && %3 && %4)",
        _isOpfor,
        _isInRangeOf,
        _isValidObjectType,
        _isObjectiveFlag
];

private _conditionToProgress = "true";

private _codeOnStart = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	["DacCongCapturingFlag"] remoteExec ["vn_mf_fnc_ctf_broadcast_notify_immediate", 2];
};
private _codeOnTick = {
	params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
	[vn_mf_bn_dc_target_flag, _progress, _maxProgress, -1] remoteExec ["vn_mf_fnc_ctf_handle_flag_height_change", 2];
};
/*
private _codeOnComplete = {
	params ["_target", "_caller", "_actionId", "_arguments"];
};

private _codeOnInterrupted = {
	params ["_target", "_caller", "_actionId", "_arguments"];
};
*/

private _codeOnComplete = {};
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
