// functions/core/ui/spawnHelpMarkers/fn_spawnHelpMarkers_enable.sqf
if (!hasInterface) exitWith {};
if (!isNil "vn_mf_spawn_help_markerEH") exitWith {};

// load + build
call compile preprocessFileLineNumbers "functions\core\spawn_help_markers_config.sqf";
[] call vn_mf_fnc_spawnHelpMarkers_buildRegistry;

// add EH
vn_mf_spawn_help_markerEH = addMissionEventHandler ["Draw3D", {
  {
    _x params ["_pos","_title","_sub","_z","_radius","_obj"];
    if (!isNull _obj) then {
      if (player distance _obj < _radius) then {
        [_obj modelToWorld [0,0,_z], _title, _sub] call vn_mf_fnc_spawnHelpMarkers_drawPlaque3D;
      };
    } else {
      if (player distance _pos < _radius) then {
        private _p = +_pos; _p set [2, (_p select 2) + _z];
        [_p, _title, _sub] call vn_mf_fnc_spawnHelpMarkers_drawPlaque3D;
      };
    };
  } forEach (missionNamespace getVariable ["vn_mf_spawn_help_markerRegistry", []]);
}];

// late retry once in case some objects spawn later
[] spawn {
  uiSleep 5;
  [] call vn_mf_fnc_spawnHelpMarkers_buildRegistry;
};
