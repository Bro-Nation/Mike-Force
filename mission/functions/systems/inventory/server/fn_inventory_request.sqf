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

private _isKnownInventoryItem =
    isClass (configFile >> "CfgMagazines" >> _item) ||
    {isClass (configFile >> "CfgWeapons" >> _item)} ||
    {isClass (configFile >> "CfgVehicles" >> _item)} ||
    {isClass (configFile >> "CfgGlasses" >> _item)};
if (!_isKnownInventoryItem) exitWith {
    ["unsupported item type"] call _reject;
};

private _playerSlots = [_caller, uniformContainer _caller, vestContainer _caller, backpackContainer _caller];
private _sourceIsPlayer = _source in _playerSlots;
private _targetIsPlayer = !isNull _target && {_target in _playerSlots};
private _sourceManOwner = objNull;
private _targetManOwner = objNull;
if (!isNull _source && {!(_source isKindOf "Man")}) then {
    private _sourceUnits = allUnits + allPlayers + allDeadMen;
    _sourceUnits = _sourceUnits arrayIntersect _sourceUnits;
    private _sourceOwnerIndex = _sourceUnits findIf {
        _source in [uniformContainer _x, vestContainer _x, backpackContainer _x]
    };
    if (_sourceOwnerIndex >= 0) then {
        _sourceManOwner = _sourceUnits select _sourceOwnerIndex;
    };
};
if (!isNull _target && {!(_target isKindOf "Man")}) then {
    private _targetUnits = allUnits + allPlayers;
    private _targetOwnerIndex = _targetUnits findIf {
        _target isEqualTo (uniformContainer _x) ||
        {_target isEqualTo (vestContainer _x)} ||
        {_target isEqualTo (backpackContainer _x)}
    };
    if (_targetOwnerIndex >= 0) then {
        _targetManOwner = _targetUnits select _targetOwnerIndex;
    } else {
        private _nearby = nearestObjects [_caller, ["CAManBase"], 8];
        private _nearbyIndex = _nearby findIf {
            _target isEqualTo (uniformContainer _x) ||
            {_target isEqualTo (vestContainer _x)} ||
            {_target isEqualTo (backpackContainer _x)}
        };
        if (_nearbyIndex >= 0) then {
            _targetManOwner = _nearby select _nearbyIndex;
        };
    };
};
private _sourceAccessible = _sourceIsPlayer || {
    if (_source isKindOf "Man") then {
        (_caller distance _source <= 8)
    } else {
        if (!isNull _sourceManOwner) then {
            (_caller distance _sourceManOwner <= 8)
        } else {
            (_caller distance _source <= 8)
        };
    };
};
private _targetAccessible = isNull _target || {_targetIsPlayer} || {
    if (_target isKindOf "Man") then {
        (_caller distance _target <= 8)
    } else {
        if (!isNull _targetManOwner) then {
            (_caller distance _targetManOwner <= 8)
        } else {
            (_caller distance _target <= 8)
        };
    };
};
if (!_sourceAccessible || {!_targetAccessible}) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_request] accessibility: caller=%1 source=%2 sourceOwner=%3 sourceAccessible=%4 target=%5 targetOwner=%6 targetAccessible=%7", name _caller, typeOf _source, typeOf _sourceManOwner, _sourceAccessible, typeOf _target, typeOf _targetManOwner, _targetAccessible];
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
private _worker = if (!isNull _sourceManOwner && {alive _sourceManOwner}) then {
    owner _sourceManOwner
} else {
    if (_sourceIsPlayer || {_targetIsPlayer} || {!isNull _targetManOwner} || {_groundDestination}) then {
        owner _caller
    } else {
        owner _source
    };
};
if (_worker <= 0) then {
    _worker = 2;
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
