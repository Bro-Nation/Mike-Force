/*
    File: fn_tr_teamInfo_show.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Loads up and sets up the task roster disaply page for teamInfo

		- LHS:
			- Current team icon and name
			- Current team description
			- Current team members on server with their role icons
			- Current count of players in specific roles, with role limits for the team
		- RHS:
			- Team change listbox menu
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

    
disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

// note that `vn_mf_db_player_group` is broadcast when set server side
// on the player in fn_force_team_change.sqf
private _groupID = player getVariable ["vn_mf_db_player_group", "MikeForce"];
private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _groupID);
private _groupNameFull = getText(_groupConfig >> "name");
private _groupIcon = getText(_groupConfig >> "icon");
private _groupName = getText(_groupConfig >> "shortname");
private _groupDescription = getText(_groupConfig >> "description");
private _traitConfigs = "true" configClasses (missionConfigFile >> "gamemode" >> "traits");

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// DATA TRANSFORMATION FOR DISPLAY

// list of traits with player counts
private _traitsTeam = _traitConfigs
	select {(configName _x) isNotEqualTo "vn_artillery"}
	apply {

		private _traitConfig = _x;
		private _traitName = configName _x;
		private _traitIcon = getText (_traitConfig >> "icon");
		private _traitText = (getText (_traitConfig >> "text") call para_c_fnc_localize);
		private _traitPlayerCount = count (
			allPlayers
				select {(_x getVariable ["vn_mf_db_player_group", "FAILED"]) isEqualTo _groupID}
				select {_x getUnitTrait _traitName}
		);
		private _traitPlayerCountLimit = getNumber (_groupConfig >> "rolelimits" >> _traitName);

		private _hmap = createHashMapFromArray [
			["name", _traitName],
			["icon", _traitIcon],
			["text", _traitText],
			["playerCount", _traitPlayerCount],
			["playerLimit", _traitPlayerCountLimit]
		];

		_hmap
	};

// players list with roles
private _teamTraits = allPlayers
	select {
		(_x getVariable ["vn_mf_db_player_group", "FAILED"]) isEqualTo _groupID
	}
	apply {
		private _player = _x;

		private _traitsIconsTooltips = _traitsTeam select {
			_player getUnitTrait (_x get "name")
		} apply {
			[_x get "icon", _x get "text"]
		};

		private _hmap = createHashMapFromArray [
			["playerName", name _player],
			["traits", _traitsIconsTooltips]
		];
		_hmap
	};

private _traitsPlayer = _traitConfigs
	select {
		(player getUnitTrait (configName _x))
	} apply {

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

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// RENDER DISPLAYS

VN_TR_SHOWTEAMINFO_LHS_LOGO_CTRL ctrlSetText _groupIcon;
VN_TR_SHOWTEAMINFO_LHS_TEAMNAME_CTRL ctrlSetStructuredText (parsetext format["<t font='tt2020base_vn_bold'>%1</t>", _groupName]);
VN_TR_SHOWTEAMINFO_LHS_DESC_CTRL ctrlSetStructuredText (parsetext _groupDescription);

private _displayCtrlPage = VN_DISP_TR_SHOWTEAMINFO;
private _displayCtrlRoleLimits = VN_TR_SHOWTEAMINFO_LHS_ROLELIMITS_CTRL;
private _displayCtrlPlayerList = VN_TR_SHOWTEAMINFO_LHS_PLAYERS_CTRL;

/////////////////////////////////////////////////////////////////////////////////
// Role limits and current team player counts per role

//--- Delete old controls
((allControls _displayCtrlPage) select {ctrlParentControlsGroup _x == _displayCtrlRoleLimits}) apply {ctrlDelete _x};
//--- Top seperator
private _seperatorRoleLimits = _displayCtrlPage ctrlCreate ["vn_mf_RscText", -1, _displayCtrlRoleLimits];
_seperatorRoleLimits ctrlSetPosition [0, 0, UIW(15), pixelH];
_seperatorRoleLimits ctrlCommit 0;
_seperatorRoleLimits ctrlSetBackgroundColor [0,0,0,1];
private _tgHRoleLimits = pixelH + UIH(0.1); // keep track of the y position in the controls group for the next row


_traitsTeam
	apply {
		private _nCtrls = []; // store newly created controls

		private _addH = 0; // find the highest h value of any text control
		private _hmap = _x;

		private _ctrlSingleRoleGroup = _displayCtrlPage ctrlCreate ["vn_mf_RscControlsGroupNoScrollbarHV", -1, _displayCtrlRoleLimits];
		_nCtrls pushBack _ctrlSingleRoleGroup;
		_ctrlSingleRoleGroup ctrlSetPosition [0, _tgHRoleLimits, UIW(15), UIH(1)];
		_ctrlSingleRoleGroup ctrlCommit 0;

		//--- Role icon, column 1
		private _ctrlRoleIcon = _displayCtrlPage ctrlCreate ["vn_mf_RscPicture",-1, _ctrlSingleRoleGroup];
		_ctrlRoleIcon ctrlSetPosition [0, 0, UIW(1), UIH(1)];
		_ctrlRoleIcon ctrlCommit 0;
		_ctrlRoleIcon ctrlSetText (_hmap get "icon");
		_ctrlRoleIcon ctrlSetTooltip (_hmap get "text");
		_ctrlRoleIcon ctrlSetTextColor [0,0,0,0.8];

		//--- Role Name, column 2
		private _ctrlRoleName = _displayCtrlPage ctrlCreate ["vn_mf_RscStructuredText",-1,_ctrlSingleRoleGroup];
		_nCtrls pushBack _ctrlRoleName;
		_ctrlRoleName ctrlSetPosition [UIW(1), 0, UIW(8.5), UIH(1)];
		_ctrlRoleName ctrlCommit 0;
		_ctrlRoleName ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>", _hmap get "text"];

		//--- Player count, column 3
		private _ctrlListPlayers = _displayCtrlPage ctrlCreate ["vn_mf_RscStructuredText", -1, _ctrlSingleRoleGroup];
		_nCtrls pushBack _ctrlListPlayers;
		_ctrlListPlayers ctrlSetPosition [UIW(10), 0, UIW(2.5), UIH(1)];
		_ctrlListPlayers ctrlCommit 0;
		_ctrlListPlayers ctrlSetStructuredText parseText format ["<t size='1'>%1</t>", _hmap get "playerCount"];

		//--- Player limits, column 4
		private _ctrlListLimit = _displayCtrlPage ctrlCreate ["vn_mf_RscStructuredText", -1, _ctrlSingleRoleGroup];
		_nCtrls pushBack _ctrlListLimit;
		_ctrlListLimit ctrlSetPosition [UIW(13), 0, UIW(2.5), UIH(1)];
		_ctrlListLimit ctrlCommit 0;
		_ctrlListLimit ctrlSetStructuredText parseText format ["<t size='1'>%1</t>", _hmap get "playerLimit"];

		_addH = (_addH max ctrlTextHeight _ctrlRoleName) max UIH(1);
		// _addH = UIH(6.5);
		_nCtrls apply {
			_x ctrlSetPositionH _addH;
			_x ctrlCommit 0;
		};
		_tgHRoleLimits = _tgHRoleLimits + _addH + UIH(0.05);

		//--- Seperator between roles
		private _seperatorUnderRole = _displayCtrlPage ctrlCreate ["RscText", -1, _displayCtrlRoleLimits];
		_seperatorUnderRole ctrlSetPosition [0, _tgHRoleLimits, UIW(15), pixelH];
		_seperatorUnderRole ctrlCommit 0;
		_seperatorUnderRole ctrlSetBackgroundColor [0,0,0,1];
		_tgHRoleLimits = _tgHRoleLimits + pixelH + UIH(0.1);

	};

/////////////////////////////////////////////////////////////////////////////////
// Players list with role icons

//--- Delete old controls
((allControls _displayCtrlPage) select {ctrlParentControlsGroup _x == _displayCtrlPlayerList}) apply {ctrlDelete _x};
//--- Top seperator
private _seperatorPlayerList = _displayCtrlPage ctrlCreate ["vn_mf_RscText", -1, _displayCtrlPlayerList];
_seperatorPlayerList ctrlSetPosition [0, 0, UIW(15), pixelH];
_seperatorPlayerList ctrlCommit 0;
_seperatorPlayerList ctrlSetBackgroundColor [0,0,0,1];
private _tgHPlayerList = pixelH + UIH(0.1); // keep track of the y position in the controls group for the next row

_teamTraits
	apply {

		private _hmap = _x;

		private _addH = 0; // find the highest h value of any text control
		private _nCtrls = []; // store newly created controls

		//--- Row group
		private _ctrlGrp = _displayCtrlPage ctrlCreate ["vn_mf_RscControlsGroupNoScrollbarHV", -1, _displayCtrlPlayerList];
		_nCtrls pushBack _ctrlGrp;
		_ctrlGrp ctrlSetPosition [0, _tgHPlayerList, UIW(15), UIH(1)];
		_ctrlGrp ctrlCommit 0;

		//--- player name
		private _ctrlPlayerName = _displayCtrlPage ctrlCreate ["vn_mf_RscStructuredText", -1, _ctrlGrp];
		_ctrlPlayerName ctrlSetPosition [0, 0, UIW(8), UIH(1)];
		_ctrlPlayerName ctrlCommit 0;
		_ctrlPlayerName ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>", (_hmap get "playerName")];
		_ctrlPlayerName ctrlSetTextColor [0,0,0,1];

		//--- role icons per player
		if (count (_hmap get "traits") isEqualTo 0) then {
			private _horizStart = 11;
			private _ctrlIcon = _displayCtrlPage ctrlCreate ["vn_mf_RscText", -1, _ctrlGrp];
			_nCtrls pushBack _ctrlIcon;
			_ctrlIcon ctrlSetPosition [UIW(_horizStart), 0, UIW(3), UIH(1)];
			_ctrlIcon ctrlCommit 0;
			_ctrlIcon ctrlSetText "None";
			_ctrlIcon ctrlSetTextColor [0,0,0,0.8];

		} else {
			{
				private _horizStart = 11 + _forEachIndex;
				private _ctrlIcon = _displayCtrlPage ctrlCreate ["vn_mf_RscPicture", -1, _ctrlGrp];
				_nCtrls pushBack _ctrlIcon;
				_ctrlIcon ctrlSetPosition [UIW(_horizStart), 0, UIW(1), UIH(1)];
				_ctrlIcon ctrlCommit 0;
				_ctrlIcon ctrlSetText (_x select 0);
				_ctrlIcon ctrlSetTooltip (_x select 1);
				_ctrlIcon ctrlSetTextColor [0,0,0,0.8];
			} forEach (_hmap get "traits");
		};

		_addH = _addH max UIH(1);

		_nCtrls apply {
			_x ctrlSetPositionH _addH;
			_x ctrlCommit 0;
		};
		_tgHPlayerList = _tgHPlayerList + _addH;

		//--- Seperator between players
		_seperatorPlayerList = _displayCtrlPage ctrlCreate ["RscText", -1, _displayCtrlPlayerList];
		_seperatorPlayerList ctrlSetPosition [0, _tgHPlayerList, UIW(15), pixelH];
		_seperatorPlayerList ctrlCommit 0;
		_seperatorPlayerList ctrlSetBackgroundColor [0,0,0,1];
		_tgHPlayerList = _tgHPlayerList + pixelH + UIH(0.05);
	};

// right hand side -- change team listbox
call vn_mf_fnc_tr_teamInfo_changeteam_init;