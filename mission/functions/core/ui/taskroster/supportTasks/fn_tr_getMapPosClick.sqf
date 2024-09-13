/*
    File: fn_tr_getMapPosClick.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by "MouseButtonClick" Map-Eventhandler in the SupportRequest Page
		Creates local Marker, if needed, and moves it to clicked Maplocation
		Name is probably a bit missleading, but noone should use that stuff anyway and i am too lazy/can't be bothered to change it atm ¯\_(ツ)_/¯
    
    Parameter(s):
		_0 - Control [Control]
		_ - Not used [Any]
		_2 - X Position on Screen [Number]
		_3 - Y Position on Screen [Number]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

disableSerialization;

_worldCoord = _control ctrlMapScreenToWorld [_xPos, _yPos];
_markerName = format["%1_missionMarker", getPlayerUID player];

if (isNil _markerName) then
{
	_marker = createMarkerLocal [_markerName, _worldCoord];
	_marker setMarkerColorLocal "ColorRed";
	_marker setMarkerSizeLocal [1, 1];
	_marker setMarkerAlphaLocal 1;
	_marker setMarkerTypeLocal "hd_objective_noShadow";
};
_markerName setMarkerPosLocal _worldCoord;

