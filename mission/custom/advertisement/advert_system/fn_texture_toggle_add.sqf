/*
	File: fn_texture_toggle_add.sqf
	Author: tylervip
	Public: yes

	Description:
		Adds a texture selection action to an object. Call from the object's
		init field in Eden Editor. The texture list for each object classname
		is defined at the top of this file — add new entries there.

	Parameter(s): none (uses 'this' from init field)

	Returns: Nothing

	Example(s):
	this call vn_mf_fnc_texture_toggle_add;
*/

// ============================================================
//  Load advertisement texture list from config file
// ============================================================
private _textures = call compile preprocessFileLineNumbers "custom\advertisement\advert_system\advert_list_config.sqf";
// ============================================================

private _object = _this;

if (count _textures == 0) exitWith {
	diag_log "[vn_mf_fnc_texture_toggle_add] Texture list is empty.";
};

// Set initial texture and state
_object setObjectTextureGlobal [0, _textures select 0];
_object setVariable ["vn_mf_textureIndex", 0, true];
_object setVariable ["vn_mf_hasTextureToggle", true, true]; // Mark object for restoration on restart

// Build one sub-action per texture
{
	private _texPath  = _x;
	private _texIndex = _forEachIndex;
	// Extract filename from path by splitting on backslash and taking last element
	private _parts    = _texPath splitString "\";
	private _fileName = _parts select (count _parts - 1);
	// Remove .paa extension
	private _extIndex = _fileName find ".paa";
	if (_extIndex >= 0) then {
		_fileName = _fileName select [0, _extIndex];
	};
	private _label    = _fileName;

	_object addAction [
		_label,
		{
			params ["_target", "_caller", "_actionId", "_args"];
			_args params ["_texPath", "_texIndex"];
			[_target, _texPath, _texIndex] remoteExecCall ["vn_mf_fnc_texture_toggle_apply", 0];
		},
		[_texPath, _texIndex],
		1.5,           // priority
		true,          // show window
		true,          // hide on use
		"",            // shortcut
		"(player distance _target < 5) && ([_caller, 'MACV'] call vn_mf_fnc_player_on_team)",
		5              // max distance
	];
} forEach _textures;
