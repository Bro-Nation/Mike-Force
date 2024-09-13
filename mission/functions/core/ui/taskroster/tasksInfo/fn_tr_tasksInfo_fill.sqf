/*
    File: fn_tr_tasksInfo_fill.sqf
    Author: Savage Game Design
    Modified: @dijksterhuis
    Public: No
    
    Description:
		Fills the TaskRoster Mission Overview with the Parent-/Maintasks. Children will be handled in "vn_mf_fnc_tr_tasksInfo_show"
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

//butchering the string, to get the Classname... don't like it, but atm, i do not know any other way.
//"task " = 5 || -5 = select [startIndex, "steps forward"];
vn_mf_fnc_getTaskConfigName =
{
	//BigBadButchery...
	private _taskname = str _this;
	//BUTTCCHHHEERR IIITTTTT
	private _taskConfigName_stripped_taskID = _taskname select [(_taskname find "-") + 1];
    private _ret = _taskConfigName_stripped_taskID select [0, (_taskConfigName_stripped_taskID find " (")];
	_ret
};

vn_mf_fnc_getTaskID =
{
	//BigBadButchery...
	private _taskname = str _this;
	//BUTTCCHHHEERR IIITTTTT
	private _ret = _taskName select [5,((_taskname find "-")-5)];
	_ret
};

private _taskCategoryLookup = createHashMapFromArray [
	["PRI",
		createHashMapFromArray [
			["priority", 0],
			["text", "PRIMARY"],
			["imgPath", "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_primary.paa"],
			// red
			["color", [0.5, 0, 0, 1]]
		]
	],
	["SEC",
		createHashMapFromArray [
			["priority", 50],
			["text", "SECONDARY"],
			["imgPath", "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa"],
			// blue
			["color", [0, 0, 0.5, 1]]
		]
	],
	["SUP",
		createHashMapFromArray [
			["priority", 100],
			["text", "SUPPORT"],
			["imgPath", "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_support.paa"],
			// green
			["color", [0, 0.5, 0, 1]]
		]
	],
	["",
		createHashMapFromArray [
			["priority", 1000],
			["text", "OTHER"],
			["imgPath", "Vn\ui_f_vietnam\ui\debrief\sticky.paa"],
			// dark grey
			["color", [0, 0, 0, 0.8]]
		]
	]
];


private _fnc_process_task = {
	params [["_task", taskNull, [taskNull]], ["_sortOffset", 0, [0]]];

	private _task_classname = _task call vn_mf_fnc_getTaskConfigName;
	private _taskID = _task call vn_mf_fnc_getTaskID;
	private _task_varName = format["%1-%2", _taskID, _task_classname];
	private _task_data = missionNamespace getVariable [format ["task_%1", _task_varName], []];
	private _task_description = (taskDescription _task) # 1;
	private _task_category = getText(missionConfigFile >> "gamemode" >> "tasks" >> _task_classname >> "taskcategory");

	private _taskTypeData = if !(_task_category in (keys _taskCategoryLookup)) then {_taskCategoryLookup get ""} else {_taskCategoryLookup get _task_category};
	private _taskTypePriority = _taskTypeData get "priority";
	private _taskTypeText = _taskTypeData get "text";
	private _taskTypeImgPath = _taskTypeData get "imgPath";
	private _taskTypeImgColor = _taskTypeData get "color";

	private _taskSubtypeImgPath = getText(configFile >> "CfgTaskTypes" >> taskType _task >> "icon");
	private _taskSubtypeStr = taskType _task;
	private _taskSubtypeCapitalised = (toUpper (_taskSubtypeStr select [0, 1])) + (_taskSubtypeStr select [1, count _taskSubtypeStr]);

	private _tooltip = format ["%1 (%2 Objective)", _task_description, _taskTypeText];
	private _sortOrderRank = _taskTypePriority + _sortOffset;

	private _hmap = createHashMapFromArray [
		["taskDescription", _task_description],
		["taskTypeIcon", _taskTypeImgPath],
		["taskTypeIconColor", _taskTypeImgColor],
		["taskTypeText", _taskTypeText],
		["taskSubtypeIcon", _taskSubtypeImgPath],
		["taskSubtypeText", _taskSubtypeCapitalised],
		["taskTooltip", _tooltip],
		["taskData", str(_task)],
		["taskSortOrderRank", _sortOrderRank],
		["tasklistClientVarData", [_sortOrderRank, _task_category, _task_classname, _task]]
	];

	_hmap

};

////////////////////////////////////////////////////////////////////////////////

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

private _ctrl = VN_TR_ACTIVETASKS_LHS_LBOX_CTRL;
lbclear _ctrl;

private _onlyParentTasks = (simpleTasks player) select {
	private _taskParent = taskParent _x;
	private _taskStatus = taskCompleted _x;
	((isNull _taskParent) && {!_taskStatus})
};

vn_tr_taskList = [];

{
	private _t = [_x, _forEachIndex] call _fnc_process_task;
	vn_tr_taskList pushBack (_t get "tasklistClientVarData");

	// new row of data
	// **MUST** set at least one value in here otherwise it breaks the UI
	// and refuses to show the right hand side page.
	private _row = _ctrl lnbAddRow ["", "", "", _t get "taskDescription"];

	// set the task data. this is grabbed by `vn_mf_fnc_tr_tasksInfo_show` when
	// activating the currently selected task on the right hand side page.
	_ctrl lnbSetData [[_row, 1], _t get "taskData"];

	// column 1 -- icon for task type
	_ctrl lnbSetValue [[_row, 0], _t get "taskSortOrderRank"];
	_ctrl lnbSetPicture [[_row, 0], _t get "taskTypeIcon"];
	_ctrl lnbSetPictureColor [[_row, 0], _t get "taskTypeIconColor"];
	_ctrl lnbSetPictureColorSelected [[_row, 0], _t get "taskTypeIconColor"];

	// column 2 -- text for task type
	_ctrl lnbSetText [[_row, 1], _t get "taskTypeText"];

	// column 3 -- icon for task subtype
	_ctrl lnbSetPicture [[_row, 2], _t get "taskSubtypeIcon"];
	_ctrl lnbSetPictureColor [[_row, 2], _t get "taskTypeIconColor"];
	_ctrl lnbSetPictureColorSelected [[_row, 2], _t get "taskTypeIconColor"];


} forEach _onlyParentTasks;

vn_tr_taskList sort true;

private _currRow = -1;
if ((count vn_tr_taskList) isNotEqualTo 0) then {
	_currRow = 0;
};

_ctrl lnbSortByValue [0, false];
_ctrl lnbSetCurSelRow _currRow;

_ctrl ctrlShow true;
