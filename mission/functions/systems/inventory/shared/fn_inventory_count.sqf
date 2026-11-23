/*
    File: fn_inventory_count.sqf
    Author: Tylervip
    Public: No

    Description:
        Counts matching item or magazine cargo in a unit or container.

    Parameter(s):
        _container - Unit or cargo object [OBJECT]
        _class - Class name to count [STRING]
        _ammo - Optional magazine ammo count; -1 matches any ammo [NUMBER]

    Returns:
        Count [NUMBER]
*/

params [
    ["_container", objNull, [objNull]],
    ["_class", "", [""]],
    ["_ammo", -1, [0]]
];

private _count = 0;
if (isNull _container || {_class isEqualTo ""}) exitWith { _count };

{
    private _items = getItemCargo _x;
    private _itemClasses = _items param [0, []];
    private _itemCounts = _items param [1, []];
    private _itemIndex = _itemClasses find _class;
    if (_itemIndex >= 0) then {
        _count = _count + (_itemCounts param [_itemIndex, 0]);
    };

    {
        _x params [["_entryClass", ""], ["_entryAmmo", 0]];
        if (_entryClass isEqualTo _class && {(_ammo < 0) || {_entryAmmo isEqualTo _ammo}}) then {
            _count = _count + 1;
        };
    } forEach (magazinesAmmoCargo _x);
} forEach ([_container] call vn_mf_fnc_inventory_slots);

_count
