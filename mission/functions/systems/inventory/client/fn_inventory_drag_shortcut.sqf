/*
    File: fn_inventory_drag_shortcut.sqf
    Author: Tylervip
    Public: No

    Description:
        Tracks a native drag and moves the remaining matching items after it succeeds.

    Parameter(s):
        _event - Drag, key, or inventory event [STRING]
        _idc - Inventory list IDC for a drag [NUMBER]
        _args - Original event arguments [ARRAY]

    Returns:
        Nothing
*/

params ["_event", "_idc", "_args"];

if (_event isEqualTo "keyDown") exitWith {
    uiNamespace setVariable ["vn_mf_inventory_shortcut_key", 1];
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

    private _external = _idc in [632, 640];
    private _sources = [];
    if (_external) then {
        private _candidates = [
            uiNamespace getVariable ["vn_mf_active_inventory_container", objNull],
            uiNamespace getVariable ["vn_mf_active_ground_inventory", objNull],
            uiNamespace getVariable ["vn_mf_active_container_inventory", objNull]
        ];
        if (!isNil "vn_mf_targetContainer") then {
            _candidates pushBackUnique vn_mf_targetContainer;
        };
        if (!isNil "vn_mf_secondaryContainer") then {
            _candidates pushBackUnique vn_mf_secondaryContainer;
        };
        {
            _candidates pushBackUnique _x;
        } forEach (nearestObjects [player, ["GroundWeaponHolder", "WeaponHolder", "WeaponHolderSimulated", "CAManBase"], 8]);

        private _containers = [];
        {
            if (!isNull _x) then {
                if (_x isKindOf "Man") then {
                    {
                        if (!isNull _x) then {
                            _containers pushBackUnique _x;
                        };
                    } forEach [uniformContainer _x, vestContainer _x, backpackContainer _x];
                } else {
                    _containers pushBackUnique _x;
                };
            };
        } forEach _candidates;
        {
            private _count = [_x, _item] call vn_mf_fnc_inventory_count;
            if (_count > 0) then {
                _sources pushBack [_x, _count];
            };
        } forEach _containers;
    };

    private _source = switch (_idc) do {
        case 619: { backpackContainer player };
        case 633: { uniformContainer player };
        case 638: { vestContainer player };
        default { objNull };
    };
    if (!_external && {isNull _source}) exitWith {};

    private _before = if (_external) then { 0 } else { [_source, _item] call vn_mf_fnc_inventory_count };
    if (!_external && {_before <= 0}) exitWith {};
    private _slots = [];
    {
        if !(isNull _x) then {
            _slots pushBack [_x, [_x, _item] call vn_mf_fnc_inventory_count];
        };
    } forEach [uniformContainer player, vestContainer player, backpackContainer player];
    uiNamespace setVariable ["vn_mf_inventory_shortcut_drag", [player, _source, _item, _before, _slots, _external, _sources]];
};

if !(_event in ["take", "put"]) exitWith {};
private _drag = uiNamespace getVariable ["vn_mf_inventory_shortcut_drag", []];
uiNamespace setVariable ["vn_mf_inventory_shortcut_drag", []];
if (_drag isEqualTo [] || {(uiNamespace getVariable ["vn_mf_inventory_shortcut_key", -1]) < 0}) exitWith {};

_drag params ["_unit", "_source", "_item", "_before", "_slots", "_external", "_sources"];
_args params ["_eventUnit", "_container", "_eventItem"];
if (_unit isNotEqualTo player || {_eventUnit isNotEqualTo _unit} || {_eventItem isNotEqualTo _item} ||
    {isNull _container}) exitWith {};
if (_external) then {
    if (_event isEqualTo "take") then {
        private _sourceIndex = _sources findIf {(_x select 0) isEqualTo _container};
        if (_sourceIndex >= 0 && {!(_container in [uniformContainer _unit, vestContainer _unit, backpackContainer _unit])}) then {
            _source = _container;
            _before = (_sources select _sourceIndex) select 1;
        };
    };
};
if (isNull _source) exitWith {
    diag_log format ["[vn_mf_inventory_drag_shortcut] source could not be verified: event=%1 container=%2 item=%3 snapshots=%4", _event, _container, _item, _sources];
    hint "The first item moved, but the source could not be verified.";
};
if (_event isEqualTo "put" && {!(_source in [uniformContainer _unit, vestContainer _unit, backpackContainer _unit])}) exitWith {};

private _remaining = [_source, _item] call vn_mf_fnc_inventory_count;
if (_remaining isNotEqualTo (_before - 1)) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_drag_shortcut] source changed unexpectedly: item=%1 before=%2 after=%3", _item, _before, _remaining];
    hint "The first item moved, but the remaining stack could not be verified.";
};
if (_remaining <= 0) exitWith {};

private _target = objNull;
if (_event isEqualTo "take") then {
    private _matches = _slots select {
        _x params ["_slot", "_count"];
        !isNull _slot &&
        {_slot in [uniformContainer _unit, vestContainer _unit, backpackContainer _unit]} &&
        {([_slot, _item] call vn_mf_fnc_inventory_count) isEqualTo (_count + 1)}
    };
    if (count _matches isEqualTo 1) then {
        _target = (_matches select 0) select 0;
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
