/*
	File: fn_counterarty_spawn_battery.sqf
	Author: Tylervip
	Public: No

	Description:
		Spawns the enemy battery for an FSB on a ring around the active AO center, at least
		a minimum distance from the FSB and from functional recon towers.

	Parameter(s):
		_fsbId - FSB id [STRING]

	Returns:
		True if a battery was spawned [BOOL]
*/
params [["_fsbId", "", [""]]];

if (!isServer) exitWith {false};

private _session = [_fsbId] call vn_mf_fnc_counterarty_get_session;
if (count _session == 0) exitWith {false};

private _retryDelay = missionNamespace getVariable ["vn_mf_counterarty_spawn_retry_delay", 30];

if ((markerShape "activeZoneCircle") isEqualTo "") exitWith {
	_session set ["spawn_ready", serverTime + _retryDelay];
	diag_log format ["VN MikeForce: Counter-battery spawn skipped for %1 - no active AO", _fsbId];
	false
};

private _aoCenter = getMarkerPos "activeZoneCircle";
private _fsbPos = _session get "fsb_pos";
private _aoMin = missionNamespace getVariable ["vn_mf_counterarty_spawn_ao_min", 2000];
private _aoMax = missionNamespace getVariable ["vn_mf_counterarty_spawn_ao_max", 5000];
private _fsbMin = missionNamespace getVariable ["vn_mf_counterarty_spawn_fsb_min", 2000];
private _towerMin = missionNamespace getVariable ["vn_mf_counterarty_spawn_tower_min", 500];
private _attempts = missionNamespace getVariable ["vn_mf_counterarty_spawn_attempts", 40];

private _towerPositions = [];
{
	if (!isNull _x && {_x getVariable ["para_s_building_functional", false]}) then {
		private _tower = (_x getVariable ["para_g_objects", []]) param [0, objNull];
		if (!isNull _tower) then {
			_towerPositions pushBack (getPosATL _tower);
		};
	};
} forEach (missionNamespace getVariable ["vn_mf_soundranging_towers", []]);

private _spawnPos = [];
for "_i" from 1 to _attempts do {
	private _pos = _aoCenter getPos [_aoMin + random (_aoMax - _aoMin), random 360];

	if (surfaceIsWater _pos) then {continue};
	if (_pos distance2D _fsbPos < _fsbMin) then {continue};
	if (_towerPositions findIf {_x distance2D _pos < _towerMin} >= 0) then {continue};
	if (count (_pos isFlatEmpty [-1, -1, 0.3, 6, 0, false, objNull]) == 0) then {continue};

	_spawnPos = _pos;
	break;
};

if (_spawnPos isEqualTo []) exitWith {
	_session set ["spawn_ready", serverTime + _retryDelay];
	diag_log format ["VN MikeForce: Counter-battery found no valid position for %1", _fsbId];
	false
};

private _group = createGroup [east, true];
private _guns = [];

{
	private _gun = createVehicle [_x, _spawnPos getPos [12 * _forEachIndex, 90], [], 0, "NONE"];
	_gun setDir (_gun getDir _fsbPos);

	private _crew = createVehicleCrew _gun;
	(units _crew) joinSilent _group;
	deleteGroup _crew;

	_guns pushBack _gun;
} forEach (missionNamespace getVariable ["vn_mf_counterarty_battery_classes", []]);

_group allowFleeing 0;

_session set ["battery", _group];
_session set ["guns", _guns];
_session set ["spread", missionNamespace getVariable ["vn_mf_counterarty_spread_start", 1000]];
_session set ["next_volley", serverTime + (missionNamespace getVariable ["vn_mf_counterarty_interval", 180])];

diag_log format ["VN MikeForce: Counter-battery spawned for %1 at %2", _fsbId, _spawnPos];
true
