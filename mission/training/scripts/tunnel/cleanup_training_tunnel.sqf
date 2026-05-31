/*
    File: cleanup_training_tunnel.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Removes the currently tracked training tunnel instance, if present.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\tunnel\cleanup_training_tunnel.sqf"
*/

if (!isServer) exitWith {};

private _closedTunnel = missionNamespace getVariable ["vn_mf_training_tunnel_closed", objNull];
private _openTunnel = missionNamespace getVariable ["vn_mf_training_tunnel_open", objNull];
private _objectiveObject = missionNamespace getVariable ["vn_mf_training_tunnel_objective_obj", objNull];

private _fnc_removeJipAction = {
    params ["_object", "_varName"];
    private _jipId = _object getVariable [_varName, ""];
    if (_jipId != "") then {
        remoteExec ["", _jipId];
    };
    _object setVariable [_varName, nil, true];
};

if (!isNull _openTunnel) then {
    private _exitTeleport = _openTunnel getVariable ["exitTeleport_training", objNull];

    // Eject nearby players before teardown so nobody gets stranded in tunnel space.
    if (!isNull _exitTeleport) then {
        private _exitPos = _exitTeleport getVariable ["exitPosition_training", getPosATL _openTunnel];
        {
            if (isPlayer _x && {_x distance2D _exitTeleport < 20}) then {
                [_exitPos] remoteExecCall ["vn_mf_fnc_tunnels_eject_player_client", _x];
            };
        } forEach allPlayers;

        _exitTeleport setVariable ["tunnelActive_training", false, true];

        [_exitTeleport, "exitJipId_training"] call _fnc_removeJipAction;
        _exitTeleport setVariable ["linkedTunnel_training", nil, true];
        _exitTeleport setVariable ["exitPosition_training", nil, true];
    };

    [_openTunnel, "enterJipId_training"] call _fnc_removeJipAction;
    _openTunnel setVariable ["exitTeleport_training", nil, true];
    _openTunnel setVariable ["linkedClosedTunnel_training", nil, true];
};

if (!isNull _closedTunnel) then {
    [_closedTunnel, "wiresJipId_training"] call _fnc_removeJipAction;
    [_closedTunnel, "openJipId_training"] call _fnc_removeJipAction;
    [_closedTunnel, "disableTrapJipId_training"] call _fnc_removeJipAction;
    _closedTunnel setVariable ["linkedOpenTunnel_training", nil, true];
    _closedTunnel setVariable ["trapActive_training", nil, true];
    _closedTunnel setVariable ["trapChecked_training", nil, true];
};

if (!isNull _objectiveObject) then { deleteVehicle _objectiveObject; };
if (!isNull _closedTunnel) then { deleteVehicle _closedTunnel; };
if (!isNull _openTunnel) then { deleteVehicle _openTunnel; };

missionNamespace setVariable ["vn_mf_training_tunnel_closed", objNull, true];
missionNamespace setVariable ["vn_mf_training_tunnel_open", objNull, true];
missionNamespace setVariable ["vn_mf_training_tunnel_objective_obj", objNull, true];
