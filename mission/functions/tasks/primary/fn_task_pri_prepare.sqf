
/*
 * Task Parameters:
 *    None
 * Subtask Parameters:
 * 	  None
 * Runtime Parameters:
 *    None
 */

params ["_taskDataStore"];

/*
CONSTANTS
*/
_taskDataStore setVariable ["subtaskDurationSeconds", 3 * 60];
_taskDataStore setVariable ["subtaskStartTimeRTB", 0];
_taskDataStore setVariable ["subtaskStartTimePrepare", 0];

/*
METHODS

The following function definitions are basically hacking the task definition
to work in an object orientated manner as a class with methods ... sort of.

If you've ever seen python OOP code you should be able to spot the method 
pattern below -- it just uses _tds instead of self

class A:
    def method(self, x, y):
        return x
*/

/*
PRIVATE METHOD -- should only be used by methods defined below.

Get safe subtask end time a.k.a. the time when the subtask is marked as complete.

The code for specific subtasks is run on a tick	so if we restart the subtask later
we have to reset the start time to zero beforehand (on the subtask's initial failure)
and then work it out again on the first tick when the subtask is triggered again.
*/
_taskDataStore setVariable ["_fnc_getSubtaskEndTime", {

	params ["_tds", "_subtaskStartTimeVarName"];

	if ((_tds getVariable _subtaskStartTimeVarName) == 0) then {
		_tds setVariable [_subtaskStartTimeVarName, serverTime];
	};

	private _startTime = _tds getVariable _subtaskStartTimeVarName;
	_startTime + (_tds getVariable "subtaskDurationSeconds")

}];

/*
PUBLIC METHOD -- can be used by any task method

Work out if a script handle variable is "empty" (we've set it to false)
or if there's an actual script handle to worry about.
*/
_taskDataStore setVariable ["fnc_checkScriptHandleStatus", {
	params ["_tds"];

	private _scriptHandle = _tds getVariable ["generateHandle", false];

	// if it's a script handle type then return the status of the script
	if (_scriptHandle isEqualType scriptNull) exitWith {
		scriptDone _scriptHandle
	};

	// otherwise return false as a default "no" result
	false
}];

/*
PUBLIC METHOD -- can be used by any task method

Work out when the RTB subtask is scheduled to end.
*/
_taskDataStore setVariable ["fnc_getSubtaskEndTimeRTB", {
	params ["_tds"];
	[_tds, "subtaskStartTimeRTB"] call (_tds getVariable "_fnc_getSubtaskEndTime")
}];

/*
PUBLIC METHOD -- can be used by any task method

Work out when the Prepare subtask is scheduled to end.
*/
_taskDataStore setVariable ["fnc_getSubtaskEndTimePrepare", {
	params ["_tds"];
	[_tds, "subtaskStartTimePrepare"] call (_tds getVariable "_fnc_getSubtaskEndTime")
}];

/* 
PRIVATE METHOD -- should only be used by methods defined below.

Get all players that match specific conditions in a specific area.
_playersToCheck should be all players that you want to check the location of.
*/
_taskDataStore setVariable ["_fnc_getPlayersInArea", {
	params ["_tds", "_playersToCheck"];
	private _areaDescriptor = _tds getVariable ["areaDescriptor", []];
	_playersToCheck inAreaArray _areaDescriptor
}];

/*
PUBLIC METHOD -- can be used by any task method

Find out if ANY players have entered the zone while the RTB subtask is active.
*/
_taskDataStore setVariable ["fnc_getPlayersInAreaRTB", {
	params ["_tds"];
	[_tds, allPlayers select {alive _x}] call (_tds getVariable "_fnc_getPlayersInArea")
}];

/*
PUBLIC METHOD -- can be used by any task method

Find out if non-DC players have entered the zone while the prepare subtask is active.
*/
_taskDataStore setVariable ["fnc_getPlayersInAreaPrepare", {
	params ["_tds"];
	[_tds, (allPlayers select {alive _x}) select {side _x != east}] call (_tds getVariable "_fnc_getPlayersInArea")
}];

