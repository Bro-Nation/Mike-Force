/*
	File: fn_action_arrest_player.sqf
	Author: Duke Lawrence
	Public: No
	
	Description:
		Arrest another player
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_arrest_player;
*/

[
	player,											// Object the action is attached to
	"vn_mf_action_arrest_player",
	format ["<t color='#B700FF'>%1</t>", localize 'STR_vn_mf_arrest_player'],							// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	// Progress icon shown on screen
	"(player getVariable ['isArrested', 'false'] == 'false') && (player getVariable ['vn_mf_db_player_group', 'MikeForce'] in ['MilitaryPolice', 'DacCong']) && player distance cursorTarget <= 3 &&{ vehicle player isEqualTo player && {cursorTarget isKindOf 'Man' && {alive cursorTarget}}}",	// Condition for the action to be shown
	"player distance cursorTarget < 5",						// Condition for the action to progress
	{},	// Code executed when action starts
	{},	// Code executed on every progress tick
	{
		[cursorTarget, player] remoteExec ["vn_mf_fnc_arrest_player", 2];
	},// Code executed on completion
	{},	// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	0.5,													// Action duration [s]
	100,													// Priority
	false,											// Remove on completion
	false												// Show in unconscious state
] call vn_mf_fnc_action_holdActionAdd;