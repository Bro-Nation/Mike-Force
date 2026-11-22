/*
	fn_pickup_nearest_ropes.sqf

	Author: TernaryOperator

	Picks up the nearest ASL rope set that is visible on the player's screen,
	from any supported helicopter around the player, exactly like ASL's own
	"Pickup Cargo Ropes" action does. If the helicopter is asset-locked, it is
	unlocked first and the pickup only happens once the unlock has fully
	completed.

	params:
		0: NUMBER - (Optional, default 20) search radius in metres

	Returns:
		BOOL - true if the pickup was started (or the unlock was started and the
		       pickup is queued behind it)
		       false if the pickup was rejected up front (see behaviour)

	behaviour:

		Searches for ASL-supported vehicles within the search radius
		(ASL_SUPPORTED_VEHICLES, or ASL_SUPPORTED_VEHICLES_OVERRIDE if set) and
		checks every active rope set on each of them. Only the free end of each
		rope is considered, and only when it is on the player's screen: in front
		of the camera and inside the screen bounds (worldToScreen result checked
		against safeZone). The rope set with the closest on-screen end to the
		player is the one picked up. Rejected up front, with a systemChat
		message, when:

			- not run on a machine with an interface
			- ASL is not loaded
			- the player is inside a vehicle
			- the player is already holding ropes
			- no rope sets are on screen within the search radius
			- the vehicle unlock function is unavailable on the server
			  (only checked when the helicopter is asset-locked)

		An asset-locked helicopter (vn_mf_g_veh_asset_locked) is unlocked through
		vn_mf_fnc_veh_asset_unlock_vehicle. That runs on the server, because
		enableSimulationGlobal needs it. The pickup is then deferred until the
		helicopter has simulation enabled, is no longer asset-locked and is no
		longer hard-locked (locked > 1). Otherwise the pickup happens immediately.

		Conditions are re-checked just before the pickup actually happens, since
		the player may have moved, entered a vehicle, grabbed other ropes, or lost
		the helicopter or rope set during the unlock wait. The pickup also fails if
		the helicopter is locked by something other than the asset lock system
		(when ASL_LOCKED_VEHICLES_ENABLED is false and locked > 1).

		The pickup is confirmed by watching the player's public
		"ASL_Ropes_Vehicle" variable for up to 5 seconds. A success or failure
		message is shown accordingly.

	IMPORTANT:

		The return value only says the process was started, not that the ropes
		were picked up. The pickup is asynchronous, so confirmation arrives later
		via systemChat.

		The "nearest" rope set is judged by the distance from the player to the
		free end of any rope in the set, but only ends currently on screen count. Ropes
		behind you or outside your field of view are ignored, so a set whose ends
		are hanging close to you but off screen will lose to a visible one further
		away. On screen does not mean unobstructed: worldToScreen doesn't check
		for objects in the way.

	Usage:

		call vn_mf_fnc_pickup_ropes;

		[50] call vn_mf_fnc_pickup_ropes;

	Locality:

		Client only. Exits immediately with false on a machine without an
		interface (dedicated server, headless client), as it relies on player
		and systemChat.
		Locality of the helicopter is handled by ASL: ASL_Pickup_Ropes forwards
		itself (remoteExec) to the helicopter's owner when it isn't local here.
		Unlocking is forwarded to the server (remoteExec to 2) unless this machine
		is the server.

	Dependencies:

		Advanced Sling Loading (ASL_Pickup_Ropes, ASL_Get_Active_Ropes,
		ASL_Get_Ropes)
		CBA (CBA_fnc_waitUntilAndExecute, CBA_missionTime)
		vn_mf_fnc_veh_asset_unlock_vehicle
*/

params [["_searchRadius", 20, [0]]];

if (!hasInterface) exitWith {
	false
};

if (isNil "ASL_Pickup_Ropes") exitWith {
	systemChat "Advanced Sling Loading isn't loaded.";
	false
};

// Early exit if player is in vic (don't want to pick up if they are)
if (vehicle player != player) exitWith {
	systemChat "You can't pick up ropes from inside a vehicle.";
	false
};
if !((player getVariable ["ASL_Ropes_Vehicle", []]) isEqualTo []) exitWith {
	systemChat "You're already holding ropes.";
	false
};

// Nearest onscreen rope from nearby vehicles
private _supported = missionNamespace getVariable ["ASL_SUPPORTED_VEHICLES_OVERRIDE", ASL_SUPPORTED_VEHICLES];

// Expand search by default for vic center from bounding box since not spherical
private _candidates = nearestObjects [player, _supported, _searchRadius + 100];

private _vehicle = objNull;
private _ropesIndex = 0;
private _closestDistance = _searchRadius; // only on-screen rope ends closer than this can win
private _playerPos = position player;

