/*
    File: start_engineer_defense.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Starts an engineer defense phase.
        The defense target is the nearest valid flag inside marker Engineer.

    Parameter(s):
        _durationSeconds - Optional duration in seconds [NUMBER, defaults to 10 * 60]

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\engineer_defense\start_engineer_defense.sqf"
*/

params [
    ["_durationSeconds", missionNamespace getVariable ["vn_mf_training_engineer_defense_duration", 10 * 60], [0]]
];

// --- Target flag ---
private _markerName = "Engineer";
private _allowedFlagClasses = ["vn_flag_pavn", "vn_flag_usa", "vn_flag_aus", "vn_flag_nz", "vn_flag_arvn"];

// --- Enemy config ---
private _enemyCount        = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_count",      16];
private _enemyWaveSize     = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_wave_size",   8];
private _enemyWaveInterval = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_wave_interval", 60];
private _enemyTypes = [
    "vn_o_men_nva_dc_01",
    "vn_o_men_nva_dc_04",
    "vn_o_men_nva_dc_08",
    "vn_o_men_nva_dc_09",
    "vn_o_men_nva_dc_11"
];

// --- Spawn position config ---
private _spawnCenterMinShift  = missionNamespace getVariable ["vn_mf_training_engineer_defense_spawn_center_min_shift", 60];
private _spawnMinDistance     = missionNamespace getVariable ["vn_mf_training_engineer_defense_spawn_min_distance",     150];
private _spawnMaxDistance     = missionNamespace getVariable ["vn_mf_training_engineer_defense_spawn_max_distance",     200];
private _spawnBearingMinDelta = missionNamespace getVariable ["vn_mf_training_engineer_defense_spawn_bearing_min_delta", 35];

if (!isServer) exitWith {
    [[_durationSeconds], {
        params ["_duration"];
        [_duration] execVM "training\scripts\engineer_defense\start_engineer_defense.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

if (_durationSeconds <= 0) then {
    _durationSeconds = 10 * 60;
};

if !(markerShape _markerName in ["RECTANGLE", "ELLIPSE"]) exitWith {
    ["Engineer defense marker 'Engineer' is missing or invalid."] remoteExecCall ["systemChat", 0];
};

private _alreadyActive = missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false];
if (_alreadyActive) exitWith {
    ["Engineer defense is already active."] remoteExecCall ["systemChat", 0];
};

private _markerPos = getMarkerPos _markerName;
private _markerSize = getMarkerSize _markerName;
private _maxSearchRadius = ((_markerSize select 0) max (_markerSize select 1)) + 25;

private _candidateFlags = nearestObjects [
    [_markerPos select 0, _markerPos select 1],
    _allowedFlagClasses,
    _maxSearchRadius
] select {alive _x && {_x inArea _markerName}};

if (_candidateFlags isEqualTo []) exitWith {
    ["Place a valid flag in the Engineer area before starting defense."] remoteExecCall ["systemChat", 0];
};

private _flagsWithDistance = _candidateFlags apply {
    [_x distance2D _markerPos, _x]
};
_flagsWithDistance sort true;

private _targetFlag = (_flagsWithDistance # 0) # 1;
private _endTime = serverTime + _durationSeconds;

missionNamespace setVariable ["vn_mf_training_engineer_defense_last_spawn_center", [], true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_last_spawn_bearing", -1, true];

private _spawnResult = [_targetFlag, _enemyCount, _enemyTypes, _spawnCenterMinShift, _spawnMinDistance, _spawnMaxDistance, _spawnBearingMinDelta, "AWARE"] call compile preprocessFileLineNumbers "training\scripts\engineer_defense\spawn_engineer_defense_group.sqf";
private _enemyGroup = _spawnResult # 0;
private _enemyUnits = _spawnResult # 1;
private _enemyGroups = [_enemyGroup];

missionNamespace setVariable ["vn_mf_training_engineer_defense_duration", _durationSeconds, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_active", true, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_target", _targetFlag, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_end_time", _endTime, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_group", _enemyGroup, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_units", _enemyUnits, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_groups", _enemyGroups, true];

private _durationMinutes = (_durationSeconds / 60) toFixed 0;
private _startMessage = format [
    "Engineer defense started. Defend the flag for %1 minute(s). Enemy units spawned: %2.",
    _durationMinutes,
    count _enemyUnits
];
[_startMessage] remoteExecCall ["systemChat", 0];

[_endTime] spawn {
    params ["_defenseEndTime"];

    private _lastAnnouncedMinute = -1;

    while {missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false] && {serverTime < _defenseEndTime}} do {
        private _secondsRemaining = (_defenseEndTime - serverTime) max 0;
        private _minutesRemaining = ceil (_secondsRemaining / 60);

        if (_minutesRemaining > 0 && {_minutesRemaining != _lastAnnouncedMinute}) then {
            _lastAnnouncedMinute = _minutesRemaining;
            [format ["Engineer defense: %1 minute(s) remaining.", _minutesRemaining]] remoteExecCall ["systemChat", 0];
        };

        sleep 5;
    };
};

[_targetFlag, _endTime, _enemyWaveSize, _enemyWaveInterval, _enemyTypes, _spawnCenterMinShift, _spawnMinDistance, _spawnMaxDistance, _spawnBearingMinDelta] spawn {
    params ["_defenseFlag", "_defenseEndTime", "_waveSize", "_waveInterval", "_unitTypes", "_minShift", "_minDistance", "_maxDistance", "_minBearingDelta"];

    if (_waveInterval < 30) then {
        _waveInterval = 30;
    };

    while {
        missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false]
        && {serverTime < _defenseEndTime}
        && {!isNull _defenseFlag}
        && {alive _defenseFlag}
    } do {
        sleep _waveInterval;

        if !(missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false]) exitWith {};
        if (serverTime >= _defenseEndTime) exitWith {};
        if (isNull _defenseFlag || {!alive _defenseFlag}) exitWith {};

        private _waveResult = [_defenseFlag, _waveSize, _unitTypes, _minShift, _minDistance, _maxDistance, _minBearingDelta, "COMBAT"] call compile preprocessFileLineNumbers "training\scripts\engineer_defense\spawn_engineer_defense_group.sqf";
        private _waveGroup = _waveResult # 0;
        private _waveUnits = _waveResult # 1;

        private _allGroups = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_groups", []];
        private _allUnits = missionNamespace getVariable ["vn_mf_training_engineer_defense_enemy_units", []];

        _allGroups pushBack _waveGroup;
        _allUnits append _waveUnits;

        missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_groups", _allGroups, true];
        missionNamespace setVariable ["vn_mf_training_engineer_defense_enemy_units", _allUnits, true];
    };
};

[_targetFlag, _endTime] spawn {
    params ["_defenseFlag", "_defenseEndTime"];

    waitUntil {
        sleep 1;
        !(missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false])
        || {isNull _defenseFlag}
        || {!alive _defenseFlag}
        || {serverTime >= _defenseEndTime}
    };

    if !(missionNamespace getVariable ["vn_mf_training_engineer_defense_active", false]) exitWith {};

    if (isNull _defenseFlag || {!alive _defenseFlag}) then {
        ["Engineer defense failed: the defense flag was destroyed."] remoteExecCall ["systemChat", 0];
    } else {
        ["Engineer defense complete: target held for full duration."] remoteExecCall ["systemChat", 0];
    };

    [] call compile preprocessFileLineNumbers "training\scripts\engineer_defense\cleanup_engineer_defense.sqf";
};