/*
	File: fn_action_recover_pilot.sqf
	Author: @dijksterhuis
	Public: No
	
	Description:
		If player is looking at a dead body at ta wreck site then allow them to bury
		the body with a holdAction.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_recover_pilot;
*/

private _objAttachTo = player;
private _title = "Recover Tags";
private _idleIcon = "custom\holdactions\holdAction_interact_ca.paa";
private _idleProgress = "custom\holdactions\holdAction_interact_ca.paa";

// the str {} trim trick here means we can write stuff that highlights in an ide
// as sqf, but we make it turns into a string for the holdAction argument to compile later
// plus we can do some performance optimisation on the condition to progress statement...
// --> action conditions are checked on each frame.
private _conditionToShowString = str {
	call {
		// stuff players can destroy
		private _classNames = [
			"Land_vn_b_prop_body_01",
			"Land_vn_b_prop_body_01_02",
			"Land_vn_b_prop_body_02",
			"Land_vn_b_prop_body_02_02"
		];

		private _res = (
			(side player != east)
			&& {
				(typeOf cursorObject in _classNames)
			&& {
				// 1.75m base distance plus object largest dimension divided by 2
				(player distance cursorObject < (1.75 + (sizeOf (typeOf cursorObject)) / 2))
			}
			}
		);
		_res;
	};
} trim ["{}", 0];

private _conditionToProgressString = _conditionToShowString;
private _codeOnStart = {};
private _codeOnProgressTick = {};
private _codeOnCompletion =	{
	[cursorObject] remoteExec ["vn_mf_fnc_sites_remoteactions_bury_pilot", 2];
};
private _codeOnInterrupted = {};
private _args = [];
private _duration = 5;
private _priority = 100;
private _removeWhenCompleted = false;
private _showWhenunconscious = false;

[
	_objAttachTo,
	_title,
	_idleIcon,
	_idleProgress,
	_conditionToShowString,
	_conditionToProgressString,
	_codeOnStart,
	_codeOnProgressTick,
	_codeOnCompletion,
	_codeOnInterrupted,
	_args,
	_duration,
	_priority,
	_removeWhenCompleted,
	_showWhenunconscious
] call BIS_fnc_holdActionAdd;
