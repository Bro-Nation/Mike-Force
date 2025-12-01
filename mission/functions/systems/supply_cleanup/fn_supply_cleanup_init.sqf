/*
    File: fn_supply_cleanup_init.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds "Clean Up Supply Boxes" actions to all supply dump objects.

    Example:
        call fn_supply_cleanup_init;
*/

// Get all missionNamespace variable names starting with "supply_cleanup"
private _dumpsters = allVariables missionNamespace select {_x find "supply_cleanup" isEqualTo 0} apply {missionNamespace getVariable [_x,objNull]};

// Add Clean Up action to each supply box
{
    if (!isNull _x) then {
        _x addAction [
            "Clean Up Supply Boxes",
            {
                params ["_target","_caller","_actionId","_arguments"];
                ["supplyCleanup",[_target]] call para_c_fnc_call_on_server;
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
} forEach _dumpsters;