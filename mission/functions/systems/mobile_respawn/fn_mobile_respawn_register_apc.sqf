/*
    File: fn_mobile_respawn_register_apc.sqf
    Author: tylervip
    Public: yes

    Description:
        Registers an M577 APC as a player respawn point.
        Creates a map marker at the APC's position, registers it as a
        respawn position for west and independent sides, stocks the APC
        with initial food supplies, and adds an onPlayerRespawn event
        handler that consumes food on each use. If food runs out the
        respawn point is automatically unregistered.

    Parameter(s):
        _vehicle - The M577 APC to register [OBJECT]

    Returns:
        Nothing

    Example(s):
        [myAPC] call vn_mf_fnc_mobile_respawn_register_apc
*/

if (!isServer) exitWith {};

params ["_vehicle"];

// Guard - already registered
if !(_vehicle getVariable ["vn_mf_m577_respawn_id", []] isEqualTo []) exitWith {
    diag_log "VN MikeForce: [mobile_respawn] Attempt to re-register APC that is already registered";
};

// Create a unique marker at the APC's current position
private _markerName = format ["vn_mf_m577_respawn_%1", netId _vehicle];
private _marker = createMarker [_markerName, getPos _vehicle];
_marker setMarkerAlpha 0;

_vehicle setVariable ["vn_mf_m577_respawn_marker", _markerName, true];

// Register as a respawn position for both sides
private _respawnId = [west, _markerName, "M577 Command Post"] call BIS_fnc_addRespawnPosition;
[independent, _markerName, "M577 Command Post"] call BIS_fnc_addRespawnPosition;

_vehicle setVariable ["vn_mf_m577_respawn_id", _respawnId, true];

// Clean up respawn immediately if this vehicle gets deleted/replaced
private _deletedEhId = _vehicle addEventHandler ["Deleted", {
    params ["_entity"];
    [_entity] call vn_mf_fnc_mobile_respawn_unregister_apc;
}];
_vehicle setVariable ["vn_mf_m577_respawn_deleted_eh", _deletedEhId, true];

// Add respawn event handler — consume food on each use, unregister if empty
private _handler = ["onPlayerRespawn", [{
    params ["_handlerParams", "_eventParams"];
    _handlerParams params ["_vehicle", "_markerName"];
    _eventParams params ["_player", "_identity"];

    if (_identity isEqualTo _markerName) then {
        private _hadFood = [_vehicle] call vn_mf_fnc_mobile_respawn_consume;
        if (!_hadFood) then {
            diag_log format ["VN MikeForce: [mobile_respawn] No food remaining at APC %1 - unregistering respawn", netId _vehicle];
            [_vehicle] call vn_mf_fnc_mobile_respawn_unregister_apc;
        };
    };
}, [_vehicle, _markerName]]] call para_g_fnc_event_add_handler;

_vehicle setVariable ["vn_mf_m577_respawn_handler", _handler, true];

diag_log format ["VN MikeForce: [mobile_respawn] Registered APC %1 at marker %2", netId _vehicle, _markerName];
