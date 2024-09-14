/*
	File: fn_daccong_respawns_delete_all.sqf
	Author: 'DJ' Dijksterhuis
	Description: Deletes all Dac Cong respawns.
	Parameter(s): None
	Returns: Nothing
	Example(s): call vn_mf_fnc_daccong_delete_respawns_all;
*/


[
	"INFO",
	format ["Deleting all Dac Cong respawns: n=%1", count vn_dc_adhoc_respawns]
] call para_g_fnc_log;

vn_dc_adhoc_respawns apply {
	private _marker = _x # 0;
	private _respawnID = _x # 1;

	_respawnID call BIS_fnc_removeRespawnPosition;
	deleteMarker _marker;
};

[
	"INFO",
	format ["Should have deleted all Dac Cong respawns: n=%1", count vn_dc_adhoc_respawns]
] call para_g_fnc_log;
