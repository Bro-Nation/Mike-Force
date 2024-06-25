/*
    File: fn_sites_create_hq.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Creates a new HQ site in the given location.
    
    Parameter(s):
		_pos - Position to spawn the HQ site at
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_hq
*/

params ["_pos"];

[
	"hq",
	_pos,
	"hq",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		missionNamespace getVariable ["current_hq", _siteStore];

		private _objectTypesToDestroy = [
			"Land_vn_pavn_launchers", 
			"vn_b_ammobox_01", 
			"Land_vn_pavn_weapons_wide", 
			"Land_vn_pavn_weapons_cache", 
			"Land_vn_pavn_ammo", 
			"Land_vn_pavn_weapons_stack1", 
			"Land_vn_pavn_weapons_stack2",
			"Land_vn_pavn_weapons_stack3", 
			"vn_b_ammobox_full_02", 
			"vn_o_ammobox_wpn_04", 
			"vn_o_ammobox_full_03", 
			"vn_o_ammobox_full_07", 
			"vn_o_ammobox_full_06"
		];

		private _objectTypesForDynamicSim = [
			"vn_o_prop_t102e_01",
			"vn_o_prop_radio_m252b_01",
			"Land_WoodenTable_small_F",
			"Land_WoodenTable_large_F",
			"Land_vn_lobby_table",
			"Land_Map_unfolded_F"
		];

		private _hqObjects = [_spawnPos] call vn_mf_fnc_sites_create_compositions_hq;
		vn_site_objects append _hqObjects;

		private _fnc_dynSimKindOfChecker = {
			params ["_object"];
			(_x isKindOf "StaticWeapon" || _x isKindOf "Building" || _x isKindOf "House" || _x isKindOf "LandVehicle")
		};

		// normalise z-coord and up vector for vehicles, static weapons, weapon creates and the intel associated objects
		_hqObjects select {typeOf _x in _objectTypesToDestroy || _x isKindOf "StaticWeapon" || _x isKindOf "LandVehicle"} apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
		};

		// keep an eye on anything we definitely don't want to fall under the floor
		_hqObjects select {typeOf _x in _objectTypesToDestroy || _x isKindOf "StaticWeapon"} apply {
			[_x] call vn_mf_fnc_sites_object_zfixer_add_object;
		};

		// enable dynamic sim for a bunch of stuff
		_hqObjects select {typeOf _x in _objectTypesToDestroy + _objectTypesForDynamicSim || [_x] call _fnc_dynSimKindOfChecker} apply {
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		};

		private _intel = _hqObjects select {typeOf _x == "Land_Map_unfolded_F"};
		missionNamespace setVariable ["hq_intel", _intel];
		missionNamespace setVariable ["hqPosition", _pos];

		private _objectsToDestroy = _hqObjects select {typeOf _x in _objectTypesToDestroy};

		// 2x ai objectives to replace other factory / hq AI that never get freed in task system
		private _objectives = [
			[_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend,
			[_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend
		];

		//Create a HQ marker.
		private _markerPos = _spawnPos getPos [20 + random 30, random 360];
		private _hqMarker = createMarker [format ["HQ_%1", _siteId], _markerPos];
		_hqMarker setMarkerType "o_hq";
		_hqMarker setMarkerText "HQ";
		_hqMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialHQ_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		private _hqRespawnMarker = createMarker [format ["dc_respawn_adhoc_%1", _siteId], _markerPos];
		_hqRespawnMarker setMarkerType "o_hq";
		_hqRespawnMarker setMarkerAlpha 0;

		private _respawnID = [east, _hqRespawnMarker] call BIS_fnc_addRespawnPosition;
		private _respawnObj = createVehicle ["Land_vn_o_platform_04", _markerPos, [], 5, "NONE"];
		_respawnObj setVariable ["vn_respawn", [_hqRespawnMarker,_respawnID]];

		vn_dc_adhoc_respawns pushBack [_hqRespawnMarker,_respawnID];
		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["markers", [_hqMarker]];
		_siteStore setVariable ["partialMarkers", [_markerPartial]];
		_siteStore setVariable ["vehicles", _hqObjects]; 
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