/*
	File: fn_counterarty_tick.sqf
	Author: Tylervip
	Public: No

	Description:
		Scheduler job. For each FSB session: removes sessions whose FSB is gone, detects a
		destroyed battery, winds down quiet sessions and fires due volleys.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!isServer) exitWith {};

private _sessions = missionNamespace getVariable ["vn_mf_counterarty_sessions", createHashMap];
private _activeFsbs = missionNamespace getVariable ["vn_mf_markers_no_harass", []];
private _timeout = missionNamespace getVariable ["vn_mf_counterarty_timeout", 600];
private _now = serverTime;

{
	private _fsbId = _x;
	private _session = _sessions getOrDefault [_fsbId, createHashMap];
	if (count _session == 0) then {continue};

	if !(_fsbId in _activeFsbs) then {
		[_fsbId] call vn_mf_fnc_counterarty_on_fsb_removed;
		continue;
	};

	private _hasBattery = !isNull (_session get "battery");
	if (_hasBattery) then {
		private _alive = (_session get "guns") findIf {alive _x && {alive gunner _x}} >= 0;
		if (!_alive) then {
			[_fsbId] call vn_mf_fnc_counterarty_on_battery_destroyed;
			_hasBattery = false;
		};
	};

	if (_now - (_session get "last_fire_time") > _timeout) then {
		[_fsbId] call vn_mf_fnc_counterarty_end_session;
		continue;
	};

	if (_hasBattery && {_now >= (_session get "next_volley")}) then {
		[_fsbId] call vn_mf_fnc_counterarty_fire_volley;
	};
} forEach (keys _sessions);
