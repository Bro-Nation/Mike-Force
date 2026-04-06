/*
    File: fn_tunnels_get_available_objective.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Returns an available (unused) tunnel objective spawn point and marks it as used.

    Parameter(s):
        None

    Returns:
        An objective object, or objNull if none available [OBJECT]

    Example(s):
        private _objective = call vn_mf_fnc_tunnels_get_available_objective
*/

private _allObjectives = missionNamespace getVariable ["vn_mf_tunnel_objectives", []];
private _usedObjectives = missionNamespace getVariable ["vn_mf_used_tunnel_objectives", []];

private _available = _allObjectives select { !(_x in _usedObjectives) };

if (_available isEqualTo []) exitWith { objNull };

private _selected = selectRandom _available;
_usedObjectives pushBack _selected;
missionNamespace setVariable ["vn_mf_used_tunnel_objectives", _usedObjectives, true];

_selected
