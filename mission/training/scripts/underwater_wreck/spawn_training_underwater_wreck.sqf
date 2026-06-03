/*
    File: spawn_training_underwater_wreck.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Spawns a fresh training underwater wreck site at marker
        training_underwater_wreck.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\underwater_wreck\spawn_training_underwater_wreck.sqf"
*/

if (!isServer) exitWith {};

private _createTrainingUnderwaterWreckSite = compile preprocessFileLineNumbers "training\scripts\underwater_wreck\create_training_underwater_wreck_site.sqf";

if !("training_underwater_wreck" in allMapMarkers) exitWith {
    systemChat "Training underwater wreck: missing marker training_underwater_wreck.";
};

private _spawnPos = markerPos "training_underwater_wreck";
private _siteStore = [_spawnPos] call _createTrainingUnderwaterWreckSite;
private _spawnedSites = [_siteStore];

missionNamespace setVariable ["vn_mf_training_underwater_wreck_sites", _spawnedSites, true];
