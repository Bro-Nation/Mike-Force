/*
    fn_shorten_ropes.sqf

    Author: Bro-Nation Dev Team

    Shortens ALL deployed rope sets by one step.
    Informs the user if for logical reasons it can't be done.

    Params:
        _player          (OBJECT) - unit whose current vehicle should shorten its ropes
                                   (any seat, not just the pilot)

    Returns:
        NUMBER - number of rope sets told to shorten
                 0 if the unit is not in a supported helicopter,
                 no ropes are deployed, or ASL is not loaded

    Behaviour:

        [player] -> shortens every deployed rope set by one step

        Works whether or not a rope set currently has cargo attached.
        Mirrors ASL's own "Shorten Cargo Ropes" -> "All Ropes" action.

        One call = one step:

            Rope length 10 m or longer  -> shortened by 5 m
            Rope length below 10 m      -> shortened by 1 m

        Call repeatedly (e.g. from a keybind or a loop) to keep winding in.

        If NO ropes are deployed, nothing happens.

    IMPORTANT:

        If a rope is already 2 m or shorter, ASL treats another
        "shorten" as a RELEASE: any cargo on that rope set is dropped
        and the empty ropes retract i.e. we DON'T crash the cargo into the vic ;)

    Usage:
        _count = [player] call vn_mf_fnc_shorten_ropes

    Locality:
        Safe to call on any machine, from scheduled or unscheduled code.
        The rope state ASL reads (ASL_Ropes) is public, and
        ASL_Shorten_Ropes forwards itself to the helicopter's owner
        (remoteExecCall) when the helicopter is not local here, the same
        way ASL's own actions work. When forwarded, the change happens on
        the owner's machine a moment after this returns.
*/

params [
    ["_player", objNull, [objNull]]
];

// Check we conform with expectations (ASL loaded, in a heli etc)
if!([_player] call vn_mf_fnc_valid_state_for_asl) exitWith {
    0
};

// Not in a vehicle -> nothing to do
private _heli = vehicle _player;

// [[ropeIndex, label], ...] for every rope set that is currently deployed
private _active = [_heli] call ASL_Get_Active_Ropes;

[_player] call vn_mf_fnc_sling_summary;


// Can exit if no ropes active
if (_active isEqualTo []) exitWith { 0 };

{
    [_heli, _player, _x select 0] call ASL_Shorten_Ropes;
} forEach _active;

[_player] remoteExec ["vn_mf_fnc_sling_summary", _player];
count _active
