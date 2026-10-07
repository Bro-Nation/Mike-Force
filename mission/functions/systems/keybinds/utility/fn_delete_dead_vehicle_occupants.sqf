/*
    mf_vn_delete_dead_vehicle_occupants.sqf

    Author: Bro-Nation Dev Team

    Removes dead occupants from the vehicle currently occupied by
    the supplied player.

    Params:
        _player          (OBJECT) - player whose current vehicle should
                                   have its dead occupants removed

    Returns:
        NOTHING

    Behaviour:

        [player] call mf_vn_delete_dead_vehicle_occupants;

        Finds the vehicle the player is currently occupying and removes
        any dead crew members from it.

        Dead AI crew members are deleted from the vehicle.

        Dead player occupants are moved out of the vehicle instead,
        as player corpses generally cannot be deleted using
        deleteVehicleCrew.

    Locality:

        The function must execute where the vehicle is local.

        If the vehicle is not local to the machine currently executing
        the function, the function remotely executes itself on the
        machine that owns the vehicle.

        Once running where the vehicle is local, the dead occupants
        are removed normally.

    Validation:

        The function exits if:

            - The supplied player object is null.
            - The supplied object is not a player.
            - The player is not currently inside a vehicle.

    IMPORTANT:

        The vehicle's crew is snapshotted before any occupants are
        removed. This prevents the crew array changing while it is
        being iterated.

        Player corpses are NOT deleted. They are moved out of the
        vehicle instead.

        AI corpses are deleted using deleteVehicleCrew.

        The function does NOT require execution on the server.
        It automatically redirects execution to the vehicle's
        owning machine when required.

    Usage:

        [player] call mf_vn_delete_dead_vehicle_occupants;
*/

params [
    ["_player", objNull, [objNull]]
];

// Validate the supplied object
if (isNull _player) exitWith {};
if (!isPlayer _player) exitWith {};

// Find the vehicle the player is currently occupying
private _vehicle = objectParent _player;

if (isNull _vehicle) exitWith {};

// If the vehicle is not local to this machine, execute the cleanup
// where the vehicle is local.
if (!local _vehicle) exitWith {
    [_player] remoteExecCall ["mf_vn_delete_dead_vehicle_occupants", owner _vehicle];
};

private _deadCrew = crew _vehicle select {
    !alive _x
};

{
    private _unit = _x;

    if (isPlayer _unit) then {
        // Usually can't delete a player corpse.
        moveOut _unit;
    } else {
        _vehicle deleteVehicleCrew _unit;
    };
} forEach _deadCrew;