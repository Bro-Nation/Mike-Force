/*
    fn_retract_all_ropes.sqf

    Releases ALL Advanced Sling Loading cargo and retracts ALL deployed
    rope sets on the helicopter.

    Behaviour:
        - Rope has cargo:
            ASL_Release_Cargo is called.
            ASL detaches the cargo and then retracts that rope automatically.

        - Rope has NO cargo:
            ASL_Retract_Ropes is called directly.

    Therefore every active rope is handled:
        cargo attached     -> release + retract
        no cargo attached  -> retract

    Params:
        _player (OBJECT) - unit whose current vehicle should be processed.
                           Any seat is valid, not just the pilot.

    Returns:
        NUMBER - number of rope sets processed.
                 0 if:
                   - player is not in a vehicle
                   - ASL is not loaded
                   - vehicle is not supported
                   - no ropes are deployed

    Usage:
        
        [player] call vn_mf_fnc_retract_all_ropes;

    Locality:
        Safe to call from any machine.

        ASL_Release_Cargo and ASL_Retract_Ropes handle locality themselves.
        If the helicopter is not local, ASL forwards the operation to the
        helicopter's owner using its normal ASL remote execution mechanism.
*/

params [
    ["_player", objNull, [objNull]]
];

// Check we conform with expectations (ASL loaded, in a heli etc)
if!([_player] call vn_mf_fnc_valid_state_for_asl) exitWith {
    0
};

private _heli = vehicle _player;

private _activeRopes = [_heli] call ASL_Get_Active_Ropes;


// Nothing deployed - nothing to do return
if (_activeRopes isEqualTo []) exitWith {
    0
};

// Process any deployed ropes
{
    private _ropeIndex = _x select 0;
    
    // Does current rope have cargo?
    private _hasCargo = false;

    {
        if ((_x select 0) isEqualTo _ropeIndex) exitWith {
            _hasCargo = true;
        };
    } forEach ([_heli] call ASL_Get_Active_Ropes_With_Cargo);

    // Does it have cargo?
    if (_hasCargo) then {
        // It does release exactly same as ASL would (which also retracts that rope)
        [_heli, _player, _ropeIndex] call ASL_Release_Cargo;

    } else {
        // It does not so we need to call retract on the rope index directly
        [_heli, _player, _ropeIndex] call ASL_Retract_Ropes;
    };

} forEach _activeRopes;

// Return number of rope affected
count _activeRopes
