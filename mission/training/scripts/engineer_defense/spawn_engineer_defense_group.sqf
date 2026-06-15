/*
    File: spawn_engineer_defense_group.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Spawns an engineer defense AI group around the selected target flag.

    Parameter(s):
        _targetFlag - Defense target flag [OBJECT]
        _spawnCount - Number of units to spawn [NUMBER]
        _unitTypes - Unit class names to pick from [ARRAY]
        _minShift - Minimum distance from the last spawn center [NUMBER]
        _minDistance - Minimum distance from the target [NUMBER]
        _maxDistance - Maximum distance from the target [NUMBER]
        _minBearingDelta - Minimum bearing delta from the last spawn [NUMBER]
        _behaviour - Group combat behaviour [STRING, defaults to "AWARE"]

    Returns:
        Array [GROUP, ARRAY<OBJECT>, ARRAY]

    Example(s):
        [_targetFlag, 16, _enemyTypes, 60, 150, 200, 35, "AWARE"] call compile preprocessFileLineNumbers "training\scripts\engineer_defense\spawn_engineer_defense_group.sqf"
*/

params [
    "_targetFlag",
    ["_spawnCount", 16, [0]],
    ["_unitTypes", [], [[]]],
    ["_minShift", 60, [0]],
    ["_minDistance", 150, [0]],
    ["_maxDistance", 200, [0]],
    ["_minBearingDelta", 35, [0]],
    ["_behaviour", "AWARE", [""]]
];

private _targetPos = getPosATL _targetFlag;
private _lastCenter = missionNamespace getVariable ["vn_mf_training_engineer_defense_last_spawn_center", []];
private _lastBearing = missionNamespace getVariable ["vn_mf_training_engineer_defense_last_spawn_bearing", -1];
private _selectedCenter = [];
private _selectedBearing = -1;

private _fnc_angleDiff = {
    params ["_a", "_b"];
    private _d = abs (_a - _b);
    if (_d > 180) then { _d = 360 - _d; };
    _d
};

for "_i" from 0 to 40 do {
    private _bearing = random 360;
    if (_lastBearing >= 0 && { [_bearing, _lastBearing] call _fnc_angleDiff < _minBearingDelta }) then {
        continue;
    };

    private _distance = _minDistance + random (_maxDistance - _minDistance);
    private _candidate = [_targetPos, _distance, _bearing] call BIS_fnc_relPos;

    if ((_candidate distance2D _targetPos) < _minDistance) then {
        continue;
    };

    if (_lastCenter isNotEqualTo [] && { (_candidate distance2D _lastCenter) < _minShift }) then {
        continue;
    };

    _selectedCenter = _candidate;
    _selectedBearing = _bearing;
    break;
};

if (_selectedCenter isEqualTo []) then {
    private _fallbackBearing = random 360;
    _selectedCenter = [_targetPos, _minDistance + random (_maxDistance - _minDistance), _fallbackBearing] call BIS_fnc_relPos;
    _selectedBearing = _fallbackBearing;

    if ((_selectedCenter distance2D _targetPos) < _minDistance) then {
        private _bestCandidate = [_targetPos, _minDistance, _selectedBearing] call BIS_fnc_relPos;
        private _bestDistance = _bestCandidate distance2D _targetPos;
        private _bestBearing = _selectedBearing;

        for "_j" from 0 to 120 do {
            private _sampleBearing = random 360;
            if (_lastBearing >= 0 && { [_sampleBearing, _lastBearing] call _fnc_angleDiff < _minBearingDelta }) then {
                continue;
            };

            private _sample = [_targetPos, _minDistance + random (_maxDistance - _minDistance), _sampleBearing] call BIS_fnc_relPos;
            private _sampleDistance = _sample distance2D _targetPos;

            if (_sampleDistance > _bestDistance) then {
                _bestCandidate = _sample;
                _bestDistance = _sampleDistance;
                _bestBearing = _sampleBearing;
            };
        };

        _selectedCenter = _bestCandidate;
        _selectedBearing = _bestBearing;
    };
};

missionNamespace setVariable ["vn_mf_training_engineer_defense_last_spawn_center", _selectedCenter, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_last_spawn_bearing", _selectedBearing, true];

private _spawnPoints = [];
for "_i" from 0 to ((_spawnCount max 6) - 1) do {
    private _testPos = [_selectedCenter, 25, _i * (360 / (_spawnCount max 6))] call BIS_fnc_relPos;
    _spawnPoints pushBack _testPos;
};

if (_spawnPoints isEqualTo []) then {
    _spawnPoints pushBack _selectedCenter;
};

private _group = createGroup [east, true];
private _units = [];

for "_i" from 1 to _spawnCount do {
    private _spawnPos = _spawnPoints # ((_i - 1) mod (count _spawnPoints));
    private _unitType = selectRandom _unitTypes;
    private _unit = _group createUnit [_unitType, _spawnPos, [], 0, "NONE"];

    _unit setPosATL _spawnPos;
    _unit setSkill ["aimingAccuracy", 0.2];
    _unit setSkill ["aimingShake", 0.25];
    _unit setSkill ["spotDistance", 0.7];
    _unit setVariable ["vn_mf_training_engineer_defense_enemy", true, true];

    _units pushBack _unit;
};

_group setBehaviourStrong _behaviour;
_group setCombatMode "RED";
_group setSpeedMode "FULL";

private _wp = _group addWaypoint [_targetPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "FULL";

[_group, _units, _selectedCenter]