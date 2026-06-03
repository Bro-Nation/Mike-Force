/*
    File: spawn_training_water_supply.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Spawns fresh training water supply sites at all markers named
        training_water_supply_0, training_water_supply_1, and so on.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\water_supply\spawn_training_water_supply.sqf"
*/

if (!isServer) exitWith {};

private _createTrainingWaterSupplySite = compile preprocessFileLineNumbers "training\scripts\water_supply\create_training_water_supply_site.sqf";

private _markers = allMapMarkers select {
    _x find "training_water_supply_" == 0
};

if (_markers isEqualTo []) exitWith {
    systemChat "Training water supply: missing marker(s) training_water_supply_0, training_water_supply_1, training_water_supply_2, training_water_supply_3.";
};

_markers sort true;

private _spawnedSites = [];

{
    private _spawnPos = markerPos _x;
    private _siteStore = [_spawnPos] call _createTrainingWaterSupplySite;
    _spawnedSites pushBack _siteStore;
} forEach _markers;

missionNamespace setVariable ["vn_mf_training_water_supply_sites", _spawnedSites, true];
