/*
    File: fn_teams_comms_change_channel.sqf
    Author: @nonJoker / S. "Scoop" Scooper
    Public: No
    
    Description:
    	Change channel to desired channel.

    	To be used with paradigm's keybinding menu, or buttons in the task roster.

    	Called by other functions in this folder, which are called by the keybind presses / menu clicks.
    
    Parameter(s):
		None
    
    Returns:
	   	Nothing
    
    Example(s):
		[1] call vn_mf_fnc_teams_comms_change_channel;
*/

params ["_custom_channel_id"];

private _global_channel_id = 15 min (6 max (_custom_channel_id + 5));

if (!(channelEnabled _global_channel_id # 1)) then
{
  _custom_channel_id radioChannelAdd [player];
  _global_channel_id enableChannel [true,true];
};

setCurrentChannel _global_channel_id;