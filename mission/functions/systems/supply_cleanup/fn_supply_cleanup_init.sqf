/*
    File: fn_supply_cleanup_init.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Adds "Clean Up Supply Boxes" actions to all supply dump objects.

    Example:
        call fn_supply_cleanup_init;
*/

private _dumpsters = allMapMarkers select {_x find "supply" isEqualTo 0};

{
    private _dumpster = missionNamespace getVariable [format["supply_cleanup_%1", _forEachIndex], objNull];
    if (isNull _dumpster) exitWith {};

    _dumpster addAction [
        "Clean Up Supply Boxes",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            ["supplyCleanup", [_target]] call para_c_fnc_call_on_server;
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
} forEach _dumpsters;