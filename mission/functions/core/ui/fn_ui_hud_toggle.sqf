/*
	File: fn_ui_hud_toggle.sqf
	Author: "DJ" Dijksterhuis
	Public: No

	Description:
		Enables/disables player HUD depending on whether HUD is already disabled/enabled.
		See: https://community.bistudio.com/wiki/showHUD

		Also disables custom Mike Force and Paradigm UI elements.

	Parameter(s): none

	Returns: nothing

	Example(s):
		[] call vn_mf_fnc_ui_hud_toggle;
*/

/* standardises the toggling one of the ui's IDC control elements */
private _fnc_toggle_ctrl = {
	params ["_uiControlName"];
	private _ctrl = uiNamespace getVariable [_uiControlName, controlNull];
	if !(isNull _ctrl) then {
		private _shown = ctrlShown _ctrl;
		_ctrl ctrlShow !_shown;
	};
};

// see: paradigm\client\ui\interactionOverlay\fn_interactionOverlay_hide.sqf
para_c_InteractionOverlay_Settings_toggled = !para_c_InteractionOverlay_Settings_toggled;
if (!para_c_InteractionOverlay_Settings_toggled) then {
	[] spawn para_c_fnc_interactionOverlay_hide;
} else {
	[] spawn para_c_fnc_interactionOverlay_show;
};

[
	'#para_InteractionOverlay_Title',
	'#para_InteractionOverlay_Action',
	'#para_InteractionOverlay_Body',
	'#para_InteractionOverlay_BodyBackground',
	"#para_InteractionOverlay_Progress",
	"#para_InteractionOverlay_state_Icon",
	'#VN_MF_TimerOverlay_Holder'
] apply {[_x] call _fnc_toggle_ctrl};

// see: MikeForce\mission\functions\systems\ui\fn_ui_create.sqf
{
	_x params ["_name", ""];

	[
		"vn_mf_db_%1_ctrl",
		"vn_mf_db_%1_ctrl_icon",
		"vn_mf_db_%1_ctrl_bg"
	] apply {[format [_x, _name]] call _fnc_toggle_ctrl};

	[
		format ["#VN_MF_HngerThirstHUD_ProgressBackground_%1", _forEachIndex]
	] call _fnc_toggle_ctrl;

} forEach getArray(missionConfigFile >> "gamemode" >> "health" >> "gui_progress_bars");


// base game arma3 hud.
// leave scripted hud always enabled to allow addAction / scroll wheel interactions
// but disable everything else.
private _enabled = player getVariable ["hud_enabled", true];

if (_enabled) then {
	showHUD [ 
		false,	// Scripted HUD (same as showHUD command)
		false,	// Vehicle + soldier info 
		false,	// Vehicle radar 
		false,	// Vehicle compass 
		false,	// Tank direction indicator 
		false,	// Commanding menu
		false,	// Group Bar 
		false,	// HUD Weapon Cursors
		false,	// Vehicle display panels 
		false,	// System chat kill notifications 
		false	// Draw3D 
	]; 

	player setVariable ["hud_enabled", false];

} else {
	showHUD [
		true,	// Scripted HUD (same as showHUD command)
		true,	// Vehicle + soldier info
		true,	// Vehicle radar
		true,	// Vehicle compass
		true,	// Tank direction indicator
		true,	// Commanding menu
		true,	// Group Bar
		true,	// HUD Weapon Cursors
		true,	// Vehicle display panels
		true,	// System chat kill notifications
		false	// Draw3D
	];

	player setVariable ["hud_enabled", true];

};

