/*
	File: fn_force_team_change.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Forces a player to switch to the given team.

	Parameter(s):
		_player - Player to force the team switch on [Object]
		_team - Name of the team [String]

	Returns: nothing

	Example(s):
		[player, "MikeForce"] call vn_mf_fnc_force_team_change
*/

params ["_player", "_team"];

private _currentPlayerGroup = _player getVariable ["vn_mf_db_player_group", "FAILED"];
private _currentPlayerGroupArray = missionNamespace getVariable [_currentPlayerGroup,[]];
private _isWhitelisted = [_player, _team] call para_g_fnc_db_check_whitelist;

if !(_isWhitelisted) then {

	private _shortname = getText (missionConfigFile >> "gamemode" >> "teams" >> _team >> "shortname");
	["ErrorNotWhitelistedForTeam", [_shortname]] remoteExec ["para_c_fnc_show_notification", _player];

	if (_currentPlayerGroup isNotEqualTo "FAILED") then {
		_team = _currentPlayerGroup;
	} else {
		_team = "MikeForce";
	};
};

["changedTeams", [_player, _team]] call para_g_fnc_event_dispatch;

// Remove the player from their original team's group array
_currentPlayerGroupArray deleteAt (_currentPlayerGroupArray find _player);
publicVariable _currentPlayerGroup;

// Add the player to the new team's player list.
_player setVariable ["vn_mf_db_player_group", _team, true];
private _nextPlayerTeamArray = missionNamespace getVariable [_team, []];
_nextPlayerTeamArray pushBackUnique _player;
/*
  @dijksterhuis commenting out line below as it just causes script errors 
  (no-one from SGD responded to my discord post about it).
  Have tested and it does not affect players switching teams.
  The list of players in a given team is updated regardless of the line below.
*/
// publicVariable _nextPlayerTeam;

[[_team], {
	[] call vn_mf_fnc_task_refresh_tasks_client;
	[] call vn_mf_fnc_update_channels;
	[] call vn_mf_fnc_apply_unit_traits;
	[] call vn_mf_fnc_action_trait;
	// DO THIS LAST
	// so the roles update properly in the teams info pages of the taskroster UI
	// otherwise when a player changes teams their roles are not updated until
	// they reopen the task roster
	[] call vn_mf_fnc_tr_teamInfo_callback_update;
}] remoteExec ["spawn", _player];
