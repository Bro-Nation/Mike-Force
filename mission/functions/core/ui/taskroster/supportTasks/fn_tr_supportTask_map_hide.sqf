/*
    File: fn_tr_supportTask_create.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Deletes the controls, that were created by the SupportTask "Position Selection"-Menu.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_map_hide
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

_markerName = format["%1_missionMarker", getPlayerUID player];
deleteMarkerLocal _markerName;