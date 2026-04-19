/*
    File: fn_tunnels_fallout_detection.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Server-side loop that monitors players inside tunnels.
        If a player moves more than 150m from their assigned exit teleport,
        they are teleported back to 3m below the exit point.
        Runs on a 30-second interval.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        call vn_mf_fnc_tunnels_fallout_detection
*/

if (!isServer) exitWith {};

while {true} do {
    {
        if (_x getVariable ["inTunnel", false]) then {
            private _exitTeleport = _x getVariable ["tunnelExitTeleport", objNull];
            if (!isNull _exitTeleport && {_x distance _exitTeleport > 150}) then {
                _x setPosATL (getPosATL _exitTeleport vectorAdd [0,0,-3]);
            };
        };
    } forEach allPlayers;
    sleep 30;
};
