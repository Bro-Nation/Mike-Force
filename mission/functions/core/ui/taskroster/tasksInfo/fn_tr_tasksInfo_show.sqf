/*
    File: fn_tr_tasksInfo_show.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by Listbox "onLBSelChanged"
		Loads and fills the Overview for the selected Task in the TaskRoster Mission Overview
    
    Parameter(s):
		_ (_ctrlSupportTasks) - Not used [Control, defaults to controlNull]
		_list_index - Index [Number, defaults to -1]
    
    Returns: nothing
    
    Example(s):
		onLBSelChanged = "_this call vn_mf_fnc_tr_tasksInfo_show;
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

params[
	["_ctrlSupportTasks",controlNull,[controlNull]], // not used
	["_list_index",-1,[0]]
];

//"unhide" Missionsheet
VN_TR_ACTIVETASKS_RHS_GROUP_CTRL ctrlShow true;

_ctrl_missionPage_map = VN_TR_ACTIVETASKS_RHS_MAP_CTRL;
//in case of wobblewobble. Probably not needed, but doesn't hurt to have.
_ctrl_missionPage_map ctrlEnable false;

VN_TR_ACTIVETASKS_RHS_PIC_CTRL ctrlEnable false;

if (_list_index < 0) exitWith
{
	//get active Mission from list and set the listSelection to that row, to trigger the list autoexecutestuffthingygnaahhhh.... i hate describing that stuff...
	private _task = if(currentTask player isEqualTo taskNull)then{taskNull}else{taskParent currentTask player};
	if(isNull _task)exitWith{};
	
	private _ActiveTask = str(_task);
	for "_i" from 0 to ((lnbSize VN_TR_ACTIVETASKS_LHS_LBOX_CTRL) # 0)-1 do
	{
		if ( (VN_TR_ACTIVETASKS_LHS_LBOX_CTRL lnbData [_i,1]) isEqualTo _ActiveTask)exitWith{ VN_TR_ACTIVETASKS_LHS_LBOX_CTRL lnbSetCurSelRow _i; };
	};
};

//try to get background img
private _missionPage_main_background_image = VN_TR_ACTIVETASKS_LHS_LBOX_CTRL lnbData [_list_index, 0];

//if "new" -> Assign a background img to the selected index (will be reassigned/redone, when the player reopens the TaskRoster, so it's just an "eye gimmick")
if(_missionPage_main_background_image isEqualTo "")then
{
	_missionPage_main_background_image = selectRandom [
		"\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_1.paa",
		"\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_2.paa",
		"\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_3.paa"
	];

	//set the Bg Img as fixed, as long as the TR is openend
	VN_TR_ACTIVETASKS_LHS_LBOX_CTRL lnbSetData [[_list_index, 0], _missionPage_main_background_image];
};

VN_TR_ACTIVETASKS_RHS_IMG_CTRL ctrlSetText _missionPage_main_background_image;
VN_TR_ACTIVETASKS_RHS_TASKS_CTRL ctrlSetStructuredText parseText "Tasks:";
lbClear VN_TR_ACTIVETASKS_RHS_TASKS_LIST_CTRL;

(vn_tr_taskList # _list_index) params ["_sortOrder", "_parent_category", "_parent_classname", "_parent"];

private _currTask = currentTask player;

(taskChildren _parent) apply {
	(taskDescription _x) params ["_taskDesc", "_taskTitle", "_taskWpDesc"];
	private _idx = VN_TR_ACTIVETASKS_RHS_TASKS_LIST_CTRL lbAdd _taskTitle;
	private _imgPaths = [
		"\vn\ui_f_vietnam\ui\taskroster\img\box_unchecked.paa",
		"\vn\ui_f_vietnam\ui\taskroster\img\box_checked.paa"
	];
	private _taskIcon = _imgPaths select taskCompleted _x;
	VN_TR_ACTIVETASKS_RHS_TASKS_LIST_CTRL lbSetPicture [_idx, _taskIcon];
	VN_TR_ACTIVETASKS_RHS_TASKS_LIST_CTRL setVariable [format ["taskIndex%1", _idx], _x];
};

VN_TR_ACTIVETASKS_RHS_TASKS_LIST_CTRL lbSetCurSel ((taskChildren _parent) findIf {_x isEqualTo _currTask});

private _imgPath = getText(missionconfigfile >> "gamemode" >> "tasks" >> _parent_classname >> "taskimage");
if(_imgPath == "") then {_imgPath = "vn\missions_f_vietnam\data\img\mikeforce\su\vn_ui_mf_task_mfs1.jpg";};
VN_TR_ACTIVETASKS_RHS_PIC_CTRL ctrlSetText _imgPath;

//--- Load right page
[VN_TR_ACTIVETASKS_LHS_LBOX_CTRL, _list_index] call vn_mf_fnc_tr_tasksInfo_listbox_select;