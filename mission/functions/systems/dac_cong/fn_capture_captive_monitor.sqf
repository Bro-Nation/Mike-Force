/*
    File: fn_capture_captive_monitor.sqf
    Author: tylervip
    Public: No

    Description:
    Starts, stops, or executes the captive monitor for a captured player.

    Parameter(s):
        _mode - Monitor mode [STRING]

    Returns: nothing

    Example(s):
    ["start"] call vn_mf_fnc_capture_captive_monitor;
*/

params [
    ["_mode", "tick", [""]]
];

private _jobId = "capture_captive_monitor";

if (_mode isEqualTo "stop") exitWith {
    [_jobId] call para_g_fnc_scheduler_remove_job;
};

if (_mode isEqualTo "start") exitWith {
    [_jobId] call para_g_fnc_scheduler_remove_job;
    [] call vn_mf_fnc_capture_captive_monitor;
    [_jobId, {[] call vn_mf_fnc_capture_captive_monitor;}, [], 1] call para_g_fnc_scheduler_add_job;
};

if (!alive player) exitWith {
    [player, false] call vn_mf_fnc_toggle_captive;
    ["stop"] call vn_mf_fnc_capture_captive_monitor;
};

private _isNearCapture = (nearestObjects [player, [], 2, false]) findIf {
    private _varName = toLower (vehicleVarName _x);
    (_varName isEqualTo "vn_mf_capture") || {(_varName find "vn_mf_capture") == 0}
} > -1;

if (_isNearCapture) then {
    if (!captive player) then {
        [player, true] call vn_mf_fnc_toggle_captive;
    };
} else {
    [player, false] call vn_mf_fnc_toggle_captive;
    ["stop"] call vn_mf_fnc_capture_captive_monitor;
};