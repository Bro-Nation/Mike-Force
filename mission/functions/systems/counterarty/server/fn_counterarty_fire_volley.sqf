/*
	File: fn_counterarty_fire_volley.sqf
	Author: Tylervip
	Public: No

	Description:
		Fires one counter-battery volley at the most recent player gun position of an FSB
		session, then tightens the spread and schedules the next volley.

	Parameter(s):
		_fsbId - FSB id [STRING]

	Returns:
		Nothing
*/
params [["_fsbId", "", [""]]];

if (!isServer) exitWith {};

private _session = [_fsbId] call vn_mf_fnc_counterarty_get_session;
if (count _session == 0) exitWith {};

private _interval = missionNamespace getVariable ["vn_mf_counterarty_interval", 180];
private _targets = _session get "last_targets";
if (_targets isEqualTo []) exitWith {
	_session set ["next_volley", serverTime + _interval];
};

private _spread = _session get "spread";
private _targetPos = (_targets select (count _targets - 1)) select 0;
private _rounds = missionNamespace getVariable ["vn_mf_counterarty_rounds", 2];
private _fired = false;

{
	private _gun = _x;
	if (!alive _gun || {!alive gunner _gun}) then {continue};

	_gun setVehicleAmmo 1;

	private _ammo = (getArtilleryAmmo [_gun]) param [0, ""];
	if (_ammo isEqualTo "") then {continue};

	private _aimPos = _targetPos getPos [random _spread, random 360];
	if !(_aimPos inRangeOfArtillery [[_gun], _ammo]) then {continue};

	(gunner _gun) doArtilleryFire [_aimPos, _ammo, _rounds];
	_fired = true;
} forEach (_session get "guns");

_session set ["next_volley", serverTime + _interval];

if (!_fired) exitWith {
	diag_log format ["VN MikeForce: Counter-battery for %1 had no gun in range of the target", _fsbId];
};

_session set ["volleys_fired", (_session get "volleys_fired") + 1];
_session set ["spread", (_spread - (missionNamespace getVariable ["vn_mf_counterarty_spread_step", 100])) max (missionNamespace getVariable ["vn_mf_counterarty_spread_min", 150])];

diag_log format ["VN MikeForce: Counter-battery volley %1 on %2 (spread %3 m)", _session get "volleys_fired", _fsbId, _spread];
