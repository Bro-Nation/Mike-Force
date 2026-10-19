/*
	File: fn_counterarty_end_session.sqf
	Author: Tylervip
	Public: No

	Description:
		Removes an FSB's counter-battery session completely, deleting any battery,
		its crew, and the cooldown/counters.

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
{
	deleteVehicle _x;
} forEach ((_session get "guns") + (if (isNull _group) then {[]} else {units _group}));

if (!isNull _group) then {
	deleteGroup _group;
};

(missionNamespace getVariable ["vn_mf_counterarty_sessions", createHashMap]) deleteAt _fsbId;

diag_log format ["VN MikeForce: Counter-battery session ended for %1", _fsbId];
