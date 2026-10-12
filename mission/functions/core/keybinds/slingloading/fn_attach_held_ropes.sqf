/*
    fn_attach_held_ropes.sqf

    Author: TernaryOperator

    Attaches the ASL rope set the player is currently holding to the object they
    are looking at (cursorTarget), exactly like ASL's own "Attach To Vehicle"
    action does. If either the helicopter or the cargo is asset-locked, it is
    unlocked first and the attach only happens once the unlock has fully completed.

    Params:
        None

    Returns:
        BOOL - true if the attach was started (or the unlock was started and the
               attach is queued behind it)
               false if the attach was rejected up front (see Behaviour)

    Behaviour:

        Uses the player's ASL_Ropes_Vehicle variable to find the helicopter and
        rope set being held, and cursorTarget as the cargo. Rejected up front,
        with a systemChat message, when:

            - not run on a machine with an interface
            - ASL is not loaded
            - the player isn't holding any ropes
            - the helicopter the ropes belong to is gone or dead
            - the player isn't looking at anything
            - the cargo is the helicopter the ropes came from
            - the player is inside a vehicle
            - the cargo is more than 10 m from the player
            - ASL doesn't consider the cargo supported (ASL_Is_Supported_Cargo)
            - the vehicle unlock function is unavailable on the server
              (only checked when the helicopter or cargo is asset-locked)

        Asset-locked objects (vn_mf_g_veh_asset_locked) are unlocked through
        vn_mf_fnc_veh_asset_unlock_vehicle. That runs on the server, because
        enableSimulationGlobal needs it. The attach is then deferred until
        every unlocked object has simulation enabled, is no longer asset-locked
        and is no longer hard-locked (locked > 1). Otherwise the attach happens
        immediately.

        Conditions are re-checked just before the attach actually happens, since
        the player may have moved, dropped the ropes, or lost the helicopter or
        cargo during the unlock wait. The attach also fails if the cargo is locked
        by something other than the asset lock system (when
        ASL_LOCKED_VEHICLES_ENABLED is false and locked > 1).

        The attach is confirmed by watching the helicopter's public "ASL_Cargo"
        array for up to 5 seconds. A success or failure message is shown
        accordingly.

    IMPORTANT:

        The return value only says the process was started, NOT that the ropes
        attached. The attach is asynchronous, so confirmation arrives later via
        systemChat.

        Ropes that are too short to reach the cargo fail the confirmation check.
        Extend them or move the helicopter closer (can also now be done with the keybindings
		if the player is close enough to the helo)

    Usage:

        call vn_mf_fnc_attach_held_ropes;

    Locality:

        Client only. Exits immediately with false on a machine without an
        interface (dedicated server, headless client), as it relies on player,
        cursorTarget and systemChat.
        Locality of the helicopter is handled by ASL: ASL_Attach_Ropes forwards
        itself (remoteExec) to the helicopter's owner when it isn't local here.
        Unlocking is forwarded to the server (remoteExec to 2) unless this machine
        is the server.

    Dependencies:

        Advanced Sling Loading (ASL_Attach_Ropes, ASL_Is_Supported_Cargo)
        CBA (CBA_fnc_waitUntilAndExecute)
        vn_mf_fnc_veh_asset_unlock_vehicle
*/

if (!hasInterface) exitWith {
	false
};

if (isNil "ASL_Attach_Ropes") exitWith {
	systemChat "Advanced Sling Loading isn't loaded.";
	false
};

private _held = player getVariable ["ASL_Ropes_Vehicle", []];
if (_held isEqualTo []) exitWith {
	systemChat "You aren't holding any ropes.";
	false
};
_held params ["_vehicle", "_ropesIndex"];

if (isNull _vehicle || {
	!alive _vehicle
}) exitWith {
	systemChat "The vehicle those ropes belong to is gone.";
	false
};

private _cargo = cursorTarget;

if (isNull _cargo) exitWith {
	systemChat "You aren't looking at anything.";
	false
};

