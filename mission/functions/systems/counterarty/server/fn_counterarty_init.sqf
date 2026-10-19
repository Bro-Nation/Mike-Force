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

private _test = missionNamespace getVariable ["vn_mf_counterarty_test_mode", false];

// Timing (live / test)
missionNamespace setVariable ["vn_mf_counterarty_interval", [180, 25] select _test];
missionNamespace setVariable ["vn_mf_counterarty_timeout", [600, 120] select _test];
missionNamespace setVariable ["vn_mf_counterarty_respawn_cooldown", [420, 45] select _test];
missionNamespace setVariable ["vn_mf_counterarty_rounds", [6, 3] select _test];

// Spread
missionNamespace setVariable ["vn_mf_counterarty_spread_start", 1000];
missionNamespace setVariable ["vn_mf_counterarty_spread_step", 100];
missionNamespace setVariable ["vn_mf_counterarty_spread_min", 150];

// Spawn ring
missionNamespace setVariable ["vn_mf_counterarty_spawn_ao_min", 2000];
missionNamespace setVariable ["vn_mf_counterarty_spawn_ao_max", 5000];
missionNamespace setVariable ["vn_mf_counterarty_spawn_fsb_min", 2000];
missionNamespace setVariable ["vn_mf_counterarty_spawn_tower_min", 500];
missionNamespace setVariable ["vn_mf_counterarty_spawn_attempts", 40];
missionNamespace setVariable ["vn_mf_counterarty_spawn_retry_delay", 30];

// Enemy pieces: one howitzer and one mortar
missionNamespace setVariable ["vn_mf_counterarty_battery_classes", [
	"vn_o_nva_static_d44",
	"vn_o_nva_static_mortar_type63"
]];

if (missionNamespace getVariable ["vn_mf_counterarty_initialized", false]) exitWith {};
missionNamespace setVariable ["vn_mf_counterarty_initialized", true];

missionNamespace setVariable ["vn_mf_counterarty_sessions", createHashMap];
["counterarty_tick", vn_mf_fnc_counterarty_tick, [], 5] call para_g_fnc_scheduler_add_job;
