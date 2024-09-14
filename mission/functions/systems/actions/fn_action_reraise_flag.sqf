/*
	File: fn_action_reraise_flag.sqf
	Author: "DJ" dijksterhuis
	Public: No
	
	Description:
		Dac Cong players have lowered a mission critical (player built)
		flag in a base. Bluefor need to raise it to 100% again.

		WARNING: This is attached to **PLAYERS**, running in **player** locality.

	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_reraise_flag;
*/

private _actionText = format ["<t color='#0000FF'>%1</t>", "Raise Flag"];
private _actionIdleIcon = "custom\holdactions\holdAction_interact_ca.paa";
private _actionProgressIcon = "custom\holdactions\holdAction_interact_ca.paa";

private _isNotOpfor = "(side player) isEqualTo west";
private _isInRangeOf = "player distance cursorObject < 5";
private _validFlagsArr = "['vn_flag_usa', 'vn_flag_aus', 'vn_flag_arvn', 'vn_flag_nz']";
private _isValidObjectType = format [
	"typeOf cursorObject in %1",
	_validFlagsArr
];
private _isObjectiveFlag = "!(isNil 'vn_mf_bn_dc_target_flag') && (cursorObject isEqualTo vn_mf_bn_dc_target_flag)";
private _isFlagLowered = "((flagAnimationPhase cursorObject) isNotEqualTo 1)";

// bluefor can raise the flag only if it has been lowered
private _conditionToShow = format [
        "(%1 && %2 && %3 && %4 && %5)",
        _isNotOpfor,
        _isInRangeOf,
        _isValidObjectType,
        _isObjectiveFlag,
        _isFlagLowered
];

private _conditionToProgress = "true";

private _codeOnStart = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	["BlueforRaisingFlag"] remoteExec ["vn_mf_fnc_ctf_broadcast_notify_immediate", 2];
};
private _codeOnTick = {
	params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
	[vn_mf_bn_dc_target_flag, _progress, _maxProgress, 1] remoteExec ["vn_mf_fnc_ctf_handle_flag_height_change", 2];
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
private _extraArgsArr = [flagAnimationPhase cursorObject];
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