if (_cargo isEqualTo _vehicle) exitWith {
	systemChat "You can't attach the ropes to the vehicle they came from.";
	false
};

if (vehicle player != player) exitWith {
	systemChat "You can't attach ropes from inside a vehicle.";
	false
};

if (player distance _cargo > 10) exitWith {
	systemChat "Target is too far away (max 10m).";
	false
};

if !([_vehicle, _cargo] call ASL_Is_Supported_Cargo) exitWith {
	systemChat "That can't be sling loaded.";
	false
};

private _doAttach = {
	params ["_vehicle", "_cargo"];

	if (isNull _cargo || {
		!alive _cargo
	} || {
		isNull _vehicle
	} || {
		!alive _vehicle
	}) exitWith {
		systemChat "The helicopter or cargo is gone/destroyed";
	};
	if ((player getVariable ["ASL_Ropes_Vehicle", []]) isEqualTo []) exitWith {
		systemChat "You're no longer holding the ropes.";
	};
	if (player distance _cargo > 10) exitWith {
		systemChat "Target is too far away (max 10m).";
	};
	
	// Locked by something other than the asset lock system, which we can't undo
	// and shouldn't even try anymore
	if (!(missionNamespace getVariable ["ASL_LOCKED_VEHICLES_ENABLED", false]) && {
		locked _cargo > 1
	}) exitWith {
		systemChat "Target is locked and can't be unlocked.";
	};

	// ASL handles locality itself: if _vehicle isn't local here, 
	// it remoteExecs ASL_Attach_Ropes to the vehicle's owner.
	[_cargo, player] call ASL_Attach_Ropes;

	// Confirm via public state, readable from any machine.
	// On success ASL adds _cargo to _vehicle's public "ASL_Cargo" array.
	[
		{
			params ["_vehicle", "_cargo"];
			_cargo in (_vehicle getVariable ["ASL_Cargo", []])
		},
		{
			params ["_vehicle", "_cargo"];
			systemChat format ["Ropes attached to %1.", getText (configOf _cargo >> "displayName")];
		},
		[_vehicle, _cargo],
		5,
		{
			systemChat "Failed to attach the ropes. If the ropes are too short, extend them or move the helicopter closer.";
		}
	] call CBA_fnc_waitUntilAndExecute;
};

// 4. Unlock whichever of the two are asset-locked
private _toUnlock = [_vehicle, _cargo] select {
	_x getVariable ["vn_mf_g_veh_asset_locked", false]
};

// If there is nothing unlock happy days, can just do the attach
if (_toUnlock isEqualTo []) exitWith {
	[_vehicle, _cargo] call _doAttach;
	true
};

// Something did/is locked so now we need to handle that properly
if (isServer && {
	isNil "vn_mf_fnc_veh_asset_unlock_vehicle"
}) exitWith {
	systemChat "Vehicle is locked and the unlock function isn't available.";
	false
};

systemChat "Unlocking vehicle(s)...";
{
	// enableSimulationGlobal in the unlock function needs to run on the server
	if (isServer) then {
		[_x] call vn_mf_fnc_veh_asset_unlock_vehicle;
	} else {
		[_x] remoteExec ["vn_mf_fnc_veh_asset_unlock_vehicle", 2];
	};
} forEach _toUnlock;

// Wait until unlocked objects are *fully* unlocked locally
// I do like CBA_fnc_waitUntilAndExecute
[
	{
		params ["_toUnlock"];
		_toUnlock findIf {
			!isNull _x && {
				(_x getVariable ["vn_mf_g_veh_asset_locked", false])
				|| {
					!simulationEnabled _x
				}
				|| {
					locked _x > 1
				}
			}
		} == -1
	},
	{
		params ["_toUnlock", "_vehicle", "_cargo", "_doAttach"];
		[_vehicle, _cargo] call _doAttach;
	},
	[_toUnlock, _vehicle, _cargo, _doAttach],
	5,
	{
		systemChat "Couldn't unlock the vehicle(s), ropes not attached.";
	}
] call CBA_fnc_waitUntilAndExecute;

true