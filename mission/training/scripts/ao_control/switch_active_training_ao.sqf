/*
    File: switch_active_training_ao.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Switches the currently active AO to a specific zone marker.
        Runs server-side and is intended for training/admin console actions.

    Parameter(s):
        _zoneMarker - Zone marker name [STRING]

    Returns:
        Nothing

    Example(s):
        ["zone_tam_pep"] execVM "training\scripts\ao_control\switch_active_training_ao.sqf"
*/

params [["_zoneMarker", "", [""]]];

if (_zoneMarker isEqualTo "") exitWith {};

if (!isServer) exitWith {
    [[_zoneMarker], {
        params ["_serverZoneMarker"];
        [_serverZoneMarker] execVM "training\scripts\ao_control\switch_active_training_ao.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

if (isNil "mf_s_zone_markers" || isNil "mf_s_dir_activeZones") exitWith {
    ["WARNING", "AO switch aborted: zone system or director not initialized yet."] call para_g_fnc_log;
};

if (isNil "vn_site_objects") then {
    vn_site_objects = [];
};

if !(_zoneMarker in mf_s_zone_markers) exitWith {
    ["WARNING", format ["AO switch aborted: zone '%1' is not a valid zone marker.", _zoneMarker]] call para_g_fnc_log;
};

if (_zoneMarker in keys mf_s_dir_activeZones) exitWith {
    ["INFO", format ["AO switch ignored: zone '%1' is already active.", _zoneMarker]] call para_g_fnc_log;
};

private _activeZoneNames = +keys mf_s_dir_activeZones;

{
    private _zoneName = _x;
    private _zoneInfo = mf_s_dir_activeZones getOrDefault [_zoneName, createHashMap];
    private _taskDataStore = _zoneInfo getOrDefault ["currentTask", objNull];

    if (!isNull _taskDataStore) then {
        [_taskDataStore, "CANCELED"] call vn_mf_fnc_task_complete;
    };

    mf_s_dir_activeZones deleteAt _zoneName;
} forEach _activeZoneNames;

// Cleanup any AO-scoped site artifacts from the previous active zone.
call vn_mf_fnc_daccong_respawns_delete_all;
call vn_mf_fnc_tunnels_eject_players;

{
    if (!isNull _x && {_x getVariable ["exitTeleport", objNull] isNotEqualTo objNull}) then {
        [_x] call vn_mf_fnc_tunnels_unregister_tunnel;
    };
} forEach vn_site_objects;

call vn_mf_fnc_tunnels_cleanup_ai;

{
    if (!isNull _x) then {
        deleteVehicle _x;
    };
} forEach vn_site_objects;

vn_site_objects = [];

["INFO", format ["AO switch requested. Activating zone '%1'.", _zoneMarker]] call para_g_fnc_log;
[_zoneMarker] call vn_mf_fnc_director_open_zone;

mf_g_dir_activeZoneNames = keys mf_s_dir_activeZones;
publicVariable "mf_g_dir_activeZoneNames";
