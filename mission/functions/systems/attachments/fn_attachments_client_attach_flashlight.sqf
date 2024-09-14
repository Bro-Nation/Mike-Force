/*
    File: fn_attachments_client_attach_flashlight.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Player wants to attach a flashlight to see in the dark.

        This triggers server side execution so we can sync everything.

        Called by the "consume" system stuff, which was hacked a little to get this working.

    Parameter(s):
        TODO

    Returns: nothing

    Example(s): none
*/
params ["_interactedItem","_item","_magazineSize","_magazineSizeMax","_magazinesAmmoFull"];

private _interactedItem = uiNamespace getVariable ["vn_mf_interacted_item",[]];
if !(_interactedItem isEqualTo []) then {
  _interactedItem = _interactedItem select 1;
};

[player] call vn_mf_fnc_attachments_global_delete_objects;
[player] call vn_mf_fnc_attachments_global_reset_jip_id;

player removeItem _interactedItem;
player setVariable ["vn_mf_bn_attch_battery_starttime", serverTime];

[player, _interactedItem] remoteExec ["vn_mf_fnc_attachments_server_attach_flashlight", 2];
