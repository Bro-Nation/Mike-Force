/*
    File: fn_create_support_opfor_troops.sqf
    Author: Legend
    Public: No

    Description:
        OPFOR-only support creation path that spawns troops directly from the coms tower.
        This intentionally bypasses support task creation/notifications.

    Parameter(s):
        _taskClass - Task class [String]
        _requestingPlayer - Requesting player [Object]
        _coords - Attack destination [Position], optional/zero means auto fallback
        _targetTeam - Cardinal spawn direction: "N", "S", "E", "W", or "" for auto [String]

    Returns: nothing
*/

params ["_taskClass", "_requestingPlayer", ["_coords", [0,0,0]], ["_targetTeam", ""]];

// Compute owner ID once; pass explicitly to every helper call (SQF compiled-code scopes
// do not reliably inherit private variables from the calling scope).
private _targetOwner = owner _requestingPlayer;

private _debugMsg = {
    params ["_msg", ["_target", -1]];
    diag_log format ["[OPFOR SUPPORT][owner:%1] %2", _target, _msg];
};

private _notifySuccess = {
    params ["_msg", "_tgt", ["_requester", objNull]];
    diag_log format ["[OPFOR SUCCESS] %1", _msg];
    private _resolvedTarget = if (!isNull _requester) then {owner _requester} else {_tgt};
    ["OpforTroopRequestSuccess", [_msg]] remoteExecCall ["para_c_fnc_show_notification", _resolvedTarget];
};

private _notifyFailed = {
    params ["_msg", "_tgt", ["_requester", objNull]];
    diag_log format ["[OPFOR FAILED] %1", _msg];
    private _resolvedTarget = if (!isNull _requester) then {owner _requester} else {_tgt};
    ["OpforTroopRequestFailed", [_msg]] remoteExecCall ["para_c_fnc_show_notification", _resolvedTarget];
};

private _failureNotified = false;
private _notifyFailedOnce = {
    params ["_msg", "_tgt", ["_requester", objNull]];
    if (_failureNotified) exitWith {};
    _failureNotified = true;
    [_msg, _tgt, _requester] call _notifyFailed;
};

[format ["create_support_opfor_troops entry: task=%1 coords=%2 player=%3 owner=%4 dir=%5", _taskClass, _coords, if (isNull _requestingPlayer) then {"<null>"} else {name _requestingPlayer}, _targetOwner, _targetTeam], _targetOwner] call _debugMsg;

