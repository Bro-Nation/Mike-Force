/*
	    fn_valid_state_for_asl.sqf
	
	    Author: TernaryOperator
	
	    Checks whether the given player is in a position to operate Advanced Sling
	    Loading (ASL) ropes, and (optionally) tells the caller WHICH helicopter
	    they would be operating.
	
	    A player qualifies in one of two ways:
	
	        A) in a helicopter / VTOL as its current pilot (the original behaviour), or
	        B) ON FOOT within 20 m of a helicopter / VTOL that supports ASL.
	
	    params:
	        _player          (OBJECT) - player to check
	                                    default: objNull
	        _returnHeli      (BOOL)   - false: return a BOOL (backwards compatible)
	                                    true : return the helicopter OBJECT to operate
	                                           (objNull if the check failed)
	                                    default: false
	        _silent          (BOOL)   - true suppresses all systemChat messages
	                                    default: false
	
	    Returns:
	        BOOL   - (_returnHeli = false) true if the player may operate ASL ropes
	        OBJECT - (_returnHeli = true)  the helicopter to operate, or objNull
	
	    behaviour:
	
	        player is in a vehicle:
	
	            1. vehicle must be a Helicopter or VTOL_Base_F, otherwise false (silent).
	            2. player must be the current pilot (currentPilot, not just driver), 
	               otherwise false ("You are not in control of the helicopter").
	            3. The required ASL functions must exist
               (otherwise "No Advanced Sling Loading Support on this machine, Check https// discord.gg/bro-nation").
	            4. The vehicle must be recognised by ASL_Is_Supported_Vehicle.
	
	        player is ON FOOT:
	
	            1. All Helicopter / VTOL_Base_F vehicles near the player are considered.
	            2. The ASL functions must exist (only reported if a helicopter is
	               actually nearby, so pressing the keybind elsewhere stays silent).
	            3. Candidates must be recognised by ASL_Is_Supported_Vehicle.
	            4. The distance is measured from the player to the nearest point of the
	               helicopter's bounding box (not its centre), so standing at the tail of
	               a big helicopter such as a Chinook still counts as "within 20 m".
	            5. The closest helicopter within 20 m is used.
	               No helicopter in range -> false (silent).
	
	        No pilot / control check is applied to a player on foot, since they are
	        by definition not flying the aircraft.
	
	    ASL Functions Checked:
	
	        ASL_Deploy_Ropes_Index
	        ASL_Deploy_Ropes
	        ASL_Extend_Ropes
	        ASL_Get_Active_Ropes_With_Cargo
	        ASL_Get_Active_Ropes
	        ASL_Get_Ropes_Count
	        ASL_Get_Sling_Load_Points
	        ASL_Is_Supported_Vehicle
	        ASL_Release_Cargo
	        ASL_Retract_Ropes
	        ASL_Shorten_Ropes
	
	    Usage:
	
        // Simple check (unchanged from before)
	        if ([player] call vn_mf_fnc_valid_state_for_asl) then {
		...
	};
	
        // get the helicopter to operate (works from the pilot seat or on foot)
	        private _heli = [player, true] call vn_mf_fnc_valid_state_for_asl;
	        if (isNull _heli) exitWith {};
	
        // Quiet lookup, e.g. for read-only displays
	        private _heli = [player, true, true] call vn_mf_fnc_valid_state_for_asl;
	
	    Locality:
	
	        Safe to call on any machine.
	        Only checks ASL availability and vehicle support on the machine where it
	        is executed. It does not perform any remote execution.
*/

params [
	["_player", objNull, [objNull]],
	["_returnHeli", false, [false]],
	["_silent", false, [false]]
];

// How close (metres) an on-foot player must be to a helicopter to operate its ropes
private _onFootRange = 20;

// Define a single exit function so we are *consistent* in all cases and return what
// the caller was expecting, null if _returnHeli is false, false otherwise
private _fail = {
	if (_returnHeli) then {
		objNull
	} else {
		false
	}
};

if (isNull _player) exitWith _fail;

private _vehicle = vehicle _player;
private _onFoot = _vehicle isEqualTo _player;

// Helper: do we have every ASL function we need? (Messages the player if not)
private _haveAsl = {
	private _aslFns = [
		"ASL_Deploy_Ropes_Index",
		"ASL_Deploy_Ropes",
		"ASL_Extend_Ropes",
		"ASL_Get_Active_Ropes_With_Cargo",
		"ASL_Get_Active_Ropes",
		"ASL_Get_Ropes_Count",
		"ASL_Get_Sling_Load_Points",
		"ASL_Is_Supported_Vehicle",
		"ASL_Release_Cargo",
		"ASL_Retract_Ropes",
		"ASL_Shorten_Ropes"
	];

	if (({
		isNil _x
	} count _aslFns) > 0) exitWith {
		if (!_silent) then {
			systemChat "No Advanced Sling Loading Support on this machine, Check https// discord.gg/bro-nation"
		};
		
		false
	};

	true
};

private _heli = objNull;

// Handle differently depending on whether player is on foot
if (_onFoot) then {
	// Candidate Helicopters - *fast* filter with safe padding for large vehicles (40)
	private _candidates = nearestObjects [_player, ["Helicopter", "VTOL_Base_F"], _onFootRange + 40];

	// No Helo in range so just fail out
	if (_candidates isEqualTo []) exitWith _fail;

	    // There is a helicopter nearby, so it's now worth complaining if ASL is missing
	if !(call _haveAsl) exitWith _fail;

	private _playerPosAGL = ASLToAGL (getPosASL _player);

	// Running total, eventually contains the best candidate if any
	private _bestDistance = _onFootRange;

	{
		if ([_x] call ASL_Is_Supported_Vehicle) then {
			// distance for this candidate to the player pos
			private _distance = [_x, _playerPosAGL] call vn_mf_fnc_distance_to_bounding_box;
			if (_distance <= _bestDistance) then {
				_bestDistance = _distance;
				_heli = _x;
			};
		};
	} forEach _candidates;
} else {
	// not a helicopter/vtol
	if !((_vehicle isKindOf "Helicopter") || {
		_vehicle isKindOf "VTOL_Base_F"
	}) exitWith _fail;

	    // player must be the currentPilot (cleanly handles co-pilot/control hand over)
	if !(_player isEqualTo currentPilot _vehicle) exitWith {
		if (!_silent) then {
			systemChat "You are not in control of the helicopter"
		};
		call _fail
	};

	    // Check we have ASL available and that the functions we need exist
	if !(call _haveAsl) exitWith _fail;

	    // vehicle must have ASL Support
	if ([_vehicle] call ASL_Is_Supported_Vehicle) then {
		_heli = _vehicle;
	};
};

if (isNull _heli) exitWith _fail;

// Caller wants the helicopter itself, otherwise just a yes
if (_returnHeli) then {
	_heli
} else {
	true
}