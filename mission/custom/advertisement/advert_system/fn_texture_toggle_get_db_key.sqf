/*
	File: fn_texture_toggle_get_db_key.sqf
	Author: tylervip
	Public: yes

	Description:
		Builds the persistent storage key for an advert texture object.

	Parameter(s):
		0: Object - the object whose advert texture state is being stored

	Returns:
		String - database key for the object

	Example(s):
		private _key = [myObject] call vn_mf_fnc_texture_toggle_get_db_key;
*/

params ["_object"];

private _objectPos = getPosATL _object;

format [
	"vn_mf_texture_%1_%2_%3_%4",
	round (_objectPos select 0),
	round (_objectPos select 1),
	round (_objectPos select 2),
	typeOf _object
]