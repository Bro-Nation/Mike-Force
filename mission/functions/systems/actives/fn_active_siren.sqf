/*
	File: fn_active_siren.sqf
	Author: Cerebral
	Public: No
	
	Description:
		Toggles a siren (Only for MACV/MPs)
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_active_siren;
*/

if (([player, 'MilitaryPolice'] call vn_mf_fnc_player_on_team)) then
{
	if (vn_mf_siren_toggle) exitWith
	{ 
		deleteVehicle vn_mf_siren;
		vn_mf_siren_toggle = false;
	};

	vn_mf_siren_toggle = true; 
	vn_mf_siren = createSoundSource ["Siren", player, [], 0];
	vn_mf_siren attachTo [player];
};


