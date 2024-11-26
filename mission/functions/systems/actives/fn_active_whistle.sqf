/*
	File: fn_active_whistle.sqf
	Author: Cerebral
	Public: No
	
	Description:
		Blows a whistle (For Dac Cong)
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_active_whistle;
*/

if (([player, 'DacCong'] call vn_mf_fnc_player_on_team)) then
{
	[player] spawn
    {
        params ["_player"];

        if (!(isNull vn_mf_whistle)) then
        {
            deleteVehicle vn_mf_whistle;
            vn_mf_whistle = objNull;
        };

        vn_mf_whistle = createSoundSource ["DacWhistle", _player, [], 0];
        vn_mf_whistle attachTo [_player];

        sleep 2;

        deleteVehicle vn_mf_whistle;
    };
};


