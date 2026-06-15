/*
    File: fn_harass_filter_target_players.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Paradigm interop function - Called from paradigm. 
		Filters the given list of players, to only the ones that the harass system should target.
    
    Parameter(s):
		_players - List of players that are possible targets [ARRAY]
    
    Returns:
		List of players that the harass system can target [ARRAY]
    
    Example(s):
		[allPlayers] call para_interop_fnc_harass_filter_target_players;
*/

params ["_players"];

private _blockedAreas = vn_mf_markers_blocked_areas + vn_mf_markers_no_harass;
private _isTrainingServer = vn_mf_is_training_server;

//Filter players based on server type
_players select 
{
	private _player = _x;
	private _notBlocked = (_blockedAreas findIf {_player inArea _x}) == -1;
	
	if (_isTrainingServer) then {
		//Training server: Player must be in an AO and not in a blocked area
		private _inAO = (vn_mf_markers_zones findIf {_player inArea _x}) > -1;
		_inAO && _notBlocked
	} else {
		//Live server: Only need to avoid blocked areas
		_notBlocked
	}
};