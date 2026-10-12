/*
    fn_retract_all_ropes.sqf

    Releases ALL Advanced Sling Loading cargo and retracts ALL deployed
    rope sets on the helicopter.

    Behaviour:

        Explicitly handles only applying rope interactions to currentPilot (not driver)
        i.e cleanly handles pilot/co-pilot and `take control` interactions via
        vn_mf_fnc_valid_state_for_asl

        Also works when the player is ON FOOT within 20 m of an ASL-supported
        helicopter (the nearest one is used).

        - Rope has cargo:
            ASL_Release_Cargo is called.
            ASL detaches the cargo and then retracts that rope automatically.

        - Rope has NO cargo:
            ASL_Retract_Ropes is called directly.

    Therefore every active rope is handled:
        cargo attached     -> release + retract
        no cargo attached  -> retract

    Params:
        None

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

// Check we conform with expectations (ASL loaded, pilot of a heli OR on foot
// within 20 m of one) and get the helicopter we are operating
private _heli = [player, true] call vn_mf_fnc_valid_state_for_asl;

if (isNull _heli) exitWith {
    0
};

if(_heli getVariable ["vn_mf_g_veh_asset_locked", false]) then {
    [_heli] call vn_mf_fnc_veh_asset_unlock_vehicle;
};

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
        [_heli, player, _ropeIndex] call ASL_Release_Cargo;

    } else {
        // It does not so we need to call retract on the rope index directly
        [_heli, player, _ropeIndex] call ASL_Retract_Ropes;
    };

} forEach _activeRopes;

// Return number of rope affected
count _activeRopes
