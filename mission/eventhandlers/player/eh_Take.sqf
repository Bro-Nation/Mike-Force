/*
    File: eh_Take.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Take Event Handler.

    Parameter(s):
		_unit - Player [OBJECT, defaults to DEFAULTVALUE]
		_container - Weaponholder [OBJECT, defaults to DEFAULTVALUE]
		_item - Item class [STRING, defaults to DEFAULTVALUE]

    Returns: nothing

    Example(s):
		Not called directly.
*/

params
[
	"_unit",
	"_container",
	"_item"
];

if (!isNull findDisplay 602 && {!isNil "CBA_fnc_getKeybind"}) then {
	["take", -1, _this] call vn_mf_fnc_inventory_drag_shortcut;
};

// refresh armor calculation for Inventory UI.
["refresh"] call vn_mf_fnc_armor_calc;
