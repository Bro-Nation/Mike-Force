/*
    File: training_fall_protection_monitor.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Client-side monitor for training tunnel bounds.
        If a player in a training tunnel moves too far from the assigned
        tunnel teleport, they are returned to the tunnel entrance.

    Parameter(s):
        _unit - Unit to monitor [OBJECT]
        _maxDistance - Maximum allowed 2D distance from exit teleport [NUMBER]

    Returns:
        Nothing

    Example(s):
        [player, 100] execVM "training\scripts\tunnel\training_fall_protection_monitor.sqf"
*/

if (!hasInterface) exitWith {};

params [
    ["_unit", player],
    ["_maxDistance", 100]
];

if (isNull _unit) exitWith {};
if (!local _unit) exitWith {};
if (_unit getVariable ["vn_mf_training_fall_monitor_running", false]) exitWith {};

_unit setVariable ["vn_mf_training_fall_monitor_running", true];

[_unit, _maxDistance] spawn {
    params ["_unit", "_maxDistance"];

    while {
        alive _unit &&
        {_unit getVariable ["inTunnel_training", false]}
    } do {
        private _exitTeleport = _unit getVariable ["tunnelExitTeleport_training", objNull];

        if (!isNull _exitTeleport && {_unit distance2D _exitTeleport > _maxDistance}) then {
            private _source = _exitTeleport getVariable ["linkedTunnel_training", objNull];

            if (!isNull _source) then {
                _unit setPosATL (getPosATL _source);
            } else {
                private _fallbackPos = _exitTeleport getVariable ["exitPosition_training", []];
                if (_fallbackPos isNotEqualTo []) then {
                    _unit setPosATL _fallbackPos;
                };
            };

            _unit setUnitFreefallHeight 100;
            _unit setVariable ["inTunnel_training", false, true];
            _unit setVariable ["tunnelExitTeleport_training", objNull, true];
            hint "You left tunnel bounds and were returned to the entrance.";
        };

        sleep 2;
    };

    _unit setVariable ["vn_mf_training_fall_monitor_running", false];
};