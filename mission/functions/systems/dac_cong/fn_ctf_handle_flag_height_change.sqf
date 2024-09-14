/*
	File: fn_ctf_handle_flag_height_change.sqf
	Author: "DJ" Dijksterhuis
	Public: No

	Description:
		Handle lowering/raising the flag server side.

	Parameter(s):
		_target -- flag we'll be raising / lowering
		_progress -- how many steps
		_maxProgress -- total steps
		_direction -- -1/+1 for lower/raise

	Returns: nothing

	Example(s):
		// lower
		[_target, 4, 24, -1] call vn_mf_fnc_ctf_handle_flag_height_change;

		// raise
		[_target, 4, 24, 1] call vn_mf_fnc_ctf_handle_flag_height_change;
*/

params ["_target", "_progress", "_maxProgress", "_direction"];

private _tickRate = 3;

// only change things every 3 holdAction ticks to ensure we're not spamming clients
// with a massive amount of changes (always a total of 24 ticks)
if ((_progress mod _tickRate ) isEqualTo 0) then {

	private _startingFlagHeight = flagAnimationPhase _target;
	private _newHeight = _startingFlagHeight;

	// -1 ---> dac cong lowering the flag
	// +1 ---> bluefor raising the flag

	if (_direction isEqualTo -1) then {

		_newHeight = _startingFlagHeight - (_tickRate / _maxProgress);

		if (_newHeight <= 0) exitWith {

			// global command, no need to remoteExec
			deleteVehicle _target;

			// broadcast notification out to all players
			["DacCongCapturedFlag"] call vn_mf_fnc_ctf_broadcast_notify_immediate;

			// clear the JIP queue for flag height.
			remoteExec ["", "JIP_DACCONG_CTF_FLAG_HEIGHT"];
		};

	} else {

		_newHeight = _startingFlagHeight + (_tickRate / _maxProgress);

		if (_newHeight >= 1) exitWith {

			// broadcast the the new flag height globally with JIP ID (includes server)
			[_target, 1] remoteExec ["setFlagAnimationPhase", 0, "JIP_DACCONG_CTF_FLAG_HEIGHT"];

			// broadcast notification out to all players
			["BlueforRaisedFlag"] call vn_mf_fnc_ctf_broadcast_notify_immediate;

		};
	};
	// set the new height globally via JIP queue so new players also see the flag at the right height
	// includes changing it on the server
	[_target, _newHeight] remoteExec ["setFlagAnimationPhase", 0, "JIP_DACCONG_CTF_FLAG_HEIGHT"];
};

nil;