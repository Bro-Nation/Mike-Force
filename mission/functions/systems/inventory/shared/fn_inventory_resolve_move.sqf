/*
    File: fn_inventory_resolve_move.sqf
    Author: Tylervip
    Public: No

    Description:
        Resolves source, target, and mode from the active inventory pane.

    Parameter(s):
        _idc - Inventory list IDC [NUMBER]
        _item - Item class to resolve [STRING]
        _buttonType - Explicit inventory action type [STRING, default "move"]

    Returns:
        Source, target, mode, and active pane [ARRAY]
*/

params [
    ["_idc", -1, [0]],
    ["_item", "", [""]],
    ["_buttonType", "move", [""]]
];

_buttonType = toLower _buttonType;
if (_buttonType isEqualTo "") then {
    _buttonType = "move";
};

private _source = objNull;
private _target = objNull;
private _mode = "";
private _activePane = -1;

private _display = findDisplay 602;
private _groundShown = if (isNull _display) then { false } else { ctrlShown (_display displayCtrl 632) };
private _containerShown = if (isNull _display) then { false } else { ctrlShown (_display displayCtrl 640) };
private _groundEnabled = if (isNull _display) then { false } else { ctrlEnabled (_display displayCtrl 632) };
private _containerEnabled = if (isNull _display) then { false } else { ctrlEnabled (_display displayCtrl 640) };
private _groundInventory = uiNamespace getVariable ["vn_mf_active_ground_inventory", objNull];
private _containerInventory = uiNamespace getVariable ["vn_mf_active_container_inventory", objNull];

private _groundActive = _groundShown && { !(_containerShown && {_containerEnabled}) };
private _containerActive = _containerShown && { !(_groundShown && {_groundEnabled}) };

if (isNull _groundInventory) then {
    _groundInventory = [player] call vn_mf_fnc_inventory_ground_holder;
};

if (_groundActive) then {
    uiNamespace setVariable ["vn_mf_active_ground_inventory", _groundInventory];
    uiNamespace setVariable ["vn_mf_active_container_inventory", objNull];
} else {
    if (_containerActive) then {
        _containerInventory = uiNamespace getVariable ["vn_mf_active_inventory_container", objNull];
        uiNamespace setVariable ["vn_mf_active_container_inventory", _containerInventory];
        uiNamespace setVariable ["vn_mf_active_ground_inventory", _groundInventory];
    } else {
        if ((_idc isEqualTo 632) || {_groundShown}) then {
            uiNamespace setVariable ["vn_mf_active_ground_inventory", _groundInventory];
            uiNamespace setVariable ["vn_mf_active_container_inventory", objNull];
        } else {
            if ((_idc isEqualTo 640) || {_containerShown}) then {
                _containerInventory = uiNamespace getVariable ["vn_mf_active_inventory_container", objNull];
                uiNamespace setVariable ["vn_mf_active_container_inventory", _containerInventory];
                uiNamespace setVariable ["vn_mf_active_ground_inventory", _groundInventory];
            };
        };
    };
};

if (isNull _groundInventory && {(_idc isEqualTo 632) || {_groundShown} || {_groundActive}}) then {
    _groundInventory = [player] call vn_mf_fnc_inventory_ground_holder;
    uiNamespace setVariable ["vn_mf_active_ground_inventory", _groundInventory];
};

if (isNull _containerInventory && {(_idc isEqualTo 640) || {_containerShown} || {_containerActive}}) then {
    _containerInventory = uiNamespace getVariable ["vn_mf_active_inventory_container", objNull];
    if (isNull _containerInventory) then {
        _containerInventory = objNull;
    };
    uiNamespace setVariable ["vn_mf_active_container_inventory", _containerInventory];
};

switch (_idc) do {
    case 619: {
        _source = backpackContainer player;
        if (_containerActive) then {
            _target = _containerInventory;
            _mode = "give";
        } else {
            if (_groundActive) then {
                _target = _groundInventory;
                _mode = "give";
            } else {
                _target = objNull;
                _mode = "";
            };
        };
        _activePane = 619;
    };
    case 633: {
        _source = uniformContainer player;
        if (_containerActive) then {
            _target = _containerInventory;
            _mode = "give";
        } else {
            if (_groundActive) then {
                _target = _groundInventory;
                _mode = "give";
            } else {
                _target = objNull;
                _mode = "";
            };
        };
        _activePane = 633;
    };
    case 638: {
        _source = vestContainer player;
        if (_containerActive) then {
            _target = _containerInventory;
            _mode = "give";
        } else {
            if (_groundActive) then {
                _target = _groundInventory;
                _mode = "give";
            } else {
                _target = objNull;
                _mode = "";
            };
        };
        _activePane = 638;
    };
    case 632: {
        _source = _groundInventory;
        _target = player;
        _mode = "take";
        _activePane = 632;
    };
    case 640: {
        _source = _containerInventory;
        _target = player;
        _mode = "take";
        _activePane = 640;
    };
    default {
        _source = objNull;
        _target = objNull;
        _mode = "";
        _activePane = -1;
    };
};

if (!isNull _source && {_idc in [619,633,638]}) then {
    if (isNull _target && {_groundActive}) then {
        _target = _groundInventory;
        _mode = "give";
    } else {
        if (isNull _target && {_containerActive}) then {
            _target = _containerInventory;
            _mode = "give";
        };
    };
};

if (!isNull _target && {_idc in [632,640]}) then {
    if (isNull _source && {_groundActive}) then {
        _source = _groundInventory;
        _mode = "take";
    } else {
        if (isNull _source && {_containerActive}) then {
            _source = _containerInventory;
            _mode = "take";
        };
    };
};

if (_buttonType isEqualTo "drop") then {
    // Keep whatever source resolve_move already calculated.
    if (isNull _source) then {
        switch (_idc) do {
            case 619: { _source = backpackContainer player; };
            case 633: { _source = uniformContainer player; };
            case 638: { _source = vestContainer player; };
            case 632: { _source = uiNamespace getVariable ["vn_mf_active_ground_inventory", objNull]; };
            case 640: { _source = uiNamespace getVariable ["vn_mf_active_inventory_container", objNull]; };
            default   { _source = objNull; };
        };
    };

    // Prefer existing ground holder (same as MOVE does).
    _target = uiNamespace getVariable ["vn_mf_active_ground_inventory", objNull];
    if (isNull _target) then {
        _target = [player] call vn_mf_fnc_inventory_ground_holder;
    };

    _mode = "give";
    _activePane = _idc;

};

[_source, _target, _mode, _activePane]
