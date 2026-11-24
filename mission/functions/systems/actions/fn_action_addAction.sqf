/*
    File: fn_action_addAction.sqf
    Author: Tylervip
    Public: No

    Description:
        Adds a standard action once for a logical key on a target. If the same
        key is registered again, its previous action is removed first.

    Parameters:
        _target - Object or player the action is attached to [OBJECT]
        _actionKey - Unique key for this action on the target [STRING]
        ... - Standard addAction arguments

    Returns:
        Action id [NUMBER]
*/

params [
    "_target",
    "_actionKey",
    "_title",
    "_script",
    ["_arguments", []],
    ["_priority", 1.5],
    ["_showWindow", true],
    ["_hideOnUse", true],
    ["_shortcut", ""],
    ["_condition", "true"],
    ["_radius", 50],
    ["_showInUnconscious", false],
    ["_selection", ""],
    ["_memoryPoint", ""]
];

if (isNull _target) exitWith { -1 };

private _existingActionId = _target getVariable [_actionKey, -1];
if (_existingActionId isEqualType 0 && {_existingActionId > -1}) then {
    _target removeAction _existingActionId;
};

private _trackedActionKeys = _target getVariable ["vn_mf_addActionKeys", []];
if !(_actionKey in _trackedActionKeys) then {
    _trackedActionKeys pushBack _actionKey;
    _target setVariable ["vn_mf_addActionKeys", _trackedActionKeys, false];
};

_target setVariable [_actionKey, -1, false];

private _actionId = _target addAction [
    _title,
    _script,
    _arguments,
    _priority,
    _showWindow,
    _hideOnUse,
    _shortcut,
    _condition,
    _radius,
    _showInUnconscious,
    _selection,
    _memoryPoint
];

_target setVariable [_actionKey, _actionId, false];
_actionId
