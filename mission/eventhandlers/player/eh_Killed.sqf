/*
    File: eh_Killed.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Player Killed Event Handler.

    Parameter(s):
		_unit - Description [DATATYPE, defaults to DEFAULTVALUE]
		_killer - Description [DATATYPE, defaults to DEFAULTVALUE]
		_instigator - Description [DATATYPE, defaults to DEFAULTVALUE]
		_useEffects - Description [DATATYPE, defaults to DEFAULTVALUE]

    Returns: nothing

    Example(s):
		Not called directly.
*/

params
[
	"_unit",
	"_killer",
	"_instigator",
	"_useEffects"
];

// disable build mode
para_l_buildmode = nil;
para_l_placing = false;

private _type = "";
switch ( true ) do { 
	case (side _unit == west) : {  _type = "B_TargetSoldier"}; 
	case (side _unit == east) : {  _type = "O_TargetSoldier"}; 
	case (side _unit == independent) : {  _type = "I_TargetSoldier"}; 
	default {  _type = "B_TargetSoldier" }; 
};

(attachedObjects _unit) select {typeOf _x isEqualTo _type} apply {
    [_x] remoteExec ["detach", 2];
    [_x] remoteExec ["deleteVehicle", 2];
};
