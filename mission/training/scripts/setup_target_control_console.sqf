/*
    setup_target_control_console.sqf
    Adds reset/cleanup actions to a control object and makes it inert.

    Params: [_target]
*/

private _target = objNull;

if (_this isEqualType []) then {
    if ((count _this) > 0) then {
        private _candidate = _this select 0;
        if (_candidate isEqualType objNull) then {
            _target = _candidate;
        };
    };
} else {
    if (_this isEqualType objNull) then {
        _target = _this;
    };
};

if (isNull _target) exitWith {};

_target addAction ["RESET POP-UP TARGETS", {
    0 = [1200, iCenter] execVM "training\scripts\reset_targets.sqf";
}];

_target allowDamage false;
_target enableSimulation false;

_target addAction ["CLEAR HIT MARKERS", {
	params ["_target", "_caller"];
    {
        deleteVehicle _x;
    } forEach (_caller getVariable ["hitMarkers", []]);
}, 0, 0, true, true, "", "_target distance _this < 3"];
