/*
	File: fn_soundranging_request_detections.sqf
	Author: Tylervip
	Public: No

	Description:
		Validates a radio request and returns recent detections to the caller.

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

if (!isServer) exitWith {};

if (isNull _caller || {!isPlayer _caller} || {owner _caller isNotEqualTo remoteExecutedOwner}) exitWith {};

private _reply = {
	params ["_player", "_detections", "_message"];
	[_detections, _message] remoteExecCall ["vn_mf_fnc_soundranging_receive_detections", _player];
};

if ((_caller getVariable ["vn_mf_db_player_group", "MikeForce"]) isNotEqualTo "QuarterHorse") exitWith {
	[_caller, [], "Only Black Horse operators can access the sound-ranging net."] call _reply;
};

if (!alive _caller) exitWith {
	[_caller, [], "You must be alive to use the sound-ranging net."] call _reply;
};

if (isNull _radio || {!alive _radio} || {(typeOf _radio) isNotEqualTo "vn_b_prop_vrc12"}) exitWith {
	[_caller, [], "This is not a sound-ranging radio."] call _reply;
};

private _building = _radio getVariable ["para_g_building", objNull];
if (
	isNull _building
	|| {(_building getVariable ["para_g_buildclass", ""]) isNotEqualTo "vn_b_prop_vrc12"}
	|| {!(_radio in (_building getVariable ["para_g_objects", []]))}
) exitWith {
	[_caller, [], "This radio is not connected to the sound-ranging net."] call _reply;
};

if !(_building getVariable ["para_g_building_constructed", false]) exitWith {
	[_caller, [], "The sound-ranging radio is not fully built."] call _reply;
};

if !(_building getVariable ["para_s_building_functional", false]) exitWith {
	[_caller, [], "The sound-ranging radio is not functional."] call _reply;
};

if (_caller distance2D _radio > 5) exitWith {
	[_caller, [], "Move closer to the sound-ranging radio."] call _reply;
};

private _cutoff = serverTime - 180;
private _detections = missionNamespace getVariable ["vn_mf_soundranging_detections", []];
_detections = _detections select {(_x # 0) > _cutoff};

[_caller, _detections, ""] call _reply;
