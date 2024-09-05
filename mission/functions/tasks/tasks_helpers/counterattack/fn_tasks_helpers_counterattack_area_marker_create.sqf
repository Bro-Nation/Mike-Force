/*
	File: fn_tasks_helpers_counterattack_area_marker_create.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Create a red area circle indicating the area that players need to hold.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_area_marker_create;
*/

params ["_tds"];

private _pos = _tds getVariable "attackPos";
private _radius = (_tds getVariable ["attackAreaSize", [100, 100]]) select 0;

// custom BN: yellow circle around the AO
private _areaMarker = createMarker ["activeDefendCircle", _pos];
_areaMarker setMarkerShape "ELLIPSE";
_areaMarker setMarkerSize [_radius, _radius];
_areaMarker setMarkerAlpha 1;
_areaMarker setMarkerBrush "Border";
_areaMarker setMarkerColor "ColorRed";

_tds setVariable ["CircleAreaMarkerName", "activeDefendCircle"];

nil;