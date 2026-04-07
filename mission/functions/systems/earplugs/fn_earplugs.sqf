/*
    File: fn_earplugs.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Enables/disables earplugs.

    Parameter(s):
        _status - Description [BOOL]

    Returns: nothing

    Example(s):
	    ["",true] call vn_mf_fnc_earplugs;
*/

params
[
	"_status" 		// 0 : BOOLEAN - status of earplugs
];

localNamespace setVariable ["vn_mf_earplugs",_status];
systemChat localize (["STR_VN_QOL_EARPLUGS_OUT","STR_VN_QOL_EARPLUGS_IN"] select _status);
private _isInVehicle = vehicle player != player;

// Get the appropriate volume based on the player's state
private _volume = if (_isInVehicle) then {
    missionNamespace getVariable ["vn_mf_earplugs_volume_vehicle", 0.5]
} else {
    missionNamespace getVariable ["vn_mf_earplugs_volume_ground", 0.5]
};

// Apply the volume
_volume fadeSound ([1, _volume] select _status);
