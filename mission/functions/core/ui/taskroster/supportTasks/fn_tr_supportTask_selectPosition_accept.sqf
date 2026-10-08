/*
    File: fn_tr_supportTask_selectPosition_accept.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Accepts the selected position?
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_selectPosition_accept
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

//get markerPos of desired Mission location
private _markerName = format["%1_missionMarker",getPlayerUID player];
private _pos = mapGridPosition (getMarkerPos _markerName);
private _markerPos = getMarkerPos _markerName;

diag_log format [
  "[SUPPORT UI] selectPosition_accept marker=%1 markerPos=%2 grid=%3 payloadBefore=%4",
  _markerName,
  _markerPos,
  _pos,
  vn_tr_supportMissionInfo
];

//update text of map selection
if ((player getVariable ["vn_mf_db_player_group", "MikeForce"]) isEqualTo "DacCong") then {
  VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText format["Attack Position: [%1]", _pos];
} else {
  VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText format["Selected Position: [%1]", _pos];
};
//update temporary data
vn_tr_supportMissionInfo set [1,_markerPos];
deleteMarkerLocal _markerName;

diag_log format ["[SUPPORT UI] selectPosition_accept payloadAfter=%1", vn_tr_supportMissionInfo];

//enable "Create new support task"-control
VN_TR_SUPREQ_CTASK_CTRL ctrlEnable true;
