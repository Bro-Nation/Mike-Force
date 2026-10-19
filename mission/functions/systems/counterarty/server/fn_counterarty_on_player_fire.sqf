/*
	File: fn_counterarty_on_player_fire.sqf
	Author: Tylervip
	Public: No

	Description:
		Registers outgoing player artillery fire from inside an FSB. Starts or refreshes
		that FSB's session, records the gun position and spawns an enemy battery when
		none is alive and the respawn cooldown has expired.

	Parameter(s):
		_gun - Static mortar or howitzer that fired [OBJECT]

	Returns:
		Nothing
*/
params [["_gun", objNull, [objNull]]];

if (!isServer) exitWith {};
if (isNull _gun || {!alive _gun}) exitWith {};
if (getNumber (configOf _gun >> "artilleryScanner") <= 0) exitWith {};
if !(isPlayer (gunner _gun)) exitWith {};
if ([_gun] call vn_mf_fnc_soundranging_is_artillery_target) exitWith {};

private _gunPos = getPosATL _gun;
private _fsbId = [_gunPos] call vn_mf_fnc_counterarty_get_fsb_for_pos;
if (_fsbId isEqualTo "") exitWith {};

private _session = [_fsbId] call vn_mf_fnc_counterarty_start_session;
private _now = serverTime;

private _targets = _session get "last_targets";
_targets pushBack [_gunPos, _gun, _now];
if (count _targets > 10) then {
	_targets deleteAt 0;
};

_session set ["last_fire_time", _now];
_session set ["active", true];

if (!isNull (_session get "battery")) exitWith {};
if (_now < (_session get "spawn_ready")) exitWith {};

[_fsbId] call vn_mf_fnc_counterarty_spawn_battery;
