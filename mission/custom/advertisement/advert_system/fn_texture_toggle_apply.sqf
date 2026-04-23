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

	Returns: Nothing

	Example(s):
		[myObject, "custom\billboards\Press_bb.paa", 0] call vn_mf_fnc_texture_toggle_apply;
*/

params ["_object", "_texPath", "_texIndex"];

_object setObjectTextureGlobal [0, _texPath];
_object setVariable ["vn_mf_textureIndex", _texIndex, true];

// Save texture state to both serverNamespace (session) and database (persistent)
if (isServer) then {
	private _objectPos = getPosATL _object;
	private _key = format ["vn_mf_texture_%1_%2_%3_%4", 
		round (_objectPos select 0), 
		round (_objectPos select 1), 
		round (_objectPos select 2),
		typeOf _object
	];
	// Save to serverNamespace for current session
	serverNamespace setVariable [_key, _texIndex];
	
	// Also save to database if available
	if (!isNil "para_s_fnc_profile_db") then {
		["SET", _key, _texIndex] call para_s_fnc_profile_db;
	};
};
