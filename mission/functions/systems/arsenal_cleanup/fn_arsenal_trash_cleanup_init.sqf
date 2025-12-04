/*
    File: fn_arsenal_trash_cleanup_init.sqf
    Author: Savage Game Design
	modified by: Tylervip
    Public: Yes

    Description:
        Initialise all trashcans on the map near arsenals by finding
        all missionNamespace variables starting with "arsenal_cleanup"
        and adding the Clean Up action.

    Parameter(s):
        None

    Returns:
        None

    Example(s):
        call vn_mf_fnc_arsenal_trash_cleanup_init;
*/

// Get all missionNamespace variable names starting with "arsenal_cleanup"
private _trashCans = allVariables missionNamespace select {_x find "arsenal_cleanup" isEqualTo 0} apply {missionNamespace getVariable [_x,objNull]};

// Add Clean Up action to each trashcan
{
    if (!isNull _x) then {
        _x addAction [
            "Clean Up",
            {
                params ["_target","_caller","_actionId","_arguments"];
                ["arsenalcleanup",[_target]] call para_c_fnc_call_on_server;
            },
            nil,
            1.5,
            true,
            true,
            "",
            "true",
            5,
            false,
            "",
            ""
        ];
    };
} forEach _trashCans;
