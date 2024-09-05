/*
	File: fn_task_helpers_counterattack_reset_flag_vars.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets a broadcasted publicVar to nil and a remoteExec JIP execution
		setting the flag height

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

// broadcast that the flag no longer exists.
vn_mf_bn_dc_target_flag = nil;
publicVariable "vn_mf_bn_dc_target_flag";

// clear the JIP queue for flag height, not necessary anymore
remoteExec ["", "JIP_DACCONG_CTF_FLAG_HEIGHT"];

nil;