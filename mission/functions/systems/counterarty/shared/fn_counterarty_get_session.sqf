/*
	File: fn_counterarty_get_session.sqf
	Author: Tylervip
	Public: No

	Description:
		Returns the counter-battery session for an FSB.

	Parameter(s):
		_fsbId - FSB id [STRING]

	Returns:
		Session hashmap, or an empty hashmap if none exists [HASHMAP]
*/
params [["_fsbId", "", [""]]];

private _sessions = missionNamespace getVariable ["vn_mf_counterarty_sessions", createHashMap];
_sessions getOrDefault [_fsbId, createHashMap]
