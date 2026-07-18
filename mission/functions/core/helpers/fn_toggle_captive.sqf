/*
    File: fn_toggle_captive.sqf
    Author: tylervip
    Public: No

    Description:
    Toggles captive state for a unit.

    Parameter(s):
        _unit - Unit to toggle captive state for [OBJECT]
        _state - Optional captive state to force [BOOL]

    Returns: nothing

    Example(s):
    [player] call vn_mf_fnc_toggle_captive;
*/

params [
    ["_unit", player, [objNull]],
    ["_state", -1, [true, 0]]
];

if (isNull _unit) exitWith {};

private _nextState = if (_state isEqualType true) then {
    _state
} else {
    !(captive _unit)
};

_unit setCaptive _nextState;