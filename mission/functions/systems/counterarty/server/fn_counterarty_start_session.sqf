/*
	File: fn_counterarty_start_session.sqf
	Author: Tylervip
	Public: No

	Description:
		Gets or creates the counter-battery session for an FSB.

	Parameter(s):
		_fsbId - FSB id [STRING]

	Returns:
		Session [HASHMAP]
*/
params [["_fsbId", "", [""]]];

private _session = [_fsbId] call vn_mf_fnc_counterarty_get_session;
if (count _session > 0) exitWith {_session};

_session = createHashMapFromArray [
	["fsb_id", _fsbId],
	["fsb_pos", getMarkerPos _fsbId],
	["battery", grpNull],
	["guns", []],
	["spawn_ready", 0],
	["spread", missionNamespace getVariable ["vn_mf_counterarty_spread_start", 1000]],
	["next_volley", 0],
	["last_targets", []],
	["last_fire_time", serverTime],
	["volleys_fired", 0],
	["active", true]
];

(missionNamespace getVariable ["vn_mf_counterarty_sessions", createHashMap]) set [_fsbId, _session];

diag_log format ["VN MikeForce: Counter-battery session started for %1", _fsbId];
_session
