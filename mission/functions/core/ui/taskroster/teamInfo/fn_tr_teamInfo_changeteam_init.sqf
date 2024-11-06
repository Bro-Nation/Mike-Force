/*
    File: fn_tr_teamInfo_changeteam_init.sqf
    Author: @dijksterhuis
    Public: No

    Description:
		Initialises the task roster teamInfo page's list box for the player to change team.

    Parameter(s): none

    Returns: nothing

    Example(s):
		[] call vn_mf_fnc_tr_teamInfo_changeteam_init;
*/


disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"


private _fnc_uid_in_whitelist = {
	params ["_uid", "_teamConfName"];

	private _teamArray = missionNamespace getVariable [
		format["whitelist_%1", _teamConfName],
		[]
	];

	(_uid in _teamArray)
};

private _fnc_get_teams_data = {
	private _teamsConfigs = "true" ConfigClasses (missionConfigFile >> "gamemode" >> "teams");

	private _teamsArrHmap = _teamsConfigs apply {

		private _wlu = (getNumber(_x >> "wlu") > 0);

		private _joinable = switch (true) do {
			case (_wlu && ([getPlayerUID player, configName _x] call _fnc_uid_in_whitelist)): {"Unlocked"};
			case (_wlu): {"Locked"};
			default {"Public"};
		};

		createHashMapFromArray [
			["confname", configName _x],
			["longname", getText(_x >> "name")],
			["shortname", getText(_x >> "shortname")],
			["icon", getText(_x >> "icon")],
			["desc", getText(_x >> "description")],
			["color", getText(_x >> "color")],
			["joinable", _joinable],
			["side", getText (_x >> "side")]
		]
	};

	_teamsArrHmap
};

private _fnc_init_listbox = {
	params ["_ctrl", "_teamsData"];

	lbclear _ctrl;
	if ((count _teamsData) isEqualTo 0) exitWith {nil};

	_teamsData apply {

		// new row of data
		// **MUST** set at least one value in here otherwise it breaks the UI
		// and refuses to show the right hand side page.

		// icon -- set later as a picture
		// name
		// public/wlu/joinable
		// map marker colour / type of unit indicator
		private _row = _ctrl lnbAddRow [
			"",
			_x get "shortname",
			"",
			"",
			""
		];

		// data we'll use to change team when player clicks the buttons
		_ctrl lnbSetData [[_row, 0], _x get "confname"];

		// column 0 -- icon for task type
		_ctrl lnbSetPicture [[_row, 0], _x get "icon"];

		_ctrl lnbSetText [[_row, 1], _x get "shortname"];
		_ctrl lnbSetTextRight [[_row, 2], _x get "joinable"];

		private _markerColor = [_x get "color"] call vn_mf_fnc_color_confname_to_rgba;
		_ctrl lnbSetPicture [[_row, 3], "\A3\ui_f\data\map\markers\nato\b_inf.paa"];
		_ctrl lnbSetPictureColor [[_row, 3], _markerColor];
		_ctrl lnbSetPictureColorSelected [[_row, 3], _markerColor];

		_ctrl lnbSetTooltip [[_row, 0], _x get "desc"];
		_ctrl lnbSetTooltip [[_row, 1], _x get "desc"];
		_ctrl lnbSetTooltip [[_row, 2], _x get "desc"];
		_ctrl lnbSetTooltip [[_row, 3], _x get "desc"];

	};

	private _playerTeam = player getVariable ["vn_mf_db_player_group", "MikeForce"];
	private _idxRowSelect = _teamsData findIf {(_x get "confname") isEqualTo _playerTeam};

	_ctrl lnbSetCurSelRow _idxRowSelect;
	_ctrl ctrlShow true;
};

private _teamsAll = call _fnc_get_teams_data;
private _teamsOnPlayerSide = _teamsAll select {
	(toLower (_x get "side")) isEqualTo (toLower (str (side player)))
};

[VN_TR_SHOWTEAMINFO_RHS_CHANGETEAM_LISTBOX_CTRL, _teamsOnPlayerSide] call _fnc_init_listbox;
