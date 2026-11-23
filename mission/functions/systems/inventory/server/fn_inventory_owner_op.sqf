/*
    File: fn_inventory_owner_op.sqf
    Author: Tylervip
    Public: No

    Description:
        Moves cargo one entry at a time, retaining magazine ammo and restoring
        an entry when the destination does not accept it.
*/

params [
    ["_caller", objNull, [objNull]],
    ["_source", objNull, [objNull]],
    ["_target", objNull, [objNull]],
    ["_item", "", [""]],
    ["_qty", 1, [0]],
    ["_mode", "", [""]],
    ["_buttonType", "move", [""]],
    ["_groundDestination", false, [false]],
    ["_operationId", -1, [0]]
];

if (remoteExecutedOwner isNotEqualTo 2) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_owner_op] rejected non-server sender: %1", remoteExecutedOwner];
};

private _reply = {
    params ["_success", "_moved", "_reason"];
    [_caller, _success, _target, _item, _moved, _buttonType, _operationId, _reason] call vn_mf_fnc_inventory_owner_reply;
};

if (isNull _caller || {isNull _source} || {_item isEqualTo ""} || {_qty <= 0}) exitWith {
    [false, 0, "source or player is unavailable"] call _reply;
};

private _playerSlots = [_caller, uniformContainer _caller, vestContainer _caller, backpackContainer _caller];
if (((_source in _playerSlots) || {!isNull _target && {_target in _playerSlots}}) && {!local _caller}) exitWith {
    [false, 0, "player inventory is not local"] call _reply;
};

if (_groundDestination) then {
    if (isNull _target || {!(_target isKindOf "GroundWeaponHolder" || {_target isKindOf "WeaponHolder"})}) then {
        _target = [_caller, true] call vn_mf_fnc_inventory_ground_holder;
    };
};
if (isNull _target) exitWith {
    [false, 0, "ground holder or destination unavailable"] call _reply;
};
if (_source isEqualTo _target || {_source isEqualTo _caller && {_target in _playerSlots}}) exitWith {
    [false, 0, "source and destination overlap"] call _reply;
};

private _available = [_source, _item] call vn_mf_fnc_inventory_count;
private _limit = _qty min _available;
private _moved = 0;
private _reason = "";
private _failed = false;

for "_index" from 1 to _limit do {
    if (isNull _target || {!(_target canAdd _item)}) exitWith {
        _reason = "destination unavailable or full";
    };

    private _entry = [_source, _item] call vn_mf_fnc_inventory_take_local;
    _entry params ["_removed", "_origin", "_ammo"];
    if (!_removed) exitWith {
        _reason = "source removal unconfirmed; inspect inventories and RPT";
        _failed = true;
    };

    private _placed = [_target, _item, _ammo] call vn_mf_fnc_inventory_give_local;
    if (_placed isEqualTo 1) then {
        _moved = _moved + 1;
    } else {
        _failed = true;
        if (_placed < 0) then {
            _reason = "destination changed unexpectedly; inspect inventories and RPT";
        } else {
            private _restored = 0;
            if !(isNull _origin) then {
                _restored = [_origin, _item, _ammo] call vn_mf_fnc_inventory_give_local;
            };
            if (_restored isEqualTo 1) then {
                _reason = "destination rejected an item; item restored";
            } else {
                if (_restored < 0) then {
                    _reason = "restore changed inventory unexpectedly; inspect inventories and RPT";
                } else {
                    private _recovery = [_caller, true] call vn_mf_fnc_inventory_ground_holder;
                    if (!isNull _recovery && {([_recovery, _item, _ammo] call vn_mf_fnc_inventory_give_local) isEqualTo 1}) then {
                        _reason = "item recovered on the ground; inspect inventory";
                    } else {
                        _reason = "item recovery failed; inspect inventories and RPT";
                    };
                };
            };
        };
        diag_log format ["[vn_mf_fnc_inventory_owner_op] transfer failure: id=%1 item=%2 origin=%3 target=%4 ammo=%5 reason=%6", _operationId, _item, _origin, _target, _ammo, _reason];
    };
    if (_failed) exitWith {};
};

if (_limit <= 0) then {
    _reason = "no matching items available";
};
private _success = (_moved > 0) && {!_failed};
if (!_success || {_reason isNotEqualTo ""}) then {
    diag_log format ["[vn_mf_fnc_inventory_owner_op] result: id=%1 machine=%2 caller=%3 source=%4 target=%5 item=%6 requested=%7 available=%8 moved=%9 success=%10 reason=%11 action=%12", _operationId, clientOwner, _caller, _source, _target, _item, _qty, _available, _moved, _success, _reason, _buttonType];
};
[_success, _moved, _reason] call _reply;
