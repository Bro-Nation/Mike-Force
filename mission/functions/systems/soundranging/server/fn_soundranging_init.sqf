/*
	File: fn_soundranging_init.sqf
	Author: Tylervip
	Public: No

	Description:
		Initializes sound-ranging tracking and local fired listeners on the machine
		that owns the static artillery objects.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (isServer) then {
	if (missionNamespace getVariable ["vn_mf_soundranging_initialized", false]) exitWith {};

	missionNamespace setVariable ["vn_mf_soundranging_initialized", true];
	missionNamespace setVariable ["vn_mf_soundranging_towers", []];
	missionNamespace setVariable ["vn_mf_soundranging_detections", []];
	missionNamespace setVariable ["vn_mf_soundranging_logged_ammo_classes", []];
	vn_mf_soundranging_markers = [];
	vn_mf_soundranging_confirmed_markers = [];

	private _staticWeapons = allMissionObjects "StaticWeapon";
	{
		[_x] call vn_mf_fnc_soundranging_attach_local_fired_handler;
	} forEach _staticWeapons;

	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];
		if (isNull _entity) exitWith {};
		if !(_entity isKindOf "StaticWeapon") exitWith {};
		if !(local _entity) exitWith {};
		[_entity] call vn_mf_fnc_soundranging_attach_local_fired_handler;
	}];

	["soundranging_cleanup", vn_mf_fnc_soundranging_cleanup, [], 30] call para_g_fnc_scheduler_add_job;
};

if (!isServer) then {
	if (missionNamespace getVariable ["vn_mf_soundranging_local_initialized", false]) exitWith {};
	missionNamespace setVariable ["vn_mf_soundranging_local_initialized", true];
	vn_mf_soundranging_markers = [];
	vn_mf_soundranging_confirmed_markers = [];
	private _localStaticWeapons = allMissionObjects "StaticWeapon";
	{
		[_x] call vn_mf_fnc_soundranging_attach_local_fired_handler;
	} forEach _localStaticWeapons;

	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];
		if (isNull _entity) exitWith {};
		if !(_entity isKindOf "StaticWeapon") exitWith {};
		if !(local _entity) exitWith {};
		[_entity] call vn_mf_fnc_soundranging_attach_local_fired_handler;
	}];
};
