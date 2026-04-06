/*
    File: fn_tunnels_eject_players.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Ejects all players currently inside tunnels with fade-to-black effect.
        Used when AO ends and tunnel collapses.

    Parameter(s):
        None

    Returns:
        Number of players ejected [NUMBER]

    Example(s):
        call vn_mf_fnc_tunnels_eject_players
*/

if (!isServer) exitWith { 0 };

private _ejectedCount = 0;
private _tunnels = missionNamespace getVariable ["vn_mf_tunnels", []];

{
    private _tunnel = _x;
    private _exitTeleport = _tunnel getVariable ["exitTeleport", objNull];
    if (!isNull _exitTeleport) then {
        private _exitPos = _exitTeleport getVariable ["exitPosition", []];
        if (_exitPos isEqualTo []) then { _exitPos = getPosATL _tunnel };

        {
            if (isPlayer _x && {_x distance2D _exitTeleport < 20} && {!([_x, 'DacCong'] call vn_mf_fnc_player_on_team)}) then {
                [_exitPos] remoteExecCall ["vn_mf_fnc_tunnels_eject_player_client", _x];
                _ejectedCount = _ejectedCount + 1;
            };
        } forEach allPlayers;
    };
} forEach _tunnels;

_ejectedCount
