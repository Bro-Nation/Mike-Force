/*
    File: fn_sites_create_site_fuel.sqf
    Author: @dijksterhuis
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
	"fuel",
	_pos,
	"hq",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _objs = [_spawnPos] call vn_mf_fnc_sites_create_compositions_fuel;

		_objs apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
			[_x] call vn_mf_fnc_sites_object_zfixer_add_object;
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		};

		vn_site_objects append _objs;

		private _objectsToDestroy = _objs select {typeOf _x isEqualTo "Land_vn_tank_rust_f"};

		private _markerPos = _spawnPos getPos [10 + random 20, random 360];
		private _mainMarker = createMarker [format ["Fuel_%1", _siteId], _markerPos];
		_mainMarker setMarkerType "o_installation";
		_mainMarker setMarkerText "Fuel";
		_mainMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialFuel_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		// 50% chance to spawn an ambush
		if (random 1 < 0.5) then {
			_siteStore setVariable ["aiObjectives", [[_spawnPos, 0.5, 1] call para_s_fnc_ai_obj_request_ambush]];
		};

		if (random 1 < 0.25) then {

			// create a larger amount of punji traps and fewer larger bigboom mines
			private _traps = ([4, ceil random 8] call vn_mf_fnc_range) apply {
				createMine [
					"vn_mine_punji_02",
					_pos,
					[],
					10
				]
			};
			
			// deletes the mines once the zone is completed
			vn_site_objects append _traps;
		};

		_siteStore setVariable ["markers", [_mainMarker]];
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