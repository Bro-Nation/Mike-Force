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
    ["_reason", "", [""]],
    ["_refresh", false, [false]]
];

if (remoteExecutedOwner isNotEqualTo 2) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_receive] rejected non-server sender: %1", remoteExecutedOwner];
};

private _itemName = [_item] call vn_mf_fnc_inventory_display_name;

_buttonType = toLower _buttonType;
if (_buttonType isEqualTo "") then {
    _buttonType = "move";
};

if (_refresh || {_success}) then {
    if (_buttonType isEqualTo "drop") then {
        if !(isNull _target) then {
            if ((_target isKindOf "GroundWeaponHolder") || {(_target isKindOf "WeaponHolder")}) then {
                uiNamespace setVariable ["vn_mf_active_ground_inventory", _target];
                uiNamespace setVariable ["vn_mf_active_container_inventory", objNull];
            };
        };
    };

    // if !(isNull findDisplay 602) then {
    //     (findDisplay 602) closeDisplay 0;
    //     [] spawn {
    //         uiSleep 0.1;
    //         if (isNull findDisplay 602) then {
    //             player action ["Gear", objNull];
    //         };
    //     };
    // };

};

if (_success) then {
    private _verb = if (_buttonType isEqualTo "drop") then { "Dropped" } else { "Moved" };
    if (_buttonType isEqualTo "drag") then {
        _qty = _qty + 1;
    };
    if (_reason isEqualTo "") then {
        hint format ["%1 %2 x%3.", _verb, _itemName, _qty];
    } else {
        hint format ["%1 %2 x%3. %4.", _verb, _itemName, _qty, _reason];
    };
} else {
    private _verb = if (_buttonType isEqualTo "drop") then { "Could not drop" } else { "Could not move" };
    if (_qty > 0) then {
        if (_buttonType isEqualTo "drag") then {
            _qty = _qty + 1;
        };
        hint format ["%1 %2 completely. Moved %3. %4.", _verb, _itemName, _qty, _reason];
    } else {
        if (_buttonType isEqualTo "drag") then {
            hint format ["Moved one %1, but could not move the rest. %2.", _itemName, _reason];
        } else {
            hint format ["%1 %2. %3.", _verb, _itemName, _reason];
        };
    };
};
