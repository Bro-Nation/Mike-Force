
/*
    File: fn_adv_explosives_water_addAction.sqf
    Author: veteran29
    Modified By: 04 SN S. "Scoop" Cooper
    Date: 2022-03-25
    Public: Yes

    Description:
        Add in water placement action for explosive magazine. Explosives placed in water can only be attached to objects.

    Parameter(s):
        _unit       - Unit to add the action to                 [OBJECT]
        _magazine   - Magazine that will be placeable in water  [STRING]

    Returns:
        Action ID [NUMBER]

    Example(s):
        [player, "vn_mine_limpet_01_mag"] call vn_fnc_adv_explosives_water_addAction;
*/

#define VAR_ACTION_ID (format ["vn_adv_explosives_water_act$%1", _magazine])

params [
    ["_unit", objNull, [objNull]],
    ["_magazine", "", [""]]
];


private _name = format [localize "STR_Action_PutBomb", getText (configFile >> "CfgMagazines" >> _magazine >> "displayName"), '%1'];

_id = _unit addAction [
    _name,
    {
        if (vn_explosive_actionInProgress) exitWith {};
        params ["_target", "", "", "_args"];
        _args params ["_magazine"];

        [_target, _magazine] call vn_mf_fnc_uwChargeDoPlace;
    },
    [_magazine],
    1,
    false,
    false,
    "",
    // build the condition function
    format [toString {
        private _unit = _this;
        private _pos = getPosWorld _unit;

        surfaceIsWater _pos && (_pos#2 < 0)
        && {
            private _magazine = "%1";
            _magazines = magazines _unit;
            _magazine in _magazines
        && (
            // update the action text, only when action menu is visible
            !isActionMenuVisible || {
                    private _name = "%2";
                    _unit setUserActionText [
                        _actionId,
                        format [_name, {_x == _magazine} count _magazines]
                    ];
                    true
                }
            )
        }
    }, _magazine, _name],
    0.001
];
_unit setVariable [VAR_ACTION_ID, _id];

// Respawn EH is persistent, add only once
private _respawnEh = _unit getVariable [format ["vn_adv_explosives_water_respawn$%1", _magazine], -1];;
if (_respawnEh == -1) then {
    // add the action back after respawn
    _respawnEh = _unit addEventHandler ["Respawn", format [toString {
        params ["_player", "_oldPlayer"];
        private _magazine = "%1";

        _oldPlayer removeAction (_oldPlayer getVariable [VAR_ACTION_ID, -1]);
        _player setVariable [VAR_ACTION_ID, nil];

        [_player, _magazine] call vn_mf_fnc_uwChargeAddAction;
    }, _magazine]];
    _unit setVariable [format ["vn_adv_explosives_water_respawn$%1", _magazine], _respawnEh];
};


nil // return
