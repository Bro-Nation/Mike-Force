/*
	File: fn_soundranging_receive_detections.sqf
	Author: Tylervip
	Public: No

	Description:
		Displays received bearings as local markers and opens the map.

	Parameter(s):
		_detections - Recent sound-ranging detections [ARRAY]
		_error - Error message from the server [STRING]

	Returns:
		Nothing
*/
params [
	["_detections", [], [[]]],
	["_error", "", [""]]
];

if (!hasInterface) exitWith {};
if (remoteExecutedOwner isNotEqualTo 2) exitWith {};

if (_error isNotEqualTo "") exitWith {
	missionNamespace setVariable ["vn_mf_soundranging_map_active", false];
	[false] call vn_mf_fnc_soundranging_set_map_click_handler;

	private _playerMarkers = vn_mf_soundranging_markers;
	{deleteMarkerLocal _x} forEach _playerMarkers;
	vn_mf_soundranging_markers = [];

	private _confirmedMarkers = vn_mf_soundranging_confirmed_markers;
	{deleteMarkerLocal _x} forEach _confirmedMarkers;
	vn_mf_soundranging_confirmed_markers = [];
	hint _error;
};

private _oldMarkers = vn_mf_soundranging_markers;
{deleteMarkerLocal _x} forEach _oldMarkers;
vn_mf_soundranging_markers = [];

private _oldConfirmedMarkers = vn_mf_soundranging_confirmed_markers;
{deleteMarkerLocal _x} forEach _oldConfirmedMarkers;
vn_mf_soundranging_confirmed_markers = [];

private _markers = [];
private _now = serverTime;
private _markerIndex = missionNamespace getVariable ["vn_mf_soundranging_marker_index", 0];

{
	if !(_x isEqualType [] && {count _x >= 2}) then {
		continue;
	};

	private _detectionTime = _x # 0;
	private _bearings = _x # 1;
	if (!(_detectionTime isEqualType 0) || {!(_bearings isEqualType [])}) then {
		continue;
	};

	private _remainingLifetime = 180 - (_now - _detectionTime);
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

		private _arrowMarkerName = format ["vn_mf_sr_dir_%1_%2", getPlayerUID player, _markerIndex];
		_markerIndex = _markerIndex + 1;

		private _towerPos = getPosATL _tower;
		private _arrowPos = _towerPos getPos [40, _bearing];

		createMarkerLocal [_arrowMarkerName, _arrowPos];
		_arrowMarkerName setMarkerTypeLocal "mil_arrow";
		_arrowMarkerName setMarkerDirLocal _bearing;
		_arrowMarkerName setMarkerColorLocal "ColorOrange";
		_arrowMarkerName setMarkerTextLocal format ["%1", _bearing];
		_markers pushBack _arrowMarkerName;

		[{
			params ["_expiredMarker"];
			deleteMarkerLocal _expiredMarker;
			private _currentMarkers = vn_mf_soundranging_markers;
			vn_mf_soundranging_markers = _currentMarkers - [_expiredMarker];
		}, [_arrowMarkerName], _remainingLifetime] call CBA_fnc_waitAndExecute;
	} forEach _bearings;
} forEach _detections;

vn_mf_soundranging_markers = _markers;
missionNamespace setVariable ["vn_mf_soundranging_marker_index", _markerIndex];
missionNamespace setVariable ["vn_mf_soundranging_map_active", true];
[true] call vn_mf_fnc_soundranging_set_map_click_handler;
openMap true;

if (_markers isEqualTo []) then {
	hint parseText "<t size='1.2'>Sound Ranging Net</t><br/><br/>No recent artillery bearings are available.<br/>Bearings remain available for three minutes after a shot.";
} else {
	hint parseText "<t size='1.2'>Sound Ranging Net</t><br/><br/>Orange arrows show bearings from each tower.<br/>Estimate where the bearings cross; no intersection is marked automatically.<br/><br/>Click near a suspected artillery piece (within 25 m) to check it.";
};