if (isNull _requestingPlayer || {!isPlayer _requestingPlayer} || {!alive _requestingPlayer} || {(allPlayers find _requestingPlayer) < 0}) exitWith {
    ["Invalid requester object for OPFOR support request.", _targetOwner] call _debugMsg;
};
if ((_requestingPlayer getVariable ["vn_mf_db_player_group", ""]) isNotEqualTo "DacCong") exitWith {
    ["Rejected OPFOR support request from non-DacCong requester.", _targetOwner] call _debugMsg;
    ["Only DacCong players can request OPFOR support.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _defaultCooldown = missionNamespace getVariable ["vn_mf_opfor_support_team_cooldown", 60];
private _requestTeam = _requestingPlayer getVariable ["vn_mf_db_player_group", "DacCong"];
private _teamCooldowns = missionNamespace getVariable ["vn_mf_opfor_support_team_cooldowns", createHashMap];
if !(_teamCooldowns isEqualType createHashMap) then {
    _teamCooldowns = createHashMap;
};

private _cooldownUntil = _teamCooldowns getOrDefault [_requestTeam, 0];
if (time < _cooldownUntil) exitWith {
    private _remaining = ceil (_cooldownUntil - time);
    [format ["Cooldown blocked request for team=%1 remaining=%2s", _requestTeam, _remaining], _targetOwner] call _debugMsg;
    [format ["Support Blocked - Cool down remaining: %1s", _remaining], _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _wreckCleanupLifetime = missionNamespace getVariable ["vn_mf_opfor_support_wreck_cleanup_time", 300];
private _bodyCleanupLifetime = missionNamespace getVariable ["vn_mf_opfor_support_body_cleanup_time", _wreckCleanupLifetime];
private _activeUnitCleanupLifetime = missionNamespace getVariable ["vn_mf_opfor_support_active_unit_cleanup_time", 300];
private _activeVehicleCleanupLifetime = missionNamespace getVariable ["vn_mf_opfor_support_active_vehicle_cleanup_time", _activeUnitCleanupLifetime];
private _registerWreckCleanup = {
    params ["_veh", "_lifetime", "_debugMsg", "_targetOwner"];

    if (isNull _veh) exitWith {};
    if (_veh getVariable ["vn_mf_opfor_wreck_cleanup_registered", false]) exitWith {};

    _veh setVariable ["vn_mf_opfor_wreck_cleanup_registered", true];
    _veh setVariable ["vn_mf_opfor_wreck_cleanup_lifetime", _lifetime];

    _veh addEventHandler ["Killed", {
        params ["_killedVehicle"];
        private _cleanupAfter = _killedVehicle getVariable ["vn_mf_opfor_wreck_cleanup_lifetime", 300];
        [_killedVehicle, false, _cleanupAfter] call para_s_fnc_cleanup_add_items;
    }];

    [format ["Registered wreck cleanup for %1 after %2s", typeOf _veh, _lifetime], _targetOwner] call _debugMsg;
};

private _registerBodyCleanup = {
    params ["_unit", "_lifetime", "_debugMsg", "_targetOwner"];

    if (isNull _unit) exitWith {};
    if (_unit getVariable ["vn_mf_opfor_body_cleanup_registered", false]) exitWith {};

    _unit setVariable ["vn_mf_opfor_body_cleanup_registered", true];
    _unit setVariable ["vn_mf_opfor_body_cleanup_lifetime", _lifetime];

    _unit addEventHandler ["Killed", {
        params ["_killedUnit"];
        private _cleanupAfter = _killedUnit getVariable ["vn_mf_opfor_body_cleanup_lifetime", 300];
        [_killedUnit, false, _cleanupAfter] call para_s_fnc_cleanup_add_items;
    }];

    [format ["Registered body cleanup for %1 after %2s", typeOf _unit, _lifetime], _targetOwner] call _debugMsg;
};

// Cardinal direction: angle (from destination) where troops will spawn from
// "N"->0, "E"->90, "S"->180, "W"->270, ""->-1 (auto)
private _spawnDirAngle = switch (_targetTeam) do {
    case "N": {0};
    case "E": {90};
    case "S": {180};
    case "W": {270};
    default {-1};
};

[format ["create_support_opfor_troops start: task=%1 coords=%2 player=%3 dir=%4", _taskClass, _coords, name _requestingPlayer, _targetTeam], _targetOwner] call _debugMsg;
["Checkpoint: start validation", _targetOwner] call _debugMsg;

private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
private _aoMarker = _activeZones param [0, ""];
private _markerExists = _aoMarker in allMapMarkers;
[format ["Checkpoint: markerExists check marker=%1", _markerExists], _targetOwner] call _debugMsg;

if !_markerExists exitWith {
    ["No active AO marker.", _targetOwner] call _debugMsg;
    ["No active AO found.", _targetOwner, _requestingPlayer] call _notifyFailed;
};
private _center = [];
private _radius = 0;
try {
    _center = markerPos _aoMarker;
    _radius = getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100;
} catch {
    diag_log format ["[OPFOR ERROR] markerPos/Size exception: %1", _exception];
};

[format ["Checkpoint: AO marker ok center=%1 radius=%2", _center, _radius], _targetOwner] call _debugMsg;

private _nearTowers = [];
try {
    _nearTowers = nearestObjects [
        _center,
        ["Land_vn_ttowersmall_2_f"],
        _radius,
        true
    ];
} catch {
    diag_log format ["[OPFOR ERROR] Tower search exception: %1", _exception];
};

[format ["Checkpoint: tower candidates=%1", count _nearTowers], _targetOwner] call _debugMsg;

private _towerObjects = [];
try {
    {
        private _building = _x getVariable ["para_g_building", objNull];
        if (alive _x && {!isNull _building} && {_building getVariable ["para_g_building_constructed", false]}) then {
            _towerObjects pushBack _x;
        };
    } forEach _nearTowers;
} catch {
    diag_log format ["[OPFOR ERROR] Tower filtering exception: %1", _exception];
};

[format ["Checkpoint: built towers=%1", count _towerObjects], _targetOwner] call _debugMsg;

if (_towerObjects isEqualTo []) exitWith {
    ["No fully built tower found.", _targetOwner] call _debugMsg;
    ["Coms tower is not fully built yet.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _tower = _towerObjects select 0;
private _building = _tower getVariable ["para_g_building", objNull];

private _supportAccessRadius = missionNamespace getVariable ["vn_mf_opfor_support_access_radius", 500];
if !(_supportAccessRadius isEqualType 0) then {_supportAccessRadius = 500;};
if (_supportAccessRadius <= 0) then {_supportAccessRadius = 500;};
if ((_requestingPlayer distance2D _tower) > _supportAccessRadius) exitWith {
    [format ["Requester outside tower access radius: dist=%1 radius=%2", round (_requestingPlayer distance2D _tower), _supportAccessRadius], _targetOwner] call _debugMsg;
    ["You are too far from the Coms tower to request OPFOR support.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

if (isNull _building) exitWith {
    ["Tower building namespace was null.", _targetOwner] call _debugMsg;
    ["Coms tower data unavailable. Try again.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _taskCfg = missionConfigFile >> "gamemode" >> "tasks" >> _taskClass;
if !(isClass _taskCfg) exitWith {
    [format ["Task config missing for %1", _taskClass], _targetOwner] call _debugMsg;
    ["Invalid support type selected.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _taskLabel = getText (_taskCfg >> "tasktitle");
if (_taskLabel isEqualTo "") then {
    _taskLabel = getText (_taskCfg >> "taskname");
};
if (_taskLabel isEqualTo "") then {
    _taskLabel = _taskClass;
};

private _paramsCfg = _taskCfg >> "parameters";
private _unitType = getText (_paramsCfg >> "unitType");
private _size = getText (_paramsCfg >> "size");
private _costSandbags = getNumber (_paramsCfg >> "cost");
private _taskCooldown = getNumber (_paramsCfg >> "cooldown");

if (_costSandbags <= 0) then {_costSandbags = 1;};

private _sandbagValue = ["building_sandbag_value", 10] call BIS_fnc_getParamValue;
if (_sandbagValue <= 0) then {_sandbagValue = 10;};

private _cost = _costSandbags * _sandbagValue;

// Use task-specific cooldown if defined, otherwise use default
private _cooldownSeconds = if (_taskCooldown > 0) then {_taskCooldown} else {_defaultCooldown};

private _isValidPos = {
    params ["_p"];
    (_p isEqualType []) && {count _p >= 2} && {(_p select 0) isEqualType 0} && {(_p select 1) isEqualType 0}
};

private _destination = _coords;
private _noMarkedTarget = (_destination isEqualTo []) || (_destination isEqualTo [0,0]) || (_destination isEqualTo [0,0,0]);

if (!_noMarkedTarget && {[_destination] call _isValidPos} && {!(_destination inArea [_center, _radius, _radius, 0, false])}) exitWith {
    [format ["Rejected explicit destination outside AO: destination=%1 center=%2 radius=%3", _destination, _center, _radius], _targetOwner] call _debugMsg;
    ["Selected destination is outside the active AO.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

if (_noMarkedTarget) then {
    ["No marker set by player. Resolving fallback destination...", _targetOwner] call _debugMsg;
    private _allBases = missionNamespace getVariable ["para_g_bases", []];
    private _basesInAO = _allBases inAreaArray [_center, _radius, _radius, 0, false];
    if !(_basesInAO isEqualTo []) then {
        _destination = getPos (_basesInAO select 0);
        [format ["No marker set. Falling back to FOB destination %1", _destination], _targetOwner] call _debugMsg;
    } else {
        _destination = _center;
        [format ["No marker set. Falling back to AO center %1", _destination], _targetOwner] call _debugMsg;
    };
};

if !([_destination] call _isValidPos) then {
    private _towerPos = getPos _tower;
    if ([_towerPos] call _isValidPos) then {
        _destination = _towerPos;
        [format ["Destination invalid. Falling back to tower position %1", _destination], _targetOwner] call _debugMsg;
    } else {
        [format ["Destination invalid and tower position invalid. destination=%1 towerPos=%2", _destination, _towerPos], _targetOwner] call _debugMsg;
        ["Failed to resolve a valid destination. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailed;
    };
};

if !([_destination] call _isValidPos) exitWith {
    ["Aborting request: no valid destination available.", _targetOwner] call _debugMsg;
};
if !(_destination inArea [_center, _radius, _radius, 0, false]) exitWith {
    [format ["Aborting request: resolved destination outside AO destination=%1 center=%2 radius=%3", _destination, _center, _radius], _targetOwner] call _debugMsg;
    ["Resolved destination is outside the active AO.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _players = allPlayers select {alive _x && {side _x != east}};
private _spawnPos = [];
private _abortAfterSpawnSearchFailure = false;

private _blockedAreas = missionNamespace getVariable ["vn_mf_markers_blocked_areas", []];
if !(_blockedAreas isEqualType []) then {_blockedAreas = [];};

private _isGroundPosClear = {
    params ["_pos", ["_radius", 20]];

    if ((_blockedAreas findIf {_pos inArea _x}) > -1) exitWith {false};
    if (surfaceIsWater _pos) exitWith {false};
    if ((count (nearestObjects [_pos, ["House", "Building"], _radius])) > 0) exitWith {false};
    if ((count (nearestObjects [_pos, ["Car", "Tank", "Air"], _radius])) > 0) exitWith {false};

    true
};

if (_unitType in ["foot", "armor", "strella"]) then {
    // If a cardinal direction was chosen, use it; otherwise fall back to mission-interop valid angles
    private _tracerDirection = if (_spawnDirAngle >= 0) then {
        // tracerDirection = angle tracer travels (toward destination).
        // Spawn point is in direction _spawnDirAngle FROM destination, so tracer comes FROM there.
        // tracer fires in opposite direction: _spawnDirAngle + 180.
        (_spawnDirAngle + 180 + (random 40) - 20) mod 360
    } else {
        private _validAttackAngles = [_destination] call para_g_fnc_spawning_valid_attack_angles;
        if ((count _validAttackAngles) >= 2) then {
            (_validAttackAngles select 0) + random ((_validAttackAngles select 1) - (_validAttackAngles select 0))
        } else {
            random 360
        }
    };

    private _tracerResult = [_destination, _players, _tracerDirection, 300] call para_g_fnc_spawning_find_valid_position_tracer;
    if !(_tracerResult isEqualTo []) then {
        private _candidate = _tracerResult select 0;
        // Reject if inside a blocked area; try 90-degree offset as fallback
        if ((_blockedAreas findIf {_candidate inArea _x}) isEqualTo -1) then {
            _spawnPos = _candidate;
        } else {
            private _altDir = (_tracerDirection + 90) mod 360;
            private _altResult = [_destination, _players, _altDir, 300] call para_g_fnc_spawning_find_valid_position_tracer;
            if (!(_altResult isEqualTo []) && {(_blockedAreas findIf {(_altResult select 0) inArea _x}) isEqualTo -1}) then {
                _spawnPos = _altResult select 0;
            };
        };
        [format ["Tracer ground spawn result: %1", _spawnPos], _targetOwner] call _debugMsg;
    };

    if (_spawnPos isEqualTo []) then {
        // BIS fallback - use gradient 0.3 (~17 degrees) to avoid steep ridgelines
        _spawnPos = [_destination, 350, 1200, 10, 0, 0.3, 0, _blockedAreas, [_destination, _destination]] call BIS_fnc_findSafePos;
        [format ["Fallback safe ground spawn result: %1", _spawnPos], _targetOwner] call _debugMsg;
    };

    if (_spawnPos isEqualTo []) then {
        ["Ground spawn search failed.", _targetOwner] call _debugMsg;
        ["No safe ground spawn location found. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailed;
        _abortAfterSpawnSearchFailure = true;
    };
};

if (_unitType in ["rotary", "fixed"]) then {
    private _minAirDist = 2000;
    private _baseAltitude = [160, 650] select (_unitType isEqualTo "fixed");
    for "_i" from 0 to 30 do {
        private _candidateAngle = if (_spawnDirAngle >= 0) then {
            (_spawnDirAngle + (random 60) - 30) mod 360
        } else {
            random 360
        };
        private _candidate2D = _destination getPos [_minAirDist + random 1200, _candidateAngle];
        if (
            ((_players findIf {_x distance2D _candidate2D < _minAirDist}) isEqualTo -1) &&
            {(_blockedAreas findIf {_candidate2D inArea _x}) isEqualTo -1}
        ) exitWith {
            _spawnPos = [_candidate2D select 0, _candidate2D select 1, _baseAltitude + random 120];
        };
    };
    [format ["Air spawn result: %1", _spawnPos], _targetOwner] call _debugMsg;

    if (_spawnPos isEqualTo []) then {
        ["Air spawn search failed.", _targetOwner] call _debugMsg;
        ["No safe air spawn found at least 2km from players. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailed;
        _abortAfterSpawnSearchFailure = true;
    };
};

if (_abortAfterSpawnSearchFailure) exitWith {
    ["Aborting request after spawn-search failure.", _targetOwner] call _debugMsg;
};

private _groundTroopPool = [
    "vn_o_men_nva_dc_01",
    "vn_o_men_nva_dc_02",
    "vn_o_men_nva_dc_03",
    "vn_o_men_nva_dc_04",
    "vn_o_men_nva_dc_05",
    "vn_o_men_nva_dc_06",
    "vn_o_men_nva_dc_07",
    "vn_o_men_nva_dc_08",
    "vn_o_men_nva_dc_09",
    "vn_o_men_nva_dc_10",
    "vn_o_men_nva_dc_11",
    "vn_o_men_nva_dc_12",
    "vn_o_men_nva_dc_13",
    "vn_o_men_nva_dc_14",
    "vn_o_men_nva_dc_15",
    "vn_o_men_nva_dc_16",
    "vn_o_men_nva_dc_17",
    "vn_o_men_nva_dc_18"
];

private _pickFromPool = {
    params ["_pool", "_count"];
    private _res = [];
    for "_i" from 1 to _count do {
        _res pushBack selectRandom _pool;
    };
    _res
};

private _splitIntoChunks = {
    params ["_items", ["_chunkSize", 10]];
    private _chunks = [];
    private _currentChunk = [];

    {
        _currentChunk pushBack _x;
        if ((count _currentChunk) >= _chunkSize) then {
            _chunks pushBack _currentChunk;
            _currentChunk = [];
        };
    } forEach _items;

    if (_currentChunk isNotEqualTo []) then {
        _chunks pushBack _currentChunk;
    };

    _chunks
};

// Spawn infantry in paced batches for very large groups. This reduces
// server frame spikes compared to creating 50-100 units in one instant.
private _spawnInfantryGradual = {
    params ["_unitClasses", "_group", "_spawnPos", ["_batchSize", 10], ["_batchPause", 0.35], ["_intraPause", 0.02]];
    private _created = [];

    // If we are unscheduled, run the paced spawner in a spawned script and wait
    // for completion so main flow still receives all created units.
    if (!canSuspend) exitWith {
        private _holder = missionNamespace;
        private _key = format ["vn_mf_opfor_support_gradual_%1_%2", diag_frameNo, floor (random 1000000)];
        _holder setVariable [_key, [false, []]];

        [_unitClasses, _group, _spawnPos, _batchSize, _batchPause, _intraPause, _holder, _key] spawn {
            params ["_unitClasses", "_group", "_spawnPos", "_batchSize", "_batchPause", "_intraPause", "_holder", "_key"];
            private _createdLocal = [];
            {
                private _unit = _group createUnit [_x, _spawnPos, [], 10, "NONE"];
                if (!isNull _unit) then {
                    _createdLocal pushBack _unit;
                };

                if (((_forEachIndex + 1) mod _batchSize) isEqualTo 0) then {
                    sleep _batchPause;
                } else {
                    sleep _intraPause;
                };
            } forEach _unitClasses;

            _holder setVariable [_key, [true, _createdLocal]];
        };

        waitUntil {
            uiSleep 0.05;
            (_holder getVariable [_key, [false, []]]) select 0
        };

        _created = (_holder getVariable [_key, [true, []]]) select 1;
        _holder setVariable [_key, nil];
        _created
    };

    {
        private _unit = _group createUnit [_x, _spawnPos, [], 10, "NONE"];
        if (!isNull _unit) then {
            _created pushBack _unit;
        };

        if (((_forEachIndex + 1) mod _batchSize) isEqualTo 0) then {
            sleep _batchPause;
        } else {
            sleep _intraPause;
        };
    } forEach _unitClasses;
    _created
};

private _footSquad = [_groundTroopPool, 10] call _pickFromPool;
private _footPlatoon = [_groundTroopPool, 50] call _pickFromPool;
private _footCompany = [_groundTroopPool, 100] call _pickFromPool;

private _armorPool = [
    "vn_o_armor_m41_02_vcmf",
    "vn_o_armor_t54b_01_vcmf",
    "vn_o_armor_pt76a_01",
    "vn_o_armor_type63_01"
];

private _rotaryPool = [
    "vn_o_air_mi2_04_06",
    "vn_o_air_mi2_04_04",
    "vn_o_air_mi2_04_02"
];

private _fixedPool = [
    "vn_o_air_mig21_cap",
    "vn_o_air_mig19_cap"
];

private _strellaPool = [
    "vn_o_men_nva_43",
    "vn_o_men_nva_44"
];

private _unitConfigs = createHashMapFromArray [
    ["foot", createHashMapFromArray [
        ["squad", _footSquad],
        ["platoon", _footPlatoon],
        ["company", _footCompany],
        // Backward-compatible aliases for any stale references.
        ["unit", _footPlatoon],
        ["battalion", _footCompany]
    ]],
    ["armor", createHashMapFromArray [
        ["single", [_armorPool, 1] call _pickFromPool],
        ["duo", [_armorPool, 2] call _pickFromPool],
        ["column", [_armorPool, 3] call _pickFromPool]
    ]],
    ["rotary", createHashMapFromArray [
        ["single", [_rotaryPool, 1] call _pickFromPool],
        ["section", [_rotaryPool, 2] call _pickFromPool],
        ["flight", [_rotaryPool, 3] call _pickFromPool]
    ]],
    ["fixed", createHashMapFromArray [
        ["single", [_fixedPool, 1] call _pickFromPool],
        ["element", [_fixedPool, 2] call _pickFromPool],
        ["squadron", [_fixedPool, 3] call _pickFromPool]
    ]],
    ["strella", createHashMapFromArray [
        ["single", [_strellaPool, 1] call _pickFromPool]
    ]]
];

private _unitSet = _unitConfigs get _unitType;
if (isNil "_unitSet") exitWith {
    [format ["Unit set missing for type %1", _unitType], _targetOwner] call _debugMsg;
    ["Unsupported reinforcement type.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _units = _unitSet get _size;
if (isNil "_units" || {_units isEqualTo []}) exitWith {
    [format ["Unit composition empty for type=%1 size=%2", _unitType, _size], _targetOwner] call _debugMsg;
    ["No unit composition configured for this option.", _targetOwner, _requestingPlayer] call _notifyFailed;
};

[format ["Unit composition resolved: type=%1 size=%2 units=%3", _unitType, _size, _units], _targetOwner] call _debugMsg;

// Validate supplies, then debit once before any unit/vehicle creation.
private _supplySource = _building getVariable ["para_g_current_supply_source", objNull];
if (isNull _supplySource) exitWith {
    ["Coms tower has no supply source attached.", _targetOwner] call _debugMsg;
    ["Coms tower supply source unavailable.", _targetOwner, _requestingPlayer] call _notifyFailed;
};
private _currentSupplies = _supplySource getVariable ["para_g_current_supplies", 0];
if (_currentSupplies < _cost) exitWith {
    [format ["Insufficient supplies: have %1, need %2", _currentSupplies, _cost], _targetOwner] call _debugMsg;
    [format ["Insufficient tower sandbags. Have %1 sandbags, need %2 sandbags.", floor (_currentSupplies / _sandbagValue), _costSandbags], _targetOwner, _requestingPlayer] call _notifyFailed;
};

private _suppliesDebited = false;
if !([_building, _cost, false] call para_s_fnc_building_consume_supplies) exitWith {
    [format ["Supply consume failed pre-spawn: cost=%1", _cost], _targetOwner] call _debugMsg;
    ["Failed to consume tower supplies. No support spawned.", _targetOwner, _requestingPlayer] call _notifyFailed;
};
_suppliesDebited = true;
[format ["Supply consumed pre-spawn: cost=%1", _cost], _targetOwner] call _debugMsg;

// Apply cooldown lock as soon as request has passed all hard preconditions.
// This prevents spam from repeated retries while a spawn is still resolving or partially failing.
_teamCooldowns set [_requestTeam, time + _cooldownSeconds];
missionNamespace setVariable ["vn_mf_opfor_support_team_cooldowns", _teamCooldowns, true];
[format ["Applied team cooldown lock early: team=%1 seconds=%2", _requestTeam, _cooldownSeconds], _targetOwner] call _debugMsg;

private _group = grpNull;
private _supportGroups = [];
private _supportGroupVehicles = createHashMap;
private _supportGroupVehicleKey = {
    params ["_group"];
    if (isNull _group) exitWith {""};
    str _group
};
private _spawnedCount = 0;
private _leadUnit = objNull;
private _spawnedUnits = [];
private _spawnedVehicles = [];
private _spawnedAirGroups = [];

if (_unitType isEqualTo "foot") then {
    if !([_spawnPos] call _isValidPos) exitWith {
        if (_suppliesDebited) then {
            [_building, -_cost, true] call para_s_fnc_building_consume_supplies;
            [format ["Refunded pre-spawn debit after foot validation failure: refund=%1", _cost], _targetOwner] call _debugMsg;
            _suppliesDebited = false;
        };
        [format ["Foot spawn aborted: invalid spawnPos %1", _spawnPos], _targetOwner] call _debugMsg;
        ["Spawn failed: no valid ground spawn position. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailed;
    };
    private _footChunks = if ((count _units) > 10) then {[_units, 10] call _splitIntoChunks} else {[_units]};

    {
        private _chunkUnits = _x;
        private _chunkGroup = [east] call para_g_fnc_create_group;
        _chunkGroup deleteGroupWhenEmpty true;

        private _chunkSpawnAnchor = _spawnPos;
        if (_forEachIndex > 0) then {
            _chunkSpawnAnchor = _spawnPos getPos [8 + random 12, ((_spawnPos getDir _destination) + (35 * _forEachIndex)) mod 360];
        };

        private _chunkSpawnPos = [_chunkSpawnAnchor, 0, 25, 5, 0, 0.3, 0, _blockedAreas, [_chunkSpawnAnchor, _chunkSpawnAnchor]] call BIS_fnc_findSafePos;
        if (_chunkSpawnPos isEqualTo []) then {
            _chunkSpawnPos = _chunkSpawnAnchor;
        };

        private _chunkSpawnedUnits = [_chunkUnits, _chunkGroup, _chunkSpawnPos, 5, 0.25, 0.02] call _spawnInfantryGradual;
        if !(_chunkSpawnedUnits isEqualType []) then {_chunkSpawnedUnits = [];};
        if (_chunkSpawnedUnits isEqualTo []) then {
            deleteGroup _chunkGroup;
        } else {
            if (isNull _group) then {
                _group = _chunkGroup;
            };

            _supportGroups pushBack _chunkGroup;
            _supportGroupVehicles set [[_chunkGroup] call _supportGroupVehicleKey, []];
            _spawnedUnits append _chunkSpawnedUnits;
            {
                [_x, _bodyCleanupLifetime, _debugMsg, _targetOwner] call _registerBodyCleanup;
            } forEach _chunkSpawnedUnits;

            _spawnedCount = _spawnedCount + (count _chunkSpawnedUnits);
            [format ["Foot support sub-group %1 created %2 units at %3", _forEachIndex + 1, count _chunkSpawnedUnits, _chunkSpawnPos], _targetOwner] call _debugMsg;

            if (_forEachIndex < ((count _footChunks) - 1)) then {
                sleep 0.4;
            };
        };
    } forEach _footChunks;

    [format ["Foot spawn created %1 total units across %2 groups", _spawnedCount, count _supportGroups], _targetOwner] call _debugMsg;
} else {
    if (_unitType isEqualTo "armor") then {
        if !([_spawnPos] call _isValidPos) exitWith {
            if (_suppliesDebited) then {
                [_building, -_cost, true] call para_s_fnc_building_consume_supplies;
                [format ["Refunded pre-spawn debit after armor validation failure: refund=%1", _cost], _targetOwner] call _debugMsg;
                _suppliesDebited = false;
            };
            [format ["Armor spawn aborted: invalid spawnPos %1", _spawnPos], _targetOwner] call _debugMsg;
            ["Spawn failed: no valid armor spawn position. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailed;
        };
        _group = [east] call para_g_fnc_create_group;
        _group deleteGroupWhenEmpty true;
        private _offsetIdx = 0;
        {
            // Spread vehicles in a column offset by spawn-to-destination bearing
            private _columnDir = _spawnPos getDir _destination;
            private _offsetPos = _spawnPos;
            if (_offsetIdx > 0) then {
                _offsetPos = _spawnPos getPos [_offsetIdx * 30, _columnDir];
            };

            // Terrain safety: find flat ground (gradient <=0.3, ~17 deg) near the offset
            private _safePos = [_offsetPos, 5, 80, 10, 0, 0.3, 0, _blockedAreas, [_offsetPos, _offsetPos]] call BIS_fnc_findSafePos;
            if !(_safePos isEqualTo []) then {_offsetPos = _safePos;};
            _offsetPos set [2, 0];

            if !([_offsetPos, 22] call _isGroundPosClear) then {
                for "_scan" from 0 to 15 do {
                    private _cand = [_offsetPos, 15, 140, 10, 0, 0.3, 0, _blockedAreas, [_offsetPos, _offsetPos]] call BIS_fnc_findSafePos;
                    if (!(_cand isEqualTo []) && {[_cand, 22] call _isGroundPosClear}) exitWith {
                        _offsetPos = _cand;
                        _offsetPos set [2, 0];
                    };
                };
            };

            private _veh = [_x, _offsetPos, 35, 8, false, true] call para_g_fnc_create_vehicle_safely;
            if (isNull _veh) then {
                private _vehPos = _offsetPos findEmptyPosition [5, 40, _x];
                if (_vehPos isEqualTo []) then {_vehPos = _offsetPos;};
                [format ["Armor safe spawn failed, trying direct create at %1", _vehPos], _targetOwner] call _debugMsg;
                _veh = createVehicle [_x, _vehPos, [], 0, "NONE"];
            };

            if (!isNull _veh) then {
                createVehicleCrew _veh;
                {
                    [_x, _bodyCleanupLifetime, _debugMsg, _targetOwner] call _registerBodyCleanup;
                    [_x] joinSilent _group;
                } forEach crew _veh;
                _spawnedUnits append (crew _veh);
                _spawnedVehicles pushBack _veh;
                private _groupVehs = _supportGroupVehicles getOrDefault [[_group] call _supportGroupVehicleKey, []];
                _groupVehs pushBack _veh;
                _supportGroupVehicles set [[_group] call _supportGroupVehicleKey, _groupVehs];
                [_veh, _wreckCleanupLifetime, _debugMsg, _targetOwner] call _registerWreckCleanup;
                if (isNull _leadUnit && {!isNull driver _veh}) then {
                    _leadUnit = driver _veh;
                };
                _spawnedCount = _spawnedCount + 1;
                [format ["Armor vehicle spawned: %1 at %2", _x, _offsetPos], _targetOwner] call _debugMsg;
            } else {
                [format ["Armor vehicle failed to spawn: %1", _x], _targetOwner] call _debugMsg;
            };
            _offsetIdx = _offsetIdx + 1;
        } forEach _units;
    } else {
        if (_unitType isEqualTo "strella") then {
                if !([_spawnPos] call _isValidPos) then {
                    _spawnPos = [_destination, 350, 1200, 10, 0, 0.3, 0, _blockedAreas, [_destination, _destination]] call BIS_fnc_findSafePos;
                    [format ["Strella fallback spawn result: %1", _spawnPos], _targetOwner] call _debugMsg;
                };
                if !([_spawnPos] call _isValidPos) exitWith {
                    if (_suppliesDebited) then {
                        [_building, -_cost, true] call para_s_fnc_building_consume_supplies;
                        [format ["Refunded pre-spawn debit after strella validation failure: refund=%1", _cost], _targetOwner] call _debugMsg;
                        _suppliesDebited = false;
                    };
                    [format ["Strella spawn aborted: invalid spawnPos %1", _spawnPos], _targetOwner] call _debugMsg;
                    ["Spawn failed: no valid Strella spawn position. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailed;
                };
                _group = [east] call para_g_fnc_create_group;
                _group deleteGroupWhenEmpty true;
                [format ["Strella spawn: attempting to create squad with units %1 at %2", _units, _spawnPos], _targetOwner] call _debugMsg;
                private _spawnResult = [_units, _group, _spawnPos] call para_g_fnc_create_squad;
                private _spawnedStrellaUnits = [];
                if (_spawnResult isEqualType [] && {count _spawnResult > 0} && {(_spawnResult select 0) isEqualType []}) then {
                    _spawnedStrellaUnits = _spawnResult select 0;
                };
                _spawnedUnits append _spawnedStrellaUnits;
                [format ["Strella spawn result: %1 units created from spawnResult %2", count _spawnedStrellaUnits, _spawnResult], _targetOwner] call _debugMsg;
                {
                    [_x, _bodyCleanupLifetime, _debugMsg, _targetOwner] call _registerBodyCleanup;
                } forEach _spawnedStrellaUnits;
                _spawnedCount = count _spawnedStrellaUnits;
                [format ["Strella units spawned: %1 units at %2", _spawnedCount, _spawnPos], _targetOwner] call _debugMsg;
            } else {
                private _flightAlt = if (_unitType isEqualTo "fixed") then {300} else {100};
                private _flightSpeed = if (_unitType isEqualTo "fixed") then {250} else {80};
        private _offsetIdx = 0;
        {
            // Spread aircraft in echelon: alternate left/right offset from spawn-to-dest bearing
            private _flightDir = _spawnPos getDir _destination;
            private _offsetPos = _spawnPos;
            if (_offsetIdx > 0) then {
                private _echelonDir = (_flightDir + (90 * ((_offsetIdx mod 2) * 2 - 1))) mod 360;
                _offsetPos = _spawnPos getPos [200 + _offsetIdx * 100, _echelonDir];
                _offsetPos set [2, _spawnPos select 2];
            };

            private _spawnPosASL = AGLToASL _offsetPos;
            private _veh = createVehicle [_x, ASLToATL _spawnPosASL, [], 0, "FLY"];
            if (isNull _veh) then {
                [format ["Air direct create failed for %1", _x], _targetOwner] call _debugMsg;
            } else {
                _veh setPosASL _spawnPosASL;
                _veh setDir _flightDir;
            };

            if (!isNull _veh) then {
                _veh setDir _flightDir;
                _veh flyInHeight _flightAlt;
                _veh setVelocityModelSpace [0, _flightSpeed, 0];
                createVehicleCrew _veh;
                {
                    [_x, _bodyCleanupLifetime, _debugMsg, _targetOwner] call _registerBodyCleanup;
                } forEach crew _veh;
                _spawnedUnits append (crew _veh);
                _spawnedVehicles pushBack _veh;
                [_veh, _wreckCleanupLifetime, _debugMsg, _targetOwner] call _registerWreckCleanup;
                private _airGroup = group (driver _veh);
                if (!isNull _airGroup) then {
                    _airGroup deleteGroupWhenEmpty true;
                    if (_supportGroups find _airGroup < 0) then {
                        _supportGroups pushBack _airGroup;
                    };
                    private _airVehs = _supportGroupVehicles getOrDefault [[_airGroup] call _supportGroupVehicleKey, []];
                    _airVehs pushBack _veh;
                    _supportGroupVehicles set [[_airGroup] call _supportGroupVehicleKey, _airVehs];
                    _spawnedAirGroups pushBack _airGroup;
                };
                _spawnedCount = _spawnedCount + 1;
                [format ["Air vehicle spawned: %1 at %2", _x, _offsetPos], _targetOwner] call _debugMsg;
            } else {
                [format ["Air vehicle failed to spawn: %1", _x], _targetOwner] call _debugMsg;
            };
            _offsetIdx = _offsetIdx + 1;
        } forEach _units;
        };
    };
};

if (_spawnedCount <= 0) exitWith {
    if (_suppliesDebited) then {
        [_building, -_cost, true] call para_s_fnc_building_consume_supplies;
        [format ["Refunded pre-spawn debit because spawn produced zero units/vehicles: refund=%1", _cost], _targetOwner] call _debugMsg;
        _suppliesDebited = false;
    };
    {
        if (!isNull _x) then {
            deleteGroup _x;
        };
    } forEach (_supportGroups + _spawnedAirGroups);
    if (!isNull _group) then { deleteGroup _group; };
    ["Spawn completed with zero created units/vehicles.", _targetOwner] call _debugMsg;
    ["Spawn failed: no units could be created. No sandbags consumed.", _targetOwner, _requestingPlayer] call _notifyFailedOnce;
};

[format ["[COMMS TOWER TEST] spawn completed type=%1 count=%2 groups=%3", _unitType, _spawnedCount, count _supportGroups], _targetOwner] call _debugMsg;

// Keep support spawns out of objective hardcap accounting while they are
// behaving as dedicated reinforcements. The flag is cleared at handoff so that
// the AI objective subsystem will treat them as free groups and clean them up.
{
    _x setVariable ["vn_mf_is_opfor_support_unit", true, true];
} forEach _spawnedUnits;

if (!isNull _group && {_supportGroups find _group < 0}) then {
    _supportGroups pushBack _group;
};
private _mainGroupVehiclesKey = [_group] call _supportGroupVehicleKey;
if (!isNull _group && {isNil {_supportGroupVehicles get _mainGroupVehiclesKey}}) then {
    _supportGroupVehicles set [_mainGroupVehiclesKey, []];
};

private _startSupportVehicleCleanupMonitor = {
    params ["_vehicle", "_activeVehicleCleanupLifetime", "_debugMsg", "_targetOwner"];

    if (isNull _vehicle) exitWith {};
    if (_vehicle getVariable ["vn_mf_opfor_support_vehicle_cleanup_monitor_active", false]) exitWith {};

    _vehicle setVariable ["vn_mf_opfor_support_vehicle_cleanup_monitor_active", true];
    _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", -1];

    [_vehicle, _activeVehicleCleanupLifetime, _debugMsg, _targetOwner] spawn {
        params ["_vehicle", "_activeVehicleCleanupLifetime", "_debugMsg", "_targetOwner"];

        private _cleanupMinPlayerDistance = missionNamespace getVariable ["para_s_cleanup_minPlayerDistance", 400];
        if !(_cleanupMinPlayerDistance isEqualType 0) then {
            _cleanupMinPlayerDistance = 400;
        };
        if (_cleanupMinPlayerDistance <= 0) then {
            _cleanupMinPlayerDistance = 400;
        };

        while {true} do {
            sleep 30;

            if (isNull _vehicle) exitWith {};
            if (!alive _vehicle) exitWith {};

            private _hasOccupants = (fullCrew [_vehicle, "", false]) findIf {!isNull (_x select 0)} > -1;
            if (_hasOccupants) then {
                _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", -1];
                continue;
            };

            if ((allPlayers findIf {_x distance2D _vehicle < _cleanupMinPlayerDistance}) > -1) then {
                _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", -1];
                continue;
            };

            private _abandonedSince = _vehicle getVariable ["vn_mf_opfor_support_vehicle_abandoned_since", -1];
            if (_abandonedSince < 0) then {
                _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", time];
                continue;
            };

            if ((time - _abandonedSince) < _activeVehicleCleanupLifetime) then {
                continue;
            };

            if (isNull _vehicle || {!alive _vehicle}) exitWith {};

            private _hasFinalOccupants = (fullCrew [_vehicle, "", false]) findIf {!isNull (_x select 0)} > -1;
            if (_hasFinalOccupants) then {
                _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", -1];
                continue;
            };

            if ((allPlayers findIf {_x distance2D _vehicle < _cleanupMinPlayerDistance}) > -1) then {
                _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", -1];
                continue;
            };

            [format ["Deleting abandoned support vehicle after %1s: %2", _activeVehicleCleanupLifetime, _vehicle], _targetOwner] call _debugMsg;
            deleteVehicle _vehicle;
            if (true) exitWith {};
        };

        if !(isNull _vehicle) then {
            _vehicle setVariable ["vn_mf_opfor_support_vehicle_cleanup_monitor_active", false];
            _vehicle setVariable ["vn_mf_opfor_support_vehicle_abandoned_since", nil];
        };
    };
};

private _startSupportGroupWatchdog = {
    params ["_group", "_spawnedVehicles", "_idleHandoffTime", "_activeVehicleCleanupLifetime", "_startSupportVehicleCleanupMonitor", "_debugMsg", "_targetOwner"];

    if (isNull _group) exitWith {};

    [_group, _spawnedVehicles, _idleHandoffTime, _activeVehicleCleanupLifetime, _startSupportVehicleCleanupMonitor, _debugMsg, _targetOwner] spawn {
        params ["_group", "_spawnedVehicles", "_idleHandoffTime", "_activeVehicleCleanupLifetime", "_startSupportVehicleCleanupMonitor", "_debugMsg", "_targetOwner"];

        private _lastEngagedTime = time;
        private _handedOff = false;

        while {!isNull _group && {count units _group > 0}} do {
            sleep 30;
            if (isNull _group) exitWith {};
            if (count units _group == 0) exitWith {};

            if (!_handedOff) then {
                private _engaged = false;
                {
                    if (alive _x) then {
                        private _tgt = _x findNearestEnemy (getPos _x);
                        if (!isNull _tgt && {(_x knowsAbout _tgt) >= 1.5}) exitWith {
                            _engaged = true;
                        };
                    };
                } forEach (units _group);

                if (_engaged) then {
                    _lastEngagedTime = time;
                } else {
                    if (time - _lastEngagedTime >= _idleHandoffTime) then {
                        {
                            _x setVariable ["vn_mf_is_opfor_support_unit", false, true];
                        } forEach (units _group);
                        [_group] call para_s_fnc_ai_obj_give_group_ownership;
                        {
                            [_x, _activeVehicleCleanupLifetime, _debugMsg, _targetOwner] call _startSupportVehicleCleanupMonitor;
                        } forEach _spawnedVehicles;
                        [format ["Handed idle support group to AI subsystem after %1s of no engagement (vehicles kept intact).", _idleHandoffTime], _targetOwner] call _debugMsg;
                        _handedOff = true;
                    };
                };
            };
        };

        if (!isNull _group) then {
            if (!_handedOff) then {
                {
                    [_x, _activeVehicleCleanupLifetime, _debugMsg, _targetOwner] call _startSupportVehicleCleanupMonitor;
                } forEach _spawnedVehicles;
                ["Group emptied before handoff; started support vehicle cleanup monitors.", _targetOwner] call _debugMsg;
            };
            deleteGroup _group;
            ["Deleted empty support group.", _targetOwner] call _debugMsg;
        };
    };
};

private _idleHandoffTime = missionNamespace getVariable ["vn_mf_opfor_support_idle_handoff_time", 300];
{
    private _groupVehicles = _supportGroupVehicles getOrDefault [[_x] call _supportGroupVehicleKey, []];
    [format ["[COMMS TOWER TEST] watchdog start group=%1 vehicles=%2", _x, count _groupVehicles], _targetOwner] call _debugMsg;
    [_x, _groupVehicles, _idleHandoffTime, _activeVehicleCleanupLifetime, _startSupportVehicleCleanupMonitor, _debugMsg, _targetOwner] call _startSupportGroupWatchdog;
} forEach _supportGroups;

private _suppliesLeft = round (_supplySource getVariable ["para_g_current_supplies", 0]);
[format ["Spawn success. Supplies left=%1", _suppliesLeft], _targetOwner] call _debugMsg;
["[COMMS TOWER TEST] entered success block", _targetOwner] call _debugMsg;

private _successMsg = format ["Reinforcements dispatched (%1). Sandbags left: %2", _taskLabel, floor (_suppliesLeft / _sandbagValue)];
[format ["[COMMS TOWER TEST] notify success owner=%1 requesterOwner=%2", _targetOwner, if (isNull _requestingPlayer) then {-1} else {owner _requestingPlayer}], _targetOwner] call _debugMsg;
[_successMsg, _targetOwner, _requestingPlayer] call _notifySuccess;

if (!isNull _group && {isNull _leadUnit} && {count units _group > 0}) then {
    _leadUnit = leader _group;
};

if (!isNull _group && {!isNull _leadUnit}) then {
    _group selectLeader _leadUnit;
};

{
    if (!isNull _x) then {
        _x setBehaviourStrong "AWARE";
        _x setCombatMode "YELLOW";
        _x setSpeedMode "FULL";
        {
            _x setBehaviour "AWARE";
            _x setUnitPos "AUTO";
        } forEach units _x;
    };
} forEach _supportGroups;

// Set up movement for all unit types
[format ["[COMMS TOWER TEST] movement block type=%1 destination=%2", _unitType, _destination], _targetOwner] call _debugMsg;
{
    if (!isNull _x) then {
        while {count waypoints _x > 0} do {deleteWaypoint [_x, 0];};
    };
} forEach _supportGroups;

if (_unitType isEqualTo "foot") then {
    private _footPatrolRadius = missionNamespace getVariable ["vn_mf_opfor_support_foot_patrol_radius", 120];
    if !(_footPatrolRadius isEqualType 0) then {
        _footPatrolRadius = 120;
    };
    if (_footPatrolRadius < 40) then {
        _footPatrolRadius = 40;
    };

    {
        private _moveWp = _x addWaypoint [_destination, 0];
        _moveWp setWaypointType "MOVE";
        _moveWp setWaypointBehaviour "AWARE";
        _moveWp setWaypointCombatMode "YELLOW";
        _moveWp setWaypointSpeed "FULL";
        [_x, _destination] call BIS_fnc_taskAttack;
        _x setCurrentWaypoint _moveWp;
        [format ["[COMMS TOWER TEST] foot waypoint group=%1 destination=%2", _x, _destination], _targetOwner] call _debugMsg;

        [_x, _destination, _footPatrolRadius, _targetOwner, _debugMsg] spawn {
            params ["_group", "_destination", "_footPatrolRadius", "_targetOwner", "_debugMsg"];

            private _arrivalThreshold = 60;
            private _timeout = time + 600;

            waitUntil {
                sleep 5;
                isNull _group
                || {({alive _x} count units _group) <= 0}
                || {({alive _x && {_x getVariable ["vn_mf_is_opfor_support_unit", false]}} count units _group) <= 0}
                || {(leader _group) distance2D _destination <= _arrivalThreshold}
                || {time > _timeout}
            };

            private _aliveUnits = (units _group) select {alive _x};

            if (isNull _group || {_aliveUnits isEqualTo []}) exitWith {};
            if ((_aliveUnits findIf {_x getVariable ["vn_mf_is_opfor_support_unit", false]}) isEqualTo -1) exitWith {};
            if ((leader _group) distance2D _destination > _arrivalThreshold) exitWith {};

            [format ["[COMMS TOWER TEST] foot destination reached group=%1 center=%2", _group, _destination], _targetOwner] call _debugMsg;

            while {count waypoints _group > 0} do {
                deleteWaypoint [_group, 0];
            };

            _group setBehaviourStrong "AWARE";
            _group setCombatMode "YELLOW";
            _group setSpeedMode "LIMITED";
            [_group, _destination, _footPatrolRadius] call BIS_fnc_taskPatrol;

            [format ["[COMMS TOWER TEST] foot patrol created group=%1 center=%2 radius=%3", _group, _destination, _footPatrolRadius], _targetOwner] call _debugMsg;
        };
    } forEach _supportGroups;
};

if (_unitType isEqualTo "armor") then {
    private _moveWp = _group addWaypoint [_destination, 0];
    _moveWp setWaypointType "MOVE";
    _moveWp setWaypointBehaviour "AWARE";
    _moveWp setWaypointCombatMode "YELLOW";
    _moveWp setWaypointSpeed "FULL";
    _moveWp setWaypointFormation "COLUMN";
    // SAD waypoint after arrival: search & destroy in 200m radius.
    private _sadWp = _group addWaypoint [_destination, 0];
    _sadWp setWaypointType "SAD";
    _sadWp setWaypointBehaviour "AWARE";
    _sadWp setWaypointCombatMode "YELLOW";
    _sadWp setWaypointSpeed "FULL";
    _group setCurrentWaypoint _moveWp;
    [format ["[COMMS TOWER TEST] armor waypoint group=%1 destination=%2", _group, _destination], _targetOwner] call _debugMsg;
    _group move _destination;
    private _armorUnits = units _group;
    for "_i" from 0 to ((count _armorUnits) - 1) do {
        private _u = _armorUnits select _i;
        private _veh = vehicle _u;
        if (_veh != _u) then {
            _veh engineOn true;
        };
        _u doMove _destination;
        _u commandMove _destination;
    };
};

if (_unitType isEqualTo "strella") then {
    private _moveWp = _group addWaypoint [_destination, 0];
    _moveWp setWaypointType "MOVE";
    _moveWp setWaypointBehaviour "AWARE";
    _moveWp setWaypointCombatMode "YELLOW";
    _moveWp setWaypointSpeed "FULL";
    // MANPAD infantry: search & destroy on foot after arrival.
    [_group, _destination] call BIS_fnc_taskAttack;
    _group setCurrentWaypoint _moveWp;
    [format ["[COMMS TOWER TEST] strella waypoint group=%1 destination=%2", _group, _destination], _targetOwner] call _debugMsg;
    _group move _destination;
};

if (_unitType in ["rotary", "fixed"]) then {
    [format ["Air task init: type=%1 vehicles=%2 groups=%3 dest=%4", _unitType, count _spawnedVehicles, count _spawnedAirGroups, _destination], _targetOwner] call _debugMsg;
    for "_i" from 0 to ((count _spawnedVehicles) - 1) do {
        private _veh = _spawnedVehicles select _i;
        private _airGroup = grpNull;
        private _attackHeight = 100;
        private _attackSpeed = 80;

        if (_i < count _spawnedAirGroups) then {
            _airGroup = _spawnedAirGroups select _i;
        };

        if (_unitType isEqualTo "fixed") then {
            _attackHeight = 300;
            _attackSpeed = 250;
        };

        if (!isNull _veh && {!isNull _airGroup}) then {
            _veh engineOn true;
            _veh flyInHeight _attackHeight;
            _veh setVelocityModelSpace [0, _attackSpeed, 0];

            _airGroup setBehaviourStrong "AWARE";
            _airGroup setCombatMode "RED";

            private _wp = _airGroup addWaypoint [_destination, 0];
            _wp setWaypointType "SAD";
            _wp setWaypointSpeed "FULL";
            _wp setWaypointBehaviour "AWARE";

            [format ["[COMMS TOWER TEST] air waypoint type=%1 group=%2 destination=%3", _unitType, _airGroup, _destination], _targetOwner] call _debugMsg;

            [_airGroup, _destination] call BIS_fnc_taskAttack;

            [format ["Air tasking applied: type=%1 veh=%2 group=%3", _unitType, _veh, _airGroup], _targetOwner] call _debugMsg;
        } else {
            [format ["Air tasking skipped: type=%1 veh=%2 group=%3", _unitType, _veh, _airGroup], _targetOwner] call _debugMsg;
        };
    };
};

if (_unitType isEqualTo "armor") then {
    [_group, _destination, _unitType, _targetOwner] spawn {
        params ["_group", "_destination", "_unitType", "_targetOwner"];
        for "_i" from 0 to 16 do {
            sleep 5;
            if ({alive _x} count units _group <= 0) exitWith {};
            if ((leader _group) distance2D _destination < 120) exitWith {};

            _group move _destination;

            private _retryUnits = units _group;
            for "_j" from 0 to ((count _retryUnits) - 1) do {
                private _u = _retryUnits select _j;
                private _veh = vehicle _u;
                if (_unitType isEqualTo "armor") then {
                    if (_veh != _u) then {
                        _veh engineOn true;
                    };
                    _u doMove _destination;
                    _u commandMove _destination;
                };
            };

            [format ["Re-issued %1 movement order toward %2", _unitType, _destination], _targetOwner] call _debugMsg;
        };
    };
};

[format ["Group ordered to destination %1", _destination], _targetOwner] call _debugMsg;
