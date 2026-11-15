/*
    File: fn_inventory_drag_drop.sqf
    Author: Tylervip
    Public: No

    Description:
        Handles listbox drag/drop inventory transfers using the clicked listbox as the source and modifier keys for quantity.

    Parameter(s):
        _action - Event action [STRING]
        _eventArgs - Event payload [ARRAY]
        _idc - Inventory list IDC [NUMBER]

    Returns:
        Nothing
*/

params [
    ["_action", "", [""]],
    ["_eventArgs", [], [[]]],
    ["_idc", -1, [0]]
];

private _readIndex = {
    params ["_args", "_control"];
    private _index = -1;
    if (_args isEqualType []) then {
        if ((count _args) > 1) then {
            _index = _args param [1, -1];
        };
        if (_index isEqualType []) then {
            private _nested = _index param [0, []];
            if (_nested isEqualType []) then {
                _index = _nested param [1, -1];
            } else {
                _index = -1;
            };
        };
        if !(_index isEqualType 0) then {
            _index = -1;
        };
        if ((_index < 0) && {(count _args) > 0}) then {
            _index = _args param [0, -1];
            if !(_index isEqualType 0) then {
                _index = -1;
            };
        };
        if (_index < 0 && {!isNull _control}) then {
            _index = lbCurSel _control;
        };
    };
    _index
};

private _readModifiers = {
    params ["_args"];
    private _shift = false;
    private _ctrl = false;
    if (_args isEqualType []) then {
        private _count = count _args;
        if (_count >= 2) then {
            private _flagOne = _args param [(_count - 2), false];
            private _flagTwo = _args param [(_count - 1), false];
            if (_flagOne isEqualType false && {_flagTwo isEqualType false}) then {
                _shift = _flagOne;
                _ctrl = _flagTwo;
            };
        };
        if (!_shift && {!_ctrl} && {_count >= 7}) then {
            _shift = _args param [4, false];
            _ctrl = _args param [5, false];
        };
    };
    [_shift, _ctrl]
};

private _resolveContainer = {
    params ["_listIDC"];
    switch (_listIDC) do {
        case 619: { backpackContainer player };
        case 633: { uniformContainer player };
        case 638: { vestContainer player };
        case 632: { [player] call vn_mf_fnc_inventory_ground_holder };
        case 640: { uiNamespace getVariable ["vn_mf_active_inventory_container", objNull] };
        default { objNull };
    };
};

private _isPlayerInventoryIDCs = [619, 633, 638];

if (_action isEqualTo "lbDrag") then {
    private _control = _eventArgs param [0, controlNull];
    private _index = [_eventArgs, _control] call _readIndex;
    if (isNull _control || {_index < 0}) exitWith {};

    private _item = _control lbData _index;
    if (_item isEqualTo "") then {
        _item = _control lbText _index;
    };
    if (_item isEqualTo "") exitWith {};

    uiNamespace setVariable ["vn_mf_dragged_inventory_item", [_idc, _item, _index]];
};

if (_action isEqualTo "lbDrop") then {
    private _dragData = uiNamespace getVariable ["vn_mf_dragged_inventory_item", []];
    if (_dragData isEqualTo []) exitWith {};

    _dragData params [
        ["_sourceIDC", -1, [0]],
        ["_item", "", [""]],
        ["_dragIndex", -1, [0]]
    ];

    if (_sourceIDC < 0 || {_item isEqualTo ""} || {_sourceIDC isEqualTo _idc}) exitWith {
        uiNamespace setVariable ["vn_mf_dragged_inventory_item", []];
    };

    private _source = [_sourceIDC] call _resolveContainer;
    private _target = [_idc] call _resolveContainer;
    if (isNull _source || {isNull _target}) exitWith {
        uiNamespace setVariable ["vn_mf_dragged_inventory_item", []];
    };
    if (_source isEqualTo _target) exitWith {
        uiNamespace setVariable ["vn_mf_dragged_inventory_item", []];
    };

    private _modifiers = [_eventArgs] call _readModifiers;
    _modifiers params ["_shiftPressed", "_ctrlPressed"];

    private _availableCount = [_source, _item] call vn_mf_fnc_inventory_count;
    private _playerCount = [player, _item] call vn_mf_fnc_inventory_count;
    private _qty = 1;
    if (_ctrlPressed) then {
        if (_sourceIDC in _isPlayerInventoryIDCs) then {
            _source = player;
            _availableCount = _playerCount;
            _qty = _playerCount;
        } else {
            _qty = _availableCount;
        };
    } else {
        if (_shiftPressed) then {
            _qty = 5;
        };
    };

    _qty = _qty min _availableCount;
    if (_qty <= 0) exitWith {
        uiNamespace setVariable ["vn_mf_dragged_inventory_item", []];
    };

    private _mode = "give";
    if ((_sourceIDC in _isPlayerInventoryIDCs) && {(_target isEqualTo player)}) then {
        _mode = "take";
    };
    if (_sourceIDC in [632,640] && {(_target isEqualTo player)}) then {
        _mode = "take";
    };
    if ((_sourceIDC in [632,640]) && {!(_target isEqualTo player)}) then {
        _mode = "give";
    };

    [_source, _target, _item, _qty, _mode, player] remoteExecCall ["vn_mf_fnc_inventory_request", 2];
    uiNamespace setVariable ["vn_mf_dragged_inventory_item", []];
};
