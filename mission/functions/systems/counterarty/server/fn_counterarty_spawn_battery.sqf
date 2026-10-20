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
private _targets = _session get "last_targets";
private _targetPos = if (_targets isEqualTo []) then {_aoCenter} else {((_targets select (count _targets - 1)) select 0)};
private _aoMin = missionNamespace getVariable ["vn_mf_counterarty_spawn_ao_min", 2000];
private _aoMax = missionNamespace getVariable ["vn_mf_counterarty_spawn_ao_max", 5000];
private _fsbMin = missionNamespace getVariable ["vn_mf_counterarty_spawn_fsb_min", 2000];
private _towerMin = missionNamespace getVariable ["vn_mf_counterarty_spawn_tower_min", 500];
private _attempts = missionNamespace getVariable ["vn_mf_counterarty_spawn_attempts", 40];
private _targetRanges = missionNamespace getVariable ["vn_mf_counterarty_spawn_target_ranges", [[741, 2167], [1430, 4181], [5720, 16725]]];

private _towerPositions = [];
{
	if (!isNull _x && {_x getVariable ["para_s_building_functional", false]}) then {
		private _tower = (_x getVariable ["para_g_objects", []]) param [0, objNull];
		if (!isNull _tower) then {
			_towerPositions pushBack (getPosATL _tower);
		};
	};
} forEach (missionNamespace getVariable ["vn_mf_soundranging_towers", []]);

// Editor-placed restricted areas: blocked_area* and no_sites_*
private _restrictedAreas = (missionNamespace getVariable ["vn_mf_markers_blocked_areas", []])
	+ (missionNamespace getVariable ["vn_mf_markers_no_sites", []]);

private _spawnPos = [];
for "_i" from 1 to _attempts do {
	private _range = selectRandom _targetRanges;
	private _rangeMin = _range select 0;
	private _rangeMax = _range select 1;
	private _distance = _rangeMin + random (_rangeMax - _rangeMin);
	private _pos = _targetPos getPos [_distance, random 360];

	if (_pos distance2D _targetPos < _rangeMin || {_pos distance2D _targetPos > _rangeMax}) then {continue};
	if (surfaceIsWater _pos) then {continue};
	if (_restrictedAreas findIf {_pos inArea _x} >= 0) then {continue};
	if (_pos distance2D _fsbPos < _fsbMin) then {continue};
	if (_towerPositions findIf {_x distance2D _pos < _towerMin} >= 0) then {continue};
	if (count (_pos isFlatEmpty [-1, -1, 0.3, 6, 0, false, objNull]) == 0) then {continue};

	_spawnPos = _pos;
	break;
};

if (_spawnPos isEqualTo []) then {
	for "_i" from 1 to _attempts do {
		private _pos = _aoCenter getPos [_aoMin + random (_aoMax - _aoMin), random 360];

		if (surfaceIsWater _pos) then {continue};
		if (_restrictedAreas findIf {_pos inArea _x} >= 0) then {continue};
		if (_pos distance2D _fsbPos < _fsbMin) then {continue};
		if (_towerPositions findIf {_x distance2D _pos < _towerMin} >= 0) then {continue};
		if (count (_pos isFlatEmpty [-1, -1, 0.3, 6, 0, false, objNull]) == 0) then {continue};

		_spawnPos = _pos;
		break;
	};
};

if (_spawnPos isEqualTo []) exitWith {
	_session set ["spawn_ready", serverTime + _retryDelay];
	diag_log format ["VN MikeForce: Counter-battery found no valid position for %1", _fsbId];
	false
};

private _gunClass = missionNamespace getVariable ["vn_mf_counterarty_battery_gun_class", "vn_o_nva_static_d44_01"];
private _gunCount = missionNamespace getVariable ["vn_mf_counterarty_battery_gun_count", 1];
private _gunSpacing = missionNamespace getVariable ["vn_mf_counterarty_battery_spacing", 18];

private _group = createGroup [east, true];
private _guns = [];

for "_i" from 0 to (_gunCount - 1) do {
	private _gunPos = _spawnPos getPos [_gunSpacing * (_i + 1), 120 * _i];
	if (surfaceIsWater _gunPos) then {continue};

	private _gun = createVehicle [_gunClass, _gunPos, [], 0, "NONE"];
	_gun setDir (_gun getDir _fsbPos);

	private _crew = createVehicleCrew _gun;
	(units _crew) joinSilent _group;
	deleteGroup _crew;

	_guns pushBack _gun;
};

if (_guns isEqualTo []) exitWith {
	deleteGroup _group;
	_session set ["spawn_ready", serverTime + _retryDelay];
	diag_log format ["VN MikeForce: Counter-battery spawn produced no guns for %1", _fsbId];
	false
};

_group allowFleeing 0;

private _defendObjective = [_spawnPos, 1, 1] call para_s_fnc_ai_obj_request_defend;
_session set ["aiObjective", _defendObjective];

_session set ["battery", _group];
_session set ["guns", _guns];
_session set ["spread", missionNamespace getVariable ["vn_mf_counterarty_spread_start", 1000]];

private _startDelayMin = missionNamespace getVariable ["vn_mf_counterarty_start_delay_min", 60];
private _startDelayRandom = missionNamespace getVariable ["vn_mf_counterarty_start_delay_random", 60];
private _spawnDelay = _startDelayMin + random _startDelayRandom;
_session set ["next_volley", serverTime + _spawnDelay];

diag_log format ["VN MikeForce: Counter-battery spawned for %1 at %2 - first volley in %3s", _fsbId, _spawnPos, round _spawnDelay];
true
