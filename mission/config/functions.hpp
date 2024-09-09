class CfgFunctions
{
	#include "..\paradigm\client\functions.hpp"
	#include "..\paradigm\server\functions.hpp"

	class vn_mf
	{
		class core
		{
			file = "functions\core";
			class apply_unit_traits {};
			class change_player_stat {};
			class end_mission {};
			class get_gamemode_value {};
			class marker_init {};
			class pow_init {};
			class respawn_points_init {};
			class arsenal_safe_zones_init {};
			class save_time_elapsed {};
			class stats_init {};
		};

		class core_helpers
		{
			file = "functions\core\helpers";
			class check_enemy_units_alive {};
			class player_within_radius {};
			class check_side {};
			class range {};
			class color_confname_to_rgba {};
			class rExecServerToGlobal_playerHost_or_dedicated {};
		};

		class core_init
		{
			file =	"functions\core\init";
			class pre_init
			{
				preinit = 1;
			};
			class post_init
			{
				postinit = 1;
			};

			class curator_init {};
			class chat_init {};
			class adv_revive_params {};
			class init_mission_handlers {};
		};

		class core_input
		{
			file = "functions\core\input";
		};

		class core_teams
		{
			file = "functions\core\teams";
			class change_team {};
			class changeteam {};
			class force_team_change {};
			class group_init {};
			class is_team_full {};
			class player_on_team {};
			class update_channels {};
		};

		class core_teams_comms_switchers
		{
			file = "functions\core\teams\comms_switchers";
			class teams_comms_switchers_onoff_air {};
			class teams_comms_switchers_onoff_cff {};
			class teams_comms_switchers_onoff_ground {};
			class teams_comms_switchers_onoff {};
			class teams_comms_switchers_off_all {};
		};

		class core_workarounds
		{
			file = "functions\core\workarounds";
			class admin_arsenal {};
			class holster_weapon {};
			class release_cargo {};
		};

		class debug {
			file = "functions\debug";
			class debug_monitor {};
			class detect_missing_arsenal_magazines {};
			class enable_debug_monitor {};
			class init_performance_logging {};
			class log_performance_data {};
			class log_ai_objective_data {};
		};

		class ui
		{
			file = "functions\core\ui";
			class armor_calc {};
			class display_location_time {};
			class ui_create {};
			class ui_sub_menu {};
			class ui_update {};
			class update_loading_screen {};
			class ui_hud_toggle {};
		};

		// these are functions that are used outside of the taskroster UI
		// the other task roster blocks are dedicated to each display page
		class ui_taskroster
		{
			file = "functions\core\ui\taskroster";

			// open on key press (default: H key)
			class enable_task_roster {};

			// open display if not already open
			class tr_init {};
		};

		class ui_taskroster_supportTasks
		{
			file = "functions\core\ui\taskroster\supportTasks";
			class tr_supportTask_show {};
			class tr_supportTask_selectTask {};
			class tr_supportTask_selectTeam {};
			class tr_supportTask_selectPosition {};
			class tr_supportTask_selectPosition_accept {};
			class tr_supportTask_create {};
			class tr_supportTask_map_hide {};
			class tr_getMapPosClick {};
		};

		class ui_taskroster_tasksInfo
		{
			file = "functions\core\ui\taskroster\tasksInfo";
			class tr_tasksInfo_fill {};
			class tr_tasksInfo_show {};
			class tr_tasksInfo_setActive {};
			class tr_tasksInfo_listbox_select {};
		};

		class ui_taskroster_teamInfo
		{
			file = "functions\core\ui\taskroster\teamInfo";
			class tr_teamInfo_show {};
			class tr_teamInfo_changeteam_select {};
			class tr_teamInfo_changeteam_init {};

			// server side callback to player to update the team
			// while the task roster is still displayed (so teams
			// data updates asap in the UI)
			class tr_teamInfo_callback_update {};
		};

		class ui_taskroster_playerInfo
		{
			file = "functions\core\ui\taskroster\playerInfo";
			class tr_playerInfo_show {};
			class tr_playerInfo_ribbon_enter {};
			class tr_playerInfo_ribbon_exit {};
			class tr_playerInfo_ribbon_setIcon {};
		};

		class ui_timerOverlay
		{
			file = "functions\core\ui\TimerOverlay";
			class timerOverlay_hideTimer {};
			class timerOverlay_setGlobalTimer {};
			class timerOverlay_setTimer {};
			class timerOverlay_showTimer {};
			class timerOverlay_removeGlobalTimer {};
			class timerOverlay_removeTimer {};
		};

		class ui_zone_marker
		{
			file = "functions\core\ui\zone_marker";
			class zone_marker_captured_zone_info {};
			class zone_marker_hostile_zone_info {};
		};

		class system_actions {
			file = "functions\systems\actions";
			class action_init {};
			class action_vehspawner_show_spawn_point {};
			class action_destroy_task {};
			class action_gather_intel {};
			class action_radiotap {};
			class action_capture_player {};
			class action_arrest_player {};
			class action_release_from_arrest_player {};
			class action_drink_water {};
			class action_eat_food {};
			class action_lower_flag {};
			class action_reraise_flag {};
			class action_curator_force_recover_wrecked_vehicle {};
			class action_curator_force_reset_idle_vehicle {};
			class action_curator_lock_spawner {};
			class action_curator_unlock_spawner {};
		};

		class system_actives {
			file = "functions\systems\actives";

			class active_init {};
			class active_siren {};
		};

		class system_ammo_repack {
			file = "functions\systems\ammo_repack";
			class ammo_repack {};
		};

		class system_arsenal_cleanup {
			file = "functions\systems\arsenal_cleanup";
			class arsenal_trash_cleanup_init {};
			class arsenal_trash_cleanup {};
		};

		class system_attachments {
			file = "functions\systems\attachments";
			class attachments_client_attach_flashlight {};
			class attachments_client_attach_chemlight {};
			class attachments_server_attach_flashlight {};
			class attachments_server_attach_chemlight {};
			class attachments_global_get_jip_id {};
			class attachments_global_reset_jip_id {};
			class attachments_global_delete_objects {};
			class attachments_client_battery_monitor_init {};
			class attachments_client_battery_monitor_job {};
		};

		class system_attachments_lightsources {
			file = "functions\systems\attachments\lightsources";
			class attachments_lightsources_flashlight {};
			class attachments_lightsources_chemlight {};
		};

		class system_awards {
			file = "functions\systems\awards";
			class player_award {};
		};

		class system_consumables {
			file = "functions\systems\consumables";
			class consume {};
			class eatdrink {};
			class enable_arsenal_food_drink_overlay {};
			class health_effects {};
			class player_health_stats {};
		};

		class system_dac_cong {
			file = "functions\systems\dac_cong";
			class daccong_respawns_delete_all {};
			class capture_player {};
			class ctf_handle_flag_height_change {};
			class ctf_broadcast_notify_immediate {};
		}

		//Gameplay director, responsible for main game progression and flow.
		class system_director
		{
			file = "functions\systems\director";
			class director_init {};
			class director_job {};
			class director_check_mission_end {};
			class director_complete_zone {};
			class director_open_connected_zones {};
			class director_open_zone {};
			class director_open_closest_zone {};
			class director_process_active_zone {};
			class director_zones_in_range_of_bases {};
			class director_play_music_completed_zone {};
			class director_start_next_zone_task {};
		};

		class system_earplugs {
			file = "functions\systems\earplugs";
			class earplugs {};
			class earplugs_toggle {};
		};

		class system_emotes {
			file = "functions\systems\emotes";
			class emotes_init {};
			class emotes_emote_toggle {};
			class emotes_menu_open {};
		};

		class system_player_markers
		{
			file = "functions\systems\player_markers";
			class player_markers_job {};
			class player_markers_subsystem_init {};
			class player_markers_update_positions {};
		};

		class system_ranks {
			file = "functions\systems\ranks";
			class player_rank_up {};
			class points_to_next_rank {};
			class unit_next_rank {};
			class unit_to_rank {};
		};

		// main sites code for handling creating a "site" during the
		// primary capture phase
		class system_sites
		{
			file = "functions\systems\sites";
			class sites_attempt_teardown {};
			class sites_create_site {};
			class sites_generate {};
			class sites_init {};
			class sites_load {};
			class sites_teardown_site {};
			class sites_delete_all_active_sites {};
			class sites_delete_active_site {};
			class sites_aa_reveal_targets {};
			class sites_get_safe_location {};
			class sites_find_area_gradient {};
			class sites_objmapper_dynamic_grass {};
			class sites_hide_unsafe_terrain_objects {};
			class sites_subsystem_client_init {};
			class sites_discovery_job {};
		};

		// remote actions that can be performed at sites
		// destroying objects etc
		class system_sites_remoteactions
		{
			file = "functions\systems\sites\remoteactions";
			class sites_remoteactions_destroy_task {};
			class sites_remoteactions_destroy_task_burn_object {};
			class sites_remoteactions_destroy_task_dc_respawn {};
			class sites_remoteactions_destroy_task_object {};
			class sites_remoteactions_destroy_task_para_building {};
			// class sites_remoteactions_burn_shelter {}; // @dijksterhuis: TODO
			class sites_remoteactions_reveal_radiotap {};
			class sites_remoteactions_reveal_intel {};
			class sites_remoteactions_reveal_scout {};
		}
		
		// compositions detailing all the objects at the site
		class system_sites_create_compositions
		{
			file = "functions\systems\sites\create\compositions";
			class sites_create_compositions_aa {};
			class sites_create_compositions_camp {};
			class sites_create_compositions_factory {};
			class sites_create_compositions_hq {};
			class sites_create_compositions_mortar {};
			class sites_create_compositions_radar {};
			class sites_create_compositions_tunnel {};
			class sites_create_compositions_water_supply {};
			// old not used
			class sites_create_tunnel {};
			class sites_create_camp {};
		}

		// creating individual sites using main sites code and compositions
		class system_sites_create_site
		{
			file = "functions\systems\sites\create\site";

			//Specific types of site
			class sites_create_site_aa {};
			class sites_create_site_artillery {};
			class sites_create_site_camp {};
			class sites_create_site_water_supply {};
			class sites_create_site_tunnel {};
			class sites_create_site_hq {};
			class sites_create_site_factory {};
			class sites_create_site_radar {};
		}

		// utility functions to simplify/DRY the existing site code
		class system_sites_utils
		{
			file = "functions\systems\sites\utils";
			class sites_utils_std_teardown {};
			class sites_utils_std_check_teardown {};
			class sites_utils_normalise_object_placement {};
		}

		// simple scheduled utility job to make triple sure that critical
		// site objects cannot fall through the ground.
		// much simpler than the paradigm fall through world check.
		// I might be remembering it wrong, but I also think the paradigm 
		// fallthrough world checker only performs adjustments once on an
		// object then releases it from checks (which doesn't always work)
		class system_sites_object_zfixer
		{
			file = "functions\systems\sites\object_zfixer";
			class sites_object_zfixer_init {};
			class sites_object_zfixer_job {};
			class sites_object_zfixer_add_object {};
		}

		class system_supplies {
			file = "functions\systems\supplies";
			class action_supplies {};
			class client_request_supplies {};
			class create_supply_officer {};
			class override_crate_contents {};
			class supplyrequest {};
		};

		class system_tasks {
			file = "functions\systems\tasks";
			class supporttaskcreate {};
			class task_client_on_task_completed {};
			class task_client_on_task_created {};
			class task_complete {};
			class task_create {};
			class task_is_completed {};
			class task_refresh_tasks_client {};
			class task_subtask_complete {};
			class task_subtask_create {};
			class task_update_clients {};
		};

		class system_teleport {
			file = "functions\systems\teleport";
			class action_teleport {};
			class client_teleport {};
			class teleport {};
		};

		class system_traits {
			file = "functions\systems\traits";
			class action_trait {};
			class settrait {};
			class training {};
		};

		class system_tutorial 
		{
			file = "functions\systems\tutorial";
			class tutorial_subsystem_client_init {};
		};

		class system_vehicle_asset_manager_client
		{
			file = "functions\systems\vehicle_asset_manager\client";
			class veh_asset_add_package_underwater_wreck_action_local {};
			class veh_asset_add_package_wreck_action_local {};
			class veh_asset_describe_status {};
			class veh_asset_finalise_spawn_point_setup_on_client {};
			class veh_asset_remove_package_underwater_wreck_action_local {};
			class veh_asset_remove_spawn_point_client {};
			class veh_asset_request_vehicle_change_client {};
			class veh_asset_setup_package_wreck_action_local {};
			class veh_asset_update_spawn_point_data {};
			class veh_asset_client_locate_vehicle_spawn_point {};
		};

		class system_vehicle_asset_manager_global
		{
			file = "functions\systems\vehicle_asset_manager\global";
			class veh_asset_can_change_vehicle {};
			class veh_asset_get_spawn_point_info_from_config {};
			class veh_asset_load_vehicle_configs {};
		};

		class system_vehicle_asset_manager_server_network
		{
			file = "functions\systems\vehicle_asset_manager\server\network";
			class packageforslingloading {};
			class veh_asset_handle_change_vehicle_request {};
		};

		class system_vehicle_asset_manager_server
		{
			file = "functions\systems\vehicle_asset_manager\server";
			class veh_asset_3DEN_spawn_point {};
			class veh_asset_add_spawn_point {};
			class veh_asset_add_unlock_action {};
			class veh_asset_assign_vehicle_to_spawn_point {};
			class veh_asset_change_vehicle {};
			class veh_asset_create_spawn_point_id {};
			class veh_asset_job {};
			class veh_asset_lock_vehicle {};
			class veh_asset_marker_create {};
			class veh_asset_marker_delete {};
			class veh_asset_marker_update_position {};
			class veh_asset_package_wreck {};
			class veh_asset_process_spawn_point {};
			class veh_asset_remove_spawn_point {};
			class veh_asset_respawn {};
			class veh_asset_respawn_job {};
			class veh_asset_set_active {};
			class veh_asset_set_disabled {};
			class veh_asset_set_global_variable {};
			class veh_asset_set_global_variables {};
			class veh_asset_set_idle {};
			class veh_asset_set_queued {};
			class veh_asset_set_repairing {};
			class veh_asset_set_respawning {};
			class veh_asset_set_wrecked {};
			class veh_asset_setup_package_wreck_action {};
			class veh_asset_subsystem_init {};
			class veh_asset_unlock_vehicle {};
		};
		class system_vehicle_asset_manager_bn
		{
			file = "functions\systems\vehicle_asset_manager\bn";
			class veh_asset_bn_curator_force_recover_wrecked_vehicle {};
			class veh_asset_bn_curator_force_reset_idle_vehicle {};
			class veh_asset_bn_curator_lock_spawner {};
			class veh_asset_bn_curator_unlock_spawner {};
		};

		class system_vehicle_creation_detection
		{
			file = "functions\systems\vehicle_creation_detection";
			class veh_create_detection_job {};
			class veh_create_detection_subsystem_init {};
		};

		class system_vehicle_locking
		{
			file = "functions\systems\vehicle_locking";
			class lock_vehicle_to_teams {};
			class player_can_enter_vehicle {};
		};

		class system_zones
		{
			file = "functions\systems\zones";
			class zone_marker_to_name {};
			class zones_capture_zone {};
			class zones_init {};
			class zones_load_zone {};
			class zones_manager_job {};
			class zones_save_zone {};
			class zones_update_zone {};
			class zones_get_struct_value {};
		};

		class system_sysmsgs
		{
			file = "functions\systems\sysmsg";
			class sysmsg_print_admin {};
			class sysmsg_print_others {};
		};

		class mod_support
		{
			class init_comms {};
			class check_zeus_pack {};
		};

		class paradigm_interop
		{
			class get_squad_composition {};
			class harass_filter_target_players {};
			class harass_get_enemy_side {};
			class valid_attack_angles {};
		};

		class tasks
		{
			class create_support_default { file = "functions\tasks\task_creation\fn_create_support_default.sqf"; };

			class simple_task_system { file = "functions\tasks\fn_simple_task_system.sqf"; };
			class state_machine_task_system { file = "functions\tasks\fn_state_machine_task_system.sqf"; };

			class task_defend_counterattack { file = "functions\tasks\defend\fn_task_defend_counterattack.sqf";};
			class task_defend_base { file = "functions\tasks\defend\fn_task_defend_base.sqf";};

			class task_destroy_aa_site { file = "functions\tasks\destroy\fn_task_destroy_aa_site.sqf";};
			class task_destroy_artillery_site { file = "functions\tasks\destroy\fn_task_destroy_artillery_site.sqf";};
			class task_destroy_camp { file = "functions\tasks\destroy\fn_task_destroy_camp.sqf";};
			class task_destroy_tunnel { file = "functions\tasks\destroy\fn_task_destroy_tunnel.sqf";};
			class task_destroy_vehicle_depot { file = "functions\tasks\destroy\fn_task_destroy_vehicle_depot.sqf";};

			class task_pri_build_fob { file = "functions\tasks\primary\fn_task_pri_build_fob.sqf"; };
			class task_pri_capture { file = "functions\tasks\primary\fn_task_pri_capture.sqf"; };
			class task_pri_prepare { file = "functions\tasks\primary\fn_task_pri_prepare.sqf"; };

			class task_sec_spike_wiretap { file = "functions\tasks\secondary\fn_task_sec_spike_wiretap.sqf";};

			class task_sup_brightlight { file = "functions\tasks\support\fn_task_sup_brightlight.sqf"; };
			class task_sup_cas { file = "functions\tasks\support\fn_task_sup_cas.sqf"; };
			class task_sup_destroy_target { file = "functions\tasks\support\fn_task_sup_destroy_target.sqf"; };
			class task_sup_transport { file = "functions\tasks\support\fn_task_sup_transport.sqf"; };
			class task_sup_resupply { file = "functions\tasks\support\fn_task_sup_resupply.sqf";};
			class task_zone_connector { file = "functions\tasks\fn_zone_connector.sqf";};
		};
	};
};
