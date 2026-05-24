/*
    PopUpTarget.sqf
    Called via HitPart event handler on pop-up targets.
    Animates the target to its fallen (hit) position.

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

_target animate ["Terc", 1];
