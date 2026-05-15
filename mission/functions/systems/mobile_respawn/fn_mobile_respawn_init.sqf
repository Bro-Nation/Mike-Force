/*
    File: fn_mobile_respawn_init.sqf
    Author: tylervip
    Public: yes

    Description:
        Initialises the M577 mobile respawn system.
        Collects all pre-placed M577 APCs into a tracking list and starts
        the scheduler job that monitors tent deployment state.
        Vehicle-asset-manager-spawned M577s are added to the tracking list
        via a hook in fn_veh_asset_assign_vehicle_to_spawn_point.sqf.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] call vn_mf_fnc_mobile_respawn_init
*/

if (!isServer) exitWith {};

// Collect pre-placed M577s and seed them with initial food supplies
vn_mf_m577_tracked_vehicles = vehicles select {
    (typeOf _x) find "vn_b_armor_m577_01" == 0
};

{ [_x] call vn_mf_fnc_mobile_respawn_add_supplies } forEach vn_mf_m577_tracked_vehicles;

diag_log format ["VN MikeForce: [mobile_respawn] Initialised - tracking %1 pre-placed M577(s)", count vn_mf_m577_tracked_vehicles];

// Start the scheduler job - checks tent state every 10 seconds
["m577_respawn_monitor", vn_mf_fnc_mobile_respawn_job, [], 10] call para_g_fnc_scheduler_add_job;
