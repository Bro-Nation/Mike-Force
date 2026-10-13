/*
    File: eh_Map.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Map opened event handler

    Parameter(s):
        _map_opened - true if map is opened, false is closed [BOOL]
        _map_forced - true if map is forced [BOOL]

    Returns: nothing

    Example(s):
	    Not called directly.
*/

params
[
	"_map_opened",
	"_map_forced"
];

if (!_map_opened) then {
	if !(missionNamespace getVariable ["vn_mf_soundranging_map_active", false]) exitWith {};

	missionNamespace setVariable ["vn_mf_soundranging_map_active", false];
	[false] call vn_mf_fnc_soundranging_set_map_click_handler;

	private _playerMarkers = player getVariable ["vn_mf_soundranging_markers", []];
	{
		deleteMarkerLocal _x;
	} forEach _playerMarkers;
	player setVariable ["vn_mf_soundranging_markers", []];

	private _confirmedMarkers = missionNamespace getVariable ["vn_mf_soundranging_confirmed_markers", []];
	{
		deleteMarkerLocal _x;
	} forEach _confirmedMarkers;
	missionNamespace setVariable ["vn_mf_soundranging_confirmed_markers", []];
};
