/*
	File: fn_zones_create_artillery_site.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates an artillery site in the given zone.
	
	Parameter(s):
		_zone - Zone marker name [STRING]
	
	Returns:
		Task Data store [NAMESPACE]
	
	Example(s):
		["zone_saigon"] call vn_mf_fnc_zones_create_artillery_site
*/

params ["_pos"];

[
	"artillery",
	_pos,
	"factory",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _artyObjs = [_spawnPos] call vn_mf_fnc_sites_create_compositions_mortar;
		{
		_x setVariable ["vn_log_enablePickup", false];
			
			if(_x isKindOf "StaticWeapon" || _x isKindOf "Building" || _x isKindOf "House" || _x isKindOf "LandVehicle" || _x isKindOf "Air") then {
				[_x, true] call para_s_fnc_enable_dynamic_sim;
			};
		} forEach _artyObjs;

		vn_site_objects append _artyObjs;

		/*
		TODO: mortar site compositions currently have a bunch
		of ammo crates dotted around that have a holdAction attached to them

		This can be confusing to players as they have the option to destroy the
		ammo crates, but it is not necessary for the objective to complete.

		We can either
		- (a) make ammo crates a requirement for completing an Arty site
		- (b) switch ammo crates out for a different ammo crate type (not in the fn_action_destroy_task list)
		*/

		// all NVA/VC artillery objects that *could* be spawned in a composition
		// reference mission/config/arsenal.hpp
		private _objectTypesToDestroy = [
			"vn_o_nva_navy_static_mortar_type63",
			"vn_o_nva_navy_static_mortar_type53",
			"vn_o_nva_65_static_mortar_type53",
			"vn_o_nva_65_static_mortar_type63",
			"vn_o_nva_static_mortar_type53",
			"vn_o_nva_static_mortar_type63",
			"vn_o_vc_static_mortar_type53",
			"vn_o_vc_static_mortar_type63",
			"vn_o_nva_65_static_d44",
			"vn_o_nva_65_static_d44_01",
			"vn_o_nva_navy_static_d44",
			"vn_o_nva_navy_static_d44_01",
			"vn_o_nva_static_d44",
			"vn_o_nva_static_d44_01",
			"vn_o_vc_static_d44",
			"vn_o_vc_static_d44_01"
		];

		private _objectsToDestroy = _artyObjs select {
			typeOf _x in _objectTypesToDestroy;
		};

		private _markerPos = _spawnPos getPos [10 + random 20, random 360];
		private _artilleryMarker = createMarker [format ["Artillery_%1", _siteId], _markerPos];
		_artilleryMarker setMarkerType "o_art";
		_artilleryMarker setMarkerText "Arty";
		_artilleryMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialArtillery_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		_objectsToDestroy apply {

			// Disable weapon dissassembly as statics aren't deleted properly
			// when disassembled, breaking the site/mission.
			_x enableWeaponDisassembly false;

			// Whitelist arty objects to discourage blufor players from
			// stealing/moving mission critical objects and blocking progress
			[_x, ["DacCong"]] call vn_mf_fnc_lock_vehicle_to_teams;
			vn_mf_dc_assets pushBack _x;
		};

		// includes all the objects to destroy for arty sites (mortars)
		_artyObjs select {_x isKindOf "StaticWeapon"} apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
			[_x] call vn_mf_fnc_sites_object_zfixer_add_object;
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		};

		// Building Kind of includes bushes and the DC wallfoliage fences
		_artyObjs select {_x isKindOf "Building"} apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		};

		_siteStore setVariable ["aiObjectives", [[_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend]];
		_siteStore setVariable ["markers", [_artilleryMarker]];
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