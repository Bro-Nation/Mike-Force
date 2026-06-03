/*
    File: cleanup_training_water_supply.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Removes the currently tracked training water supply sites, if present.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\water_supply\cleanup_training_water_supply.sqf"
*/

if (!isServer) exitWith {};

private _siteStores = missionNamespace getVariable ["vn_mf_training_water_supply_sites", []];
private _legacySiteStore = missionNamespace getVariable ["vn_mf_training_water_supply_site", objNull];

{
    if (!isNull _x) then {
        [_x] call vn_mf_fnc_sites_teardown_site;
    };
} forEach _siteStores;

if (!isNull _legacySiteStore) then {
    [_legacySiteStore] call vn_mf_fnc_sites_teardown_site;
};

missionNamespace setVariable ["vn_mf_training_water_supply_sites", [], true];
missionNamespace setVariable ["vn_mf_training_water_supply_site", objNull, true];
