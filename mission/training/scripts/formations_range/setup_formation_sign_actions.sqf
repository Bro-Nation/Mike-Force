/*
    File: setup_formation_sign_actions.sqf
    Author: Spade
    Public: Yes

    Description:
        Helper actions for formation sign interaction.

    Parameter(s):
        _sign - The trigger or object used as the formation sign [OBJECT]

    Returns:
        Nothing

    Example(s):
        [thisTrigger] call setup_formation_sign_actions;
*/

params ["_sign"];
private _formationNames = ["file", "line", "stagcol", "echelon", "diamond", "wedge"];
private _poleCount = 4;
private _displayNames = ["File", "Battle Line", "Staggered Column", "Echelon", "Diamond", "Wedge"];
private _textureNames = [
    "training\billboards\file.paa",
    "training\billboards\line.paa",
    "training\billboards\staggeredcolumn.paa",
    "training\billboards\echelon.paa",
    "training\billboards\diamond.paa",
    "training\billboards\wedge.paa"
];
private _formationSets = [];

{
    private _formKey = _x;
    private _poles = [];
    for "_i" from 1 to _poleCount do {
        private _poleName = format ["pole_%1_%2", _formKey, _i];
        private _obj = missionNamespace getVariable [_poleName, objNull];
        if (isNull _obj) then {
            diag_log format ["[vn_formationSign] WARNING: %1 not found", _poleName];
        };
        _poles pushBack _obj;
    };
    _formationSets pushBack [(_displayNames select _forEachIndex), _poles, (_textureNames select _forEachIndex)];
} forEach _formationNames;

_sign setVariable ["vn_formationSets", _formationSets, true];
private _jipId = format ["vn_formationSignActions_%1", netId _sign];
missionNamespace setVariable ["vn_formationSignActions_jip", _jipId, true];

// Hide all poles at mission start.
{
    _x params ["", "_poles"];
    { if (!isNull _x) then { _x hideObjectGlobal true }; } forEach _poles;
} forEach _formationSets;

[[_sign, _formationSets], {
    params ["_sign", "_formationSets"];
    if (!hasInterface || { isNull _sign }) exitWith {};
    _sign setVariable ["vn_formationSets", _formationSets, true];

    {
        private _name = _x select 0;
        private _poles = _x select 1;
        private _texture = _x select 2;
        _sign addAction [
            format ["<t color='#00FF00'>Show %1</t>", _name],
            {
                params ["_target", "_caller", "_actionId", "_args"];
                _args params ["_selectedPoles", "_texture"];
                {
                    _x params ["", "_poleSet"];
                    { if (!isNull _x) then { _x hideObjectGlobal true }; } forEach _poleSet;
                } forEach (_target getVariable ["vn_formationSets", []]);
                { if (!isNull _x) then { _x hideObjectGlobal false }; } forEach _selectedPoles;
                if (!isNull _target) then {
                    _target setObjectTextureGlobal [0, _texture];
                };
            },
            [_poles, _texture],
            1.5, true, true, "", "true"
        ];
    } forEach _formationSets;
}] remoteExecCall ["BIS_fnc_call", 0, _jipId];
