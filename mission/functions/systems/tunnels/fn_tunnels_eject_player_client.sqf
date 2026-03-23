/*
    File: fn_tunnels_eject_player_client.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Client-side handler for ejecting a player from a tunnel.
        Performs fade-to-black, teleports player, and displays hint.

    Parameter(s):
        _trapdoorPos - Position to eject player to [ARRAY or OBJECT]

    Returns:
        Nothing

    Example(s):
        [_exitPosition] call vn_mf_fnc_tunnels_eject_player_client
*/

params ["_trapdoorPos"];

// Fade to black
cutText ["", "BLACK OUT", 0.5];
sleep 0.5;

// Teleport player
player setPosATL _trapdoorPos;

// Fade back in
cutText ["", "BLACK IN", 1];
hint "Tunnel collapsed!";
