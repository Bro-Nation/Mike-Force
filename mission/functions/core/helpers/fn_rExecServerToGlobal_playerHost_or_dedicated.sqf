/*
    File: fn_rExecServerToGlobal_playerHost_or_dedicated.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:

        Server to global client remoteExec depending on whether execution
        is happening on a player hosted server or a dedicated server.

        TL;DR: `-2` does not work for the `target` parameter when running a
        player hosted server, i.e. when doing development work.

        TODO: Move applicable functions, like Dac Cong CTF notification broadcast,
        over to using this.

    Parameter(s):
        _args - All the arguments for the remoteExec
        _fncString - String of function to be executed globally
        -jipId [OPTIONAL] - JIP ID for the remoteExec.

    Returns: nothing

    Example(s):

        [
            [[_lightSourceOne, _lightSourceTwo], _classname],
            "vn_mf_fnc_attachments_lightsources_chemlight",
            "MY_JIP_ID"
        ] call _fnc_rExecServerToGlobal_playerHost_or_dedicated;

        [
            ["DacCongFlagCaptured"],
            "para_c_fnc_show_notification"
        ] call _fnc_rExecServerToGlobal_playerHost_or_dedicated;

*/

params ["_args", "_fncString", ["_jipId", objNull]];

/*
dedicated server --- target=2
*/

if (isDedicated) exitWith {

    // no JIP
    if (_jipId isEqualType objNull) exitWith {
        _args remoteExec [_fncString, -2];
        nil;
    };

    // no JIP'd
    _args remoteExec [_fncString, -2, _jipId];
    nil;
};

/*
player hosted --- target=allPlayers
*/

if (!isDedicated && isServer) exitWith {

    // no JIP
    if (_jipId isEqualType objNull) exitWith {
        allPlayers
            apply {_args remoteExec [_fncString, _x]}
        ;
        nil;

    };

    // JIP'd
    allPlayers
        apply {_args remoteExec [_fncString, _x, _jipId]}
    ;
    nil;
};

diag_log format [
    "WARNING: Not player hosted server or dedicated server! Not executing! args=%1 fncString=%2 jipId=%3",
    _args, _fncString, _jipId
];
nil;