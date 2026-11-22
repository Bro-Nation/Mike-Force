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

private _markers = missionNamespace getVariable ["vn_mf_markers_fsb", []];
private _index = _markers findIf { _pos inArea _x };

if (_index < 0) exitWith {""};
_markers select _index
