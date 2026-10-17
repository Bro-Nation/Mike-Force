/*
    fn_unlock_vehicle_controls.sqf

    Author: TernaryOperator

    Toggles the vehicle controls lock for the vehicle currently occupied
    by the supplied player, allowing the copilot to take control of
    aircraft that are configured with a copilot seat.

    Params:
        0: OBJECT - The player attempting to lock or unlock the controls.

    Returns:
        NOTHING

    Behaviour:

        [player] call mf_vn_toggle_vehicle_controls_lock;

        Finds the vehicle the player is currently occupying and toggles
        its control lock state.

        If the controls are currently unlocked, they are locked again
        and the vehicle's "controlsUnlocked" variable is set to false.

        If the controls are currently locked, the copilot is enabled
        and the controls are unlocked, and the "controlsUnlocked"
        variable is set to true.

        Feedback is given to the player through systemChat:

            - "Controls Locked"
            - "Controls Unlocked"
            - "Only the pilot can do this"
            - "No configured copilot on this vehicle"

    Locality:

        The function should execute on the machine of the player who
        is the driver/pilot of the vehicle, as the lock and unlock
        actions are issued through the player.

        The "controlsUnlocked" variable is broadcast globally so all
        machines share the current lock state.

    Validation:

        The function exits if:

            - The supplied player object is null (returns 0).
            - The player is not alive.
            - The player is not currently inside a vehicle.
            - The vehicle is not alive.
            - The player is not the driver/pilot of the vehicle.
            - The vehicle has no turret configured with isCopilot = 1
              (only checked when unlocking).

    IMPORTANT:

        Only the driver/pilot may lock or unlock the controls.

        Re-locking is always permitted, even if the vehicle no longer
        has a configured copilot turret. The copilot check only applies
        when unlocking.

        Copilot support is determined solely by the "isCopilot" config
        entry of the vehicle's turrets, so planes and helicopters are
        handled consistently regardless of vehicle class.

        The function does NOT require execution on the server.

    Usage:

        [player] call mf_vn_toggle_vehicle_controls_lock;
*/

params [
    ["_player", objNull, [objNull]]
    ];

if(isNull _player) exitWith {0};

private _vic = vehicle _player;

// Sanity checks
if (!alive _player || {
	_player == _vic
} || {
	!alive _vic
}) exitWith {};

// Only the driver/pilot can lock or unlock
if (driver _vic != _player) exitWith {
	systemChat "Only the pilot can do this";
};

// Always allow re-locking
if (_vic getVariable ["controlsUnlocked", false]) exitWith {
	_player action ["LockVehicleControl", _vic];
	_vic setVariable ["controlsUnlocked", false, true];
	systemChat "Controls Locked";
};

// To handle planes and helicopters properly don't depend on anything
// but `isCopilot` been set as a single truth.
private _copilotTurrets = (allTurrets [_vic, true]) select {
	getNumber (([_vic, _x] call BIS_fnc_turretConfig) >> "isCopilot") == 1
};

if (_copilotTurrets isEqualTo []) exitWith {
	systemChat "No configured copilot on this vehicle";
};

_vic enableCopilot true;
_player action ["UnlockVehicleControl", _vic];
_vic setVariable ["controlsUnlocked", true, true];
systemChat "Controls Unlocked";