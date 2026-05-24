/*
    PopUpTarget.sqf
    Called via HitPart event handler on pop-up targets.
    Animates the target to its fallen (hit) position.

    Params: [_target]
*/

params ["_target"];
if (isNull _target) exitWith {};

_target animate ["Terc", 1];
