/*
	File: fn_counterarty_on_fsb_removed.sqf
	Author: Tylervip
	Public: No

	Description:
		Cleans up all counter-battery state for an FSB that no longer exists.

	Parameter(s):
		_fsbId - FSB id [STRING]

	Returns:
		Nothing
*/
params [["_fsbId", "", [""]]];

if (!isServer) exitWith {};

diag_log format ["VN MikeForce: Counter-battery FSB %1 removed", _fsbId];
[_fsbId] call vn_mf_fnc_counterarty_end_session;
