/*
    File: fn_action_remove_flashlight.sqf
    Author: nonJoker / SR S. "Scooper" Cooper
    Public: No

    Description:
        Allows a player to manually remove their attached chemlight.
        Drops a physical chemlight, synced globally via server.
        Cleans up all light sources and data. Removes its own addAction.

    Example(s): call vn_mf_fnc_action_remove_flashlight;
*/


if (!isNil "vn_mf_flashlight_remove_action") then {
    player removeAction vn_mf_flashlight_remove_action;
};

private _conditionToShow = "count (attachedObjects player select { typeOf _x == 'vn_b_item_mx991_01'}) > 0";

vn_mf_flashlight_remove_action = player addAction
[
    "<t color='#FF9900'>Remove Attached Flashlight</t>",
    {
		private _flashlightClass = player getVariable ["vn_mf_attached_flashlight_class", "vn_mx991"];
        // Clean up player light sources + tracking
        [player] call vn_mf_fnc_attachments_global_delete_objects;
        [player] call vn_mf_fnc_attachments_global_reset_jip_id;
        player setVariable ["vn_mf_bn_attch_battery_starttime", -1];

        ["LightsourceAttachRemoved", []] call para_c_fnc_show_notification;
		

		if (player canAdd _flashlightClass) then {
			player addItem _flashlightClass; // Give back their flashlight (inventory)
		} else {
			[player, _flashlightClass] remoteExecCall ["vn_mf_fnc_attachments_server_spawn_dropped_chemlight", 2];
		};


        if (!isNil "vn_mf_flashlight_remove_action") then {
            player removeAction vn_mf_flashlight_remove_action;
            vn_mf_flashlight_remove_action = nil;
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

