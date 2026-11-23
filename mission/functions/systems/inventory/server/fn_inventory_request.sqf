/*
    File: fn_inventory_request.sqf
    Author: Tylervip
    Public: No

    Description:
        Validates and serializes player inventory transfer requests.
*/

params [
    ["_source", objNull, [objNull]],
    ["_target", objNull, [objNull]],
    ["_item", "", [""]],
    ["_qty", 1, [0]],
    ["_mode", "", [""]],
    ["_caller", objNull, [objNull]],
    ["_buttonType", "move", [""]],
    ["_groundDestination", false, [false]]
];

if (!isServer) exitWith {
    diag_log "[vn_mf_fnc_inventory_request] rejected request outside server";
};
if (isNull _caller || {!isPlayer _caller} || {!alive _caller}) exitWith {
    diag_log "[vn_mf_fnc_inventory_request] rejected invalid caller";
};
if (remoteExecutedOwner isNotEqualTo (owner _caller)) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_request] rejected caller ownership mismatch: caller=%1 sender=%2", _caller, remoteExecutedOwner];
};

private _reject = {
    params ["_reason"];
    diag_log format ["[vn_mf_fnc_inventory_request] rejected: caller=%1 item=%2 reason=%3", _caller, _item, _reason];
    [false, _target, _item, 0, _buttonType, _reason] remoteExecCall ["vn_mf_fnc_inventory_receive", owner _caller];
};

if (isNull _source || {_item isEqualTo ""} || {_qty <= 0} || {_qty isNotEqualTo (floor _qty)}) exitWith {
    ["invalid request"] call _reject;
};
if !(_buttonType in ["move", "drag"] && {_mode in ["give", "take"]}) exitWith {
    ["invalid action"] call _reject;
};
if (_groundDestination && {_mode isNotEqualTo "give"}) exitWith {
    ["invalid ground destination"] call _reject;
};

private _isMagazine = isClass (configFile >> "CfgMagazines" >> _item);
private _itemType = _item call BIS_fnc_itemType;
if (!_isMagazine && {(_itemType param [0, ""]) isNotEqualTo "Item"}) exitWith {
    ["unsupported item type"] call _reject;
};

private _playerSlots = [_caller, uniformContainer _caller, vestContainer _caller, backpackContainer _caller];
private _sourceIsPlayer = _source in _playerSlots;
private _targetIsPlayer = !isNull _target && {_target in _playerSlots};
if ((!_sourceIsPlayer && {_source isKindOf "Man" || {_caller distance _source > 8}}) ||
    {!isNull _target && {!_targetIsPlayer} && {_target isKindOf "Man" || {_caller distance _target > 8}}}) exitWith {
    ["container is not accessible"] call _reject;
};
if (isNull _target && {!_groundDestination}) exitWith {
    ["no destination"] call _reject;
};
if (_groundDestination && {!isNull _target} && {!(_target isKindOf "GroundWeaponHolder" || {_target isKindOf "WeaponHolder"})}) then {
    _target = objNull;
};
if (!isNull _target && {_source isEqualTo _target || {_source isEqualTo _caller && {_targetIsPlayer}}}) exitWith {
    ["source and destination overlap"] call _reject;
};

private _busy = missionNamespace getVariable ["vn_mf_inventory_operation", []];
if !(_busy isEqualTo []) exitWith {
    ["another stack transfer is in progress"] call _reject;
};

private _operationId = (missionNamespace getVariable ["vn_mf_inventory_operation_id", 0]) + 1;
missionNamespace setVariable ["vn_mf_inventory_operation_id", _operationId];
private _worker = if (_sourceIsPlayer || {_targetIsPlayer} || {_groundDestination}) then {
    owner _caller
} else {
    owner _source
};
if (_worker <= 0) exitWith {
    ["inventory owner unavailable"] call _reject;
};

missionNamespace setVariable ["vn_mf_inventory_operation", [_operationId, _caller, _worker]];
[_caller, _source, _target, _item, _qty, _mode, _buttonType, _groundDestination, _operationId] remoteExecCall ["vn_mf_fnc_inventory_owner_op", _worker];

[_operationId, _caller, _item, _buttonType] spawn {
    params ["_operationId", "_caller", "_item", "_buttonType"];
    sleep 60;
    private _busy = missionNamespace getVariable ["vn_mf_inventory_operation", []];
    if !(_busy isEqualTo []) then {
        if ((_busy select 0) isEqualTo _operationId) then {
            if (isNull _caller || {!isPlayer _caller}) then {
                missionNamespace setVariable ["vn_mf_inventory_operation", nil];
                diag_log format ["[vn_mf_fnc_inventory_request] released disconnected operation: id=%1", _operationId];
            } else {
                diag_log format ["[vn_mf_fnc_inventory_request] operation still pending after 60 seconds: id=%1 caller=%2", _operationId, _caller];
                [false, objNull, _item, 0, _buttonType, "transfer stalled; stack actions remain locked"] remoteExecCall ["vn_mf_fnc_inventory_receive", owner _caller];
            };
        };
    };
};
