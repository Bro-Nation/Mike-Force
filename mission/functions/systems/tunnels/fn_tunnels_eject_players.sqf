/*
    File: fn_tunnels_eject_players.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Ejects all players currently inside tunnels with fade-to-black effect.
        Used when AO ends or tunnels collapse.

    Parameter(s):
        None

    Returns:
        Number of players ejected [NUMBER]

    Example(s):
        call vn_mf_fnc_tunnels_eject_players
*/

private _ejectedCount = 0;
private _allTeleports = call vn_mf_fnc_tunnels_get_teleports;

{
    private _teleport = _x;
    {
        if (isPlayer _x && {_x distance _teleport < 10}) then {
            private _trapdoorPos = _teleport getVariable ["exitPosition", []];
            if (_trapdoorPos isNotEqualTo []) then {
                // Fade to black
                _x cutText ["", "BLACK OUT", 0.5];
                sleep 0.5;

                _x setPosATL _trapdoorPos;
                _x cutText ["", "BLACK IN", 1];
                hint "Tunnel collapsed!";

                _ejectedCount = _ejectedCount + 1;
            };
        };
    } forEach allPlayers;
} forEach _allTeleports;

_ejectedCount
