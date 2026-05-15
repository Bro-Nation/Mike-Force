/*
    File: fn_isTentDeployed.sqf
    Author: tylervip
    Public: yes

    Description:
        Returns whether a vehicle's deployable tent is currently deployed.
        Uses the "hide_tent" animation: 0 = deployed, 1 = stowed/hidden.

    Parameter(s):
        _vehicle - Vehicle to check [OBJECT]

    Returns:
        True if tent is deployed, false otherwise [BOOL]

    Example(s):
        [myAPC] call vn_mf_fnc_isTentDeployed
*/

params ["_vehicle"];

if (isNull _vehicle) exitWith { false };

// hide_tent animation: 0 = deployed, 1 = stowed (hidden)
(_vehicle animationPhase "hide_tent") == 0
