/*
	File: sites_remoteactions_reveal_intel.sqf
	Author: Cerebral
	Modified: 'DJ' Dijksterhuis
	Public: No
	
	Description:
		Reveals all the site primary markers on map for a specific 'supply line'.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		[_object, _player] call vn_mf_fnc_sites_remoteactions_reveal_intel;
*/


params ["_intel", "_player"];

private _intelType = typeOf _intel;
private _sites = [];

// if a player moves their cursor quickly after the completion, or theres some lag etc,
// apparently they can pass the factory building as the intel object to be used in the reveal
// which causes some problems.
//
// so double check that we're looking at the right object and warn the player if not.

if !(typeOf _intel in ['Land_Map_unfolded_F','Land_Map_unfolded_Malden_F', 'vn_b_prop_cabinet_02']) exitWith {
	["IntelError"] remoteExec ["para_c_fnc_show_notification", player];
};

switch (_intelType) do
{
	case 'Land_Map_unfolded_F': {_sites = missionNamespace getVariable ["side_sites_hq", []]};
	case 'Land_Map_unfolded_Malden_F': {_sites = missionNamespace getVariable ["side_sites_factory", []]};
	case 'vn_b_prop_cabinet_02': {_sites = missionNamespace getVariable ["side_sites_factory", []]};
};

_sites apply {

	// set the site as "discovered" so the radio tap feature does not 
	// try and reveal this site

	// hide any existing 'partial' markers which will be in a 'wronger'
	// location.

	_x setVariable ["discovered", true];
	_x getVariable ["partialMarkers", []] apply {_x setMarkerAlpha 0.0};

	// aa markers are large areas where AA might be able to see rotary.
	// we don't have these on our sites. but SGD use them
	private _markers = _x getVariable ["markers", []];

	private _markersAA = []; // TODO: _markers select ((_x find "AA_zone_") >= 0);
	private _markersNotAA = _markers - _markersAA;

	_markersNotAA apply {_x setMarkerAlpha 0.5};
	_markersAA apply {_x setMarkerAlpha 0.3};
};

deleteVehicle _intel;

[["IntelSuccess"], "para_c_fnc_show_notification"] call vn_mf_fnc_rExecServerToGlobal_playerHost_or_dedicated;

nil;