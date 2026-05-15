/*
    File: fn_mobile_respawn_job.sqf
    Author: tylervip
    Public: yes

    Description:
        Scheduler job (runs every 10s) that monitors all tracked M577 APCs.
        Registers a vehicle as a respawn point when its tent is deployed,
        and unregisters it when the tent is stowed. Dead or null vehicles
        are pruned from the tracking list.

    Parameter(s):
        None (called by scheduler)

    Returns:
        Nothing

    Example(s):
        ["m577_respawn_monitor", vn_mf_fnc_mobile_respawn_job, [], 10] call para_g_fnc_scheduler_add_job
*/

private _tracked = missionNamespace getVariable ["vn_mf_m577_tracked_vehicles", []];
private _stillAlive = [];

{
    private _vehicle = _x;

    // Prune destroyed/null vehicles from tracking
    if (isNull _vehicle || !alive _vehicle) then {
        // If it was registered, clean up
        if !(_vehicle getVariable ["vn_mf_m577_respawn_id", []] isEqualTo []) then {
            [_vehicle] call vn_mf_fnc_mobile_respawn_unregister_apc;
        };
        // Do not add to _stillAlive - drops from tracking list
    } else {
        _stillAlive pushBack _vehicle;

        private _isTentDeployed = [_vehicle] call vn_mf_fnc_isTentDeployed;
        private _isRegistered   = !(_vehicle getVariable ["vn_mf_m577_respawn_id", []] isEqualTo []);
        private _hasSupplies    = [_vehicle] call vn_mf_fnc_mobile_respawn_has_supplies;

        if (_isTentDeployed && !_isRegistered && _hasSupplies) then {
            [_vehicle] call vn_mf_fnc_mobile_respawn_register_apc;
        };

        if (_isRegistered && (!_isTentDeployed || !_hasSupplies)) then {
            [_vehicle] call vn_mf_fnc_mobile_respawn_unregister_apc;
        };
    };
} forEach _tracked;

// Update tracking list (removes dead vehicles)
missionNamespace setVariable ["vn_mf_m577_tracked_vehicles", _stillAlive];
