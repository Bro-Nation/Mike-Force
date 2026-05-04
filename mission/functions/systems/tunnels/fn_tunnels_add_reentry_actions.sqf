/*
    File: fn_tunnels_add_reentry_actions.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds re-entry actions to tunnel reentry point objects.
        Players who fall out of the tunnel can use these to teleport back to the nearest objective.

    Parameter(s):
        _reentryPoints - Array of Land_vn_infostand_v2_f objects [ARRAY]

    Returns:
        Nothing

    Example(s):
        [_reentryPoints] call vn_mf_fnc_tunnels_add_reentry_actions
*/

params ["_reentryPoints"];

{
    private _jipId = format ["tunnelReentry_%1", netId _x];
    
    [
        _x,
        "<t color='#ff8800'>Re-enter Tunnel</t>",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",
        "player distance _target < 5",
        "player distance _target < 5",
        {},
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
            private _objectives = missionNamespace getVariable ["vn_mf_tunnel_objectives", []];
            if (_objectives isEqualTo []) exitWith { hint "No tunnel objectives found."; };

            private _closest = objNull;
            private _closestDist = 9999999;
            {
                private _dist = _caller distance _x;
                if (_dist < _closestDist) then {
                    _closest = _x;
                    _closestDist = _dist;
                };
            } forEach _objectives;

            if (isNull _closest) exitWith { hint "No tunnel entry point found."; };
            
            _caller setPosATL (getPosATL _closest);
            hint "Teleported back into tunnel.";
        },
        {},
        [],
        1,
        100,
        true,
        false
    ] remoteExec ["BIS_fnc_holdActionAdd", 0, _jipId];
} forEach _reentryPoints;
