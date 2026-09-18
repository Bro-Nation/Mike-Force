/*
    File: setup_flag_visibility_actions.sqf
    Author: Spade
    Public: Yes

    Description:
        Sets up the flag visibility action menu on the selected control object.

    Parameter(s):
        _target - Action host object [OBJECT]

    Returns:
        Nothing

    Example(s):
        [this] execVM "training\scripts\flags\setup_flag_visibility_actions.sqf";
*/

params ["_target"];

if (isNull _target) exitWith {};

private _condition = "(player distance _target < 5) && ([player, 'Instructors'] call vn_mf_fnc_player_on_team)";

private _fnc_scanPrefix = {
    params ["_prefix"];
    private _found = [];
    private _i = 1;
    while { !(isNil (format ["%1%2", _prefix, _i])) } do {
        private _obj = missionNamespace getVariable [format ["%1%2", _prefix, _i], objNull];
        if !(isNull _obj) then {
            _found pushBack _obj;
        };
        _i = _i + 1;
    };
    _found
};

private _altPoles = ["flag_alt_"] call _fnc_scanPrefix;
private _sucPoles = ["flag_suc_"] call _fnc_scanPrefix;

private _existingIds = _target getVariable ["vn_flag_visibility_action_ids", []];
{
    if (_x >= 0) then {
        _target removeAction _x;
    };
} forEach _existingIds;

private _actionDefs = [
    ["Show All", {
        params ["_target", "_caller", "_actionId", "_args"];
        _args params ["_altPoles", "_sucPoles"];
        { _x hideObjectGlobal false } forEach (_altPoles + _sucPoles);
    }, 5],
    ["Hide All", {
        params ["_target", "_caller", "_actionId", "_args"];
        _args params ["_altPoles", "_sucPoles"];
        { _x hideObjectGlobal true } forEach (_altPoles + _sucPoles);
    }, 4],
    ["Alternating", {
        params ["_target", "_caller", "_actionId", "_args"];
        _args params ["_altPoles", "_sucPoles"];
        { _x hideObjectGlobal false } forEach _altPoles;
        { _x hideObjectGlobal true } forEach _sucPoles;
    }, 3],
    ["Successive", {
        params ["_target", "_caller", "_actionId", "_args"];
        _args params ["_altPoles", "_sucPoles"];
        { _x hideObjectGlobal true } forEach _altPoles;
        { _x hideObjectGlobal false } forEach _sucPoles;
    }, 1]
];

private _newIds = [];
{
    _x params ["_label", "_code", "_priority"];
    private _id = _target addAction [
        _label,
        _code,
        [_altPoles, _sucPoles],
        _priority,
        true,
        true,
        "",
        _condition
    ];
    _newIds pushBack _id;
} forEach _actionDefs;

_target setVariable ["vn_flag_visibility_action_ids", _newIds, true];

{ _x hideObjectGlobal true } forEach (_altPoles + _sucPoles);
