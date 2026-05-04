/*
    File: fn_tunnels_cleanup_ai.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Cleans up all spawned tunnel AI units and their groups.
        Should be called when the AO ends or during teardown.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        call vn_mf_fnc_tunnels_cleanup_ai
*/

if (!isServer) exitWith {};

private _tunnelAiUnits = missionNamespace getVariable ["vn_mf_tunnel_ai_units", []];
{
    if (!isNull _x) then {
        private _group = group _x;
        deleteVehicle _x;
        if (count units _group == 0) then {
            deleteGroup _group;
        };
    };
} forEach _tunnelAiUnits;
missionNamespace setVariable ["vn_mf_tunnel_ai_units", [], true];
