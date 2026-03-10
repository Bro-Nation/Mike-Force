
/*
    File: fn_adv-explosives_placement.sqf
    Author: veteran29
    Modified By: 04 SN S. "Scoop" Cooper
    Date: 2022-03-25
    Public: No

    Description:
        Handle advanced explosive placement.

    Parameter(s):
        _unit - Unit placing the explosive      [OBJECT]
        _ammo - Explosive that is being placed  [OBJECT]
        _attachDist - Distance to search for objects to attachTo [NUMBER, defaults to 1.5]

    Returns:
        Explosive was attached [BOOL]

    Example(s):
        _ammo = createVehicle ["vn_mine_limpet_01_mag", [0,0,0], [], 0, "CAN_COLLIDE"];
        [player, _ammo] call vn_fnc_adv_explosives_placement;
*/

params ["_unit", "_explosive", ["_attachDist", 1.5]];
if (_unit isNotEqualTo (call vn_fnc_player)) exitWith {};

_origin = AGLToASL positionCameraToWorld [0,0,0];
_offset = [0,0,0];
// adjust the origin pos in third person view
if (cameraView == "EXTERNAL") then {
    _offset = eyePos _unit vectorDiff _origin;
    _origin = _origin vectorAdd _offset;
};

#if __A3_DEBUG__
    vn_adv_explosive_placement = [];
#endif

{
    private _checkPos = (AGLToASL positionCameraToWorld (_x + [_attachDist])) vectorAdd _offset;
    private _intersects = lineIntersectsSurfaces [_origin, _checkPos, _unit, objNull, true, 1, "VIEW", "FIRE"];

    #if __A3_DEBUG__
        vn_adv_explosive_placement pushBack [_origin, _checkPos];
    #endif

    _intersects param [0, []] params ["_pos", "_surfaceNormal", ["_obj", objNull]];
    
    if (
        !isNull _obj
    ) exitWith {
        private _attachPos = _obj worldToModel ASLToAGL _pos;
        _explosive attachTo [_obj, _attachPos];
        _explosive setVectorDirAndUp [
            [0,0,-1],
            _obj vectorWorldToModel _surfaceNormal
        ];

        [true, "vn_adv_explosives_attached", [_unit, _explosive, _obj]] call BIS_fnc_callScriptedEventHandler;


        true // return
    };
    false // return
} forEach [[0,0], [0.1,0.1], [0.1,-0.1], [-0.1,0.1], [-0.1,-0.1]];

