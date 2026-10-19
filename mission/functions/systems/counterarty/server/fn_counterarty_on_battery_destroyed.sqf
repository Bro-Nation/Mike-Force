/*
	File: fn_counterarty_on_battery_destroyed.sqf
	Author: Tylervip
	Public: No

	Description:
		Stops an FSB's volleys after its battery is destroyed and starts the
		respawn cooldown for that FSB only.

	Parameter(s):
		_fsbId - FSB id [STRING]

	Returns:
		Nothing
*/
params [["_fsbId", "", [""]]];

if (!isServer) exitWith {};

private _session = [_fsbId] call vn_mf_fnc_counterarty_get_session;
if (count _session == 0) exitWith {};

private _group = _session get "battery";
if (!isNull _group) then {
	{deleteVehicle _x} forEach (units _group select {!alive _x});
	if (units _group isEqualTo []) then {
		deleteGroup _group;
	};
};

_session set ["battery", grpNull];
_session set ["guns", []];
_session set ["next_volley", 0];
_session set ["spawn_ready", serverTime + (missionNamespace getVariable ["vn_mf_counterarty_respawn_cooldown", 420])];

diag_log format ["VN MikeForce: Counter-battery destroyed for %1", _fsbId];
