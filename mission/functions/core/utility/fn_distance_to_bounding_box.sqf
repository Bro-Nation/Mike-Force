params [
    ["_object", objNull, [objNull]],
    ["_posAGL", [0,0,0], [[]], 3]
];

if (isNull _object) exitWith { 1e10 };

// Real bounding box in the object's model space
private _bb  = boundingBoxReal _object;
private _min = _bb select 0;
private _max = _bb select 1;

// Shift the position into the object's frame of reference
private _local = _object worldToModel _posAGL;

// Closest point in the box to the position
private _clamped = [
    ((_local select 0) max (_min select 0)) min (_max select 0),
    ((_local select 1) max (_min select 1)) min (_max select 1),
    ((_local select 2) max (_min select 2)) min (_max select 2)
];

// 0 if inside the box, otherwise distance to the closest surface point
_local distance _clamped
