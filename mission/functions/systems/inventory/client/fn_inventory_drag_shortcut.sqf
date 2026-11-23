/*
    Tracks a native drag and moves the remaining matching items after it succeeds.
*/

params ["_event", "_idc", "_args"];

if (_event isEqualTo "keyDown") exitWith {
    private _binding = ["BN Keybinds - Generic", "vn_mf_inventory_move_stack"] call CBA_fnc_getKeybind;
    if (isNil "_binding") exitWith {};
    _args params ["_display", "_key", "_shift", "_ctrl", "_alt"];
    private _bindings = _binding param [8, []];
    if ((_bindings findIf {
        (_x select 0) isEqualTo _key && {(_x select 1) isEqualTo [_shift, _ctrl, _alt]}
    }) >= 0) then {
        uiNamespace setVariable ["vn_mf_inventory_shortcut_key", _key];
    };
};

if (_event isEqualTo "keyUp") exitWith {
    if ((_args param [1, -1]) isEqualTo (uiNamespace getVariable ["vn_mf_inventory_shortcut_key", -1])) then {
        uiNamespace setVariable ["vn_mf_inventory_shortcut_key", -1];
    };
};

if (_event isEqualTo "drag") exitWith {
    uiNamespace setVariable ["vn_mf_inventory_shortcut_drag", []];
    private _rows = _args param [1, []];
    if !(_rows isEqualType [] && {count _rows isEqualTo 1}) exitWith {};
    private _row = _rows select 0;
    if !(_row isEqualType []) exitWith {};
    private _item = _row param [2, "", [""]];
    if (_item isEqualTo "") exitWith {};

    private _source = switch (_idc) do {
        case 619: { backpackContainer player };
        case 633: { uniformContainer player };
        case 638: { vestContainer player };
        case 632: { uiNamespace getVariable ["vn_mf_active_ground_inventory", objNull] };
        case 640: { uiNamespace getVariable ["vn_mf_active_inventory_container", objNull] };
        default { objNull };
    };
    if (isNull _source) exitWith {};

    private _before = [_source, _item] call vn_mf_fnc_inventory_count;
    if (_before <= 0) exitWith {};
    private _slots = [];
    {
        if !(isNull _x) then {
            _slots pushBack [_x, [_x, _item] call vn_mf_fnc_inventory_count];
        };
    } forEach [uniformContainer player, vestContainer player, backpackContainer player];
    uiNamespace setVariable ["vn_mf_inventory_shortcut_drag", [player, _source, _item, _before, _slots]];
};

if !(_event in ["take", "put"]) exitWith {};
private _drag = uiNamespace getVariable ["vn_mf_inventory_shortcut_drag", []];
uiNamespace setVariable ["vn_mf_inventory_shortcut_drag", []];
if (_drag isEqualTo [] || {(uiNamespace getVariable ["vn_mf_inventory_shortcut_key", -1]) < 0}) exitWith {};

_drag params ["_unit", "_source", "_item", "_before", "_slots"];
_args params ["_eventUnit", "_container", "_eventItem"];
if (_unit isNotEqualTo player || {_eventUnit isNotEqualTo _unit} || {_eventItem isNotEqualTo _item} ||
    {isNull _source} || {isNull _container}) exitWith {};
if (_event isEqualTo "put" && {!(_source in [uniformContainer _unit, vestContainer _unit, backpackContainer _unit])}) exitWith {};

private _remaining = [_source, _item] call vn_mf_fnc_inventory_count;
if (_remaining isNotEqualTo (_before - 1)) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_drag_shortcut] source changed unexpectedly: item=%1 before=%2 after=%3", _item, _before, _remaining];
    hint "The first item moved, but the remaining stack could not be verified.";
};
if (_remaining <= 0) exitWith {};

private _target = objNull;
if (_event isEqualTo "take") then {
    if (_container isEqualTo _source) then {
        private _matches = _slots select {
            _x params ["_slot", "_count"];
            !isNull _slot &&
            {_slot in [uniformContainer _unit, vestContainer _unit, backpackContainer _unit]} &&
            {([_slot, _item] call vn_mf_fnc_inventory_count) isEqualTo (_count + 1)}
        };
        if (count _matches isEqualTo 1) then {
            _target = (_matches select 0) select 0;
        };
    };
} else {
    _target = _container;
    private _slotIndex = _slots findIf {(_x select 0) isEqualTo _target};
    if (_slotIndex >= 0) then {
        private _targetBefore = (_slots select _slotIndex) select 1;
        if (([_target, _item] call vn_mf_fnc_inventory_count) isNotEqualTo (_targetBefore + 1)) then {
            _target = objNull;
        };
    };
};

if (isNull _target || {_source isEqualTo _target}) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_drag_shortcut] destination could not be verified: item=%1 source=%2 container=%3 event=%4", _item, _source, _container, _event];
    hint "The first item moved, but the destination could not be verified.";
};

private _mode = if (_event isEqualTo "take") then { "take" } else { "give" };
[_source, _target, _item, _remaining, _mode, _unit, "drag", false] remoteExecCall ["vn_mf_fnc_inventory_request", 2];
