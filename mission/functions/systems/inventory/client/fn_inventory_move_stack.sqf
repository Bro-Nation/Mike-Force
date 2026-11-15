
/*
    File: fn_inventory_move_stack.sqf
    Author: Tylervip
    Public: No

    Description:
        Validates a player-driven stack move request and sends it to the server.

    Parameter(s):
        _item - Class to move [STRING]
        _idc - Inventory list IDC [NUMBER]
        _qty - Requested move count [NUMBER]
        _buttonType - Button action type [STRING, default "move"]

    Returns:
        Nothing

    Example(s):
        ["vn_mx991", 632, 5, "move"] call vn_mf_fnc_inventory_move_stack;      // Move 5
        ["vn_mx991", 619, 10, "drop"] call vn_mf_fnc_inventory_move_stack;     // Drop 10
        ["vn_mx991", 632, -1, "move"] call vn_mf_fnc_inventory_move_stack;      // Move all available
*/

params [
    ["_item", "", [""]],
    ["_idc", -1, [0]],
    ["_qty", 0, [0]],
    ["_buttonType", "move", [""]]
];

private _source = objNull;
private _target = objNull;
private _mode = "";
private _sourceType = "<null>";
private _targetType = "<null>";

private _resolved = [_idc, _item, _buttonType] call vn_mf_fnc_inventory_resolve_move;
_source = _resolved param [0, objNull];
_target = _resolved param [1, objNull];
_mode = _resolved param [2, ""];

private _display = findDisplay 602;
private _groundVisible = if (isNull _display) then { false } else { ctrlShown (_display displayCtrl 632) };
private _containerVisible = if (isNull _display) then { false } else { ctrlShown (_display displayCtrl 640) };
private _groundEnabled = if (isNull _display) then { false } else { ctrlEnabled (_display displayCtrl 632) };
private _containerEnabled = if (isNull _display) then { false } else { ctrlEnabled (_display displayCtrl 640) };

private _groundPaneActive = _groundVisible && { !(_containerVisible && {_containerEnabled}) };
private _containerPaneActive = _containerVisible && { !(_groundVisible && {_groundEnabled}) };
private _groundDestination = (_buttonType isEqualTo "drop") || {
    (_mode isEqualTo "give") && {_groundPaneActive}
};

if (_buttonType isEqualTo "drop") then {
    _mode = "give";

    // Always use the player as source when dropping from his own containers.
    if (_idc in [619, 633, 638]) then {
        _source = player;
    };

    if (isNull _target || {!(_target isKindOf "GroundWeaponHolder" || _target isKindOf "WeaponHolder")}) then {
        _target = [player] call vn_mf_fnc_inventory_ground_holder;
    };

    uiNamespace setVariable ["vn_mf_active_ground_inventory", _target];
} else {
    if ((_mode isEqualTo "give") && {isNull _target} && {_groundPaneActive || {_groundVisible}}) then {
        _target = [player] call vn_mf_fnc_inventory_ground_holder;
        uiNamespace setVariable ["vn_mf_active_ground_inventory", _target];
    };
};

if ((_mode isEqualTo "take") && {isNull _source} && {_groundPaneActive || {_groundVisible}}) then {
    _source = [player] call vn_mf_fnc_inventory_ground_holder;
    uiNamespace setVariable ["vn_mf_active_ground_inventory", _source];
};

_sourceType = if (isNull _source) then {"<null>"} else {typeOf _source};
_targetType = if (isNull _target) then {"<null>"} else {typeOf _target};

if (_groundPaneActive && { _buttonType isNotEqualTo "drop" }) then {
    uiNamespace setVariable ["vn_mf_active_container_inventory", objNull];
};
if (_containerPaneActive && { _buttonType isNotEqualTo "drop" }) then {
    uiNamespace setVariable ["vn_mf_active_ground_inventory", objNull];
};

diag_log format ["[vn_mf_fnc_inventory_move_stack] resolved: item=%1 idc=%2 qty=%3 groundVisible=%4 containerVisible=%5 groundEnabled=%6 containerEnabled=%7 groundPaneActive=%8 containerPaneActive=%9 source=%10 target=%11 mode=%12", _item, _idc, _qty, _groundVisible, _containerVisible, _groundEnabled, _containerEnabled, _groundPaneActive, _containerPaneActive, _sourceType, _targetType, _mode];

if (_mode isEqualTo "") exitWith { diag_log "[vn_mf_fnc_inventory_move_stack] no valid move mode for this IDC"; };
if (_item isEqualTo "") exitWith { diag_log "[vn_mf_fnc_inventory_move_stack] no item selected"; hint "No item selected."; };
if (isNull _source || {isNull _target && {!_groundDestination}}) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_move_stack] source or target is null: source=%1 target=%2 groundVisible=%3 containerVisible=%4 groundPaneActive=%5 containerPaneActive=%6 buttonType=%7", _sourceType, _targetType, _groundVisible, _containerVisible, _groundPaneActive, _containerPaneActive, _buttonType];
    hint "No container is selected.";
};
if (_qty == 0) exitWith { diag_log "[vn_mf_fnc_inventory_move_stack] qty is zero"; hint "Nothing moved."; };

private _playerTotalCount = [player, _item] call vn_mf_fnc_inventory_count;
if (_idc in [619,633,638]) then {
    _source = player;
    if (_qty >= _playerTotalCount) then {
        _qty = _playerTotalCount;
    };
    _sourceType = typeOf _source;
};

private _availableCount = [_source, _item] call vn_mf_fnc_inventory_count;
if (_qty < 0) then {
    _qty = _availableCount;
};
diag_log format ["[vn_mf_fnc_inventory_move_stack] available count: item=%1 count=%2", _item, _availableCount];
if (_availableCount <= 0) exitWith { diag_log format ["[vn_mf_fnc_inventory_move_stack] no item available: item=%1 source=%2", _item, _sourceType]; hint "No item available."; };
if (_qty <= 0) exitWith { diag_log format ["[vn_mf_fnc_inventory_move_stack] no quantity to move: item=%1 qty=%2", _item, _qty]; hint "Nothing moved."; };

[_source, _target, _item, _qty, _mode, player, _buttonType, _groundDestination] remoteExecCall ["vn_mf_fnc_inventory_request", 2];
diag_log format ["[vn_mf_fnc_inventory_move_stack] remote request sent: source=%1 target=%2 item=%3 qty=%4 mode=%5 buttonType=%6", _sourceType, _targetType, _item, _qty, _mode, _buttonType];
