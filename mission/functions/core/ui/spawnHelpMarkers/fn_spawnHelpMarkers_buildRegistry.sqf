/*
  Build registry from a mixed list where each name can be:
    - an object variable name
  Stores: [posATL, titleKey, subKey, z, radius, objOrNull]
*/
if (!hasInterface) exitWith {};

private _cfg = missionNamespace getVariable ["vn_mf_spawn_help_marker_cfg", []];
private _reg = [];

{
  _x params ["_name","_title","_sub","_z","_radius"];

  private _obj = missionNamespace getVariable [_name, objNull];
  private _pos = [0,0,0];

  if (!isNull _obj) then {
    // object var name
    _pos = getPosATL _obj;
  } else {
    // try marker
    private _mp = getMarkerPos _name;
    if (!(_mp isEqualTo [0,0,0])) then { _pos = _mp; };
  };

  if (!(_pos isEqualTo [0,0,0])) then {
    _reg pushBack [_pos, _title, _sub, _z, _radius, _obj];
  } else {
    diag_log format ["[SpawnHelp] Skipped '%1' (no object or marker found).", _name];
  };
} forEach _cfg;

missionNamespace setVariable ["vn_mf_spawn_help_markerRegistry", _reg];
diag_log format ["[SpawnHelp] Registry entries: %1", count _reg];
