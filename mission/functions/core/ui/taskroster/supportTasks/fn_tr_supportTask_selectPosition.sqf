/*
    File: fn_tr_supportTask_map_hide.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Opens the Mapscreen for the Maplocation.
		[!:info] As of the 23rd of December 2019, this is not in use.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_map_hide
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

_ctrl_map = VN_DISP_TR_SUPREQ ctrlCreate ["vn_tr_supportRequest_miniMapAA", VN_TR_SUPREQ_MAP_IDC];

private _coords = getPos player;
//move map to player Position
_ctrl_map ctrlMapAnimAdd [0, 0.15, _coords];
ctrlMapAnimCommit _ctrl_map;