/*
PUBLIC METHOD -- can be used by any task method

Change the colour of the BN circular area marker
*/
_taskDataStore setVariable ["fnc_changeAreaMarkerColor", {
	params ["_tds", "_color"];
	(_tds getVariable "areaMarkerName") setMarkerColor _color;
}];

	
/*
Base "Go Away" subtask -- Players entered the AO too early. Turn it black, delete everything and tell them to GTFO!

We actually call this twice (see the bottom of this script), but we include different players to watch for in each one.
*/
_taskDataStore setVariable ["fnc_subtaskGoAway", {

	params ["_tds", "_nextSubTask", "_playersInArea", "_obj_pos"];

	[_tds, "ColorBlack"] call (_tds getVariable "fnc_changeAreaMarkerColor");

	/*
	players have left the AO's blue circle
	we're good to end this task and move back to the DC prepare task
	*/

	if ((count _playersInArea) == 0) exitWith {

		// we need to set the timer overlay up before we start the task
		// otherwise task block above will call this on every task tick

		private _nextsubtaskDurationSeconds = _tds getVariable "subtaskDurationSeconds";
		
		[] call vn_mf_fnc_timerOverlay_removeGlobalTimer;

		[
			"Attack Operation preparation",
			serverTime + _nextsubtaskDurationSeconds,
			true
		] call vn_mf_fnc_timerOverlay_setGlobalTimer;

		[
			"INFO",
			format ["Task: Prepare: GoAway: Players have now left the AO, switching to next subtask: %1", _nextSubtask]
		] call para_g_fnc_log;
		
		[
			"SUCCEEDED", 
			[[_nextSubtask, _obj_pos]]
		] call _fnc_finishSubtask;

	};

	/*
	players have not stayed out of the AO's blue circle so set the sub task as failed
	send player information to logs if in blue zone (possible trolls).
	and spam notifications to all players until they leave.
	*/
	if ((count _playersInArea) > 0) exitWith {

		private _logmsg = format [
			"Task: Prepare: GoAway: Players still in the AO: %1",
			_playersInArea apply {getPlayerUID _x}
		];

		["INFO", _logmsg] call para_g_fnc_log;
		/*
		players have not stayed out of the AO's blue circle so set the sub task as failed
		send player information to logs if in blue zone (possible trolls).
		and spam notifications to all players until they leave.
		*/

		private _pollingDelay = 30;

		private _hudOverlayParams = [
			"Leave the area immediately!",
			serverTime + _pollingDelay,
			true
		];

		[
			"AttackPreparingFailed",
			["Leave the area immediately! Charlie isn't ready!"]
		] remoteExec ["para_c_fnc_show_notification", 0];

		[] call vn_mf_fnc_timerOverlay_removeGlobalTimer;
		_hudOverlayParams call vn_mf_fnc_timerOverlay_setGlobalTimer;

		// wait for a while to not spam players TOO Much. Just enough!
		// not including this spawms all players with notification every 5 seconds or something
		sleep _pollingDelay;
	};
}];

// no players allowed into the AO, so we can spawn in sites safely
_taskDataStore setVariable ["fnc_subtaskRTB", {
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
}];

