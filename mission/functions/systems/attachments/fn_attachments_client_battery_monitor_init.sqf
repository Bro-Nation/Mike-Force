/*
    File: fn_attachments_client_battery_monitor_init.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Initialises a paradigm scheduled job on the client
        checking whether the lightsources have "run out of juice".

        or .... every 60 seconds check if 10 minutes has passed and
        delete all the attached objects and lightsources if so.

    Parameter(s): None
    Returns: nothing
    Example(s):
        call vn_mf_fnc_attachments_client_battery_monitor_init
*/

["attch_client_battery_monitor", vn_mf_fnc_attachments_client_battery_monitor_job, [], 60] call para_g_fnc_scheduler_add_job;
