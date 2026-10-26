/*
	File: fn_soundranging_remove_confirmed_marker.sqf
	Author: Tylervip
	Public: No

	Description:
		Removes a confirmed-target marker and its target lifecycle handlers.

	Parameter(s):
		_target - Confirmed artillery target [OBJECT]

	Returns:
		Nothing
*/
params [["_target", objNull, [objNull]]];

if (!hasInterface) exitWith {};

private _markerName = _target getVariable ["vn_mf_soundranging_confirmed_marker_name", ""];
if (_markerName isNotEqualTo "") then {
	deleteMarkerLocal _markerName;
	private _confirmedMarkers = missionNamespace getVariable ["vn_mf_soundranging_confirmed_markers", []];
	missionNamespace setVariable ["vn_mf_soundranging_confirmed_markers", _confirmedMarkers - [_markerName]];
	_target setVariable ["vn_mf_soundranging_confirmed_marker_name", nil, false];
};

private _killedEh = _target getVariable ["vn_mf_soundranging_confirmed_killed_eh", -1];
if (_killedEh >= 0) then {
	_target removeEventHandler ["Killed", _killedEh];
	_target setVariable ["vn_mf_soundranging_confirmed_killed_eh", nil, false];
};

private _deletedEh = _target getVariable ["vn_mf_soundranging_confirmed_deleted_eh", -1];
if (_deletedEh >= 0) then {
	_target removeEventHandler ["Deleted", _deletedEh];
	_target setVariable ["vn_mf_soundranging_confirmed_deleted_eh", nil, false];
};
