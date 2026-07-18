/*
    File: fn_daccong_add_teleport_actions.sqf
    Author: Tylervip
    Public: No

    Description:
        Adds DAC Cong-only teleport actions to the local player.
        Actions are shown when the player looks at editor-placed objects
        whose variable names match the expected prefixes.

    Parameter(s): none

    Returns:
        Nothing

    Example(s):
        call vn_mf_fnc_daccong_add_teleport_actions;
*/

private _tunnelSpawnObjectName = "mf_dc_spawnpoint_daccong_aotunnel";
private _powCampMarker = "mf_dc_respawn_daccong_powcamp";

[
    player,
    "<t color='#ffaa00'>Teleport to Tunnel</t>",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
    "(player getVariable ['vn_mf_side', side group player]) == EAST && {vehicle player isEqualTo player} && {!isNull cursorObject} && {player distance cursorObject < 5} && {(vehicleVarName cursorObject) find 'dacTunnelRespawnAction_' == 0}",
    "!isNull cursorObject && {player distance cursorObject < 5} && {(vehicleVarName cursorObject) find 'dacTunnelRespawnAction_' == 0}",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];

        _arguments params ["_spawnObjectName", "_successHint"];

        private _exitTeleport = missionNamespace getVariable [_spawnObjectName, objNull];

        _caller setPosATL (getPosATL _exitTeleport vectorAdd [0,0,1]);
        _caller setUnitFreefallHeight 32000;
        _caller setVariable ["inTunnel", true, true];
        hint _successHint;
    },
    {},
    [_tunnelSpawnObjectName, "Teleported to tunnel spawn."],
    .1,
    100,
    false,
    false
] call BIS_fnc_holdActionAdd;

[
    player,
    "<t color='#ffaa00'>Teleport to POW Camp</t>",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
    "(player getVariable ['vn_mf_side', side group player]) == EAST && {vehicle player isEqualTo player} && {!isNull cursorObject} && {player distance cursorObject < 5} && {(vehicleVarName cursorObject) find 'dacPowCampRespawnAction_' == 0}",
    "!isNull cursorObject && {player distance cursorObject < 5} && {(vehicleVarName cursorObject) find 'dacPowCampRespawnAction_' == 0}",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];

        _arguments params ["_destinationMarker", "_missingMarkerHint", "_successHint"];

        private _destinationPos = markerPos _destinationMarker;
        if (_destinationPos isEqualTo [0, 0, 0]) exitWith { hint _missingMarkerHint; };

        _caller setPosASL _destinationPos;
        _caller setUnitFreefallHeight 100;
        _caller setVariable ["inTunnel", false, true];
        hint _successHint;
    },
    {},
    [_powCampMarker, "POW camp respawn marker not found.", "Teleported to POW camp respawn."],
    .1,
    100,
    false,
    false
] call BIS_fnc_holdActionAdd;
