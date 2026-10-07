/*
    File: fn_gasUnit.sqf
    Author: S. Cooper
    Public: No

    Description:
        Applies gas effects to a given unit

    Parameter(s): Object (Unit to gas)

    Returns: nothing

    Example(s): none
*/
params ["_unit"];

private _blurred = ppEffectCreate ["DynamicBlur", 500];


if (isPlayer _unit && _unit == player) then
{
    // Apply effects to given unit ONLY
    if (ppEffectEnabled _blurred == false) then {
        
        _blurred ppeffectadjust [5];
        _blurred ppEffectEnable true;
        _blurred ppeffectcommit 15;

        

        [_unit] spawn {

            _sound = (_this # 0) say3D "cough";

            sleep 6.135;

            deleteVehicle _sound;
        };

    };
} else {
    [_unit] spawn {

        _sound = (_this # 0) say3D "cough";

        sleep 6.135;

        deleteVehicle _sound;
    };
};


// Force AI to disperse (fleeing)
if (!isPlayer _unit) then
{
    // Force AI to get off static weapons
    if ((vehicle _unit) isKindOf "StaticWeapon") then
    {
        [_unit] orderGetIn false;
    };
    _unit setBehaviour "CARELESS";
    _unit move (_unit getRelPos [75, random 360]);

};

// Effects wear off
[_unit, _blurred] spawn {
    _gasTimer = [15] call BIS_fnc_countdown;

    waitUntil {[0] call BIS_fnc_countdown < 1};

    // Apply effects to given unit ONLY
    (_this # 1) ppeffectadjust [0];
    (_this # 1) ppEffectEnable false;
    (_this # 1) ppeffectcommit 0;


    (_this # 0) setBehaviour "AWARE";
};