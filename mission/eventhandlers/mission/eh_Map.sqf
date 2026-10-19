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
	[] call vn_mf_fnc_soundranging_on_map_closed;
};
