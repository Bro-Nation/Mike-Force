/*
    File: fn_tunnels_get_teleports.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Returns the cached tunnel teleport objects.

    Parameter(s):
        None

    Returns:
        Array of teleport objects [ARRAY]

    Example(s):
        private _teleports = call vn_mf_fnc_tunnels_get_teleports
*/

missionNamespace getVariable ["vn_mf_tunnel_teleports", []]
