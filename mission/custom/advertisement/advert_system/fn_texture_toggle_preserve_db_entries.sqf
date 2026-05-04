/*
	File: fn_texture_toggle_preserve_db_entries.sqf
	Author: tylervip
	Public: yes

	Description:
		Backs up advert texture database entries before the main campaign save
		state is cleared.

	Parameter(s): none

	Returns:
		Nothing

	Example(s):
		call vn_mf_fnc_texture_toggle_preserve_db_entries;
*/

if (isNil "para_s_fnc_profile_db") exitWith {};

private _advertTextureToken = "vn_mf_texture_";
private _preservedAdvertTextures = [];

{
	private _tokenIndex = _x find _advertTextureToken;
	if (_tokenIndex >= 0) then {
		private _key = _x select [_tokenIndex];
		private _entry = ["GET", _key, -1] call para_s_fnc_profile_db;
		_preservedAdvertTextures pushBack [_key, _entry select 1];
	};
} forEach (["LIST"] call para_s_fnc_profile_db);

missionNamespace setVariable ["vn_mf_texture_toggle_preserved_db_entries", _preservedAdvertTextures];