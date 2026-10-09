/*
    fn_release_cargo_via_shortcut.sqf

    Named as it is to avoid conflict with the existing release_cargo override BN MF has.

    Author: TernaryOperator

    Releases ALL Advanced Sling Loading (ASL) cargo from the unit's current helicopter,
    exactly like ASL's own "Release Cargo" action does. Every rope set that currently
    has cargo attached is released in the same call. ASL then retracts the empty ropes
    by itself.

    Params:
        None
    Returns:
        NUMBER - number of cargo items released
                 0 if the unit is not in a supported helicopter, nothing is attached,
                 or ASL is not loaded

    Behaviour:

        Explicitly handles only applying rope interactions to currentPilot (not driver)
        i.e cleanly handles pilot/co-pilot and `take control` interactions via
        vn_mf_fnc_valid_state_for_asl


        All rope sets with cargo attached are released in the same call. If the user
        wishes to release one specific load, that can be done via the scroll menu as
        usual, in reality you mostly do want to do bulk operations on rope sets.

        Rope sets with no cargo attached are ignored and not counted in the return
        value. They are left as they are.

    Usage:

        [player] call vn_mf_fnc_release_cargo_via_shortcut;

    Locality:

        Safe to call on any machine, from scheduled or unscheduled code.
        The rope and cargo state ASL reads (ASL_Ropes / ASL_Cargo) is public, and
        ASL_Release_Cargo forwards itself to the helicopter's owner (remoteExecCall)
        when the helicopter is not local here - the same way ASL's own actions work.
        When forwarded, the release happens on the owner's machine a moment after this
        returns.
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

// [[ropeIndex, label], ...] for every rope set that currently has cargo attached
private _active = [_heli] call ASL_Get_Active_Ropes_With_Cargo;
if (_active isEqualTo []) exitWith { 0 };

{
	[_heli, _player, _x select 0] call ASL_Release_Cargo;
} forEach _active;

count _active
