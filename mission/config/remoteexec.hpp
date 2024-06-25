/*

# top class fields

------------
`mode`

Operation modes:
	0 - remote execution is blocked
	1 - only whitelisted functions / commands are allowed
	2 - remote execution is fully allowed, ignoring the whitelist (default, because of backward compatibility)

------------
`jip`

JIP:
	0 - JIP flag can not be set
	1 - JIP flag can be set (default)


# specific function / commands

------------
`allowedTargets`

Allowed targets:
	0 - can target all machines (default)
	1 - can only target clients, execution on the server is denied
	2 - can only target the server, execution on clients is denied
	Any other value will be treated as 0.

------------
`jip`

as above

*/

#define ALLOW_SERVER allowedTargets = 2
#define ALLOW_CLIENTS allowedTargets = 1
#define ALLOW_ALL allowedTargets = 0

#define DISABLE_JIP jip = 0
#define ENABLE_JIP jip = 1


class CfgRemoteExec {
	
	class Functions
	{
		mode = 1;
		ENABLE_JIP;

		class BIS_fnc_effectKilledAirDestruction {
			ALLOW_ALL;
			DISABLE_JIP;
		};

		class BIS_fnc_effectKilledSecondaries {
			ALLOW_ALL;
			DISABLE_JIP;
		};

		class BIS_fnc_fire {
			ALLOW_ALL;
			DISABLE_JIP;
		};

		class BIS_fnc_objectVar {
			ALLOW_ALL;
			DISABLE_JIP;
		};

		class BIS_fnc_setCustomSoundController {
			ALLOW_ALL;
			DISABLE_JIP;
		};

		class para_c_fnc_show_notification : base {
			ALLOW_CLIENTS;
			ENABLE_JIP;
		};

		class para_s_fnc_init_player {
			ALLOW_SERVER;
			ENABLE_JIP;
		};

		class para_s_fnc_postinit_player {
			ALLOW_SERVER;
			ENABLE_JIP;
		};

		class para_s_fnc_rehandler {
			ALLOW_SERVER;
			ENABLE_JIP;
		};

	};

	class Commands
	{
		mode = 1;
		ENABLE_JIP;

		class setSpeaker {
			ALLOW_ALL;
			ENABLE_JIP;
		};
		// fn_operate_wrench.sqf
		class setDamage {
			ALLOW_ALL;
			ENABLE_JIP;
		};
	};
};