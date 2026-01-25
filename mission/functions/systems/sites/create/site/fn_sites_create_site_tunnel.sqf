/*
    File: fn_sites_create_camp_tunnel.sqf
    Author: Tylervip
    Public: yes
    
    Description:
		Creates a new Factory site in the given location.
    
    Parameter(s):
		_pos - Position to spawn the HQ site at
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_tunnel_site
*/

params ["_pos"];

[
	"tunnel",
	_pos,
	"hq",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;
		private _tunnelObj = ["Land_vn_o_trapdoor_01", _spawnPos] call para_g_fnc_create_vehicle;

		// Register ONLY the first tunnel for teardown
		_siteStore setVariable ["objectsToDestroy", [_tunnelObj]];

		// Watch for deletion
		[_tunnelObj, _siteStore] spawn {
			params ["_oldTunnel", "_siteStore"];
			private _pos = getPosATL _oldTunnel;
			private _dir = getDir _oldTunnel;
			waitUntil { sleep 0.5; isNull _oldTunnel };
			private _newTunnel = "Land_vn_o_trapdoor_02" createVehicle _pos;
			_newTunnel setDir _dir;
			vn_site_objects pushBack _newTunnel;
		};

		private _tunnelMarkerPos = _spawnPos getPos [10 + random 20, random 360];
		private _tunnelMarker = createMarker [format ["Tunnel_%1", _siteId], _tunnelMarkerPos];
		_tunnelMarker setMarkerType "o_installation";
		_tunnelMarker setMarkerText "Tunnel";
		_tunnelMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["PartialTunnel_%1", _siteId], _partialMarkerPos];
		_partialMarker setMarkerType "o_unknown";
		_partialMarker setMarkerAlpha 0;

		_siteStore setVariable ["markers",[_tunnelMarker]];
		_siteStore setVariable ["partialMarkers",[_partialMarker]];
		
		if (random 1 < 0.7) then {
			_siteStore setVariable [
				"aiObjectives",
				[[_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_ambush]
			];
		} else {
			_siteStore setVariable [
				"aiObjectives",
				[[_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend]
			];
		};

		if (random 1 < 0.5) then {
			private _mines = ([3, ceil random 8] call vn_mf_fnc_range) apply {
				createMine ["vn_mine_punji_02", _spawnPos, [], 5]
			};
			vn_site_objects append _mines;
		};


	},
	//Teardown condition check code
	{
		//Check if we need to teardown every 15 seconds.
		15 call _fnc_periodicallyAttemptTeardown;
	},
	//Teardown condition
	{
		params ["_siteStore"];
		[_siteStore] call vn_mf_fnc_sites_utils_std_check_teardown;
	},
	//Teardown code
	{
		params ["_siteStore"];
		[_siteStore] call vn_mf_fnc_sites_utils_std_teardown;
	}
] call vn_mf_fnc_sites_create_site;