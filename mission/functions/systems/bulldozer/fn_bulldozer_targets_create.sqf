/*
    File: fn_bulldozer_targets_create.sqf
    Author: Tylervip
    Public: yes

    Creates the invisible target vehicles attached to a bulldozer tank and assigns
    their crew to the provided side.

    Parameter(s):
        0: OBJECT - tank
        1: SIDE - side to assign target crews
        2: ARRAY - target spawn position (optional)

    Returns:
        ARRAY - created target objects
*/
params ["_vehicle", "_side", ["_targetPos", []]];

if (isNull _vehicle || { _side == sideUnknown }) exitWith { [] };
if (!isServer) exitWith { [] };

private _existingTargets = _vehicle getVariable ["invisTargets", []];
if !(_existingTargets isEqualTo []) exitWith { _existingTargets };

private _pos = if (_targetPos isEqualTo []) then { getPosATL _vehicle } else { _targetPos };
private _targetOffsets = [
    [ 0,   2.8,  -0.1],  // front
    [ 0,  -1.9,  -0.1],  // rear
    [-1.5,   0,   -0.1],  // left
    [ 1.5,   0,   -0.1],  // right
    [ 0,   0.4,   -0.2]   // top
];

private _targets = [];
{
    private _target = createVehicle ["B_TargetSoldier", _pos, [], 0, "CAN_COLLIDE"];
    if (!isNull _target) then {
        createVehicleCrew _target;
        _target allowDamage false;
        _target attachTo [_vehicle, _x];
        _target setVariable ["vn_mf_bulldozer_target", true, true];
        _targets pushBack _target;

        {
            _x addEventHandler ["Killed", {
                params ["_unit"];
                private _group = group _unit;
                if (!isNull _group && { count units _group == 0 }) then {
                    deleteGroup _group;
                };
            }];
        } forEach (crew _target);
    };
} forEach _targetOffsets;

_vehicle setVariable ["invisTargets", _targets, true];
[_vehicle, _side] call vn_mf_fnc_bulldozer_targets_sync;

_targets
