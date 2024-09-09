/*
    File: fn_attachments_global_reset_jip_id.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Resets the JIP RExec queue.

    Parameter(s):
        _player - Player who's JIP Id we need to reset.

    Returns: JIP id string

    Example(s):
      [_player] call vn_mf_fnc_attachments_global_reset_jip_id;
*/

params ["_player"];

// clean up the JIP queue
private _jipId = [_player] call vn_mf_fnc_attachments_global_get_jip_id;
remoteExec ["", 0, _jipId];
