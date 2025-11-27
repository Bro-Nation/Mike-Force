/*
    File: fn_sites_create_radar.sqf
    Author: Cerebral
    Public: No
    
    Description:
		Creates a new radar site in the given location.
    
    Parameter(s):
		_pos - Position to spawn the HQ site at
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_radar
*/

params ["_pos"];

[
	"radar",
	_pos,
	"factory",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _radarObjs = [_spawnPos] call vn_mf_fnc_sites_create_compositions_radar;
		{
		_x setVariable ["vn_log_enablePickup", false, true];

			if(_x isKindOf "StaticWeapon" || _x isKindOf "LandVehicle" || _x isKindOf "Air" || typeOf _x in ['Land_Net_Fence_Gate_F'] || _x isKindOf "Building") then {
				[_x, true] call para_s_fnc_enable_dynamic_sim;
			};

			if(typeof _x == "vn_o_static_rsna75" || typeof _x == "vn_sa2") then {
				_x enableSimulation true;
				createVehicleCrew _x;

				_x setVehicleRadar 1;
				_x setVehicleReportOwnPosition true;
				_x setVehicleReceiveRemoteTargets true;
				_x setVehicleReportRemoteTargets true;
			};
		} forEach _radarObjs;

		vn_site_objects append _radarObjs;

		private _objectsToDestroy = _radarObjs select { typeof _x == "vn_o_static_rsna75" || typeof _x == "vn_sa2"};
		
		private _markerPos = _spawnPos getPos [10 + random 20, random 360];
		private _radarMarker = createMarker [format ["radar_%1", _siteId], _markerPos];
		_radarMarker setMarkerType "o_support";
		_radarMarker setMarkerText "Radar";
		_radarMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialRadar_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		private _staticWeapons = _radarObjs select {
			_x isKindOf "StaticWeapon" && !(typeof _x == "vn_o_static_rsna75") && !(typeof _x == "vn_sa2");
		};

		_staticWeapons apply {[_x, true] call para_s_fnc_enable_dynamic_sim};

		_siteStore setVariable ["aiObjectives", [[_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend]];
		_siteStore setVariable ["markers", [_radarMarker]];
		_siteStore setVariable ["partialMarkers", [_markerPartial]];
		_siteStore setVariable ["objectsToDestroy", _objectsToDestroy];
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