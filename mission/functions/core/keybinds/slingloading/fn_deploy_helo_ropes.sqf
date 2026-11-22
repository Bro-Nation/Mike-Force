/*
	    fn_deploy_helo_ropes.sqf
	
	    Author: TernaryOperator
	
	    Deploys the requested TOTAL NUMBER OF rope sets.
	    Informs the user if for logical reasons it can't match the request
	
	    Works when the player is the current pilot of an ASL helicopter, or when the
	    player is on foot within 20 m of an ASL-supported helicopter (see
	    vn_mf_fnc_valid_state_for_asl).
	
	    params:
	        _player          (OBJECT) - unit whose helicopter should deploy its ropes
	                                   (the vehicle they pilot, or the nearest ASL
	                                   helicopter within 20 m if on foot)
	        _numberOfRopes   (NUMBER) - total number of rope sets to deploy
	                                   default: 1
	
	    Returns:
	        NUMBER - number of rope sets deployed
	                 0 if deployment was refused or failed
	
	    behaviour:
	
	        [player, 1] -> deploys 1 rope set
	        [player, 2] -> deploys 2 rope sets
	        [player, 3] -> deploys 3 rope sets
	
	        if ANY rope sets are already deployed, nothing is deployed.
	        The player is told that the existing ropes must be retracted
	        before deploying a new configuration.
	
	        After deploying, the helicopter's "lock last toggled" timestamp is
	        pushed into the future so the idle auto-relock can't trigger while the
	        ground crew shouldn't hooking up cargo. It will still relock just slightly
	        later than otherwise (in case the player deploys the ropes and then goes to
	        watch youtube/tiktok)
	
	    IMPORTANT:
	
	        _numberOfRopes is the TOTAL desired rope count, not an
	        additional/incremental count.
	
	        Therefore:
	
	            [player, 1]
	            [player, 2]
	            [player, 3]
	
	        are different deployment configurations.
	
	        if ropes are already active, the function will not add more.
	        They must be fully retracted first.
	        
	    Usage:
	        
	        [player, 1] call vn_mf_fnc_deploy_helo_ropes;
*/

params [
	["_player", objNull, [objNull]],
	["_numberOfRopes", 1, [0]]
];

// Check we conform with expectations (ASL loaded, pilot of a heli or on foot
// within range of one) and get the helicopter we are operating
private _heli = [_player, true] call vn_mf_fnc_valid_state_for_asl;

if (isNull _heli) exitWith {
	0
};

// Guard clause, since number could be 1.5 (shouldn't be but could be)
_numberOfRopes = floor _numberOfRopes;

// exit since makes no sense to deploy less than one rope
if (_numberOfRopes < 1) exitWith {
	0
};

// Player is interacting with vehicle and it's locked, reasonable to unlock it
// this has the nice UX that if they deploy ropes on a locked vic since it's
// unlocked the ropes deploy immediately
if (_heli getVariable ["vn_mf_g_veh_asset_locked", false]) then {
	[_heli] call vn_mf_fnc_veh_asset_unlock_vehicle;
};

// Retrieve the current rope array (note: read from ASL variables)
private _existingRopes = _heli getVariable ["ASL_Ropes", []];

// ASL_Ropes can contain:
// 
//     []                    = no rope set deployed at this index
//     [rope, rope, rope, rope] = rope set is deployed
// Loop them, if any entry contains ropes, we refuse and tell the user to retract
// redeploy, in theory we could add the additional ropes where > existing but
// that gets complicated because what if they are slinging 2 ropes and request 1 etc
private _activeRopes = 0;

{
	if ((count _x) > 0) then {
		_activeRopes = _activeRopes + 1;
	};
} forEach _existingRopes;

// Inform the user to fully retract (i.e. de facto reset) before requesting ropes
if (_activeRopes > 0) exitWith {
	systemChat format [
		"Cannot deploy %1 rope set%2: %3 rope set%4 already deployed. Retract existing ropes first.",
		_numberOfRopes,
		if (_numberOfRopes == 1) then {
			""
		} else {
			"s"
		},
		_activeRopes,
		if (_activeRopes == 1) then {
			""
		} else {
			"s"
		}
	];

	0
};

// Refuse the request if ropes are deployed
if ((count _existingRopes) > 0) exitWith {
	systemChat "Cannot deploy new rope configuration: existing rope slots must be fully retracted first.";

	0
};

// count the number of points
private _slingLoadPoints = [_heli] call ASL_Get_Sling_Load_Points;

private _maxRopes =
count _slingLoadPoints;

if (_maxRopes <= 0) exitWith {
	systemChat "Vehicle doesn't support cargo ropes";
	0
};

// We could deploy the max if requested is greater than max but better
// to not surprise the user, instead just inform them what the limit is
// for whatever vehicle they are in.
if (_numberOfRopes > _maxRopes) exitWith {
	systemChat format [
		"Cannot deploy %1 rope sets. This vehicle supports a maximum of %2.",
		_numberOfRopes,
		_maxRopes
	];

	0
};

// Deploy exactly what they requested
[_heli, _player, _numberOfRopes] call ASL_Deploy_Ropes;

// When ropes are deployed we nudge the timestamp so that we don't relock.
// In theory we could alter this upstream *but* that's a larger change than I
// think makes sense and the relock logic is important for performance in ways
// I'm not comfortable I fully understand the impact of.
// One day I'll rewrite ASL to emit events...
// 
// The server's relock check is: serverTime - last_toggled > vn_mf_veh_asset_relock_time
// Setting last_toggled in the FUTURE makes the left side negative, so the check
// can't pass until serverTime catches up.
// 
// Theoretically doable with a wait loop/tombstone value but that has a lot more complexity
// edge cases
// 
// Earliest relock = deploy time + _holdTime + vn_mf_veh_asset_relock_time
private _holdTime = 90; // seconds
private _holdUntil = serverTime + _holdTime;

// max so that redeploying can never shorten an existing hold
// Broadcast (true) since the server reads this variable
_heli setVariable [
	"vn_mf_g_veh_asset_lock_last_toggled",
	_holdUntil max (_heli getVariable ["vn_mf_g_veh_asset_lock_last_toggled", 0]),
	true
];

// Verification - since ASL_Deploy_Ropes has variable locality (locally or remotely)
// We can't report success until we *check* that they deployed as requested
private _deployedRopes = _heli getVariable ["ASL_Ropes", []];

private _deployedCount = 0;

{
	if ((count _x) > 0) then {
		_deployedCount = _deployedCount + 1;
	};
} forEach _deployedRopes;

if (_deployedCount == _numberOfRopes) then {
	// local update - We know they where deployed
	systemChat format [
		"%1 rope set%2 deployed",
		_deployedCount,
		if (_deployedCount == 1) then {
			""
		} else {
			"s"
		}
	];

	_deployedCount
} else {
	// Remote update - We know it was requested
	systemChat format [
		"Rope deployment requested: %1 rope set%2.",
		_numberOfRopes,
		if (_numberOfRopes == 1) then {
			""
		} else {
			"s"
		}
	];

	_deployedCount
};