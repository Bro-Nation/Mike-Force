/*
	File: fn_zones_capture_zone.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Marks a zone as captured

	Parameter(s):
		_zone - Zone name [String]

	Returns:
		None

	Example(s):
		["zone_ba_ria"] call vn_mf_fnc_zones_capture_zone;
*/

params ["_zone"];

[_zone, struct_zone_m_captured, true] call vn_mf_fnc_zones_update_zone;
[_zone, struct_zone_m_task, ""] call vn_mf_fnc_zones_update_zone;

_zone setMarkerColorLocal "ColorGreen";
_zone setMarkerBrushLocal "Solid";
_zone setMarkerAlpha 1;

[_zone, "zone_captured"] call para_c_fnc_zone_marker_add;
