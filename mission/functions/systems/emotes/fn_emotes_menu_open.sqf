/*
    File: fn_emotes_menu_open.sqf
    Author: @dijksterhuis
    Public: No
    
    Description:
    	Opens the emotes wyheel menu.

    	Runs locally on the client.
    
    Parameter(s):
		None
    
    Returns:
	   	Nothing
    
    Example(s):
		call vn_mf_fnc_emotes_menu_open;
*/

if ([player] call para_g_fnc_unit_is_incapacitated) exitWith {
    ["ErrorEmotesPlayerIncap", []] call para_c_fnc_show_notification;
};

if !(alive player) exitWith {
    ["ErrorEmotesPlayerDead", []] call para_c_fnc_show_notification;
};

if (vehicle player != player) exitWith {
    ["ErrorEmotesInVehicle", []] call para_c_fnc_show_notification;
};

// probably swimming
if (surfaceIsWater (getPos player) && ((getPosASL player) select 2) < -1.5) exitWith {
    ["ErrorEmotesInWater", []] call para_c_fnc_show_notification;
};

// not on the ground -- basejumping / freefalling?
if (((getPos player) select 2) > 1) exitWith {
    ["ErrorEmotesNotOnGround", []] call para_c_fnc_show_notification;
};

private _actions = uiNamespace getVariable ["vn_mf_bn_emotes_menu_actions", []];

if !(_actions isEqualType [] && count _actions > 0) exitWith {
	diag_log format ["ERROR: Emote Menu actions not set up correctly."];
};

[_actions, player, false] call para_c_fnc_wheel_menu_open;
