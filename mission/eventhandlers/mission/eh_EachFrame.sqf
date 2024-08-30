/*
    File: eh_EachFrame.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Executes code each frame.

    Parameter(s): none

    Returns: nothing

    Example(s):
        Not called directly.
*/

// set the specific unit's stamina based on provided modifier value.
private _fnc_unitSetStamina = {
    params ["_unit", "_stamMod"];

    diag_log format ["Setting unit's stamina: StamMod=%1 NewStamina=%2", _stamMod, getFatigue _unit - _stamMod];
    _unit setFatigue (0 max (getFatigue _unit - _stamMod));
    diag_log format ["Unit's new stamina: %1", getFatigue _unit];

};

// change the unit's stamina based on the current surface
private _fnc_unitStaminaModifier = {
    params ["_unit"];

    // only increase stamina when the player lowers their weapon
    if !(weaponLowered _unit) exitWith {nil};

    // fatigue applied to unit over time is decreased when moving over easier terrain
    switch (true) do {
        case ((surfaceType getPos _unit) in ["#CLN_GrassTall", "#GdtRock"]) : {
            [_unit, 0.0075] call _fnc_unitSetStamina;
        };
        case ((surfaceType getPos _unit) isEqualTo "#CLN_Forest") : {
            [_unit, 0.0025] call _fnc_unitSetStamina;
        };
        case (surfaceIsWater position _unit) : {
            [_unit, 0.001] call _fnc_unitSetStamina;
        };
        default {
            [_unit, 0.01] call _fnc_unitSetStamina;
        };
    };
};

// change unit's aim co-efficient based on stance.
private _fnc_unitAimModifier = {
    params ["_unit"];
    switch (true) do {
        diag_log format ["Setting unit's aim coefficient based on stance: unit=%1 stance=%2", _unit, stance _unit];

        case (stance _unit == "PRONE") : {_unit setCustomAimCoef 0.5};
        case (stance _unit == "CROUCH") : {_unit setCustomAimCoef 0.9};
        case (stance _unit == "STAND") : {_unit setCustomAimCoef 1.6};
        default {_unit setCustomAimCoef 1};
    };
};

// is client side
if (hasInterface && {diag_frameNo mod 15 isEqualTo 0}) exitWith {

    // can use local effect commands with `player` etc. as we are client side
    diag_log format ["DEBUG: Updating player unit stamina: unit=%1", player];

    [player] call _fnc_unitStaminaModifier;
    [player] call _fnc_unitAimModifier;

    diag_log format ["DEBUG: Updated player unit stamina: unit=%1", player];
};