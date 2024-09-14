/*
    File: fn_earplugs_toggle.sqf
    Author: "DJ" Dijksterhuis
    Public: No

    Description:
	    Enables/disables earplugs depending on whether earplugs are already disabled/enabled.

    Parameter(s): none

    Returns: nothing

    Example(s):
	    [] call vn_mf_fnc_earplugs_toggle;
*/

// do the opposite of whatever the current status is
private _newStatus = !(localNamespace getVariable ["vn_mf_earplugs", false]);
[_newStatus] call vn_mf_fnc_earplugs;
