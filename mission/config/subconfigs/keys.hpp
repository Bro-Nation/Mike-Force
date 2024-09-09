#include "\a3\ui_f\hpp\definedikcodes.inc"

//--- Key down actions:
class vn_mf_keydown_escape_action
{
	defaultKey = DIK_ESC;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_abort_building";
	down = 1;
	displayName = "";
	access = 0;
};

class para_keydown_open_wheel_menu
{
	defaultKey = DIK_6;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_wheel_menu_open_keybind";
	down = 1;
	displayName = $STR_vn_mf_keybindings_selector;
	access = 1;
};
/*
class para_vote_1
{
	defaultKey = DIK_F1;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_vote_1";
	down = 1;
	displayName = "Vote for Option #1";
	access = 1;
};
class para_vote_2
{
	defaultKey = DIK_F2;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_vote_2";
	down = 1;
	displayName = "Vote for Option #2";
	access = 1;
};
class para_vote_3
{
	defaultKey = DIK_F3;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_openVoteMenu";
	down = 1;
	displayName = "Open Voting Menu";
	access = 1;
};
*/
class vn_mf_interactionOverlay_toggle
{
	defaultKey = DIK_7; // 7
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_interactionOverlay_toggle";
	down = 1;
	displayName = $STR_vn_mf_keybindings_interactionOverlay_toggle;
	access = 1;
};

//--- Key up actions:
class vn_mf_debug_monitor_action
{
	defaultKey = DIK_GRAVE;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_enable_debug_monitor";
	down = 0;
	displayName = $STR_vn_mf_keybindings_debug_monitor;
	access = 1;
};

class vn_mf_task_roster_action
{
	defaultKey = DIK_H;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_enable_task_roster";
	down = 0;
	displayName = $STR_vn_mf_keybindings_task_roster;
	access = 1;
};

class vn_mf_ack_hint_card {
	defaultKey = DIK_8;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_ui_hints_acknowledgeHintKeypress";
	down = 0;
	displayName = "Acknowledge Hint";
	access = 1;
};

class vn_mf_build_mode_action_up
{
	defaultKey = DIK_N;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_toggle_buildmode";
	down = 0;
	displayName = $STR_vn_mf_keybindings_build_mode;
	access = 1;
};

class vn_mf_quick_build
{
	defaultKey = DIK_N;
	shift = "false";
	ctrl = "true";
	alt = "false";
	function = "para_c_fnc_buildingMenu_quickBuild";
	down = 0;
	displayName = "Quick Build /loc";
	access = 1;
};

class vn_mf_holster_weapon
{
	defaultKey = DIK_H; // SHIFT + H
	shift = "true";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_holster_weapon";
	down = 0;
	displayName = "Holster Weapon";
	access = 1;
};

class vn_mf_release_cargo
{
	defaultKey = DIK_4; // SHIFT + 4
	shift = "true";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_release_cargo";
	down = 0;
	displayName = "Release Cargo (ADVSL)";
	access = 1;
};

class vn_mf_channel_toggle_ground
{
	defaultKey = DIK_F1;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_teams_comms_switchers_onoff_ground";
	down = 0;
	displayName = "Mute/Unmute 'Ground'";
	access = 1;
};

class vn_mf_channel_toggle_air
{
	defaultKey = DIK_F2;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_teams_comms_switchers_onoff_air";
	down = 0;
	displayName = "Mute/Unmute 'Air'";
	access = 1;
};

class vn_mf_channel_toggle_cff
{
	defaultKey = DIK_F3;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_teams_comms_switchers_onoff_cff";
	down = 0;
	displayName = "Mute/Unmute 'CFF'";
	access = 1;
};

class vn_mf_channel_disable_all
{
	defaultKey = DIK_F4;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_teams_comms_switchers_off_all";
	down = 0;
	displayName = "Mute All channels";
	access = 1;
};

class vn_mf_veh_asset_locate_vehicle_spawn_point
{
	defaultKey = DIK_F5;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_veh_asset_client_locate_vehicle_spawn_point";
	down = 0;
	displayName = "Locate Vehicle's Spawner";
	access = 1;
};

class vn_mf_toggle_earplugs
{
	defaultKey = DIK_F6;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_earplugs_toggle";
	down = 0;
	displayName = "Toggle Earplugs";
	access = 1;
};

class vn_mf_toggle_hud
{
	defaultKey = DIK_F7;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_ui_hud_toggle";
	down = 0;
	displayName = "Toggle HUD (Strimmer mode)";
	access = 1;
};

class vn_mf_emotes_menu
{
	defaultKey = DIK_F8;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_emotes_menu_open";
	down = 0;
	displayName = "Open Emotes Menu";
	access = 1;
};
