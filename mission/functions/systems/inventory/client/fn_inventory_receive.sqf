/*
    File: fn_inventory_receive.sqf
    Author: Tylervip
    Public: No

    Description:
        Receives the server response for a move request.

    Parameter(s):
        _success - Move succeeded [BOOL]
        _target - Target container [OBJECT]
        _item - Item class moved [STRING]
        _qty - Quantity moved [NUMBER]

    Returns:
        Nothing
*/

params [
    ["_success", false, [false]],
    ["_target", objNull, [objNull]],
    ["_item", "", [""]],
    ["_qty", 0, [0]],
    ["_buttonType", "move", [""]],
    ["_reason", "", [""]]
];

if (remoteExecutedOwner isNotEqualTo 2) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_receive] rejected non-server sender: %1", remoteExecutedOwner];
};

private _itemName = [_item] call vn_mf_fnc_inventory_display_name;

_buttonType = toLower _buttonType;
if (_buttonType isEqualTo "") then {
    _buttonType = "move";
};

if (_success) then {
    if (_buttonType isEqualTo "drag") then {
        _qty = _qty + 1;
    };
    if (_reason isEqualTo "") then {
        hint format ["Moved %1 x%2.", _itemName, _qty];
    } else {
        hint format ["Moved %1 x%2. %3.", _itemName, _qty, _reason];
    };
} else {
    if (_qty > 0) then {
        if (_buttonType isEqualTo "drag") then {
            _qty = _qty + 1;
        };
        hint format ["Could not move %1 completely. Moved %2. %3.", _itemName, _qty, _reason];
    } else {
        if (_buttonType isEqualTo "drag") then {
            hint format ["Moved one %1, but could not move the rest. %2.", _itemName, _reason];
        } else {
            hint format ["Could not move %1. %2.", _itemName, _reason];
        };
    };
};
