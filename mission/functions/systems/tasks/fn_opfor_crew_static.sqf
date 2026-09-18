/*
    File: fn_opfor_crew_static.sqf
    Author: Legend
    Public: No

    Description:
        OPFOR request handler for assigning one spawned AI to crew a static weapon.
        [!:warning] `_player` is provided by the rehandler parent scope.

    Parameter(s):
        _static - Static weapon to be crewed [Object]

    Returns:
        Nothing
*/

params ["_static"];

if (isNull _player) exitWith {};

private _owner = owner _player;
private _notifyFail = {
    params ["_msg", "_owner"];
    ["OpforTroopRequestFailed", [_msg]] remoteExecCall ["para_c_fnc_show_notification", _owner];
};
private _notifyOk = {
    params ["_msg", "_owner"];
    ["OpforTroopRequestSuccess", [_msg]] remoteExecCall ["para_c_fnc_show_notification", _owner];
};

if ((_player getVariable ["vn_mf_db_player_group", "MikeForce"]) isNotEqualTo "DacCong") exitWith {
    ["Only OPFOR can request static crews.", _owner] call _notifyFail;
};

if (isNull _static || {!alive _static} || {!(_static isKindOf "StaticWeapon")}) exitWith {
    ["Invalid static weapon.", _owner] call _notifyFail;
};

private _assignedUnit = _static getVariable ["vn_mf_opfor_static_crew_unit", objNull];
if (!isNull _assignedUnit && {alive _assignedUnit}) exitWith {
    ["This static already has an assigned crewman.", _owner] call _notifyFail;
};

if (!isNull gunner _static && {alive gunner _static}) exitWith {
    ["This static is already crewed.", _owner] call _notifyFail;
};

if (missionNamespace getVariable ["vn_mf_coms_tower_destroyed_in_ao", false]) exitWith {
    ["Coms tower destroyed in this AO. Static crews are locked until next AO.", _owner] call _notifyFail;
};

private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
private _aoMarker = _activeZones param [0, ""];
if !(_aoMarker in allMapMarkers) exitWith {
    ["No active AO marker found.", _owner] call _notifyFail;
};

private _aoCenter = markerPos _aoMarker;
private _aoRadius = getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100;
private _functionalTowers = (nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f"], _aoRadius, true]) select {
    private _building = _x getVariable ["para_g_building", objNull];
    alive _x && {!isNull _building} && {_building getVariable ["para_g_building_constructed", false]}
};
if (_functionalTowers isEqualTo []) exitWith {
    ["Coms tower is not fully built yet.", _owner] call _notifyFail;
};

private _tower = _functionalTowers select 0;
private _building = _tower getVariable ["para_g_building", objNull];
if (isNull _building) exitWith {
    ["Coms tower data unavailable.", _owner] call _notifyFail;
};

private _supplySource = _building getVariable ["para_g_current_supply_source", objNull];
if (isNull _supplySource) exitWith {
    ["Coms tower supply source unavailable.", _owner] call _notifyFail;
};

private _sandbagValue = ["building_sandbag_value", 10] call BIS_fnc_getParamValue;
if (_sandbagValue <= 0) then {_sandbagValue = 10;};
private _costSandbags = missionNamespace getVariable ["vn_mf_opfor_static_crew_cost_sandbags", 5];
if (_costSandbags <= 0) then {_costSandbags = 1;};
private _cost = _costSandbags * _sandbagValue;

private _supplies = _supplySource getVariable ["para_g_current_supplies", 0];
if (_supplies < _cost) exitWith {
    [format ["Insufficient tower sandbags. Have %1, need %2.", floor (_supplies / _sandbagValue), _costSandbags], _owner] call _notifyFail;
};

private _cooldownSeconds = missionNamespace getVariable ["vn_mf_opfor_static_crew_cooldown", 60];
private _team = _player getVariable ["vn_mf_db_player_group", "DacCong"];
private _teamCooldowns = missionNamespace getVariable ["vn_mf_opfor_static_crew_team_cooldowns", createHashMap];
if !(_teamCooldowns isEqualType createHashMap) then {_teamCooldowns = createHashMap;};
private _cooldownUntil = _teamCooldowns getOrDefault [_team, 0];
if (time < _cooldownUntil) exitWith {
    [format ["Crew Static blocked - cool down remaining: %1s", ceil (_cooldownUntil - time)], _owner] call _notifyFail;
};

private _players = allPlayers select {alive _x && {side _x != east}};
private _blockedAreas = missionNamespace getVariable ["vn_mf_markers_blocked_areas", []];
private _spawnMinDistance = missionNamespace getVariable ["vn_mf_opfor_static_crew_spawn_min_distance", 300];
private _destination = getPos _static;

