/*
    File: eh_GetOutMan.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Fires on the 'GetOutMan' event on the client
    
    Parameter(s):
		_unit - Unit the event handler is assigned to [Object]
		_vehicle - Vehicle the unit exited [Object]
		_role - Can be either "driver", "gunner" or "cargo" [String]
		_turret - Turret path [Array]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_unit", "_vehicle", "_role", "_turret"];

// Switch earplug volume when exiting vehicle
if (localNamespace getVariable ["vn_mf_earplugs", false]) then {
	private _volume = missionNamespace getVariable ["vn_mf_earplugs_volume_ground", 0.5];
	_volume fadeSound _volume;
};