{
	private _candidate = _x;

	{
		private _index = _x select 0;

		// Each rope index is a set of 4 rope objects
		{
			private _ends = ropeEndPosition _x;
			if (count _ends == 2) then {
				
				// We only care about the one that isn't attached (since the end on the helo is)
				private _end = _ends#1;

				// boundary check what the player can actually see
				private _screen = worldToScreen _end;
				private _onScreen = false;
				if (count _screen == 2) then {
					_screen params ["_sx", "_sy"];
					private _inFront = ((getCameraViewDirection player) vectorDotProduct (_end vectorDiff (positionCameraToWorld [0, 0, 0]))) > 0;
					_onScreen = _inFront
						&& {_sx >= safeZoneX}
						&& {_sx <= (safeZoneX + safeZoneW)}
						&& {_sy >= safeZoneY}
						&& {_sy <= (safeZoneY + safeZoneH)};
				};

				if (_onScreen) then {
					private _dist = _playerPos distance _end;
					if (_dist < _closestDistance) then {
						_closestDistance = _dist;
						_vehicle = _candidate;
						_ropesIndex = _index;
					};
				};
			};
		} forEach ([_candidate, _index] call ASL_Get_Ropes);
	} forEach ([_candidate] call ASL_Get_Active_Ropes);
} forEach _candidates;

if (isNull _vehicle) exitWith {
	systemChat format ["No ropes in view within %1m.", _searchRadius];
	false
};

// 3. The pickup step, run immediately or after unlocking
private _doPickup = {
	params ["_vehicle", "_ropesIndex"];

	// Re-validate: state may have changed while waiting for the unlock
	if (isNull _vehicle || {
		!alive _vehicle
	}) exitWith {
		systemChat "The vehicle those ropes belong to is gone.";
	};
	if (vehicle player != player) exitWith {
		systemChat "You can't pick up ropes from inside a vehicle.";
	};
	if !((player getVariable ["ASL_Ropes_Vehicle", []]) isEqualTo []) exitWith {
		systemChat "You're already holding ropes.";
	};
	if !(_ropesIndex in (([_vehicle] call ASL_Get_Active_Ropes) apply {
		_x select 0
	})) exitWith {
		systemChat "Those ropes are no longer available.";
	};

	// Locked by something other than the asset lock system, which we can't undo
	if (!(missionNamespace getVariable ["ASL_LOCKED_VEHICLES_ENABLED", false]) && {
		locked _vehicle > 1
	}) exitWith {
		systemChat "Cannot pick up cargo ropes from a locked vehicle.";
	};

	// ASL handles locality itself: if _vehicle isn't local here,
	// it remoteExecs ASL_Pickup_Ropes to the vehicle's owner.
	[_vehicle, player, _ropesIndex] call ASL_Pickup_Ropes;

	// Confirm via public state, readable from any machine.
	// On success ASL sets the player's public "ASL_Ropes_Vehicle" to [_vehicle, _ropesIndex].
	[
		{
			params ["_vehicle", "_ropesIndex"];
			(player getVariable ["ASL_Ropes_Vehicle", []]) isEqualTo [_vehicle, _ropesIndex]
		},
		{
			params ["_vehicle"];
			systemChat format ["Picked up ropes from %1.", getText (configOf _vehicle >> "displayName")];
		},
		[_vehicle, _ropesIndex],
		5,
		{
			systemChat "Failed to pick up the ropes.";
		}
	] call CBA_fnc_waitUntilAndExecute;
};

// not locked, we can just pick them up
if !(_vehicle getVariable ["vn_mf_g_veh_asset_locked", false]) exitWith {
	[_vehicle, _ropesIndex] call _doPickup;
	true
};

if (isServer && {
	isNil "vn_mf_fnc_veh_asset_unlock_vehicle"
}) exitWith {
	systemChat "Vehicle is locked and the unlock function isn't available.";
	false
};

systemChat "Auto Unlocking vehicle...";

// enableSimulationGlobal in the unlock function needs to run on the server
// though unlock does more than that so we should call it properly
// can't just enableSimulationGlobal as it wouldn't be consistent
if (isServer) then {
	[_vehicle] call vn_mf_fnc_veh_asset_unlock_vehicle;
} else {
	[_vehicle] remoteExec ["vn_mf_fnc_veh_asset_unlock_vehicle", 2];
};

// Wait until the vehicle is fully unlocked on this machine (synced)
// flag cleared, simulation back on, lock level normal,
// after 5 seconds if not unlocked let user know, they can still unlock manually
[
	{
		params ["_vehicle"];
		isNull _vehicle || {
			!(_vehicle getVariable ["vn_mf_g_veh_asset_locked", false])
			&& {
				simulationEnabled _vehicle
			}
			&& {
				locked _vehicle <= 1
			}
		}
	},
	{
		params ["_vehicle", "_ropesIndex", "_doPickup"];
		// Theoretically possible if vehicle went away during the wait
		if (isNull _vehicle) exitWith {};
		[_vehicle, _ropesIndex] call _doPickup;
	},
	[_vehicle, _ropesIndex, _doPickup],
	5,
	{
		systemChat "Couldn't unlock the vehicle, ropes not picked up.";
	}
] call CBA_fnc_waitUntilAndExecute;

true
