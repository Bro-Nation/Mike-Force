/*
	File: fn_action_capture_travel_powcamp.sqf
	Author: Legend
    modified: tylyervip
	Public: No

	Description:
		Capture an incapacitated opponent and travel with them to POW camp

	Parameter(s): none

	Returns:

	Example(s):
		call vn_mf_fnc_action_capture_travel_powcamp;
*/

[
	player,											// Object the action is attached to
	format ["<t color='#ffee00ff'>%1</t>", localize 'STR_vn_mf_capture_travel_powcamp'],							// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	// Progress icon shown on screen
	"player getVariable ['vn_mf_side', EAST] == EAST && cursorTarget getVariable ['vn_mf_side', WEST] == WEST && player distance cursorTarget <= 3 && { vehicle player isEqualTo player && {cursorTarget isKindOf 'Man' && {alive cursorTarget && { [cursorTarget] call vn_fnc_revive_moving && {[player] call vn_fnc_revive_moving && { [cursorTarget] call vn_fnc_revive_incap && { !([player] call vn_fnc_revive_incap) }}}}}}}", // Condition for the action to be shown
	"player distance cursorTarget < 5",						// Condition for the action to progress
	{},	// Code executed when action starts
	{},	// Code executed on every progress tick
	{
		[cursorTarget, player, "mf_dc_respawn_daccong_powcamp"] remoteExec ["vn_mf_fnc_capture_travel", 2];
	},// Code executed on completion
	{},	// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	3,													// Action duration [s]
	100,												// Priority
	false,											// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
