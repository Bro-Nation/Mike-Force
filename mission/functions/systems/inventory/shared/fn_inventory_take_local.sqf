/*
    File: fn_inventory_take_local.sqf
    Author: Tylervip
    Public: No

    Description:
        Removes one cargo entry and returns its original container and ammo count.

    Parameter(s):
        _container - Unit or cargo object [OBJECT]
        _class - Item or magazine class [STRING]

    Returns:
        [removed, original container, ammo count] [ARRAY]
*/

params [
    ["_container", objNull, [objNull]],
    ["_class", "", [""]]
];

if (isNull _container || {_class isEqualTo ""}) exitWith { [false, objNull, -1] };
private _isMagazine = isClass (configFile >> "CfgMagazines" >> _class);
private _slots = [_container] call vn_mf_fnc_inventory_slots;
private _result = [false, objNull, -1];
private _unit = if (_container isKindOf "Man") then {
    _container
} else {
    private _units = allUnits + allPlayers + allDeadMen;
    private _index = _units findIf {
        _container in [uniformContainer _x, vestContainer _x, backpackContainer _x]
    };
    if (_index < 0) then { objNull } else { _units select _index }
};

{
    private _slot = _x;
    private _countBefore = if (!isNull _slot && {!(_slot isKindOf "Man")}) then {
        [_slot, _class] call vn_mf_fnc_inventory_count
    } else {
        0
    };
    if (_countBefore > 0) exitWith {
        private _ammo = -1;
        private _beforeMagazines = [];

        if (_isMagazine) then {
            _beforeMagazines = (magazinesAmmoCargo _slot) select { (_x select 0) isEqualTo _class };
            if !(_beforeMagazines isEqualTo []) then {
                _ammo = (_beforeMagazines select 0) select 1;
            };
        };

        if (!_isMagazine || {_ammo >= 0}) then {
            if (_isMagazine) then {
                if (!isNull _unit && {_class call BIS_fnc_isThrowable}) then {
                    if (_slot isEqualTo (uniformContainer _unit)) then {
                        _unit removeItemFromUniform _class;
                    } else {
                        if (_slot isEqualTo (vestContainer _unit)) then {
                            _unit removeItemFromVest _class;
                        } else {
                            _unit removeItemFromBackpack _class;
                        };
                    };
                } else {
                    _slot addMagazineAmmoCargo [_class, -1, _ammo];
                };
            } else {
                _slot addItemCargoGlobal [_class, -1];
            };

            private _countAfter = [_slot, _class] call vn_mf_fnc_inventory_count;
            private _removed = _countBefore - _countAfter;
            if (_removed isEqualTo 1) then {
                if (_isMagazine) then {
                    private _remaining = (magazinesAmmoCargo _slot) select { (_x select 0) isEqualTo _class };
                    private _missing = [];
                    {
                        private _index = _remaining find _x;
                        if (_index < 0) then {
                            _missing pushBack _x;
                        } else {
                            _remaining deleteAt _index;
                        };
                    } forEach _beforeMagazines;
                    if ((count _missing) isEqualTo 1) then {
                        _ammo = (_missing select 0) select 1;
                        _result = [true, _slot, _ammo];
                    } else {
                        diag_log format ["[vn_mf_fnc_inventory_take_local] unable to identify removed magazine: item=%1 slot=%2", _class, _slot];
                    };
                } else {
                    _result = [true, _slot, -1];
                };
            } else {
                diag_log format ["[vn_mf_fnc_inventory_take_local] removal changed %1 entries instead of one: item=%2 slot=%3", _removed, _class, _slot];
            };
        };
    };
} forEach _slots;

_result
