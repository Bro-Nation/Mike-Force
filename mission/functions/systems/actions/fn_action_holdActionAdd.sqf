/*
    File: fn_action_holdActionAdd.sqf
    Author: Tylervip
    Public: No

    Description:
        Guards holdAction registration so AO resets and respawns do not leave
        duplicate actions behind when the same target is re-used.

    Parameters:
        _target                 - Object or player the action is attached to [OBJECT]
        _actionKey              - Unique key to track the action on the target [STRING]
        ...                     - Standard BIS_fnc_holdActionAdd arguments

    Returns:
        New action id [NUMBER]
*/

params [
    "_target",
    "_actionKey",
    "_title",
    "_idleIcon",
    "_progressIcon",
    "_showCondition",
    "_progressCondition",
    "_startCode",
    "_progressCode",
    "_completeCode",
    "_interruptedCode",
    "_arguments",
    "_duration",
    "_priority",
    ["_removeOnComplete", false],
    ["_showInUnconscious", false]
];

if (isNull _target) exitWith { -1 };

private _existingActionId = _target getVariable [_actionKey, -1];
if (_existingActionId isEqualType 0 && {_existingActionId > -1}) then
{
    [_target, _existingActionId] call BIS_fnc_holdActionRemove;
};

private _trackedActionKeys = _target getVariable ["vn_mf_holdActionKeys", []];
if !(_actionKey in _trackedActionKeys) then
{
    _trackedActionKeys pushBack _actionKey;
    _target setVariable ["vn_mf_holdActionKeys", _trackedActionKeys, false];
};

_target setVariable [_actionKey, -1, false];

private _actionId = [
    _target,
    _title,
    _idleIcon,
    _progressIcon,
    _showCondition,
    _progressCondition,
    _startCode,
    _progressCode,
    _completeCode,
    _interruptedCode,
    _arguments,
    _duration,
    _priority,
    _removeOnComplete,
    _showInUnconscious
] call BIS_fnc_holdActionAdd;

_target setVariable [_actionKey, _actionId, false];
_actionId
