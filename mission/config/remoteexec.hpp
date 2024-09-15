/*
# cfgRemoteExec -- https://community.bistudio.com/wiki/Arma_3:_CfgRemoteExec

this file stops script kiddies from being able to remotely execute code as best as we can.

## top class fields (functions and commands)
### `mode`
* 0 - remote execution is blocked
* 1 - only whitelisted functions / commands are allowed
* 2 - remote execution is fully allowed, ignoring the whitelist (default, because of backward compatibility)

### `jip`
* 0 - JIP flag can not be set
* 1 - JIP flag can be set (default)

## specific function / commands

### `allowedTargets`

Allowed targets:
	0 - can target all machines (default)
	1 - can only target clients, execution on the server is denied
	2 - can only target the server, execution on clients is denied
	Any other value will be treated as 0.

### `jip`
* 0 - JIP flag can not be set
* 1 - JIP flag can be set (default)

*/

#define ALLOW_SERVER allowedTargets = 2
#define ALLOW_CLIENTS allowedTargets = 1
#define ALLOW_ALL allowedTargets = 0

#define DISABLE_JIP jip = 0
#define ENABLE_JIP jip = 1

#define FNC_CONSTRUCTOR(fncname, server, jip) \
	class fncname { \
		server; \
		jip; \
	};

#define FNC_ALLOW_SERVER_ENABLE_JIP(fncname) \
	class fncname { \
		ALLOW_SERVER; \
		ENABLE_JIP; \
	};

class CfgRemoteExec {
	
	class Functions
	{
		mode = 1;
		ENABLE_JIP;

		// fundamental to the gamemode, do not disable
		FNC_CONSTRUCTOR(BIS_fnc_effectKilledAirDestruction, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(BIS_fnc_effectKilledSecondaries, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(BIS_fnc_fire, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(BIS_fnc_objectVar, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(BIS_fnc_setCustomSoundController, ALLOW_SERVER, DISABLE_JIP)

		// allow admin debug console access
		// https://community.bistudio.com/wiki/Arma_3:_CfgRemoteExec#Notes
		FNC_CONSTRUCTOR(BIS_fnc_debugConsoleExec, ALLOW_SERVER, DISABLE_JIP)

		// required by task system initialisiation on the player
		FNC_CONSTRUCTOR(bis_fnc_settasklocal, ALLOW_SERVER, ENABLE_JIP)
		FNC_CONSTRUCTOR(bis_fnc_sharedobjectives, ALLOW_SERVER, ENABLE_JIP)

		// https://www.reddit.com/r/armadev/comments/8fkitd/comment/dy5k5pf/
		// DO NOT ENABLE THIS. THIS ONLY LIVES HERE TO TELL YOU NOT TO DO THIS.
		// FNC_CONSTRUCTOR(bis_fnc_execvm, NONONONO, NONONONO)

		// required to allow zeus interface
		FNC_CONSTRUCTOR(bis_fnc_call, ALLOW_SERVER, ENABLE_JIP)

		// VANILLA MIKE FORCE SPECIFIC

		// paradigm client initialisiation
		FNC_CONSTRUCTOR(para_s_fnc_init_player, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(para_s_fnc_postinit_player, ALLOW_SERVER, DISABLE_JIP)

		// paradigm utils
		FNC_CONSTRUCTOR(para_s_fnc_rehandler, ALLOW_SERVER, ENABLE_JIP)
		FNC_CONSTRUCTOR(para_c_fnc_show_notification, ALLOW_SERVER, DISABLE_JIP)

		// rehandler functions. TODO: are these actually remote exec'd? or do we remoteExec rehandler?
		FNC_CONSTRUCTOR(vn_mf_fnc_arsenal_trash_cleanup, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_changeteam, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_eatdrink, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_packageforslingloading, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_settrait, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_supplyrequest, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_supporttaskcreate, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_teleport, ALLOW_SERVER, DISABLE_JIP)

		// change vehicles at a vehicle spawner
		FNC_CONSTRUCTOR(vn_mf_fnc_veh_asset_handle_change_vehicle_request, ALLOW_SERVER, DISABLE_JIP)

		// BRO-NATION MIKE FORCE SPECIFIC

		// player site specific hold actions
		FNC_CONSTRUCTOR(vn_mf_fnc_sites_remoteactions_reveal_radiotap, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_sites_remoteactions_reveal_scout, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_sites_remoteactions_reveal_intel, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_sites_remoteactions_destroy_task, ALLOW_SERVER, DISABLE_JIP)

		// player vehicle spawner specifc hold actions
		FNC_ALLOW_SERVER_DISABLE_JIP(vn_mf_fnc_veh_asset_bn_curator_force_recover_wrecked_vehicle, ALLOW_SERVER, DISABLE_JIP)
		FNC_ALLOW_SERVER_DISABLE_JIP(vn_mf_fnc_veh_asset_bn_curator_force_reset_idle_vehicle, ALLOW_SERVER, DISABLE_JIP)
		FNC_ALLOW_SERVER_DISABLE_JIP(vn_mf_fnc_veh_asset_bn_curator_lock_spawner, ALLOW_SERVER, DISABLE_JIP)
		FNC_ALLOW_SERVER_DISABLE_JIP(vn_mf_fnc_veh_asset_bn_curator_unlock_spawner, ALLOW_SERVER, DISABLE_JIP)

		// dac cong
		FNC_CONSTRUCTOR(vn_mf_fnc_capture_player, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_ctf_handle_flag_height_change, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_ctf_broadcast_notify_immediate, ALLOW_SERVER, DISABLE_JIP)

		// light attachments
		FNC_CONSTRUCTOR(vn_mf_fnc_attachments_server_attach_chemlight, ALLOW_SERVER, DISABLE_JIP)
		FNC_CONSTRUCTOR(vn_mf_fnc_attachments_server_attach_flashlight, ALLOW_SERVER, DISABLE_JIP)

	};

	class Commands
	{
		mode = 1;
		ENABLE_JIP;

		// needed during player init process to silence radio messages from
		// player's character
		FNC_CONSTRUCTOR(setSpeaker, ALLOW_SERVER, DISABLE_JIP)
		// fn_operate_wrench.sqf
		FNC_CONSTRUCTOR(setDamage, ALLOW_SERVER, DISABLE_JIP)
	};
};