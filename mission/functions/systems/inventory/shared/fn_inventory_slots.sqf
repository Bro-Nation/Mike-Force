/*
    File: fn_inventory_slots.sqf
    Author: Tylervip
    Public: No

    Description:
        Returns the relevant inventory containers for a unit or cargo object.

    Parameter(s):
        _container - Unit or cargo object [OBJECT]

    Returns:
        Container list [ARRAY]
*/

params [
    ["_container", objNull, [objNull]]
];

if (isNull _container) exitWith { [] };

private _slots = [_container];
if (_container isKindOf "Man") then {
    {
        if !(isNull _x) then {
            _slots pushBackUnique _x;
        };
    } forEach [
        uniformContainer _container,
        vestContainer _container,
        backpackContainer _container
    ];
};

_slots
