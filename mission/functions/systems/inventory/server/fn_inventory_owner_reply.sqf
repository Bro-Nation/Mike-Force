/*
    File: fn_inventory_owner_reply.sqf
    Author: Tylervip
    Public: No

    Description:
        Completes a serialized operation on the server and replies to the player.
*/

params [
    ["_caller", objNull, [objNull]],
    ["_success", false, [false]],
    ["_target", objNull, [objNull]],
    ["_item", "", [""]],
    ["_qty", 0, [0]],
    ["_buttonType", "move", [""]],
    ["_operationId", -1, [0]],
    ["_reason", "", [""]]
];

if (!isServer) exitWith {
    if (remoteExecutedOwner isEqualTo 2) then {
        _this remoteExecCall ["vn_mf_fnc_inventory_owner_reply", 2];
    } else {
        diag_log format ["[vn_mf_fnc_inventory_owner_reply] rejected non-server sender: %1", remoteExecutedOwner];
    };
};

private _busy = missionNamespace getVariable ["vn_mf_inventory_operation", []];
if (_operationId < 0 || {_busy isEqualTo []} || {(_busy select 0) isNotEqualTo _operationId} ||
    {(_busy select 1) isNotEqualTo _caller} || {(_busy select 2) isNotEqualTo remoteExecutedOwner}) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_owner_reply] rejected invalid completion: id=%1 sender=%2", _operationId, remoteExecutedOwner];
};
missionNamespace setVariable ["vn_mf_inventory_operation", nil];

if (isNull _caller) exitWith {
    diag_log format ["[vn_mf_fnc_inventory_owner_reply] caller unavailable: id=%1 item=%2", _operationId, _item];
};

[_success, _target, _item, _qty, _buttonType, _reason, true] remoteExecCall ["vn_mf_fnc_inventory_receive", owner _caller];
