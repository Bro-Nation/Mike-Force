/*
    File: fn_change_team.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Changes team with checks.
    
    Parameter(s):
		_player - Player to change to the team of [UNIT]
		_team - Name of the team to change to [STRING]
    
    Returns:
	   	Team join successful [BOOLEAN]
    
    Example(s):
		[_myPlayer, "ACAV"] call vn_mf_fnc_change_team
*/

params ["_player", "_team", ["_fullTeamBehaviour", "ABORT"]];

private _currentTeam = _player getVariable ["vn_mf_db_player_group", "MikeForce"];
if (_currentTeam isEqualTo _team) exitWith { false };

private _inMACV = [_player, "MACV"] call para_g_fnc_db_check_whitelist;
if ((getPos _player distance [0,0,0]) >= 100) then {
    if (!_inMACV && vn_mf_duty_officers inAreaArray [getPos _player, 20, 20, 0, false, 100] isEqualTo []) exitWith {
        ["TaskFailed", ["", "STR_vn_mf_needdutyofficer"]] remoteExecCall ["para_c_fnc_show_notification", _player];
        false;
    };
};

[_player, _team] call vn_mf_fnc_force_team_change;
true
