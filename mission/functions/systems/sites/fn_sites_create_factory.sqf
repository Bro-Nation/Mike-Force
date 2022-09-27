/*
    File: fn_sites_create_factory.sqf
    Author: Cerebral
    Public: No
    
    Description:
		Creates a new Factory site in the given location.
    
    Parameter(s):
		_pos - Position to spawn the HQ site at
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_factory
*/

params ["_pos"];

[
	"factory",
	_pos,
	"factory",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		missionNamespace getVariable ["current_factory", _siteStore];

		private _factoryObjects = [_spawnPos] call vn_mf_fnc_create_factory_buildings;
		private _objectsToDestroy = _factoryObjects select {typeOf _x == "Land_vn_wf_vehicle_service_point_east"};
		private _intel = _factoryObjects select {typeOf _x == "Land_Map_unfolded_Malden_F"};
		missionNamespace setVariable ["factory_intel", _intel];
		missionNamespace setVariable ["factoryPosition", _pos];

		_intel call vn_mf_fnc_action_gather_intel;
		private _currentVehicles = vehicles;

		{
			if(_x isKindOf "Building" || _x isKindOf "House" || typeOf _x in ["Land_Map_unfolded_Malden_F", "Land_vn_wf_vehicle_service_point_east", "Land_vn_fuel_tank_stairs", "Land_Net_Fence_Gate_F"] || _x isKindOf "StaticWeapon" || _x isKindOf "LandVehicle" || _x isKindOf "Air") then {
				[_x, true] call para_s_fnc_enable_dynamic_sim;
			};

			if (_x in _currentVehicles) then {
				[_x, ["DacCong"]] call vn_mf_fnc_lock_vehicle_to_teams;
				vn_mf_dc_assets pushBack _x;
			};

		} forEach _factoryObjects;

		vn_site_objects append _factoryObjects;

		//Create a factory marker.
		private _markerPos = _spawnPos getPos [20 + random 30, random 360];
		private _factoryMarker = createMarker [format ["factory_%1", _siteId], _markerPos];
		_factoryMarker setMarkerType "o_Ordnance";
		_factoryMarker setMarkerText "Factory";
		_factoryMarker setMarkerAlpha 0;

		private _factoryRespawnMarker = createMarker [format ["dc_respawn_adhoc_%1", _siteId], _markerPos];
		_factoryRespawnMarker setMarkerType "o_Ordnance";
		_factoryRespawnMarker setMarkerAlpha 0;
		
		private _respawnID = [east, _factoryRespawnMarker] call BIS_fnc_addRespawnPosition;
		private _respawnObj = createVehicle ["Land_vn_o_platform_04", _markerPos, [], 5, "NONE"];
		_respawnObj setVariable ["vn_respawn", [_factoryRespawnMarker, _respawnID]];
	
		vn_dc_adhoc_respawns pushBack [_factoryRespawnMarker, _respawnID];

		private _guns = _factoryObjects select {_x isKindOf "StaticWeapon"};
		private _objectives = [];
		{
			_objectives pushBack ([_x] call para_s_fnc_ai_obj_request_crew);
		} forEach _guns;
		_objectives pushBack ([_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend);

		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["markers", [_factoryMarker]];
		_siteStore setVariable ["staticGuns", _guns];
		_siteStore setVariable ["vehicles", _factoryObjects]; 
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

		(_siteStore getVariable "objectsToDestroy" findIf {alive _x} == -1)
	},
	//Teardown code
	{
		params ["_siteStore"];

		private _objectsToDestroy = _siteStore getVariable "objectsToDestroy";

		{
			deleteMarker _x;
		} forEach (_siteStore getVariable "markers");
	}
] call vn_mf_fnc_sites_create_site;