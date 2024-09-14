/*
	File: fn_ctf_broadcast_notify_immediate.sqf
	Author: "DJ" Dijksterhuis
	Public: No

	Description:
	   Display a notification for all players via a remoteExec callback.

	   Used to perform a global notification broadcast out to all players
	   from a specific player locality.

	   player -> server -> all players

	   Means the specific player client isn't sending out remoteExec instructions to
	   all connected players, hopefully mitigating some desync/latency issues and enabling
	   use to implement a CfgRemoteExec later on.

	   TODO: Refactor this out to core/helpers?
	   TODO: Rename? Should be like fn_broadcast_global_notification.sqf

	Parameter(s):
		- _notificationClass -- class name of the notification to show [STRING]
		- _args -- arguments for string replacement in notification description text [ARRAY]

	Returns: nothing

	Example(s):
		// from player locality
		// remote execs this script on the server
		// which then remoteExecs a notification for all clients (and server, see note below)
		["FireInTheHole"] remoteExec ["vn_mf_fnc_ctf_broadcast_notify_immediate", 2];

		// from server locality
		["FireInTheHole"] call vn_mf_fnc_ctf_broadcast_notify_immediate;
*/

params [
	"_notificationClass",
	["_args", []]
];

if (!isServer) exitWith {
	["ERROR", "Function should only run on server!"] call para_g_fnc_log;
};

if (_notificationClass isEqualTo "") exitWith {
	["ERROR", format ["Function passed an empty string for _notificationClass! value=%1", _notificationClass]] call para_g_fnc_log;
};

if !(_notificationClass isEqualType "testvalue") exitWith {
	["ERROR", format ["Function passed non-string for _notificationClass! value=%1", _notificationClass]] call para_g_fnc_log;
};

if !(_args isEqualType []) exitWith {
	["ERROR", format ["Function passed non-array for _args! value=%1", _args]] call para_g_fnc_log;
};

// This *should* be -2 --> but then notifications don't work on player hosted (local development)
// cba to optimise this right now. it'll be fine for the moment.
[_notificationClass, _args] remoteExec ["para_c_fnc_show_notification", 0];

nil;