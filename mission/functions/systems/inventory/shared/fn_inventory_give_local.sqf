/*
    File: fn_inventory_give_local.sqf
    Author: Tylervip
    Public: No

    Description:
        Adds one item or magazine, preserving its ammo count.

    Parameter(s):
        _container - Unit or cargo object [OBJECT]
        _class - Item or magazine class [STRING]
        _ammo - Magazine ammo count, or -1 for an item [NUMBER]

    Returns:
        1 if added, 0 if not added, -1 if the observed change is unexpected [NUMBER]
*/

params [
    ["_container", objNull, [objNull]],
    ["_class", "", [""]],
    ["_ammo", -1, [0]]
];

if (isNull _container || {_class isEqualTo ""}) exitWith { 0 };
private _units = allUnits + allPlayers + allDeadMen;
private _ownedSlot = _units findIf {
    _container in [uniformContainer _x, vestContainer _x, backpackContainer _x]
};
if (!(_container isKindOf "Man") && {_ownedSlot < 0} && {!(_container canAdd _class)}) exitWith { 0 };

private _isMagazine = isClass (configFile >> "CfgMagazines" >> _class);
if (_isMagazine && {_ammo < 0}) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_give_local] missing magazine ammo count: item=%1", _class];
    -1
};

private _before = [_container, _class] call vn_mf_fnc_inventory_count;
private _matchingBefore = if (_isMagazine) then {
    [_container, _class, _ammo] call vn_mf_fnc_inventory_count
} else {
    _before
};

if (_container isKindOf "Man") then {
    if (_isMagazine) then {
        _container addMagazine [_class, _ammo];
    } else {
        _container addItem _class;
    };
} else {
    if (_isMagazine) then {
        if (_ownedSlot >= 0 && {_class call BIS_fnc_isThrowable}) then {
            private _unit = _units select _ownedSlot;
            if (_container isEqualTo (uniformContainer _unit)) then {
                _unit addItemToUniform _class;
            } else {
                if (_container isEqualTo (vestContainer _unit)) then {
                    _unit addItemToVest _class;
                } else {
                    _unit addItemToBackpack _class;
                };
            };
        } else {
            _container addMagazineAmmoCargo [_class, 1, _ammo];
        };
    } else {
        _container addItemCargoGlobal [_class, 1];
    };
};

private _after = [_container, _class] call vn_mf_fnc_inventory_count;
private _matchingAfter = if (_isMagazine) then {
    [_container, _class, _ammo] call vn_mf_fnc_inventory_count
} else {
    _after
};
private _change = _after - _before;
private _matchingChange = _matchingAfter - _matchingBefore;

if (_change isEqualTo 1 && {_matchingChange isEqualTo 1}) exitWith { 1 };
if (_change isEqualTo 0 && {_matchingChange isEqualTo 0}) exitWith { 0 };

diag_log format ["[vn_mf_fnc_inventory_give_local] unexpected cargo change: item=%1 container=%2 countDelta=%3 matchingDelta=%4", _class, _container, _change, _matchingChange];
-1
