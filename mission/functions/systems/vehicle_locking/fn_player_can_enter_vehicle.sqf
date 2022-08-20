/*
	File: fn_player_can_enter_vehicle.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Check if the player can enter the vehicle.

	Parameter(s):
	_player - Player that wants to enter [Object]
	_role - Role in the vehicle they want to enter [String]
	_vehicle - Vehicle that the player is entering [Object]

	Returns:
		Can they enter the vehicle? [Boolean]

	Example(s): none
*/


params ["_player", "_role", "_vehicle"];

private _isCopilot = (getNumber ([_vehicle, _vehicle unitTurret _player] call BIS_fnc_turretConfig >> "isCopilot") > 0);
private _playerGroup = _player getVariable ["vn_mf_db_player_group", "FAILED"];

//TODO: FIX THIS (DOES NOT WORK AS INTENDED, DOES NOT EVEN LET WHITELISTED BLACKHAWKS USE 105s)
// if (_vehicle isKindOf "vn_b_army_static_m101_02") exitWith {
// 	private _inBlackHawks = [_player, "BlackHawk"] call para_g_fnc_db_check_whitelist;
// 	if (_inBlackHawks) exitWith {
// 		true
// 	};

// 	["VehicleLockedToTeam", ["Black Hawk artillery squadron members only, apply on Discord."]] remoteExec ["para_c_fnc_show_notification", _player];
// 	false
// };

if (_role == "driver" || _isCopilot) exitWith {
	private _teamsVehicleIsLockedTo = _vehicle getVariable ["teamLock", []];
	if (_teamsVehicleIsLockedTo isEqualTo [] || _playerGroup in _teamsVehicleIsLockedTo) exitWith {
		true
	};
	false
};

true