private _validAttackAngles = [_destination] call para_g_fnc_spawning_valid_attack_angles;
private _tracerDirection = if ((count _validAttackAngles) >= 2) then {
    (_validAttackAngles select 0) + random ((_validAttackAngles select 1) - (_validAttackAngles select 0))
} else {
    random 360
};

private _tracerResult = [_destination, _players, _tracerDirection, _spawnMinDistance] call para_g_fnc_spawning_find_valid_position_tracer;
private _spawnPos = [];
if !(_tracerResult isEqualTo []) then {
    _spawnPos = _tracerResult select 0;
};

if (_spawnPos isEqualTo []) then {
    _spawnPos = [_destination, _spawnMinDistance + 50, 1200, 10, 0, 0.3, 0, _blockedAreas, [_destination, _destination]] call BIS_fnc_findSafePos;
};

if (_spawnPos isEqualTo [] || {(_players findIf {_x distance2D _spawnPos < 200}) > -1}) exitWith {
    ["No safe spawn position found for static crew.", _owner] call _notifyFail;
};

private _crewPool = [
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

private _suppliesDebited = false;
if !([_building, _cost, false] call para_s_fnc_building_consume_supplies) exitWith {
    ["Failed to consume tower supplies.", _owner] call _notifyFail;
};
_suppliesDebited = true;

private _group = [east] call para_g_fnc_create_group;
if (isNull _group) exitWith {
    if (_suppliesDebited) then {
        [_building, -_cost, true] call para_s_fnc_building_consume_supplies;
        _suppliesDebited = false;
    };
    ["Failed to create static crew group.", _owner] call _notifyFail;
};
_group deleteGroupWhenEmpty true;

private _unitClass = selectRandom _crewPool;
private _unit = _group createUnit [_unitClass, _spawnPos, [], 10, "NONE"];
if (isNull _unit) exitWith {
    if (_suppliesDebited) then {
        [_building, -_cost, true] call para_s_fnc_building_consume_supplies;
        _suppliesDebited = false;
    };
    deleteGroup _group;
    ["Failed to create static crew unit.", _owner] call _notifyFail;
};

_teamCooldowns set [_team, time + _cooldownSeconds];
missionNamespace setVariable ["vn_mf_opfor_static_crew_team_cooldowns", _teamCooldowns, true];

_static setVariable ["vn_mf_opfor_static_crew_unit", _unit, true];

private _bodyCleanupLifetime = missionNamespace getVariable ["vn_mf_opfor_support_body_cleanup_time", 300];
_unit setVariable ["vn_mf_opfor_body_cleanup_lifetime", _bodyCleanupLifetime];
_unit addEventHandler ["Killed", {
    params ["_killedUnit"];
    private _static = _killedUnit getVariable ["vn_mf_opfor_static_target", objNull];
    if (!isNull _static && {(_static getVariable ["vn_mf_opfor_static_crew_unit", objNull]) isEqualTo _killedUnit}) then {
        _static setVariable ["vn_mf_opfor_static_crew_unit", objNull, true];
    };
    private _cleanupAfter = _killedUnit getVariable ["vn_mf_opfor_body_cleanup_lifetime", 300];
    [_killedUnit, false, _cleanupAfter] call para_s_fnc_cleanup_add_items;
}];

_unit setVariable ["vn_mf_opfor_static_target", _static];
_unit setSkill 0.5;
_unit setBehaviour "AWARE";
_group setBehaviourStrong "AWARE";
_group setCombatMode "YELLOW";
_group setSpeedMode "FULL";

if (!local _unit) then {
    [[_unit], true] remoteExecCall ["orderGetIn", _unit];
};

_unit assignAsGunner _static;
[_unit] orderGetIn true;
_unit doMove (getPos _static);

[_group, _unit, _static] spawn {
    params ["_group", "_unit", "_static"];
    for "_i" from 0 to 24 do {
        sleep 5;
        if (isNull _unit || {!alive _unit}) exitWith {};
        if (isNull _static || {!alive _static}) exitWith {};
        if ((gunner _static) isEqualTo _unit) exitWith {};

        _unit assignAsGunner _static;
        [_unit] orderGetIn true;
        if (!local _unit) then {
            [[_unit], true] remoteExecCall ["orderGetIn", _unit];
        };
        _unit doMove (getPos _static);
    };

    if (isNull _unit || {!alive _unit}) exitWith {};
    if (isNull _static || {!alive _static}) exitWith {};
    if ((gunner _static) isEqualTo _unit) exitWith {};

    if ((_static getVariable ["vn_mf_opfor_static_crew_unit", objNull]) isEqualTo _unit) then {
        _static setVariable ["vn_mf_opfor_static_crew_unit", objNull, true];
    };
};

[format ["Static crew en route. Cost: %1 sandbags.", _costSandbags], _owner] call _notifyOk;
