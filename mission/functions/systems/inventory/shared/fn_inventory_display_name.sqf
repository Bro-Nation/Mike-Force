/*
    File: fn_inventory_display_name.sqf
    Author: Tylervip
    Public: No

    Description:
        Resolves the display name for a given inventory item or cargo class.

    Parameter(s):
        _class - Class name to look up [STRING]

    Returns:
        Display label [STRING]
*/

params [
    ["_class", "", [""]]
];

if (_class isEqualTo "") exitWith { "" };

private _displayName = "";
private _configPaths = [
    "CfgWeapons",
    "CfgMagazines",
    "CfgVehicles",
    "CfgGlasses"
];

{
    private _config = configFile >> _x >> _class;
    if (isClass _config) exitWith {
        _displayName = getText (_config >> "displayName");
    };
} forEach _configPaths;

if (_displayName isEqualTo "") then {
    _displayName = _class;
};

_displayName
