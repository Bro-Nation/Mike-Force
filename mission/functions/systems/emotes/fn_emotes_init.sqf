/*
	File: fn_emotes_init.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Initialise emote system.

		Builds the wheel menu options and stores them in the player's
		uiNamespace for later use.

	Parameter(s):
		_player: OBJECT: Player we're initialising the system for.

	Returns:
		Nothing

	Example(s):
		call vn_mf_fnc_emotes_init;
*/

params ["_player"];

private _rgba_color = [40/256, 110/256, 23/256, 1];

uiNamespace setVariable ["vn_mf_bn_emotes_menu_actions", []];

private _fnc_setup_action = {
	params [
		"_name",
		"_method",
		"_action",
		["_icon", "img\vn_ico_mf_emotes.paa"],
		["_iconColorCodes", [
			_rgba_color,
			[1, 1, 1, 1]
		]],
		["_selectorColorCodes", [
			_rgba_color,
			[1, 1, 1, 1]
		]]
	];
	createHashMapFromArray [
		["text", _name],
		["iconPath", _icon],
		["spawnFunction", false],
		["functionArguments", [_player, _method, _action]],
		["function", "vn_mf_fnc_emotes_emote_toggle"],
		["iconColorCodes", _iconColorCodes],
		["selectorColorCodes", _selectorColorCodes]
	]
};

private _fnc_setup_category = {
	params [
		"_name",
		"_data",
		["_icon", "img\vn_ico_mf_emotes.paa"]
	];
	createHashMapFromArray [
		["text", _name],
		["iconPath", _icon],
		["submenuActions", _data],
		["iconColorCodes", [
			_rgba_color,
			[1, 1, 1, 1]
		]],
		["selectorColorCodes", [
			_rgba_color,
			[1, 1, 1, 1]
		]]
	]
};

/*
Read config data located at mission\config\subconfigs\emotes.hpp

- `seq` --> will play a sequence of animations one after the other.
- `loop` --> these animations are looped and there's no end point to them.

*/
private _fnc_create_categories_from_config = {
	params ["_configName"];
	private _config = missionConfigFile >> "gamemode" >> "emotes" >> _configName;

	private _categorySubData = [];

	("isClass(_x)" configClasses (_config)) apply {

		private _cls = _x;

		private _categorySubOptions = getArray (_cls >> "options");
		private _categorySubName = getText (_cls >> "title");
		private _categorySubIcon = getText (_cls >> "icon");

		// maximum 9 options
		_categorySubOptions resize (9 min (count _categorySubOptions));

		private _categorySubActions = _categorySubOptions select {
			(_x isEqualType []) && (count _x == 2)
		} apply {
			[_x select 0, _configName, _x select 1, _categorySubIcon] call _fnc_setup_action
		};

		private _categorySubActionsSorted = [_categorySubActions, [], {_x get "text"}, "DESCEND"] call BIS_fnc_sortBy;

		if (count _categorySubData >= 9) exitWith {false};
		_categorySubData pushBackUnique (
			[_categorySubName, _categorySubActionsSorted, _categorySubIcon] call _fnc_setup_category
		);
	};

	private _categorySubDataSorted = [_categorySubData, [], {_x get "text"}, "DESCEND"] call BIS_fnc_sortBy;

	private _catMainName = getText (_config >> "title");
	private _catMainIcon = getText (_config >> "icon");

	[
		_catMainName,
		_categorySubDataSorted,
		_catMainIcon
	] call _fnc_setup_category
};

private _looped = ["loop"] call _fnc_create_categories_from_config;
private _seqd = ["seq"] call _fnc_create_categories_from_config;

// initial action is the "stop doing the current aniamtion" option
private _actionInitial = [
	"Stop Animation(s)",
	"loop", // `switchMove` hard cancel
	"", 	// `switchMove` to 'nothing' animation
	"img\vn_ico_mf_emotes.paa",
	[[1,0,0,1], [1,0,0,1]],
	[[1,0,0,0.4], [1,0,0,1]]
] call _fnc_setup_action;

uiNamespace setVariable [
	"vn_mf_bn_emotes_menu_actions",
	[_actionInitial, _looped, _seqd]
];
