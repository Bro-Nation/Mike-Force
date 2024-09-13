/*
    File: fn_tr_tasksInfo_listbox_select.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        No description added yet.
    
    Parameter(s):
        _lb - Listbox from which the onLBSelChanged EH was executed [CONTROL, defaults to NIL]
        _ind - Selected index of the listbox [INTEGER, defaults to -1]
    
    Returns:
        nil
    
    Example(s):
        [_listbox, 0] call vn_mf_fnc_tr_tasksInfo_listbox_select;
*/

#include "..\..\..\..\..\config\ui\ui_def_base.inc"

params ["_lb", ["_ind", -1]];
private ["_task","_coords"];
if (_lb == VN_TR_ACTIVETASKS_LHS_LBOX_CTRL) then {
	//--- Main task selected
	_task = vn_tr_taskList # _ind param[3, taskNull];
	_coords = {
		private _dest = taskDestination _x;
		if !(_dest isEqualTo [0,0,0]) exitWith{_dest};
		nil
	} forEach taskChildren _task;
} else {
	//--- Subtask, task is stored on the listbox
	_task = _lb getVariable [format["taskIndex%1", _ind], taskNull];
	_coords = taskDestination _task;
};
if (isNil "_coords") then {_coords = [0,0,0]};
private _distance = round (getPos player distance _coords);
private _distance_type = "m";
if(count(str (round _distance)) > 3)then{_distance = (_distance / 1000) toFixed 1; _distance_type = "km";};
VN_TR_ACTIVETASKS_RHS_COORDS_CTRL ctrlSetText format["%1 %2", _distance, _distance_type];

VN_TR_MISSION_MAP_CTRL ctrlMapAnimAdd [0, 0.25, _coords];
ctrlMapAnimCommit VN_TR_ACTIVETASKS_RHS_MAP_CTRL;

VN_TR_ACTIVETASKS_RHS_NAME_CTRL ctrlSetText (taskDescription _task)#1;
VN_TR_ACTIVETASKS_RHS_DESC_CTRL ctrlSetText (taskDescription _task)#0;

// set the selected subtask as active
call vn_mf_fnc_tr_tasksInfo_setActive;

nil