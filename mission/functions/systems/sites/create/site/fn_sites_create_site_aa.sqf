/*
	File: fn_zones_create_aa_site.sqf
	Author: Savage Game Design
	Modified: @dijksterhuis
	Public: No
	
	Description:
		Creates an AA site in the given zone.
		(An 'AA' site is 1x ZPU that needs to be destroyed)
	
	Parameter(s):
		_zone - Zone marker name [STRING]
	
	Returns:
		Task data store [NAMESPACE]
	
	Example(s):
		["zone_saigon"] call vn_mf_fnc_zones_create_aa_site
*/

params ["_pos"];

[
	"aa",
	_pos,
	"factory",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _objects = [_spawnPos] call vn_mf_fnc_sites_create_compositions_aa;

		vn_site_objects append _objects;

		_objects apply {
			[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
			[_x] call vn_mf_fnc_sites_object_zfixer_add_object;
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		};

		private _markerPos = _spawnPos getPos [10 + random 20, random 360];

		private _aaMarker = createMarker [format ["AA_%1", _siteId], _markerPos];
		_aaMarker setMarkerType "o_antiair";
		_aaMarker setMarkerText "AA";
		_aaMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialAA_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		_siteStore setVariable ["aiObjectives", []];
		_siteStore setVariable ["markers", [_aaMarker]];
		_siteStore setVariable ["partialMarkers", [_markerPartial]];
		_siteStore setVariable ["objectsToDestroy", _objects];
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
		// delete the vehicle crew then teardown everything else
		(_siteStore getVariable "objectsToDestroy") apply {deleteVehicleCrew _x};
		[_siteStore] call vn_mf_fnc_sites_utils_std_teardown;
	}
] call vn_mf_fnc_sites_create_site;
