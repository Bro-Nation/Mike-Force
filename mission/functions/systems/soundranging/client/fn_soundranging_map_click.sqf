/*
	File: fn_soundranging_map_click.sqf
	Author: Tylervip
	Public: No

	Description:
		Confirms supported artillery near a selected map location.

	Parameter(s):
		_position - Selected map position [ARRAY]

	Returns:
		Nothing
*/
params [["_position", [], [[]]]];

if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["vn_mf_soundranging_map_active", false]) exitWith {};
if (count _position < 2) exitWith {
	hint "No valid map position was selected.";
};

private _nearby = nearestObjects [_position, ["StaticWeapon", "vn_howitzer_base"], 25];
private _artillery = _nearby select {
	alive _x && {[_x] call vn_mf_fnc_soundranging_is_artillery_target}
};

private _gun = objNull;
private _closestDistance = 25;
{
	private _distance = (getPosATL _x) distance2D _position;
	if (_distance <= _closestDistance) then {
		_gun = _x;
		_closestDistance = _distance;
	};
} forEach _artillery;

if (isNull _gun) exitWith {
	hint "No enemy artillery piece was found within 25 m of that position.";
};

private _markerName = format ["vn_mf_sr_confirmed_%1", netId _gun];
if !(_markerName in vn_mf_soundranging_confirmed_markers) then {
	createMarkerLocal [_markerName, getPosATL _gun];
	private _confirmedMarkers = vn_mf_soundranging_confirmed_markers;
	_confirmedMarkers pushBack _markerName;
	vn_mf_soundranging_confirmed_markers = _confirmedMarkers;
};

_gun setVariable ["vn_mf_soundranging_confirmed_marker_name", _markerName, false];
private _killedEh = _gun getVariable ["vn_mf_soundranging_confirmed_killed_eh", -1];
if (_killedEh < 0) then {
	_killedEh = _gun addEventHandler ["Killed", {
		params ["_unit"];
		[_unit] call vn_mf_fnc_soundranging_remove_confirmed_marker;
	}];
	_gun setVariable ["vn_mf_soundranging_confirmed_killed_eh", _killedEh, false];
};

private _deletedEh = _gun getVariable ["vn_mf_soundranging_confirmed_deleted_eh", -1];
if (_deletedEh < 0) then {
	_deletedEh = _gun addEventHandler ["Deleted", {
		params ["_unit"];
		[_unit] call vn_mf_fnc_soundranging_remove_confirmed_marker;
	}];
	_gun setVariable ["vn_mf_soundranging_confirmed_deleted_eh", _deletedEh, false];
};

_markerName setMarkerPosLocal getPosATL _gun;
_markerName setMarkerTypeLocal "Contact_pencilTask3";
_markerName setMarkerColorLocal "ColorGreen";
_markerName setMarkerTextLocal "CONFIRMED TARGET";

hint format ["Target confirmed at grid %1", mapGridPosition getPosATL _gun];
