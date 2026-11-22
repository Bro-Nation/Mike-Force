/*
	File: fn_soundranging_update_tower_markers.sqf
	Author: Tylervip
	Public: No

	Description:
			Shows sound-ranging tower markers only to West players.
			All other sides keep the marker alpha at 0.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!hasInterface) exitWith {};

private _towerMarkerPrefix = "vn_mf_sr_tower_";
{
	private _markerName = _x;
	private _isTowerMarker = (_markerName find _towerMarkerPrefix) isEqualTo 0;
	if !(_isTowerMarker) then {
		continue;
	};

	private _netId = _markerName select [count _towerMarkerPrefix];
	if (_netId isEqualTo "") then {
		continue;
	};

	private _markerSide = missionNamespace getVariable [format ["vn_mf_sr_tower_side_%1", _markerName], west];
	private _showMarker = (_markerSide isEqualTo west) && {side player isEqualTo west};
	_markerName setMarkerAlphaLocal (if (_showMarker) then {1} else {0});
} forEach allMapMarkers;
