/*
	File: fn_texture_toggle_restore_db_entries.sqf
	Author: tylervip
	Public: yes

	Description:
		Restores advert texture database entries after the main campaign save
		state has been cleared.

	Parameter(s): none

	Returns:
		Nothing

	Example(s):
		call vn_mf_fnc_texture_toggle_restore_db_entries;
*/

if (isNil "para_s_fnc_profile_db") exitWith {};

private _preservedAdvertTextures = missionNamespace getVariable ["vn_mf_texture_toggle_preserved_db_entries", []];

{
	_x params ["_key", "_value"];
	["SET", _key, _value] call para_s_fnc_profile_db;
} forEach _preservedAdvertTextures;

missionNamespace setVariable ["vn_mf_texture_toggle_preserved_db_entries", nil];

["SAVE"] call para_s_fnc_profile_db;