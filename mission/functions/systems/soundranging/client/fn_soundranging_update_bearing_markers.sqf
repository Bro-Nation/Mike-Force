/*
	File: fn_soundranging_update_bearing_markers.sqf
	Author: Tylervip
	Public: No

	Description:
		Creates or refreshes the local bearing markers and their expiry timers.

	Parameter(s):
		_detections - Sound-ranging detections [ARRAY]

	Returns:
		Created or refreshed marker names [ARRAY]
*/
params [["_detections", [], [[]]]];

if (!hasInterface) exitWith {[]};

private _markers = missionNamespace getVariable ["vn_mf_soundranging_markers", []];
private _entries = missionNamespace getVariable ["vn_mf_soundranging_bearing_marker_entries", []];
private _markerIndex = missionNamespace getVariable ["vn_mf_soundranging_marker_index", 0];
private _now = serverTime;

{
	if !(_x isEqualType [] && {count _x >= 2}) then {
		continue;
	};

	private _detectionTime = _x # 0;
	private _bearings = _x # 1;
	private _target = _x param [2, objNull];
	if (
		!(_detectionTime isEqualType 0)
		|| {!(_bearings isEqualType [])}
		|| {!(_target isEqualType objNull)}
	) then {
		continue;
	};

	private _expiresAt = _detectionTime + 180;
	private _remainingLifetime = _expiresAt - _now;
	if (_remainingLifetime <= 0) then {
		continue;
	};

	{
		if !(_x isEqualType [] && {count _x >= 2}) then {
			continue;
		};

		private _tower = _x # 0;
		private _bearing = _x # 1;
		if (!(_tower isEqualType objNull) || {isNull _tower} || {!(_bearing isEqualType 0)}) then {
			continue;
		};

		private _entryIndex = -1;
		if (!isNull _target) then {
			_entryIndex = _entries findIf {
				(_x # 0) isEqualTo _target
				&& {(_x # 1) isEqualTo _tower}
			};
		};

		private _markerName = "";
		private _generation = 1;
		if (_entryIndex >= 0) then {
			private _entry = _entries # _entryIndex;
			_markerName = _entry # 2;
			_generation = (_entry # 4) + 1;
		} else {
			_markerIndex = _markerIndex + 1;
			_markerName = format ["vn_mf_sr_dir_%1_%2", getPlayerUID player, _markerIndex];
		};

		private _towerPos = getPosATL _tower;
		private _arrowPos = _towerPos getPos [40, _bearing];
		if !(_markerName in allMapMarkers) then {
			createMarkerLocal [_markerName, _arrowPos];
		};
		_markerName setMarkerPosLocal _arrowPos;
		_markerName setMarkerTypeLocal "mil_arrow";
		_markerName setMarkerDirLocal _bearing;
		_markerName setMarkerColorLocal "ColorOrange";
		_markerName setMarkerTextLocal format ["%1", _bearing];

		if !(_markerName in _markers) then {
			_markers pushBack _markerName;
		};

		private _entry = [_target, _tower, _markerName, _expiresAt, _generation];
		if (_entryIndex >= 0) then {
			_entries set [_entryIndex, _entry];
		} else {
			_entries pushBack _entry;
		};

		[{
			params ["_markerName", "_generation"];

			private _entries = missionNamespace getVariable ["vn_mf_soundranging_bearing_marker_entries", []];
			private _entryIndex = _entries findIf {(_x # 2) isEqualTo _markerName};
			if (_entryIndex < 0) exitWith {};

			private _entry = _entries # _entryIndex;
			if ((_entry # 4) isNotEqualTo _generation) exitWith {};

			deleteMarkerLocal _markerName;
			_entries deleteAt _entryIndex;
			missionNamespace setVariable ["vn_mf_soundranging_bearing_marker_entries", _entries];

			private _markers = missionNamespace getVariable ["vn_mf_soundranging_markers", []];
			missionNamespace setVariable ["vn_mf_soundranging_markers", _markers - [_markerName]];
		}, [_markerName, _generation], _remainingLifetime] call CBA_fnc_waitAndExecute;
	} forEach _bearings;
} forEach _detections;

missionNamespace setVariable ["vn_mf_soundranging_markers", _markers];
missionNamespace setVariable ["vn_mf_soundranging_bearing_marker_entries", _entries];
missionNamespace setVariable ["vn_mf_soundranging_marker_index", _markerIndex];

_markers
