/*
	File: fn_tr_playerInfo_show.sqf
	Author: Savage Game Design
	Modified: @dijksterhuis (heavily)
	Public: No

	Description:
		Called by clicking on the Playername.
		Inhides and files the Charactersheet

	Parameter(s): none

	Returns: nothing

	Example(s): none
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

private _fnc_bold_title_plain_value = {
	params ["_title", "_value"];
	format ["<t font='tt2020base_vn_bold'>%1</t><t font='tt2020base_vn'>: %2</t>", _title, _value]
};

/////////////////////////////////////////////////////////////////////////////////
// General player info
private _fnc_display_player_stats = {
	private _player_id = player getVariable [
		"vn_mf_db_serial",
		"0"
	];
	private _progress = call vn_mf_fnc_points_to_next_rank;
	private _scores = getPlayerScores player;
	private _kills = format [
		"%1 / %2 / %3 / %4",
		_scores # 0,
		_scores # 1,
		_scores # 2,
		_scores # 3
	];

	VN_TR_PLAYERINFO_NAME_CTRL ctrlSetStructuredText parseText (
		format ["<t font='tt2020base_vn_bold'>Profile Name:</t> %1", profileName]
	);
	VN_TR_PLAYERINFO_SNUM_CTRL ctrlSetStructuredText parseText (
		format ["<t font='tt2020base_vn_bold'>Serial Number:</t> %1", _player_id]
	);
	VN_TR_PLAYERINFO_UID_CTRL ctrlSetStructuredText parseText (
    	format ["<t font='tt2020base_vn_bold'>Player UID:</t> %1", getPlayerUID player]
   	);
	VN_TR_PLAYERINFO_RANK_CTRL ctrlSetStructuredText parseText (
		format ["<t font='tt2020base_vn_bold'>Current Rank:</t> %1", rank player]
	);
	VN_TR_PLAYERINFO_POINTS_CTRL ctrlSetStructuredText parseText (
		format ["<t font='tt2020base_vn_bold'>Current Rank Points:</t> %1", str(player getVariable ["vn_mf_db_rank",0])]
	);
	VN_TR_PLAYERINFO_PROGR_CTRL ctrlSetStructuredText parseText (
		format ["<t font='tt2020base_vn_bold'>Points to Next Rank:</t> %1", _progress]
	);

	VN_TR_PLAYERINFO_REWARD_TEXT_CTRL ctrlSetStructuredText parseText "<t size='0.6' font='tt2020base_vn'></t>";
	_ctrl_text ctrlCommit 0;
};

/////////////////////////////////////////////////////////////////////////////////
// Player ribbons
private _fnc_display_player_ribbons = {

	private _awards_cur = player getVariable ["vn_mf_db_awards", vn_mf_default_awards];

	for "_i" from 0 to 34 do {

		private _ctrl = GET_BY_ID_VN_TR_PLAYERINFO_RIBBON_CTRL(_i);

		private _className = _awards_cur # _i # 0;
		private _index = _awards_cur # _i # 1;
		private _cfgPath = (missionConfigFile >> "gamemode" >> "awards_config" >> _className);
		private _img_data = getArray (_cfgPath >> "levels");
		private _desc = getText (_cfgPath >> "desc");
		private _name = getText (_cfgPath >> "title");

		if(_index != -1) then
		{
			//store medal for preview Image
			_ctrl setVariable ["medal", (_img_data # _index # 0)];
			//set Ribbon
			_ctrl ctrlSetText (_img_data # _index # 1);
			// turn up color, so the player knows he earned that one.
			_ctrl ctrlSetTextColor [0.8, 0.8, 0.8, 1];
		}else{
			//store medal for preview Image
			_ctrl setVariable ["medal", (_img_data # 0 # 0)];
			//set Ribbon
			_ctrl ctrlSetText (_img_data # 0 # 1);
			// turn down color, as indicator that the player hasn't earned it yet.
			_ctrl ctrlSetTextColor [0.3, 0.3, 0.3, 0.5];
		};
		_ctrl setVariable ["text", _desc];
		_ctrl setVariable ["name", _name];
		_ctrl ctrlSetToolTip localize _name;
		_ctrl ctrlCommit 0;
	};
};

/////////////////////////////////////////////////////////////////////////////////
// Player roles
private _fnc_get_player_traits = {

	private _traitsConfig = "true" configClasses (missionConfigFile >> "gamemode" >> "traits");

	private _traitsPlayerConf = _traitsConfig select {
		(player getUnitTrait (configName _x))
	};

	if ((count _traitsPlayerConf) isEqualTo 0) exitWith {
		private _traitsPlayerArrHMap = [
			createHashMapFromArray [
				["name", "n/a"],
				["icon", ""],
				["text", "You haven't selected any roles."],
				["desc", ""]
			]
		];

		_traitsPlayerArrHMap
	};

	private _traitsPlayerArrHMap = _traitsPlayerConf apply {

		private _traitConfig = _x;
		private _traitName = configName _x;
		private _traitIcon = getText (_traitConfig >> "icon");
		private _traitText = (getText (_traitConfig >> "text") call para_c_fnc_localize);

		private _traitTasks = switch _traitName do {
			case "medic":{localize "STR_vn_mf_taskRoster_Main_medicTasks"};
			case "engineer":{localize "STR_vn_mf_taskRoster_Main_engineerTasks"};
			case "explosiveSpecialist":{localize "STR_vn_mf_taskRoster_Main_explosive_specialistTasks"};
			case "radioOperator": { localize "STR_vn_mf_radioOperatorTasks" };
			default {""};
		};

		private _hmap = createHashMapFromArray [
			["name", _traitName],
			["icon", _traitIcon],
			["text", _traitText],
			["desc", _traitTasks]
		];

		_hmap
	};

	_traitsPlayerArrHMap

};


private _fnc_display_player_traits = {

	private _traits = call _fnc_get_player_traits;

	private _displayCtrlPage = VN_DISP_TR_SHOWPLAYERINFO;
	private _displayCtrlGrpRoles = VN_TR_PLAYERINFO_ROLES_CTRL;

	//--- Delete old controls
	((allControls _displayCtrlPage) select {ctrlParentControlsGroup _x == _displayCtrlGrpRoles}) apply {ctrlDelete _x};
	//--- Top seperator
	private _seperator = _displayCtrlPage ctrlCreate ["vn_mf_RscText", -1, _displayCtrlGrpRoles];
	_seperator ctrlSetPosition [0, 0, UIW(15), pixelH];
	_seperator ctrlCommit 0;
	_seperator ctrlSetBackgroundColor [0,0,0,1];
	_tgH = pixelH + UIH(0.1); // keep track of the y position in the controls group for the next row

	_traits apply {

		private _hmap = _x;

		private _addH = 0; // find the highest h value of any text control
		private _nCtrls = []; // store newly created controls

		//--- Row group
		private _ctrlSingleRoleGroup = _displayCtrlPage ctrlCreate ["vn_mf_RscControlsGroupNoScrollbarHV", -1, _displayCtrlGrpRoles];
		_nCtrls pushBack _ctrlSingleRoleGroup;
		_ctrlSingleRoleGroup ctrlSetPosition [0, _tgH, UIW(15), UIH(1)];
		_ctrlSingleRoleGroup ctrlCommit 0;

		//--- Role icon, column 1
		private _ctrlRoleIcon = _displayCtrlPage ctrlCreate ["vn_mf_RscPicture", -1, _ctrlSingleRoleGroup];
		_ctrlRoleIcon ctrlSetPosition [0, 0, UIW(1.5), UIH(1.5)];
		_ctrlRoleIcon ctrlCommit 0;
		_ctrlRoleIcon ctrlSetText (_hmap get "icon");
		_ctrlRoleIcon ctrlSetTooltip ((_hmap get "text") call para_c_fnc_localize);
		_ctrlRoleIcon ctrlSetTextColor [0,0,0,0.8];

		//--- Tasks, column 2
		private _ctrlRoleName = _displayCtrlPage ctrlCreate ["vn_mf_RscStructuredText", -1, _ctrlSingleRoleGroup];
		_nCtrls pushBack _ctrlRoleName;
		_ctrlRoleName ctrlSetPosition [UIW(3), 0, UIW(6.5), UIH(1)];
		_ctrlRoleName ctrlCommit 0;
		_ctrlRoleName ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>", (_hmap get "text")];
		_addH = _addH max ctrlTextHeight _ctrlRoleName;

		//--- Player list, column 3
		private _ctrlDesc = _displayCtrlPage ctrlCreate ["vn_mf_RscStructuredText", -1, _ctrlSingleRoleGroup];
		_nCtrls pushBack _ctrlDesc;
		_ctrlDesc ctrlSetPosition [UIW(9), 0, UIW(6.5), UIH(1)];
		_ctrlDesc ctrlCommit 0;
		_ctrlDesc ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>", (_hmap get "desc")];

		_addH = _addH max ctrlTextHeight _ctrlDesc;
		_addH = _addH max UIH(1.5);
		_nCtrls apply {
			_x ctrlSetPositionH _addH;
			_x ctrlCommit 0;
		};
		_tgH = _tgH + _addH + UIH(0.1);

		//--- Seperator between roles
		_seperator = _displayCtrlPage ctrlCreate ["RscText", -1, _displayCtrlGrpRoles];
		_seperator ctrlSetPosition [0, _tgH, UIW(15), pixelH];
		_seperator ctrlCommit 0;
		_seperator ctrlSetBackgroundColor [0,0,0,1];
		_tgH = _tgH + pixelH + UIH(0.1);

	};
};

call _fnc_display_player_stats;
call _fnc_display_player_ribbons;
call _fnc_display_player_traits;
