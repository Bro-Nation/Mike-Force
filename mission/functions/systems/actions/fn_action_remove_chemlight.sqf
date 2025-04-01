/*
    File: fn_action_remove_chemlight.sqf
    Author: Legend
    Public: No

    Description:
        Allows a player to remove their chemlight manually.
        Auto-hides if no chemlight is attached.
        Cleans up after itself.

    Parameter(s): none
    Returns: nothing
    Example(s): call vn_mf_fnc_action_remove_chemlight;
*/

if (!isNil "vn_mf_chemlight_remove_action") then {
    player removeAction vn_mf_chemlight_remove_action;
};

private _conditionToShow = "count (attachedObjects player select { toLower typeOf _x find 'chemlight' > -1 }) > 0";

vn_mf_chemlight_remove_action = player addAction
[
    "<t color='#FF9900'>Remove Attached Chemlight</t>",
    {
        [player] call vn_mf_fnc_attachments_global_delete_objects;
        [player] call vn_mf_fnc_attachments_global_reset_jip_id;
        player setVariable ["vn_mf_bn_attch_battery_starttime", -1];
        ["LightsourceAttachRemoved",[]] call para_c_fnc_show_notification;

        // Remove the action
        if (!isNil "vn_mf_chemlight_remove_action") then {
            player removeAction vn_mf_chemlight_remove_action;
            vn_mf_chemlight_remove_action = nil;
        };
    },
    nil,
    0.1,
    true,
    true,
    "",
    _conditionToShow,
    2
];
