/*
	File: fn_action_init.sqf
	Author: Cerebral
	Modified: @dijksterhuis
	Public: No
	
	Description:
		Init player actions
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_init;
*/

if (isNil "vn_mf_actions_player") then
{
	vn_mf_actions_player = player;
};

if (isNil "vn_mf_actions_initialized" || vn_mf_actions_player != player) then //arma's  variable system is asinine
{
	vn_mf_actions_player = player;
	vn_mf_actions_initialized = 1;
	call vn_mf_fnc_action_capture_player;
	//call vn_mf_fnc_action_arrest_player;
	//call vn_mf_fnc_release_from_arrest_player;
	call vn_mf_fnc_action_destroy_task;
	call vn_mf_fnc_action_gather_intel;
	call vn_mf_fnc_action_vehspawner_show_spawn_point;
	call vn_mf_fnc_action_radiotap;
	call vn_mf_fnc_action_lower_flag;
	call vn_mf_fnc_action_reraise_flag;
	"vn_holdActionAdd_layer" cutText ["","PLAIN"];
	// curator / admin / moderator only
	call vn_mf_fnc_action_curator_force_recover_wrecked_vehicle;
	call vn_mf_fnc_action_curator_force_reset_idle_vehicle;
	call vn_mf_fnc_action_curator_lock_spawner;
	call vn_mf_fnc_action_curator_unlock_spawner;
	// press corp only
	call vn_mf_fnc_action_press_toggle_spectator;
};