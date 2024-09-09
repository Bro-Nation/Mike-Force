/*
    File: fn_director_complete_zone.sqf
    Author: Spoffy
    Date: 2023-01-07
    Last Update: 2023-01-07
    Public: Yes
    
    Description:
	   	Closes down an active zone, and marks it as completed.
    
    Parameter(s):
	   	_zone - Zone to complete [STRING]
    
    Returns:
	   	Nothing
    
    Example(s):
		["zone_ba_ria"] call vn_mf_fnc_director_complete_zone;
*/

params ["_zone"];

if !(_zone in mf_s_dir_activeZones) exitWith {
	["WARNING", format ["Attempting to close inactive zone '%1'", _zone]] call para_g_fnc_log;
};

private _zoneInfo = mf_s_dir_activeZones get _zone;

private _task = _zoneInfo getOrDefault ["currentTask", objNull];
if !([_task] call vn_mf_fnc_task_is_completed) then {
	[_task, 'SUCCEEDED'] call vn_mf_fnc_task_complete;
};

call vn_mf_fnc_daccong_respawns_delete_all;

// delete all site composition objects.
vn_site_objects apply {deleteVehicle _x};

[_zone] call vn_mf_fnc_zones_capture_zone;

// upstream SGD allow any connected zone to be open, which is not what we want in BN
[] call vn_mf_fnc_director_open_closest_zone;
// [] call vn_mf_fnc_director_open_connected_zones;

// we don't want to start playing music for
// players still in the intro / player init

allPlayers select {simulationEnabled _x} apply {
    remoteExec ["vn_mf_fnc_director_play_music_completed_zone", _x];
};

mf_s_dir_activeZones deleteAt _zone;
mf_g_dir_activeZoneNames = keys mf_s_dir_activeZones;
publicVariable "mf_g_dir_activeZoneNames";