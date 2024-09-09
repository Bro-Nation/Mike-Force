/*
    File: fn_attachments_client_battery_job.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Once the lightsources have 'run out of battery' remove them from the player.

        'Out of battery' is 10 minutes after attaching it.

        Runs on the client directly, so player should be accessible.

    Parameter(s): none.
    Returns: nothing
    Example(s):
        call vn_mf_fnc_attachments_client_battery_job;
*/

private _ttl = 10 * 60;

private _startTime = player getVariable ["vn_mf_bn_attch_battery_starttime", -1];

// final tick -- do this before the next one using an exitWith
// to avoid sending duplicate notifications.
if((_startTime > 0) && {serverTime > (_startTime + _ttl)}) exitWith {
    diag_log format ["INFO: Light attachment has ran out of battery, removing."];
    [player] call vn_mf_fnc_attachments_global_delete_objects;
    ["LightsourceAttachOutOfEnergy",[]] call para_c_fnc_show_notification;
    player setVariable ["vn_mf_bn_attch_battery_starttime", -1];
};

// one tick a minute before the player is going to lose the light source.
// assumes we're running this job once a minute!
// see: fn_attachments_client_battery_monitor_init.sqf
if ((_startTime > 0) && {serverTime > (_startTime + _ttl - 60)}) exitWith {
    ["LightsourceAttachLosingEnergy",[]] call para_c_fnc_show_notification;
};

