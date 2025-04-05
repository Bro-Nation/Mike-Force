/*
    File: fn_action_remove_chemlight.sqf
    Author: Legend
    Public: No

    Description:
        Allows a player to manually remove their attached chemlight.
        Drops a physical chemlight, synced globally via server.
        Cleans up all light sources and data. Removes its own addAction.

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
        private _chemlightClass = player getVariable ["vn_mf_attached_chemlight_class", "Chemlight_green"];

        // Create dropped chemlight on server
        [player, _chemlightClass] remoteExecCall ["vn_mf_fnc_attachments_server_spawn_dropped_chemlight", 2];

        // Clean up player light sources + tracking
        [player] call vn_mf_fnc_attachments_global_delete_objects;
        [player] call vn_mf_fnc_attachments_global_reset_jip_id;
        player setVariable ["vn_mf_bn_attch_battery_starttime", -1];
        player setVariable ["vn_mf_attached_chemlight_class", nil];

        ["LightsourceAttachRemoved", []] call para_c_fnc_show_notification;

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
