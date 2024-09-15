/*
	File: fn_action_gather_intel.sqf
	Author: Cerebral
	Modified By: @dijksterhuis
	Public: No

	Description:
		"Gather" the intel object at a main supply line site (HQ/Factory)
		during the capture phase.

		Reveals all the site map markers for that supply line.

	Parameter(s): none

	Returns:

	Example(s):
		// on the client!
		call vn_mf_fnc_action_gather_intel;
*/


private _object = player;
private _title = "Gather Enemy Intel";
private _iconIdle = "custom\holdactions\holdAction_documents_ca.paa";
private _iconProgress = "custom\holdactions\holdAction_documents_ca.paa";


// this is a hacky workaround following similar logic to this github gist
// https://gist.github.com/CalebSerafin/f4a16f2f564a438882ca6f32107bec24
// which tries to solve this issue
// https://feedback.bistudio.com/T155638
//
// however, instead of relying on undocumented functionality
// (which could disappear in the future!) i've changed it so that the
// holdAction UI is always redrawn every 5-ish seconds.

private _conditionToShow = str {
	call {
		private _needToReDrawHoldAction = (serverTime - 10) > (player getVariable ["vn_mf_bn_actions_intel_client_lastcheck", 0]);
		private _actualCondition = (
			player distance cursorObject < 5
			&& {typeOf cursorObject in ['Land_Map_unfolded_F','Land_Map_unfolded_Malden_F', 'vn_b_prop_cabinet_02']}
		);
		private _res = false;
		// don't need to redraw yet and we're looking at an intel thing -- show the UI.
		if (!_needToReDrawHoldAction && _actualCondition) then {_res = true};
		// reset timer so the ui comes back on the next frame
		if (_needToReDrawHoldAction) then {player setVariable ["vn_mf_bn_actions_intel_client_lastcheck", serverTime]};
		// letftover cases --
		// 1. need to redraw and looking at the thing -- return false for 1x frame to redraw holdAction UI
		// 2. need to redraw and NOT looking at the thing -- return false because we're not looking at the thing.
		_res;
	};
} trim ["{}", 0];


private _conditionToProgress = "player distance cursorObject < 5";
private _codeOnStart = {};
private _codeOnTick = {};
private _codeOnCompleted = {
	[cursorObject, player] remoteExec ["vn_mf_fnc_sites_remoteactions_reveal_intel", 2];
};
private _codeOnInterrupted = {};
private _scriptArgs = [];
private _duration = 45;
private _priority = 100;
private _removeWhenCompleted = false;
private _showWhenUncon = false;

[
	_object,
	_title,
	_iconIdle,
	_iconProgress,
	_conditionToShow,
	_conditionToProgress,
	_codeOnStart,
	_codeOnTick,
	_codeOnCompleted,
	_codeOnInterrupted,
	_scriptArgs,
	_duration,
	_priority,
	_removeWhenCompleted,
	_showWhenUncon
] call BIS_fnc_holdActionAdd;
