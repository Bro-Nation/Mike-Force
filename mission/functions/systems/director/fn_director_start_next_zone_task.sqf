/*
	File: fn_director_start_next_zone_task.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Starts the next zone task from the director process active zones job.

		Will update the zone data in both missionNamespace and in the profile DB.

		WARNING: Should only be executed in the director's process active zones job!

	Parameter(s):
		_zone - The zone name [STRING]
		_zoneInfo - The zone info hashmap [HASHMAP]
		_taskString - The config name of the next task [STRING]
		_taskArgs - Any parameters that need to be passed to the task creation.

	Returns:
		_task -- the newly created task

	Example(s):
		private _zone = "zone_ba_ria";
		private _zoneInfo = mf_s_dir_activeZones get _zone;
		[_zone, _zoneInfo, "capture_zone"] call vn_mf_fnc_director_start_next_zone_task;
		[_zone, _zoneInfo, "defend_counterattack", [["prepTime", 180]]] call vn_mf_fnc_director_start_next_zone_task;
*/

params [
	"_zone",
	"_zoneInfo",
	"_taskString",
	["_taskArgs", []]
];

["INFO", format ["Director: Zone '%1' creating new task '%2'.", _zone, _taskString]] call para_g_fnc_log;

private _task = (([_taskString, _zone, _taskArgs] call vn_mf_fnc_task_create) # 1);

["INFO", format ["Director: Zone '%1' updating task data.", _zone]] call para_g_fnc_log;

_zoneInfo set ["state", _taskString];
_zoneInfo set ["currentTask", _task];
[_zone, struct_zone_m_task, _taskString] call vn_mf_fnc_zones_update_zone;

["INFO", format ["Director: Zone '%1' task created and zone data updated.", _zone]] call para_g_fnc_log;

_task;