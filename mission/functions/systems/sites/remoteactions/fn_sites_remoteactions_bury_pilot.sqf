/*
	File: fn_sites_remoteactions_bury_pilot.sqf
	Author: @dijksterhuis
	Public: No
	
	Description:
		Buries a pilot by forcing the body underground.

		Probably a bit janky, but we can't use `hideBody` here as
		that only applies to units
		https://community.bistudio.com/wiki/hideBody
	
	Parameter(s):
		- _task - the respawn object
	
	Returns:
		nil
	
	Example(s):
		// from server
		[_body] call vn_mf_fnc_sites_remoteactions_bury_pilot;

		// from player attached holdAction
		[cursorObject] remoteExec ["vn_mf_fnc_sites_remoteactions_bury_pilot", 2];
*/

params ["_body"];

deleteVehicle _body;

// TODO: @dijksterhuis: This isn't working :/

/*
_body setVariable ["vn_mf_sites_object_zfixer_ignore", true];
_body enableSimulationGlobal false;

[_body] spawn {

	private _startTime = serverTime;

	while {true} do {

		private _newPos = [
			(getPosATL _this) # 0,
			(getPosATL _this) # 1,
			((getPosATL _this) # 2) - 0.01
		];
		_this setPosATL _newPos;
		sleep 0.005;

		// should be hidden now (hopefully)
		// TODO: we can generalise this to other objects by finding the maximum dimension.
		if ((_newPos # 2) < -1) then {break};
		// failsafe inc ase body refuses to clip through the ground
		if (serverTime > _startTime + 3) then {break};
	};
	deleteVehicle _this;
};
*/

nil;