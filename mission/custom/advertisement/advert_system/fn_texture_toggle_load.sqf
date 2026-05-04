/*
	File: fn_texture_toggle_load.sqf
	Author: tylervip
	Public: yes

	Description:
		Loads saved texture states from database and applies them to objects.
		Call on server init to restore textures from previous session.

	Parameter(s): none

	Returns: Nothing

	Example(s):
		call vn_mf_fnc_texture_toggle_load;
*/

if (!isServer) exitWith {};

// ============================================================
//  Load advertisement texture list from config file
// ============================================================
private _textures = call compile preprocessFileLineNumbers "custom\advertisement\advert_system\advert_list_config.sqf";
// ============================================================

// Find objects marked with texture toggle actions
private _allObjects = allMissionObjects "All" select {(_x getVariable ["vn_mf_hasTextureToggle", false])};

// Try to restore texture state for each marked object
{
	private _object = _x;
	private _objectPos = getPosATL _object;
	private _key = [_object] call vn_mf_fnc_texture_toggle_get_db_key;
	
	// Try to get saved texture index from database
	private _savedIndex = -1;
	if (!isNil "para_s_fnc_profile_db") then {
		private _dbResult = ["GET", _key, -1] call para_s_fnc_profile_db;
		if (_dbResult isEqualType []) then {
			_savedIndex = _dbResult select 1;
		} else {
			_savedIndex = _dbResult;
		};
	};
	
	if (_savedIndex >= 0 && _savedIndex < count _textures) then {
		private _texPath = _textures select _savedIndex;
		[_object, _texPath, _savedIndex] call vn_mf_fnc_texture_toggle_apply;
		diag_log format ["[vn_mf_fnc_texture_toggle_load] Restored texture %1 for object at %2", _savedIndex, _objectPos];
	} else {
		// No saved texture found - apply default (first texture in list)
		private _texPath = _textures select 0;
		[_object, _texPath, 0] call vn_mf_fnc_texture_toggle_apply;
		diag_log format ["[vn_mf_fnc_texture_toggle_load] Applied default texture for object at %1", _objectPos];
	};
} forEach _allObjects;
