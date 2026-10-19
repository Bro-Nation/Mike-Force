/*
	File: fn_counterarty_get_fsb_for_pos.sqf
	Author: Tylervip
	Public: No

	Description:
		Finds the active FSB zone marker containing a position.

	Parameter(s):
		_pos - Position to test [ARRAY]

	Returns:
		FSB id (the no-harass marker name), or "" if the position is outside every FSB [STRING]
*/
params [["_pos", [], [[]]]];

if (_pos isEqualTo []) exitWith {""};

private _markers = missionNamespace getVariable ["vn_mf_markers_no_harass", []];
private _index = _markers findIf {
	(((_x select [0, 8]) isEqualTo "FSB_bh_") || {(_x select [0, 13]) isEqualTo "no_harass_bh_"}) && {_pos inArea _x}
};

if (_index < 0) exitWith {""};
_markers select _index
