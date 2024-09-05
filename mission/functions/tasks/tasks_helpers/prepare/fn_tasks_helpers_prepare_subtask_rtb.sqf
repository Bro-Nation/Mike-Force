
/*
 * Task Parameters:
 *    None
 * Subtask Parameters:
 * 	  None
 * Runtime Parameters:
 *    None
 */

params ["_tds"];

[_tds, "ColorBlue"] call (_tds getVariable "fnc_changeAreaMarkerColor");

private _subtaskEndTime = [_tds] call (_tds getVariable "fnc_getSubtaskEndTimeRTB");
private _playersInArea = [_tds] call (_tds getVariable "fnc_getPlayersInAreaRTB");

// we have not generated any sites already...
// wait for a few minutes to generate the sites -- otherwise the server is having to handle players
// fighting AI in one AO while we're creating a bunch of stuff somewhere else (perf optimisation)
if (serverTime > _subtaskEndTime and not (_tds getVariable ["generateStarted", false])) exitWith {

	["INFO", "Task: Prepare: RTB: Spawning sites."] call para_g_fnc_log;

	private _handle = [_tds getVariable "taskMarker"] spawn vn_mf_fnc_sites_generate;
	_tds setVariable ["generateStarted", true];
	_tds setVariable ["generateHandle", _handle];
};

/*
players have not stayed out of the AO's blue circle while the sites were generating
set the sub task as failed, reset the state and move to the "Go away" phase

this needs to be immediately after the if block for the generate site to
ensure we are checking immediately if players shjowed up during site generation
*/

if ((count _playersInArea) > 0) exitWith {

	[
		"INFO",
		"Task: Prepare: RTB: Failed -- players entered the AO too early. Switching to GoAwayRTB subtask"
	] call para_g_fnc_log;

	[_tds, "ColorBlack"] call (_tds getVariable "fnc_changeAreaMarkerColor");

	/*
	if we've started spawning sites, await for all sites to have spawned in then delete them once completed.

	WARNING: do not use `terminate` here -- you might stop a site generating halfway through it's init
	leading to dangling sites!
	*/



	if (_tds getVariable ["generateStarted", false]) then {

		waitUntil {

			sleep 5;
			private _sitesFinishedSpawning = [_tds] call (_tds getVariable "fnc_checkScriptHandleStatus");

			[
				"INFO",
				format ["Task: Prepare: RTB: Awaiting spawned site generation: done=%1", _sitesFinishedSpawning]
			] call para_g_fnc_log;

			_sitesFinishedSpawning
		};

		// Delete all active sites and DC respawns once we know they've finished generating
		call vn_mf_fnc_sites_delete_all_active_sites;
		call vn_mf_fnc_daccong_respawns_delete_all;

		// reset the flag for whether to spawn in new sites or not
		_tds setVariable ["generateStarted", false];

		// reset the script handle to false
		_tds setVariable ["generateHandle", false];
	};

	// set start time to zero so we know next time we trigger the subtask that we'll need to recalculate
	_tds setVariable ["subtaskStartTimeRTB", 0];

	// be explicit about the fact that we were not successful generating the sites.
	_tds setVariable ["generated", false];

	[
		"FAILED",
		[
			["go_away_rtb", getMarkerPos "starting_point"]
		]
	] call _fnc_finishSubtask;
};

// we actually generated the sites and haven't triggered a subtask failure. great success!
if (
	(_tds getVariable ["generateStarted", false]) && ([_tds] call (_tds getVariable "fnc_checkScriptHandleStatus"))
) exitWith {

	[
		"INFO",
		"Task: Prepare: RTB: Success -- sites generated without interruption. Switching to Prepare subtask"
	] call para_g_fnc_log;

	_tds setVariable ["generated", true];

	[
		"SUCCEEDED",
		[
			["prepare", _tds getVariable ["stagingPos", getMarkerPos "starting_point"]]
		]
	] call _fnc_finishSubtask;
};