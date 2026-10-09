/*
    fn_extend_ropes.sqf

    Author: TernaryOperator

    Extends ALL deployed rope sets on the unit's current helicopter by one step,
    exactly like ASL's own "Extend Cargo Ropes" action does when you pick "All Ropes".
    Works whether or not a rope set currently has cargo attached.

    Params:
        None

    Returns:
        NUMBER - number of rope sets told to extend
                 0 if the unit is not in a supported helicopter, no ropes are
                 deployed, or ASL is not loaded

    Behaviour:

        Explicitly handles only applying rope interactions to currentPilot (not driver)
        i.e cleanly handles pilot/co-pilot and `take control` interactions via
        vn_mf_fnc_valid_state_for_asl

        If called repeatedly will extend per step (ASL unwinds 5 m per action).
        Call it repeatedly (e.g. from a keybind or a loop) to keep paying out rope.

        All deployed rope sets are extended in the same call. (if user wishes to shorted)
        a specific rope that can be done via scroll menu as usual, in reality you mostly
        do want to do bulk operations on rope sets.

    IMPORTANT:

        ASL will not extend a rope set that is already longer than 100 m.
        Those sets are still counted in the return value, they just don't change.

    Usage:

        [player] call vn_mf_fnc_extend_ropes;

    Locality:

        Safe to call on any machine, from scheduled or unscheduled code.
        The rope state ASL reads (ASL_Ropes) is public, and ASL_Extend_Ropes forwards
        itself to the helicopter's owner (remoteExecCall) when the helicopter is not
        local here - the same way ASL's own actions work.
        When forwarded, the change happens on the owner's machine a moment after this
        returns.
*/

// Check we conform with expectations (ASL loaded, in a heli etc)
if!([player] call vn_mf_fnc_valid_state_for_asl) exitWith {
    0
};

private _heli = vehicle player;

// [[ropeIndex, label], ...] for every rope set that is currently deployed
private _active = [_heli] call ASL_Get_Active_Ropes;
if (_active isEqualTo []) exitWith { 0 };

{
    [_heli, player, _x select 0] call ASL_Extend_Ropes;
} forEach _active;

[player] remoteExec ["vn_mf_fnc_sling_summary", player];

count _active
