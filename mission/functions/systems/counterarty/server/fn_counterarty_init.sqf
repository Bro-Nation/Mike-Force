/*
	File: fn_counterarty_init.sqf
	Author: Tylervip
	Public: No

	Description:
		Applies counter-battery configuration and starts the server tick job.
		Calling it again re-applies the configuration (e.g. after enabling
		vn_mf_counterarty_test_mode from the debug console) without adding a second job.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!isServer) exitWith {};

// Timing
missionNamespace setVariable ["vn_mf_counterarty_interval", 180];
missionNamespace setVariable ["vn_mf_counterarty_timeout", 600];
missionNamespace setVariable ["vn_mf_counterarty_respawn_cooldown", 420];
missionNamespace setVariable ["vn_mf_counterarty_respawn_cooldown_min", 420];
missionNamespace setVariable ["vn_mf_counterarty_respawn_cooldown_random", 180];
missionNamespace setVariable ["vn_mf_counterarty_rounds", 6];
missionNamespace setVariable ["vn_mf_counterarty_start_delay_min", 60];
missionNamespace setVariable ["vn_mf_counterarty_start_delay_random", 60];

// Spread
missionNamespace setVariable ["vn_mf_counterarty_spread_start", 1000];
missionNamespace setVariable ["vn_mf_counterarty_spread_step", 100];
missionNamespace setVariable ["vn_mf_counterarty_spread_min", 150];

// Spawn ring
missionNamespace setVariable ["vn_mf_counterarty_spawn_ao_min", 750];
missionNamespace setVariable ["vn_mf_counterarty_spawn_ao_max", 5000];
missionNamespace setVariable ["vn_mf_counterarty_spawn_fsb_min", 1200];
missionNamespace setVariable ["vn_mf_counterarty_spawn_tower_min", 500];
missionNamespace setVariable ["vn_mf_counterarty_spawn_attempts", 40];
missionNamespace setVariable ["vn_mf_counterarty_spawn_retry_delay", 30];
missionNamespace setVariable ["vn_mf_counterarty_spawn_target_ranges", [
	[741, 2167],
	[1430, 4181],
	[5720, 16725]
]];

// Artillery gun placement
missionNamespace setVariable ["vn_mf_counterarty_battery_gun_count", 1];
missionNamespace setVariable ["vn_mf_counterarty_battery_gun_class", "vn_o_nva_static_d44_01"];
missionNamespace setVariable ["vn_mf_counterarty_battery_spacing", 18];

if (missionNamespace getVariable ["vn_mf_counterarty_initialized", false]) exitWith {};
missionNamespace setVariable ["vn_mf_counterarty_initialized", true];

missionNamespace setVariable ["vn_mf_counterarty_sessions", createHashMap];
["counterarty_tick", vn_mf_fnc_counterarty_tick, [], 5] call para_g_fnc_scheduler_add_job;
