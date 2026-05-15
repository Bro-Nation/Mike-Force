/*
    File: fn_mobile_respawn_unregister_apc.sqf
    Author: tylervip
    Public: yes

    Description:
        Removes an M577 APC as a player respawn point.
        Cleans up the marker, respawn position registration, and event handler.

    Parameter(s):
        _vehicle - The M577 APC to unregister [OBJECT]

    Returns:
        Nothing

    Example(s):
        [myAPC] call vn_mf_fnc_mobile_respawn_unregister_apc
*/

if (!isServer) exitWith {};

params ["_vehicle"];

// Guard - skip if not registered
if (_vehicle getVariable ["vn_mf_m577_respawn_id", []] isEqualTo []) exitWith {
    diag_log "VN MikeForce: [mobile_respawn] Attempt to unregister APC that is not registered";
};

// Remove respawn position
(_vehicle getVariable "vn_mf_m577_respawn_id") call BIS_fnc_removeRespawnPosition;

// Delete map marker
deleteMarker (_vehicle getVariable "vn_mf_m577_respawn_marker");

// Remove onPlayerRespawn event handler
["onPlayerRespawn", _vehicle getVariable "vn_mf_m577_respawn_handler"] call para_g_fnc_event_remove_handler;

// Remove Deleted event handler
private _deletedEhId = _vehicle getVariable ["vn_mf_m577_respawn_deleted_eh", -1];
if (_deletedEhId >= 0) then {
    _vehicle removeEventHandler ["Deleted", _deletedEhId];
};

// Clear all tracking variables
_vehicle setVariable ["vn_mf_m577_respawn_id",      [], true];
_vehicle setVariable ["vn_mf_m577_respawn_marker",  nil, true];
_vehicle setVariable ["vn_mf_m577_respawn_handler", nil, true];
_vehicle setVariable ["vn_mf_m577_respawn_deleted_eh", -1, true];
