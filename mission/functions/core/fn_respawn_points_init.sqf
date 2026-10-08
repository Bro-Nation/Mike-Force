/*
    File: fn_respawn_points_init.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Sets up main mission respawn points
    
    Parameter(s):
		None
    
    Returns:
		None
    
    Example(s):
		[] call vn_mf_fnc_respawn_points_init
*/

vn_mf_respawn_points = vn_mf_markers_base_respawns apply {
	[west, _x, markerText _x] call BIS_fnc_addRespawnPosition;
  [independent, _x, markerText _x] call BIS_fnc_addRespawnPosition;
};

vn_dc_respawn_points = vn_mf_dc_markers_base_respawns apply { 
	[east, _x, markerText _x] call BIS_fnc_addRespawnPosition;
};

// When a player spawns at the AO Tunnel respawn, give them freefall height for tunnel entry
//todo make sure this is the right place to put this
["onPlayerRespawn", [{
	params ["_handlerParams", "_eventParams"];
	_eventParams params ["_player", "_identity"];
	if (_identity isEqualTo "mf_dc_respawn_daccong_aotunnel") then {
		private _exitTeleport = missionNamespace getVariable ["mf_dc_spawnpoint_daccong_aotunnel", objNull];
		_player setPosATL (getPosATL _exitTeleport vectorAdd [0,0,1]);

		_player setUnitFreefallHeight 32000;
		_player setVariable ["inTunnel", true, true];
	};
}, []]] call para_g_fnc_event_add_handler;