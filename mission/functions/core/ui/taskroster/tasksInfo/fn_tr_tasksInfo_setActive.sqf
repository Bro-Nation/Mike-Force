/*
    File: fn_tr_tasksInfo_setActive.sqf
    Author: Savage Game Design
    Modified: @dijksterhuis
    Public: No
    
    Description:
		Set the active sub task for the player.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

#include "..\..\..\..\..\config\ui\ui_def_base.inc"

private _list_index = lbCurSel VN_TR_ACTIVETASKS_LHS_LBOX_CTRL;
private _subtask_index = lbCurSel VN_TR_ACTIVETASKS_RHS_TASKS_LIST_CTRL;

(vn_tr_taskList # _list_index) params["", "", "", "_parent"];

private _task = (taskChildren _parent) select _subtask_index;

if (taskCompleted _task) exitWith {
	hint "Error: Cannot set task as active because it has been completed! Select another task.";
};

// fine, already selected
if (_task isEqualTo (currentTask player)) exitWith {true};

player setCurrentTask _task;
