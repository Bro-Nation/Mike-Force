
/*
 * Task Parameters:
 *    None
 * Subtask Parameters:
 * 	  None
 * Runtime Parameters:
 *    None
 */


	params ["_tds"];

private _zone = _tds getVariable "taskMarker";

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
_tds setVariable ["areaDescriptor", _areaDescriptor];

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

_tds setVariable ["areaMarkerName", _areaMarker];

/*
the staging position is where the Arma objective marker changes to when the
zone flips from the RTB subtask to the Prepare subtask
*/
private _stagingPos = _zonePosition getPos [
	vn_mf_bn_s_zone_radius + 300,
	_zonePosition getDir (getMarkerPos "starting_point")
];
_tds setVariable ["stagingPos", _stagingPos];

/* send notifications about starting the next AO */
private _totalTaskDurationSeconds = (_tds getVariable ["subtaskDurationSeconds", 0]) * 2;

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