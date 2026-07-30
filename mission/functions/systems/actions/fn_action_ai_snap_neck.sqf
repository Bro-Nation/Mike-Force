/*
	File: fn_action_ai_snap_neck.sqf
	Author: tylervip
	Public: No

	Description:
		Adds a hold action that lets players silently kill nearby enemy AI from behind.

	Parameter(s): none

	Returns:

	Example(s):
		call vn_mf_fnc_action_ai_snap_neck;
*/

[
	player,
	format ["<t color='#FF3333'>%1</t>", localize 'STR_vn_mf_neck_snap_ai'],
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
	"player distance cursorTarget < 3 && {cursorTarget isKindOf 'Man'} && {!isPlayer cursorTarget} && {alive cursorTarget} && {!(cursorTarget in (missionNamespace getVariable ['vn_mf_duty_officers', []]))} && {side cursorTarget != side player} && {abs ((cursorTarget getRelDir player) - 180) < 100}",
	"player distance cursorTarget < 3",
	{
		[cursorTarget, player] remoteExec ["vn_mf_fnc_neck_snap_start", 2];
	},
	{},
	{
		[cursorTarget, player] remoteExec ["vn_mf_fnc_neck_snap_ai", 2];
	},
	{
		[cursorTarget, player] remoteExec ["vn_mf_fnc_neck_snap_interrupt", 2];
	},
	[],
	1.5,
	100,
	false,
	false
] call BIS_fnc_holdActionAdd;