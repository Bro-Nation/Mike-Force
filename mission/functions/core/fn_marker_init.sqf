/*
	File: fn_marker_init.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Initialises mission state from the markers on the map.
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		call vn_mf_fnc_marker_init
*/

vn_mf_markers_base_respawns = [];
vn_mf_dc_assets = [];
vn_mf_dc_markers_base_respawns = [];
vn_mf_markers_blocked_areas = [];
vn_mf_markers_zones = [];
vn_mf_markers_connectors = [];
vn_mf_markers_no_sites = [];
vn_mf_markers_supply_officer_initial = [];
vn_mf_markers_wreck_recovery = [];
vn_mf_markers_no_harass = [];

{
	if (_x find "mf_respawn_" isEqualTo 0) then {
		_x setMarkerAlpha 0;
		vn_mf_markers_base_respawns pushBack _x;
	};

	if (_x find "mf_dc_respawn_" isEqualTo 0)then {
		_x setMarkerAlpha 0;
		vn_mf_dc_markers_base_respawns pushBack _x;
	};

	if (_x find "blocked_area" isEqualTo 0) then {
		_x setMarkerAlpha 0;
		vn_mf_markers_blocked_areas pushBack _x;
	};

	if (_x find "fob_" isEqualTo 0) then
	{
		_x setMarkerAlpha 0;
	};

	if (_x find "no_sites_" isEqualTo 0) then {
		_x setMarkerAlpha 0;
		vn_mf_markers_no_sites pushBack _x; 
	};

	if (_x find "no_harass_" isEqualTo 0) then {
		_x setMarkerAlpha 0;
		vn_mf_markers_no_harass pushBack _x;
	};

	if (_x find "fsb_" isEqualTo 0) then
	{
		_x setMarkerAlpha 0;
	};

	if (_x find "connector_" isEqualTo 0) then
	{
		_x setMarkerAlpha 0;
		vn_mf_markers_connectors pushBack _x;
	};

	if (_x find "zone_" isEqualTo 0) then
	{
		vn_mf_markers_zones pushBack _x;
		//Select everything after 'zone_'
		private _locationMarker = _x select [5];
		//Hide location marker used for mission mockup
		_locationMarker setMarkerAlpha 0;

		private _noHarassMarker = createMarker [format ["no_harass_%1", _x], getMarkerPos _x];
		_noHarassMarker setMarkerShape "ELLIPSE";
		_noHarassMarker setMarkerSize [200, 200];
		_noHarassMarker setMarkerAlpha 0;
		vn_mf_markers_no_harass pushBack _noHarassMarker;
	};

	if (_x find "wreck_recovery" isEqualTo 0) then {
		vn_mf_markers_wreck_recovery pushBack _x;
	};

	if (_x find "supply_officer_initial" isEqualTo 0) then {
		vn_mf_markers_supply_officer_initial pushBack _x;
	};

	if (_x find "dac_cong_assets" isEqualTo 0) then {
		private _vehicles = vehicles inAreaArray _x;

		_x setMarkerAlpha 0;
		vn_mf_dc_assets = vn_mf_dc_assets + _vehicles;
	};

	if (_x find "baseflag_" isEqualTo 0) then {
		_str = _x splitString "_";
		private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _str#1);
		private _groupColor = getText(_groupConfig >> "color");
		_x setMarkerColor _groupColor;
		_x setMarkerAlpha 1;
	};
} forEach allMapMarkers;

publicVariable "vn_mf_markers_blocked_areas";
publicVariable "vn_mf_markers_no_sites";
publicVariable "vn_mf_dc_assets";