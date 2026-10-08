/*
    File: fn_action_crew_static.sqf
    Author: Legend
    Public: No

    Description:
        Adds OPFOR action to request an AI crewman for an uncrewed static.

    Parameter(s):
        None

    Returns:
        Nothing
*/

private _conditionToShow = "[player, cursorTarget] call vn_mf_fnc_action_can_crew_static";

player addAction [
    "<t color='#A04406'>Crew Static</t>",
    {
        params ["_actionTarget", "_caller", "_actionId", "_arguments"];

        // This action is attached to the player, so _actionTarget is the player object.
        // Resolve the actual intended static weapon from the current cursor target.
        private _static = cursorTarget;

        private _status = [_caller, _static, true] call vn_mf_fnc_action_can_crew_static;
        private _allowed = false;
        private _reason = "Crew Static request blocked.";

        if (_status isEqualType []) then {
            _allowed = _status param [0, false, [false]];
            _reason = _status param [1, _reason, [""]];
        } else {
            if (_status isEqualType false) then {
                _allowed = _status;
            };
        };

        if (!_allowed) exitWith {
            ["OpforTroopRequestFailed", [_reason]] call para_c_fnc_show_notification;
        };

        ["opforcrewstatic", [_static]] call para_c_fnc_call_on_server;
    },
    nil,
    -10,
    true,
    true,
    "",
    _conditionToShow,
    6,
    false,
    "",
    ""
];
