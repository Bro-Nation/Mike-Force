/*
    File: fn_director_process_active_zone.sqf
    Author: Spoffy
    Date: 2023-01-07
    Last Update: 2023-01-07
    Public: Yes
    
    Description:
	   	Checks the current status of the zone, and handles the flow for that zone if needed.
		For example, creating a new task or completing the zone.
    
    Parameter(s):
		_zone - The zone name [STRING]
    
    Returns:
	   	Nothing
    
    Example(s):
		["zone_ba_ria"] call vn_mf_fnc_director_process_active_zone;
*/
params ["_zone"];
if !(_zone in mf_s_dir_activeZones) exitWith {
	["WARNING", format ["Attempted to process inactive zone '%1'", _zone]] call para_g_fnc_log;
};
private _zoneInfo = mf_s_dir_activeZones get _zone;
private _currentState = _zoneInfo get "state";
private _task = _zoneInfo get "currentTask";
private _taskIsCompleted = [_task] call vn_mf_fnc_task_is_completed;
private _taskResult = _task getVariable ["taskResult", ""];

[
	"INFO",
	format [
		"Director: checking for task completion: zone=%1 state=%2 result=%3 completed=%4",
		_zone,
		_currentState,
		_taskResult,
		_taskIsCompleted
	]
] call para_g_fnc_log;

if (_taskIsCompleted) then {
	["INFO", format ["Zone '%1' task '%2' completed with status: %3.", _zone, _currentState, _taskResult]] call para_g_fnc_log;

	/*
	Preparation phase has ended.

	Either:
	(a) all site compositions generated and players did not enter zone (move to capture)
	(b) players entered the zone (move to go_away)
	*/
	if (_currentState isEqualTo "prepare_zone") exitWith {
		[_zone, _zoneInfo, "capture_zone"] call vn_mf_fnc_director_start_next_zone_task;
	};

	/*
	All capture site sub tasks have been completed. End of the capture phase.

	Trigger the Zone's counterattack state.
	*/

	if (_currentState isEqualTo "capture_zone") exitWith {
		// prep time needs to be 180 until other PR is merged as well.
		[_zone, _zoneInfo, "defend_counterattack", [["prepTime", 180]]] call vn_mf_fnc_director_start_next_zone_task;
	};

	/*
	Counterattack results are in!
	Do some clean up (remove dc respawns/compositions) then either:
	(a) counterattack phase failed -- reset back to prepare phase (players need to leave zone).
	(b) counterattack phase successful -- close the zone (opening a new zone after).
	*/

	if (_currentState isEqualTo "defend_counterattack") exitWith {

		if (_taskResult isEqualTo "FAILED") exitWith {
			// prep time needs to be 180 until other PR is merged as well.
			[_zone, _zoneInfo, "defend_counterattack", [["prepTime", 180]]] call vn_mf_fnc_director_start_next_zone_task;
		};

		// the counterattacked was defended against successfully
		["INFO", format ["Zone '%1' counterattack successfully defended against, completing zone", _zone]] call para_g_fnc_log;
		// Task is finished, and hasn't failed
		[_zone] call vn_mf_fnc_director_complete_zone;
	};

	[
		"ERROR",
		format ["Director: Task completed, but could not move to new task! zone=%1 currentTask=%2", _zone, _currentState]
	] call para_g_fnc_log;

};