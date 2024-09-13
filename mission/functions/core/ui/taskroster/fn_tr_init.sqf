/*
    File: fn_tr_init.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Opens or closes TaskRoster
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

//check if closing or opening the TR
if(isNull VN_DISP_TR_TASKROSTER)then
{
	//open TaskRoster
	createDialog "vn_tr_disp_taskRoster_Main";
}else{
	//close TaskRoster
	closeDialog VN_IDD_TR_TASKROSTER;
};

