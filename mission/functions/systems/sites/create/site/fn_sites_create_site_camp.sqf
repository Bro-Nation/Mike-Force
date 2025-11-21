/*
    File: fn_sites_create_camp_site.sqf
    Author: Cerebral
    Public: No
    
    Description:
		Creates a new Factory site in the given location.
    
    Parameter(s):
		_pos - Position to spawn the HQ site at
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_camp_site
*/

params ["_pos"];

[
	"camp",
	_pos,
	"hq",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _campObjs = [_spawnPos] call vn_mf_fnc_sites_create_compositions_camp;

		{
			if(_x isKindOf "StaticWeapon" || _x isKindOf "Building" || _x isKindOf "House" || _x isKindOf "LandVehicle" || _x isKindOf "Air") then {
				[_x, true] call para_s_fnc_enable_dynamic_sim;
			};
		} forEach _campObjs;

		vn_site_objects append _campObjs;

		private _campObjectiveTypes = [
			"Land_vn_o_shelter_06",
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

		private _objectsToDestroy = _campObjs select {typeOf _x in _campObjectiveTypes};

		_objectsToDestroy apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
			[_x] call vn_mf_fnc_sites_object_zfixer_add_object;
			[_x, true] call para_s_fnc_enable_dynamic_sim
		};

		private _markerPos = _spawnPos getPos [10 + random 20, random 360];
		private _campMarker = createMarker [format ["Camp_%1", _siteId], _markerPos];
		_campMarker setMarkerType "o_recon";
		_campMarker setMarkerText "Camp";
		_campMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialCamp_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		// Building Kind of includes bushes and the DC wallfoliage fences
		_campObjs select {_x isKindOf "Building"} apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
		};

		// 30% chance to spawn an ambush
		// @dijksterhuis: we don't assign AI to every camp site to save AI budget on other assignments
		// like tracker teams or factory/HQ/arty sites. 
		// also reduce the scaling factor (affects how many AI should be assigned to this specific location)
		if (random 1 < 0.3) then {
			_siteStore setVariable ["aiObjectives", [[_spawnPos, 0.5, 1] call para_s_fnc_ai_obj_request_ambush]];
		};

		if (random 1 < 0.3) then {

			// create a larger amount of punji traps and fewer larger bigboom mines
			private _traps = ([4, ceil random 8] call vn_mf_fnc_range) apply {
				createMine [
					"vn_mine_punji_02",
					_pos,
					[],
					10
				]
			};

			private _mines = ([1, ceil random 2] call vn_mf_fnc_range) apply {
				private _mine = createMine [
					selectRandom ["vn_mine_pot_range", "vn_mine_jerrycan_range"],
					_pos,
					[],
					4
				];

				// store mine position for the handler
				_mine setVariable ["minePos", getPos _mine, true];

				// add Deleted event handler for AI dispatch
				_mine addEventHandler ["Deleted", {
					params ["_mine"];
					private _minePosStored = _mine getVariable ["minePos", [0,0,0]];

					[_minePosStored] spawn {
						params ["_posStored"];
						sleep 0.35;

						private _holders = nearestObjects [_posStored, ["GroundWeaponHolder"], 10];
						private _wasDisarmed = false;

						{
							if ((magazineCargo _x) find "vn_mine_pot_range_mag" != -1 ||
								(magazineCargo _x) find "vn_mine_jerrycan_range_mag" != -1) exitWith { _wasDisarmed = true };
								
						} forEach _holders;

						if (!_wasDisarmed) then {
							private _player = nearestObject [_posStored, "CAManBase"];

							if (isPlayer _player) then {
								[[_player], 1, 1, east] call para_s_fnc_ai_obj_request_pursuit;
							};
						};
					};
				}];

				_mine
			};

			// deletes the mines once the zone is completed
			vn_site_objects append (_traps + _mines);
		};

		_siteStore setVariable ["markers", [_campMarker]];
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