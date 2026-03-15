/*
	File: fn_active_team_sound.sqf
	Author: Tylervip
	Public: No
	
	Description:
		Calls both siren and whistle functions. Each function internally checks if the player is on the correct team.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_active_team_sound;
*/

call vn_mf_fnc_active_siren;
call vn_mf_fnc_active_whistle;
