/*
    File: fn_tunnels_get_available_teleport.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Returns an available (unused) tunnel teleport point and marks it as used.

    Parameter(s):
        None

    Returns:
        A teleport object, or objNull if none available [OBJECT]

    Example(s):
        private _teleport = call vn_mf_fnc_tunnels_get_available_teleport
*/

private _allTeleports = missionNamespace getVariable ["vn_mf_tunnel_teleports", []];
private _usedTeleports = missionNamespace getVariable ["vn_mf_used_tunnel_teleports", []];

private _available = _allTeleports select { !(_x in _usedTeleports) };

if (_available isEqualTo []) exitWith { objNull };

private _selected = _available select 0;
_usedTeleports pushBack _selected;
missionNamespace setVariable ["vn_mf_used_tunnel_teleports", _usedTeleports, true];

_selected
