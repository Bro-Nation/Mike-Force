/*
    File: fn_ctf_bluefor_raise_flag.sqf
    Author: "DJ" Dijksterhuis
    Public: No

    Description:
	   Raise the flag on clients and server simulateneously.

       Flags raised on server are not visibly raised on client and vice versa.

       So this script has to be executed on every machine.

    Parameter(s):
        - _target -- flag we'll be raising
        - _maxProgress -- maximum number of steps to raise the flag height with

    Returns: nothing

    Example(s):
	[_target, 4] call vn_mf_fnc_ctf_bluefor_raise_flag;
*/

params ["_notificationClass"];

[_notificationClass, []] remoteExec ["para_c_fnc_show_notification", -2];