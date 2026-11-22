/*
	File: fn_soundranging_open_net.sqf
	Author: Tylervip
	Public: No

	Description:
		Requests current sound-ranging detections from the server.

	Parameter(s):
		_radio - Sound-ranging radio object [OBJECT]
		_caller - Player requesting detections [OBJECT]

	Returns:
		Nothing
*/
params [
	["_radio", objNull, [objNull]],
	["_caller", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (isNull _radio || {isNull _caller} || {_caller isNotEqualTo player}) exitWith {
	hint "Use the nearby AN/VRC-12 radio to access the sound-ranging net.";
};

hint "Requesting current sound-ranging bearings...";
[_radio, _caller] remoteExec ["vn_mf_fnc_soundranging_request_detections", 2];
