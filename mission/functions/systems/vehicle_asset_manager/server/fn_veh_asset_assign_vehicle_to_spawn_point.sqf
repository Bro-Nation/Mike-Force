/*
	File: fn_veh_asset_assign_vehicle_to_spawn_point.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Assigns a vehicle to the given spawn point

	Parameter(s):
		_spawnPoint - Spawn point the vehicle is assigned to [HashMap]
		_vehicle - Vehicle to initialise [Object]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint", "_vehicle"];

_vehicle setVariable ["veh_asset_spawnPointId", _spawnPoint get "id", true];
_spawnPoint set ["lastClassSpawned", typeOf _vehicle];
[_spawnPoint, "currentVehicle", _vehicle] call vn_mf_fnc_veh_asset_set_global_variable;

[_vehicle] call vn_mf_fnc_veh_asset_add_unlock_action;

[_vehicle] call vn_mf_fnc_mobile_respawn_track_vehicle;

// add the eject and parachute action to it
if (_vehicle isKindOf "Helicopter") then {
    [_vehicle] remoteExecCall ["vn_mf_fnc_eject_and_parachute", 0, _vehicle];
};
[_spawnPoint] call vn_mf_fnc_veh_asset_set_idle;

_vehicle addEventHandler ["RopeAttach", {[_this # 2] call vn_mf_fnc_veh_asset_unlock_vehicle}];

private _lockTeamArr = _spawnPoint get "settings" getOrDefault ["lockTeams", []];

[_vehicle, _lockTeamArr] call vn_mf_fnc_lock_vehicle_to_teams;
