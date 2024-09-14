/*
	File: fn_sites_remoteactions_destroy_task_dc_respawn.sqf
	Author: @dijksterhuis
	Public: No
	
	Description:
		Deregisters a dac cong respawn from the mission.

		**THIS DOES NOT DELETE THE PLATFORM.**

		You must call vn_mf_fnc_sites_remoteactions_destroy_task_object after this one.
	
	Parameter(s):
		- _task - the respawn object
	
	Returns:
		Nothing
	
	Example(s):
		[_platform] call vn_mf_fnc_sites_remoteactions_destroy_task_dc_respawn;
		// must be called to blow up the platform!
		[_platform] call vn_mf_fnc_sites_remoteactions_destroy_task_object;
*/

params ["_task"];

private _respawnInfo = _task getVariable ["vn_respawn", []];

if !(_respawnInfo isEqualTo []) then
{
	private _marker = _respawnInfo # 0;
	private _respawnID = _respawnInfo # 1;

	_respawnID call BIS_fnc_removeRespawnPosition;
	deleteMarker _marker;

	// pop removed spawn from global list of DC spawns
	vn_dc_adhoc_respawns = vn_dc_adhoc_respawns select { !(_x isEqualTo _respawnInfo) } ;
	publicVariable "vn_dc_adhoc_respawns";
};
