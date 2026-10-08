/*
    File: fn_supporttaskcreate.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Creates support tasks.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!

    Parameter(s):
		_taskClass - Task classname [String]
		_coords - Coordinates [Position]
		_teamToTarget - Targeted team [Group]

    Returns: nothing

    Example(s): none
*/

params ["_taskClass", "_coords", "_teamToTarget"];

private _taskCfg = missionConfigFile >> "gamemode" >> "tasks" >> _taskClass;
if !(isClass _taskCfg) exitWith {
  diag_log format ["[SUPPORT TASK] rejected: task class missing class=%1", _taskClass];
};

private _opforSupportTaskClasses = [
  "support_opfor_foot_squad", "support_opfor_foot_unit", "support_opfor_foot_battalion",
  "support_opfor_armor_single", "support_opfor_armor_duo", "support_opfor_armor_column",
  "support_opfor_rotary_single", "support_opfor_rotary_section", "support_opfor_rotary_flight",
  "support_opfor_fixed_single", "support_opfor_fixed_element", "support_opfor_fixed_squadron",
  "support_opfor_strella_support"
];
private _isOpforSupportTaskClass = _taskClass in _opforSupportTaskClasses;
private _taskCreationFunction = getText (_taskCfg >> "creationfunction");

if (_isOpforSupportTaskClass && {_taskCreationFunction isNotEqualTo "vn_mf_fnc_create_support_opfor_troops"}) exitWith {
  diag_log format ["[SUPPORT TASK] rejected: OPFOR class resolved to unexpected function class=%1 fn=%2", _taskClass, _taskCreationFunction];
};
if (!_isOpforSupportTaskClass && {_taskCreationFunction isEqualTo "vn_mf_fnc_create_support_opfor_troops"}) exitWith {
  diag_log format ["[SUPPORT TASK] rejected: non-whitelisted class attempted OPFOR creation class=%1", _taskClass];
};

if (_isOpforSupportTaskClass && {
  isNull _player || {!isPlayer _player} || {!alive _player} || {(allPlayers find _player) < 0}
}) exitWith {
  diag_log format ["[SUPPORT TASK] rejected: invalid requester for OPFOR support class=%1", _taskClass];
};

if (_isOpforSupportTaskClass && {
  (_player getVariable ["vn_mf_db_player_group", ""]) isNotEqualTo "DacCong"
}) exitWith {
  private _requestGroup = _player getVariable ["vn_mf_db_player_group", ""];
  diag_log format [
    "[SUPPORT TASK] rejected: requester not DacCong player=%1 uid=%2 group=%3 class=%4",
    name _player,
    getPlayerUID _player,
    _requestGroup,
    _taskClass
  ];
};

diag_log format [
  "[SUPPORT TASK] request received: player=%1 uid=%2 class=%3 coords=%4 target=%5",
  if (isNull _player) then {"<null>"} else {name _player},
  if (isNull _player) then {"<null>"} else {getPlayerUID _player},
  _taskClass,
  _coords,
  _teamToTarget
];

diag_log format ["[SUPPORT TASK] creation function config lookup: class=%1 fn=%2", _taskClass, _taskCreationFunction];

private _creationCode = missionNamespace getVariable [_taskCreationFunction, "__MISSING__"];
diag_log format ["[SUPPORT TASK] creation function namespace lookup: fn=%1 type=%2", _taskCreationFunction, typeName _creationCode];

private _isOpforSupport = (_taskCreationFunction isEqualTo "vn_mf_fnc_create_support_opfor_troops");

if (_creationCode isEqualTo "__MISSING__") exitWith {
  diag_log format ["[SUPPORT TASK] creation function lookup failed: %1", _taskCreationFunction];
};

if !(_creationCode isEqualType {}) exitWith {
  diag_log format ["[SUPPORT TASK] creation function resolved to non-code: %1 -> %2", _taskCreationFunction, typeName _creationCode];
};

if (_isOpforSupport) then {
  // Force execution from the mission file to avoid stale namespace bindings.
  // Arma file loading APIs here require mission-relative paths.
  private _opforCreationPath = "functions\tasks\task_creation\fn_create_support_opfor_troops.sqf";
  private _directOpforSource = preprocessFileLineNumbers _opforCreationPath;

  if (_directOpforSource isEqualTo "") then {
    diag_log format ["[SUPPORT TASK] direct-file OPFOR fallback source empty/missing: %1", _opforCreationPath];
  } else {
    private _directOpforCode = compileFinal _directOpforSource;
    if (_directOpforCode isEqualType {}) then {
      _creationCode = _directOpforCode;
      diag_log format ["[SUPPORT TASK] using direct-file OPFOR creation code fallback path=%1", _opforCreationPath];
    } else {
      diag_log format ["[SUPPORT TASK] direct-file OPFOR fallback compile returned non-code path=%1 type=%2", _opforCreationPath, typeName _directOpforCode];
    };
  };
};

diag_log format [
  "[SUPPORT TASK] invoking creation function: fn=%1 player=%2 uid=%3 class=%4 coords=%5 target=%6",
  _taskCreationFunction,
  if (isNull _player) then {"<null>"} else {name _player},
  if (isNull _player) then {"<null>"} else {getPlayerUID _player},
  _taskClass,
  _coords,
  _teamToTarget
];

try {
  if (_isOpforSupport) then {
    [_taskClass, _player, _coords, _teamToTarget] spawn _creationCode;
    diag_log format ["[SUPPORT TASK] OPFOR creation function spawned (scheduled): fn=%1", _taskCreationFunction];
  } else {
    [_taskClass, _player, _coords, _teamToTarget] call _creationCode;
    diag_log format ["[SUPPORT TASK] creation function returned normally: fn=%1", _taskCreationFunction];
  };
} catch {
  diag_log format ["[SUPPORT TASK] creation function exception: fn=%1 exception=%2", _taskCreationFunction, _exception];
};
