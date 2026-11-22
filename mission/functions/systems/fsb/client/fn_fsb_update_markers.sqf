/*
	File: fn_fsb_update_markers.sqf
	Author: Tylervip
	Public: No

	Description:
		Sets FSB/HQ marker alpha based on the owning side.
		Only West players can see West-owned FSB markers.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!hasInterface) exitWith {};

if (isNil "vn_mf_fsb_marker_map_eh_installed") then {
	vn_mf_fsb_marker_map_eh_installed = true;
	"para_c_zone_markers_map" addPublicVariableEventHandler [missionNamespace, {
		[] call vn_mf_fnc_fsb_update_markers;
	}];
};

{
	private _markerName = _x;
	private _lowerMarkerName = toLower _markerName;
	private _markerSide = missionNamespace getVariable [format ["vn_mf_fsb_side_%1", _markerName], sideUnknown];
	private _isFsbBaseMarker = (_lowerMarkerName find "hq_fsb" isEqualTo 0) || {
		_lowerMarkerName find "base_fsb" isEqualTo 0
	};
	if (!_isFsbBaseMarker && {_markerSide isEqualTo sideUnknown}) then {
		continue;
	};

	if (_markerSide isEqualTo sideUnknown) then {
		_markerSide = west;
	};
	private _showMarker = side player isEqualTo _markerSide;
	private _visibleAlpha = if (_lowerMarkerName find "base_fsb" isEqualTo 0) then {0.25} else {1};
	_markerName setMarkerAlphaLocal (if (_showMarker) then {_visibleAlpha} else {0});
} forEach allMapMarkers;
