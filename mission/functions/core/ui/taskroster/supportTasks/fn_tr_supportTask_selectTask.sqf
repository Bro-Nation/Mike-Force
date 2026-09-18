/*
    File: fn_tr_supportTask_selectTask.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Called by Listbox "onLBSelChanged".
		Support Request Teams will be updated, depending on the selected Missions.

    Parameter(s):
		_0 - List-/Combobox control [Control]
		_1 - List-/Combobox selected Index (list of Tasknames) [Number]

    Returns: nothing

    Example(s):
		onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTask; false;"
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

private _display = ctrlParent (_this#0);
//get selected Index of ctrl
private _index = _this#1;

//disable "Create new support Task" (all requirements must be met, before it get's enabled)
VN_TR_SUPREQ_CTASK_CTRL ctrlEnable false;
//reset Map position (if Team or Mission selection has changed)
VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText "Select Position";

//Get the data from the selected Index
private _supportClassname = VN_TR_SUPREQ_TASK_CTRL lnbData [_index,0];
//update temporary data
vn_tr_supportMissionInfo = [_supportClassname,[],[]];

private _isOpfor = (player getVariable ["vn_mf_db_player_group", "MikeForce"]) isEqualTo "DacCong";
if (_isOpfor) then {
	vn_tr_supportMissionInfo set [2, ""];
};

//get the Teams-List-/Combobox and clear it
_ctrl_availableTeams = VN_TR_SUPREQ_TEAM_CTRL;
lnbclear _ctrl_availableTeams;
//get the Teams, who are able to be assigned to the selected Task
//ret: Array with configName of allowed Teams for that Task
_teamsToAssign = getArray(missionConfigFile >> "gamemode" >> "tasks" >> _supportClassname >> "taskgroups");
_taskDesc = getText(missionConfigFile >> "gamemode" >> "tasks" >> _supportClassname >> "requesterDesc");
private _descTitle = "Selected Task Description";
if (_isOpfor) then {
	_descTitle = "Selected Support Effect";
};
missionNamespace setVariable ["vn_mf_tr_opfor_selected_effect", _taskDesc];

if (_isOpfor) then {
	private _statusMsg = "Coms tower operational. Optional target marker can be set on the map.";
	private _supplyText = "N/A";
	private _sandbagValue = ["building_sandbag_value", 10] call BIS_fnc_getParamValue;
	private _supportAccessRadius = missionNamespace getVariable ["vn_mf_opfor_support_access_radius", 300];
	if (_sandbagValue <= 0) then {_sandbagValue = 10;};
	private _canCreate = false;
	private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
	private _aoMarker = _activeZones param [0, ""];
	private _aoCenter = getMarkerPos _aoMarker;
	private _aoRadius = [0, getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100] select (_aoMarker in allMapMarkers);
	private _towerParts = nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f","vn_ttowersmall_2_f_part0","vn_ttowersmall_2_f_part1"], _aoRadius];
	private _paraTowers = _towerParts select {not isNull (_x getVariable ["para_g_building", objNull])};
	private _functionalTowers = (nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f"], _aoRadius]) select {
		private _building = _x getVariable ["para_g_building", objNull];
		alive _x && {!isNull _building} && {_building getVariable ["para_g_building_constructed", false]}
	};
	private _destroyed = missionNamespace getVariable ["vn_mf_coms_tower_destroyed_in_ao", false];
	private _towerExists = (_paraTowers isNotEqualTo []);
	private _towerForSupply = if (_functionalTowers isNotEqualTo []) then {_functionalTowers select 0} else {if (_towerExists) then {_paraTowers select 0} else {objNull}};

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
		_statusMsg = "Coms tower destroyed in this AO. Support creation is locked until the next AO.";
	} else {
		if (!_towerExists) then {
			_statusMsg = "No coms tower available in this AO. Build one first to unlock OPFOR support creation.";
		} else {
			if (_functionalTowers isEqualTo []) then {
				_statusMsg = "Coms tower is under construction. Support creation unlocks when final build state is complete.";
			} else {
				private _towerDist = player distance (_functionalTowers select 0);
				if (_towerDist > _supportAccessRadius) then {
					_statusMsg = format ["Move within %1m of the coms tower to create support.", round _supportAccessRadius];
				} else {
					_canCreate = true;
				};
			};
		};
	};

	VN_TR_SUPREQ_DESC_TXT_CTRL ctrlSetStructuredText parseText format [
		"<t font='tt2020base_vn_bold'>Tower Status</t>: %1<br/><t font='tt2020base_vn_bold'>Tower Sandbags</t>: %2<br/><t font='tt2020base_vn_bold'>Selected Effect</t>: %3",
		_statusMsg,
		_supplyText,
		_taskDesc
	];
	VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText "Attack Position: AUTO (FOB/AO Center)";
	VN_TR_SUPREQ_CTASK_CTRL ctrlEnable _canCreate;
} else {
	VN_TR_SUPREQ_DESC_TXT_CTRL ctrlSetStructuredText parseText (
		format ["<t font='tt2020base_vn_bold'>%1</t>: %2", _descTitle, _taskDesc]
	);
};

//Fill the List-/Combobox with the Teams
_teamsToAssign apply {
	private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _x);
	private _groupNameFull = getText(_groupConfig >> "name");
	private _groupIcon = getText(_groupConfig >> "icon");
	private _groupName = getText(_groupConfig >> "shortname");

	private _index = _ctrl_availableTeams lnbAddRow ["",_groupName];
	_ctrl_availableTeams lnbSetData [[_index,0], _x];
	_ctrl_availableTeams lnbSetPicture [[_index,0],_groupIcon];
};
if (_isOpfor) then {
	// Repopulate direction list (task selection resets the listbox)
	lnbClear _ctrl_availableTeams;
	{
		private _idx = _ctrl_availableTeams lnbAddRow ["", _x select 0];
		_ctrl_availableTeams lnbSetData [[_idx, 0], _x select 1];
	} forEach [["North", "N"], ["East", "E"], ["South", "S"], ["West", "W"]];
	_ctrl_availableTeams lbSetCurSel -1;
	vn_tr_supportMissionInfo set [2, ""];
} else {
	_ctrl_availableTeams lbSetCurSel 0;
};
