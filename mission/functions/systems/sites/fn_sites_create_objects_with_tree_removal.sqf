/*
    File: fn_sites_create_objects_with_tree_removal.sqf
    Author: Cerebral
    Public: No
    
    Description:
        Creates objects using BIS_fnc_objectsMapper and removes trees within their bounding box area
    
    Parameter(s):
        _position - Position to create objects at [Position]
        _angle - Angle to rotate composition [Number]
        _objects - Array of objects to create [Array]
        _badChance - Random chance to not create objects (optional, default 0) [Number]
    
    Returns:
        Created objects [Array]
    
    Example(s):
        [_pos, 0, _objects] call vn_mf_fnc_sites_create_objects_with_tree_removal
*/

params [
    "_position",
    "_angle",
    "_objects",
    ["_badChance", 0]
];

// Create the objects using BIS_fnc_objectsMapper
private _createdObjects = [_position, _angle, _objects, _badChance] call BIS_fnc_objectsMapper;

// Get all trees in a large radius around the position
private _nearbyTrees = nearestTerrainObjects [_position, ["TREE", "SMALL TREE", "BUSH"], 50, false, true];

// Process each created object
{
    private _object = _x;
    
    // Get the object's bounding box
    private _boundingBox = boundingBoxReal _object;
    private _boundingBoxCenter = boundingCenter _object;
    
    // Calculate the maximum radius of the bounding box
    private _xSize = abs(((_boundingBox select 1) select 0) - ((_boundingBox select 0) select 0)) / 2;
    private _ySize = abs(((_boundingBox select 1) select 1) - ((_boundingBox select 0) select 1)) / 2;
    private _maxRadius = (_xSize max _ySize) * 1.2; // Add 20% margin
    
    // Remove trees within the object's footprint
    {
        if (_x distance _object < _maxRadius) then {
            _x hideObjectGlobal true;
        };
    } forEach _nearbyTrees;

} forEach _createdObjects;

_createdObjects 