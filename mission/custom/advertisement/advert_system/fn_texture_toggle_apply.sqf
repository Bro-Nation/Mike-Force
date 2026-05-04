/*
	File: fn_texture_toggle_apply.sqf
	Author: tylervip
	Public: yes

	Description:
		Applies a texture to an object and stores the index.
		Called globally via remoteExecCall from fn_texture_toggle_add.
		Saves texture state to database for persistence across restarts.

	Parameter(s):
		0: Object  - the object to texture
		1: String  - texture path (.paa)
		2: Number  - texture index (for state tracking)
		3: Object  - unit making the change (optional, for logging who changed it)
		4: String  - label shown in action menu (optional, used in logs)

	Returns: Nothing

	Example(s):
		[myObject, "custom\billboards\Press_bb.paa", 0] call vn_mf_fnc_texture_toggle_apply;
		[myObject, "custom\billboards\Press_bb.paa", 0, player] call vn_mf_fnc_texture_toggle_apply;
		[myObject, "custom\billboards\Press_bb.paa", 0, player, "Press_bb"] call vn_mf_fnc_texture_toggle_apply;
*/

params ["_object", "_texPath", "_texIndex", ["_changedBy", objNull], ["_label", "Unknown"]];

_object setObjectTextureGlobal [0, _texPath];
_object setVariable ["vn_mf_textureIndex", _texIndex, true];

// Log who made the change
private _changedByName = if (_changedBy isEqualType objNull && {!isNull _changedBy}) then {
	name _changedBy
} else {
	"Unknown"
};

// Save texture state to both serverNamespace (session) and database (persistent)
if (isServer) then {
	private _key = [_object] call vn_mf_fnc_texture_toggle_get_db_key;
	// Save to serverNamespace for current session
	serverNamespace setVariable [_key, _texIndex];
	
	// Also save to database if available
	if (!isNil "para_s_fnc_profile_db") then {
		["SET", _key, _texIndex] call para_s_fnc_profile_db;
		diag_log format ["[vn_mf_fnc_texture_toggle_apply] Saved texture '%1' to database. Changed by: %2", _label, _changedByName];
	} else {
		diag_log "[vn_mf_fnc_texture_toggle_apply] WARNING: Failed to save to database - para_s_fnc_profile_db not available.";
	};
};
