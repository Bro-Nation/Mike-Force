/*
	File: fn_countdown_in_ao.sqf
	Author: tylervip
	Public: yes

	Description:
		Displays a 20-second (configurable) countdown to a player while
		they remain inside the blocked AO during prepare/go-away phases.

	Parameter(s):
		_unit - Player unit to warn [Object]
		_areaDescriptor - inArea descriptor for blocked AO [Array]
		_countdownSeconds - Countdown length in seconds [Number, defaults to 20]

	Returns: nothing

	Example(s):
		[_unit, _areaDescriptor, 20] remoteExec ["vn_mf_fnc_task_pri_prepare_countdown_in_ao", _unit];
*/

if (!hasInterface) exitWith {};

params ["_unit", "_areaDescriptor", ["_countdownSeconds", 20]];

if (isNull _unit) exitWith {};
if (!local _unit) exitWith {};

if (!alive _unit) exitWith {
	_unit setVariable ["vn_mf_prepareAO_inZoneCountdownRunning", false, true];
};

private _remaining = _countdownSeconds;

while {_remaining > 0 && alive _unit && (_unit inArea _areaDescriptor)} do {
	private _msg = format [
		"<t size='2' color='#FF0000' align='center'>WARNING: You are in the AO! Leave in %1 seconds!</t>",
		_remaining
	];

	[_msg, 1.05] call vn_mf_fnc_ui_warning_dynamic_text;
	_remaining = _remaining - 1;
	uiSleep 1;
};

if (!alive _unit) exitWith {
	_unit setVariable ["vn_mf_prepareAO_inZoneCountdownRunning", false, true];
};

if (_unit inArea _areaDescriptor) then {
	["<t size='2' color='#FF0000' align='center'>You failed to leave the AO.</t>", 3] call vn_mf_fnc_ui_warning_dynamic_text;

	private _respawnPos = getMarkerPos "mf_respawn_mikeforce";
	// If the player is in a vehicle, eject first so we move only the player.
	if (vehicle _unit != _unit) then {
		moveOut _unit;
		uiSleep 0.1;
	};
	_unit setPosATL _respawnPos;
} else {
	["<t size='1.5' color='#00FF00' align='center'>You left the AO in time.</t>", 2] call vn_mf_fnc_ui_warning_dynamic_text;
};

_unit setVariable ["vn_mf_prepareAO_inZoneCountdownRunning", false, true];
