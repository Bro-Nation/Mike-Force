/*
    File: cleanup_training_underwater_wreck.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Removes the currently tracked training underwater wreck sites, if present.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\underwater_wreck\cleanup_training_underwater_wreck.sqf"
*/

if (!isServer) exitWith {};

private _siteStores = missionNamespace getVariable ["vn_mf_training_underwater_wreck_sites", []];

{
    if (!isNull _x) then {
        [_x] call vn_mf_fnc_sites_teardown_site;
    };
} forEach _siteStores;

missionNamespace setVariable ["vn_mf_training_underwater_wreck_sites", [], true];
