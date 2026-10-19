/*
	File: fn_soundranging_on_fired.sqf
	Author: Tylervip
	Public: No

	Description:
		Records bearings from active towers to a supported artillery position.

	Parameter(s):
		_artillery - Artillery object that fired [OBJECT]

	Returns:
		Nothing
*/
params [["_artillery", objNull, [objNull]]];

if (!isServer) exitWith {};

if (isNull _artillery) exitWith {};

if !([_artillery] call vn_mf_fnc_soundranging_is_artillery_target) exitWith {};

private _shotPos = getPosATL _artillery;
private _towers = missionNamespace getVariable ["vn_mf_soundranging_towers", []];
private _activeTowers = [];
private _bearings = [];

{
	if (isNull _x || {!(_x getVariable ["para_s_building_functional", false])}) then {
		continue;
	};

	private _tower = (_x getVariable ["para_g_objects", []]) param [0, objNull];
	if (isNull _tower || {!alive _tower}) then {
		continue;
	};
	_activeTowers pushBack _x;

	private _towerPos = getPosATL _tower;
	private _distance = _towerPos distance2D _shotPos;
	if (_distance > 12000) then {
		continue;
	};

	private _bearing = ((_towerPos getDir _shotPos) + 360) mod 360;
	_bearings pushBack [_tower, _bearing];
} forEach _towers;

missionNamespace setVariable ["vn_mf_soundranging_towers", _activeTowers];

if (_bearings isEqualTo []) exitWith {};

private _now = serverTime;
private _detections = missionNamespace getVariable ["vn_mf_soundranging_detections", []];
private _mergeIndex = _detections findIf {
	_now - (_x # 0) <= 4
};

if (_mergeIndex < 0) then {
	_detections pushBack [_now, _bearings];
} else {
	private _detection = _detections # _mergeIndex;
	private _existingBearings = _detection # 1;
	_existingBearings append _bearings;
	_detection set [1, _existingBearings];
	_detections set [_mergeIndex, _detection];
};

missionNamespace setVariable ["vn_mf_soundranging_detections", _detections];
