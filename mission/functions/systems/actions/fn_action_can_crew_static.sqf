/*
    File: fn_action_can_crew_static.sqf
    Author: Legend
    Public: No

    Description:
        Returns true when the OPFOR "Crew Static" action should be visible.

    Parameter(s):
        _player - Player evaluating the action [Object]
        _target - Target static weapon [Object]
        _withReason - Return [Bool, String] instead of Bool [Bool, defaults false]

    Returns:
        Bool or [Bool, String]
*/

params ["_player", "_target", ["_withReason", false]];

private _result = {
    params ["_ok", ["_msg", ""]];
    if (_withReason) exitWith {[_ok, _msg]};
    _ok
};

if (isNull _player || {isNull _target}) exitWith {[false, "Invalid player or target."] call _result};
if ((_player getVariable ["vn_mf_db_player_group", "MikeForce"]) isNotEqualTo "DacCong") exitWith {[false, "Only OPFOR can crew statics."] call _result};
if (!alive _target || {!(_target isKindOf "StaticWeapon")}) exitWith {[false, "Target must be a live static weapon."] call _result};
if (vehicle _player isNotEqualTo _player) exitWith {[false, "Exit your vehicle before using Crew Static."] call _result};
if ((_player distance _target) > 6) exitWith {[false, "Move closer to the static to request a crewman."] call _result};
if (missionNamespace getVariable ["vn_mf_coms_tower_destroyed_in_ao", false]) exitWith {[false, "Coms tower destroyed in this AO. Static crews are locked until next AO."] call _result};
private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
private _aoMarker = _activeZones param [0, ""];
if !(_aoMarker in allMapMarkers) exitWith {[false, "No active AO found."] call _result};

private _assignedUnit = _target getVariable ["vn_mf_opfor_static_crew_unit", objNull];
if (!isNull _assignedUnit && {alive _assignedUnit}) exitWith {[false, "This static already has an assigned crewman."] call _result};
if (!isNull gunner _target && {alive gunner _target}) exitWith {[false, "This static is already crewed."] call _result};

private _aoCenter = markerPos _aoMarker;
private _aoRadius = getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100;

private _functionalTowers = (nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f"], _aoRadius, true]) select {
    private _building = _x getVariable ["para_g_building", objNull];
    alive _x && {!isNull _building} && {_building getVariable ["para_g_building_constructed", false]}
};
if (_functionalTowers isEqualTo []) exitWith {[false, "Coms tower is not fully built yet."] call _result};

private _tower = _functionalTowers select 0;
private _building = _tower getVariable ["para_g_building", objNull];
if (isNull _building) exitWith {[false, "Coms tower data unavailable."] call _result};

private _supplySource = _building getVariable ["para_g_current_supply_source", objNull];
if (isNull _supplySource) exitWith {[false, "Coms tower supply source unavailable."] call _result};

private _sandbagValue = ["building_sandbag_value", 10] call BIS_fnc_getParamValue;
if (_sandbagValue <= 0) then {_sandbagValue = 10;};
private _costSandbags = missionNamespace getVariable ["vn_mf_opfor_static_crew_cost_sandbags", 5];
private _cost = _costSandbags * _sandbagValue;
if ((_supplySource getVariable ["para_g_current_supplies", 0]) < _cost) exitWith {
    [false, format ["Insufficient tower sandbags. Need %1 sandbags for static crew.", _costSandbags]] call _result
};

private _cooldown = missionNamespace getVariable ["vn_mf_opfor_static_crew_cooldown", 60];
private _team = _player getVariable ["vn_mf_db_player_group", "DacCong"];
private _teamCooldowns = missionNamespace getVariable ["vn_mf_opfor_static_crew_team_cooldowns", createHashMap];
if !(_teamCooldowns isEqualType createHashMap) then {_teamCooldowns = createHashMap;};
private _cooldownUntil = _teamCooldowns getOrDefault [_team, 0];
if (time < _cooldownUntil) exitWith {
    [false, format ["Crew Static blocked - cool down remaining: %1s", ceil (_cooldownUntil - time)]] call _result
};

[true, ""] call _result