/*
"Prepare" logic -- Dac Cong are allowed into the AO now, all sites have been generated. Blufor need to wait a few minutes still.
*/
_taskDataStore setVariable ["fnc_subtaskPrepare", {

	params ["_tds"];

	[_tds, "ColorBlue"] call (_tds getVariable "fnc_changeAreaMarkerColor");
	private _subtaskEndTime = [_tds] call (_tds getVariable "fnc_getSubtaskEndTimePrepare");
	private _playersInArea = [_tds] call (_tds getVariable "fnc_getPlayersInAreaPrepare");

	// success -- everything has gone smoothly and we can now close out the final subtask
	if (serverTime > _subtaskEndTime and (count _playersInArea) == 0) exitWith {

		[
			"INFO",
			"Task: Prepare: Prepare subtask success. Ending Prepare task."
		] call para_g_fnc_log;

		_tds setVariable ["prepared", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};

	// players have not stayed out of the AO's blue circle so set the sub task as failed
	if ((count _playersInArea) > 0) exitWith {

		[
			"INFO",
			"Task: Prepare: Prepare subtask failed -- Blufor entered the AO. Switching to GoAwayNotDC subtask."
		] call para_g_fnc_log;

		_tds setVariable ["subtaskStartTimePrepare", 0];

		[
			"FAILED", 
			[
				["go_away_prepare", _tds getVariable ["stagingPos", getMarkerPos "starting_point"]]
			]
		] call _fnc_finishSubtask;
	};
}];


/*
MAIN TASK LOGIC IMPLEMETATIONS START HERE

These call the methods above to implement the different phases of the prepare task.

Except for INIT which is it's own thing.

All of these method names need to match up to those in the task's config file.
*/

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _zone = _taskDataStore getVariable "taskMarker";

	private _logmsg = format [
		"Task: Prepare: Init: serverTime=%1 zone=%2",
		serverTime,
		_zone
	];
	["INFO", _logmsg] call para_g_fnc_log;

	/* base Mike Force AO marker. */
	private _zonePosition = getMarkerPos _zone;
	_zone setMarkerColor "ColorBlue";
	_zone setMarkerBrush "DiagGrid";

	/* area marker is the outer BN circle, or effective AO play area. */
	private _areaMarkerSize = vn_mf_bn_s_zone_radius + 100;
	private _areaDescriptor = [_zonePosition, _areaMarkerSize, _areaMarkerSize, 0, false];
	_taskDataStore setVariable ["areaDescriptor", _areaDescriptor];

	/*
	Initial changes to the marker for the BN playable area.

	Don't set the colour during init as we'll handle it during subtasks
	so we can switch colours based on conditions
	*/
	private _areaMarker = createMarkerLocal ["prepZoneCircle", _zonePosition];
	_areaMarker setMarkerShapeLocal "ELLIPSE";
	_areaMarker setMarkerSizeLocal [_areaMarkerSize, _areaMarkerSize];
	_areaMarker setMarkerAlphaLocal 0.5;
	_areaMarker setMarkerBrush "DiagGrid";

	_taskDataStore setVariable ["areaMarkerName", _areaMarker];

	/*
	the staging position is where the Arma objective marker changes to when the
	zone flips from the RTB subtask to the Prepare subtask
	*/
	private _stagingPos = _zonePosition getPos [
		vn_mf_bn_s_zone_radius + 300,
		_zonePosition getDir (getMarkerPos "starting_point")
	];
	_taskDataStore setVariable ["stagingPos", _stagingPos];

	/* send notifications about starting the next AO */
	private _totalTaskDurationSeconds = (_taskDataStore getVariable ["subtaskDurationSeconds", 0]) * 2;

	[
		"AttackPreparing",
		[format ["%1", _totalTaskDurationSeconds / 60]]
	] remoteExec ["para_c_fnc_show_notification", 0];

	[] call vn_mf_fnc_timerOverlay_removeGlobalTimer;

	[
		"Attack Operation preparation",
		serverTime + _totalTaskDurationSeconds,
		true
	] call vn_mf_fnc_timerOverlay_setGlobalTimer;

	[
		"INFO",
		"Prepare AO: Init Finished, switching to RTB subtask"
	] call para_g_fnc_log;

	[
		[
			["rtb", getMarkerPos "starting_point"]
		]
	] call _fnc_initialSubtasks;
}];

// actual rtb logic is called via method above
_taskDataStore setVariable ["rtb", {
	params ["_taskDataStore"];
	[_taskDataStore] call (_taskDataStore getVariable "fnc_subtaskRTB");
}];

// actual prepare logic is called via method above
_taskDataStore setVariable ["prepare", {
	params ["_taskDataStore"];
	[_taskDataStore] call (_taskDataStore getVariable "fnc_subtaskPrepare");
}];

// players entered the AO during the RTB subtask, spam notifications until they leave
_taskDataStore setVariable ["go_away_rtb", {
	params ["_taskDataStore"];

	private _playersInArea = [_taskDataStore] call (_taskDataStore getVariable "fnc_getPlayersInAreaRTB");
	private _objPos = getMarkerPos "starting_point";

	[_taskDataStore, "rtb", _playersInArea, _objPos] call (_taskDataStore getVariable "fnc_subtaskGoAway");
}];

// non-DC players entered the AO during prepare subtask, spam notifications until non-DC players leave
_taskDataStore setVariable ["go_away_prepare", {
	params ["_taskDataStore"];

	private _playersInArea = [_taskDataStore] call (_taskDataStore getVariable "fnc_getPlayersInAreaPrepare");
	private _objPos = _taskDataStore getVariable ["stagingPos", getMarkerPos "starting_point"];

	[_taskDataStore, "prepare", _playersInArea, _objPos] call (_taskDataStore getVariable "fnc_subtaskGoAway");
}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	private _generated = _taskDataStore getVariable ["generated", false];
	private _prepared = _taskDataStore getVariable ["prepared", false];

	if (_generated and _prepared) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	diag_log format ["Prepare AO: Task complete, cleaning up."];
	private _areaMarkerName = _taskDataStore getVariable "areaMarkerName";
	deleteMarker _areaMarkerName;
}];
