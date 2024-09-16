/*
    File: fn_attachments_global_get_jip_id.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Get the JIP id we'll use for JIP-ing the light sources.

    Parameter(s):
        _player - Player we will be attaching to

    Returns: JIP id string

    Example(s):
      [_player] call vn_mf_fnc_attachments_server_get_jip_id;
*/

params ["_player"];

format ["vn_mf_bn_jip_attch_lightsrc_%1", getPlayerUID _player]