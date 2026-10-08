/*
    File: fn_tr_supportTask_show.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Fills the TaskRosters "Request Support Mission"-List
		Filtered by Teams

    Parameter(s): none

    Returns: nothing

    Example(s):
		call vn_mf_fnc_tr_supportTask_show
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

VN_TR_SUPREQ_CTASK_CTRL ctrlEnable false;
//"unhide" supportRequest Page
VN_TR_SUPREQ_CTRL ctrlShow true;

//Var for Missions
//["TeamName","Type",[Coords]]
vn_tr_supportMissionInfo = ["",[],[]];

//fill "Team" dropDownMenu
_ctrl_taskSelection = VN_TR_SUPREQ_TASK_CTRL;
lnbClear _ctrl_taskSelection;

_groupID = player getVariable ["vn_mf_db_player_group", "MikeForce"];

private _tasksToShow = ("true" configClasses (missionConfigFile >> "gamemode" >> "tasks")) select {
	(getText(_x >> "taskcategory") isEqualTo "SUP") && (_groupID in getArray(_x >> "requestgroups"))
};

// For DacCong, additional checks
if (_groupID == "DacCong") then {
	private _statusMsg = "";
	private _supplyText = "N/A";
	private _sandbagValue = ["building_sandbag_value", 10] call BIS_fnc_getParamValue;
	private _supportAccessRadius = missionNamespace getVariable ["vn_mf_opfor_support_access_radius", 500];
	if (_sandbagValue <= 0) then {_sandbagValue = 10;};
	private _selectedEffect = missionNamespace getVariable ["vn_mf_tr_opfor_selected_effect", "No reinforcement type selected."];

	VN_TR_SUPREQ_TITLE_CTRL ctrlSetText "Create Support Troops";
	VN_TR_SUPREQ_SUBTITLE_CTRL ctrlSetStructuredText parseText "Use this page to deploy reinforcements from the active coms tower. Mark an attack position to direct the units, or leave it unset to use FOB/AO defaults.";
	VN_TR_SUPREQ_STEP_TASK_CTRL ctrlSetText "1. Create Reinforcements";
	private _stepTaskPos = ctrlPosition VN_TR_SUPREQ_STEP_TASK_CTRL;
	_stepTaskPos set [2, UIW(10.5)];
	VN_TR_SUPREQ_STEP_TASK_CTRL ctrlSetPosition _stepTaskPos;
	VN_TR_SUPREQ_STEP_TASK_CTRL ctrlCommit 0;
	VN_TR_SUPREQ_STEP_MAP_TITLE_CTRL ctrlSetText "3. Mark Attack Position";
	VN_TR_SUPREQ_STEP_MAP_HELP_CTRL ctrlSetText "Optional: left-click to set an attack destination. If no marker is placed, units will attack the nearest FOB in the AO; if no FOB exists, they will move to the AO center.";
	VN_TR_SUPREQ_TASK_TXT_CTRL ctrlSetText "Support Type";
	VN_TR_SUPREQ_TEAM_TXT_CTRL ctrlSetText "Spawn Direction";
	VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText "Attack Position: AUTO (FOB/AO Center)";
	// Repurpose team panel as cardinal direction selector
	VN_TR_SUPREQ_STEP_TEAM_CTRL ctrlSetText "2. Spawn Direction (Optional)";
	VN_TR_SUPREQ_STEP_TEAM_CTRL ctrlShow true;
	VN_TR_SUPREQ_TEAM_TXT_CTRL ctrlShow true;
	VN_TR_SUPREQ_TEAM_CTRL ctrlShow true;
	lnbClear VN_TR_SUPREQ_TEAM_CTRL;
	{
		private _idx = VN_TR_SUPREQ_TEAM_CTRL lnbAddRow ["", _x select 0];
		VN_TR_SUPREQ_TEAM_CTRL lnbSetData [[_idx, 0], _x select 1];
	} forEach [["North", "N"], ["East", "E"], ["South", "S"], ["West", "W"]];
	VN_TR_SUPREQ_TEAM_CTRL lbSetCurSel -1;
	vn_tr_supportMissionInfo set [2, ""];
	private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
	private _aoMarker = _activeZones param [0, ""];
	private _aoCenter = getMarkerPos _aoMarker;
	private _aoRadius = [0, getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100] select (_aoMarker in allMapMarkers);
	private _towerParts = nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f","vn_ttowersmall_2_f_part0","vn_ttowersmall_2_f_part1"], _aoRadius];
	private _paraTowerParts = _towerParts select {not isNull (_x getVariable ["para_g_building", objNull])};
	private _functionalTowers = (nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f"], _aoRadius]) select {
		private _building = _x getVariable ["para_g_building", objNull];
		alive _x && {!isNull _building} && {_building getVariable ["para_g_building_constructed", false]}
	};
	private _activeTower = if (_functionalTowers isNotEqualTo []) then {_functionalTowers select 0} else {objNull};
	private _towerExists = (_paraTowerParts isNotEqualTo []);
	private _destroyed = missionNamespace getVariable ["vn_mf_coms_tower_destroyed_in_ao", false];
	private _towerForSupply = if (!isNull _activeTower) then {_activeTower} else {if (_towerExists) then {_paraTowerParts select 0} else {objNull}};

	if (!isNull _towerForSupply) then {
		private _building = _towerForSupply getVariable ["para_g_building", objNull];
		if (!isNull _building) then {
			private _supplySource = _building getVariable ["para_g_current_supply_source", objNull];
			if (!isNull _supplySource) then {
				private _rawSupplies = _supplySource getVariable ["para_g_current_supplies", 0];
				_supplyText = str floor (_rawSupplies / _sandbagValue);
			};
		};
	};

	if (_destroyed) then {
		_tasksToShow = [];
		_statusMsg = "Coms tower destroyed in this AO. Support creation is locked until the next AO.";
	} else {
		if (!_towerExists) then {
			_tasksToShow = [];
			_statusMsg = "No coms tower available in this AO. Build one first to unlock OPFOR support creation.";
		} else {
			if (isNull _activeTower) then {
				_tasksToShow = [];
				_statusMsg = "Coms tower is under construction. Support creation unlocks when final build state is complete.";
			} else {
				private _towerDist = player distance _activeTower;
				if (_towerDist > _supportAccessRadius) then {
					_tasksToShow = [];
					_statusMsg = format ["Move within %1m of the coms tower to create support.", round _supportAccessRadius];
				} else {
					_statusMsg = "Coms tower operational. Select support type and optional attack marker.";
					VN_TR_SUPREQ_CTASK_CTRL ctrlEnable true;
				};
			};
		};
	};

	VN_TR_SUPREQ_DESC_TXT_CTRL ctrlSetStructuredText parseText format [
		"<t font='tt2020base_vn_bold'>Tower Status</t>: %1<br/><t font='tt2020base_vn_bold'>Tower Sandbags</t>: %2<br/><t font='tt2020base_vn_bold'>Selected Effect</t>: %3",
		_statusMsg,
		_supplyText,
		_selectedEffect
	];

	vn_tr_supportMissionInfo set [2, ""];
};

_tasksToShow apply {
	_task_name = getText(_x >> "taskname");
	_task_type = getText(_x >> "tasktype");
	_task_icon = getText(configFile >> "CfgTaskTypes" >> _task_type >> "icon");
	private _taskTooltip = getText(_x >> "requesterDesc");
	if (_taskTooltip isEqualTo "") then {
		_taskTooltip = getText(_x >> "taskdesc");
	};
	if (_taskTooltip isEqualTo "") then {
		_taskTooltip = format ["Create support task: %1", _task_name];
	};

	_index = _ctrl_taskSelection lnbAddRow ["",_task_name];
	_ctrl_taskSelection lnbSetPicture [[_index,0], _task_icon];
	_ctrl_taskSelection lnbSetData [[_index,0], (configName _x)];
	_ctrl_taskSelection lnbSetTooltip [[_index,0], _taskTooltip];
	_ctrl_taskSelection lnbSetTooltip [[_index,1], _taskTooltip];
};

// triggers the teams list to fill up automatically on page load
// (teams list has an OnSelected script trigger)
_ctrl_taskSelection lbSetCurSel 0;
call vn_mf_fnc_tr_supportTask_selectPosition;
