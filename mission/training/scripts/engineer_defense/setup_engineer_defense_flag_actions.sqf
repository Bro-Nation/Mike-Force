/*
    File: setup_engineer_defense_flag_actions.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Finds a valid flag in marker Engineer and assigns START/STOP engineer defense actions to that flag.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\engineer_defense\setup_engineer_defense_flag_actions.sqf"
*/

private _markerName = "Engineer";
private _allowedFlagClasses = ["vn_flag_pavn", "vn_flag_usa", "vn_flag_aus", "vn_flag_nz", "vn_flag_arvn"];

if (!isServer) exitWith {
    [[], {
        [] execVM "training\scripts\engineer_defense\setup_engineer_defense_flag_actions.sqf";
    }] remoteExecCall ["BIS_fnc_call", 2];
};

if !(markerShape _markerName in ["RECTANGLE", "ELLIPSE"]) exitWith {
    ["Engineer defense marker 'Engineer' is missing or invalid."] remoteExecCall ["systemChat", 0];
};

private _markerPos = getMarkerPos _markerName;
private _markerSize = getMarkerSize _markerName;
private _maxSearchRadius = ((_markerSize select 0) max (_markerSize select 1)) + 25;

private _candidateFlags = nearestObjects [
    [_markerPos select 0, _markerPos select 1],
    _allowedFlagClasses,
    _maxSearchRadius
] select {alive _x && {_x inArea _markerName}};

if (_candidateFlags isEqualTo []) exitWith {
    ["No valid flag found in Engineer area. Place a flag first."] remoteExecCall ["systemChat", 0];
};

private _flagsWithDistance = _candidateFlags apply {
    [_x distance2D _markerPos, _x]
};
_flagsWithDistance sort true;

private _targetFlag = (_flagsWithDistance # 0) # 1;
private _oldFlag = missionNamespace getVariable ["vn_mf_training_engineer_defense_control_flag", objNull];
private _oldJipId = missionNamespace getVariable ["vn_mf_training_engineer_defense_flag_actions_jip", ""];

if (_oldJipId != "") then {
    remoteExec ["", _oldJipId];
};

if (!isNull _oldFlag) then {
    [[_oldFlag], {
        params ["_flag"];

        if (!hasInterface || {isNull _flag}) exitWith {};

        private _startId = _flag getVariable ["vn_mf_training_engineer_defense_start_action_id", -1];
        if (_startId >= 0) then {
            _flag removeAction _startId;
        };

        private _stopId = _flag getVariable ["vn_mf_training_engineer_defense_stop_action_id", -1];
        if (_stopId >= 0) then {
            _flag removeAction _stopId;
        };

        _flag setVariable ["vn_mf_training_engineer_defense_start_action_id", nil];
        _flag setVariable ["vn_mf_training_engineer_defense_stop_action_id", nil];
    }] remoteExecCall ["BIS_fnc_call", 0];
};

private _jipId = format ["engineer_defense_flag_actions_%1", netId _targetFlag];
missionNamespace setVariable ["vn_mf_training_engineer_defense_control_flag", _targetFlag, true];
missionNamespace setVariable ["vn_mf_training_engineer_defense_flag_actions_jip", _jipId, true];

[[_targetFlag], {
    params ["_flag"];

    if (!hasInterface || {isNull _flag}) exitWith {};

    private _existingStart = _flag getVariable ["vn_mf_training_engineer_defense_start_action_id", -1];
    if (_existingStart >= 0) then {
        _flag removeAction _existingStart;
    };

    private _existingStop = _flag getVariable ["vn_mf_training_engineer_defense_stop_action_id", -1];
    if (_existingStop >= 0) then {
        _flag removeAction _existingStop;
    };

    private _startId = _flag addAction ["START ENGINEER DEFENSE", {
        0 = [] execVM "training\scripts\engineer_defense\start_engineer_defense.sqf";
    }, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team) && !(missionNamespace getVariable ['vn_mf_training_engineer_defense_active', false])"];

    private _stopId = _flag addAction ["STOP ENGINEER DEFENSE", {
        0 = [] execVM "training\scripts\engineer_defense\stop_engineer_defense.sqf";
    }, 0, 5, true, true, "", "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team) && (missionNamespace getVariable ['vn_mf_training_engineer_defense_active', false])"];

    _flag setVariable ["vn_mf_training_engineer_defense_start_action_id", _startId];
    _flag setVariable ["vn_mf_training_engineer_defense_stop_action_id", _stopId];
}] remoteExecCall ["BIS_fnc_call", 0, _jipId];

["Engineer defense flag actions are now active on the selected flag."] remoteExecCall ["systemChat", 0];
