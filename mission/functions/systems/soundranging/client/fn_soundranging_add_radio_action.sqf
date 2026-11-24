/*
	File: fn_soundranging_add_radio_action.sqf
	Author: Tylervip
	Public: No

	Description:
		Adds a local sound-ranging action to a radio.

	Parameter(s):
		_radio - Radio object [OBJECT]

	Returns:
		Nothing
*/
params [["_radio", objNull, [objNull]]];

if (!hasInterface) exitWith {};
if (isNull _radio) exitWith {};

private _actionId = [
	_radio,
	"vn_mf_soundranging_action_id",
	"<t color='#00FF00'>Access Sound Ranging Net</t>",
	{
		params ["_target", "_caller"];
		[_target, _caller] call vn_mf_fnc_soundranging_open_net;
	},
	nil,
	1.5,
	true,
	true,
	"",
	"alive _target && {alive _this} && {_this getVariable ['vn_mf_db_player_group', 'MikeForce'] isEqualTo 'QuarterHorse'}",
	3
] call vn_mf_fnc_action_addAction;

_radio setVariable ["vn_mf_soundranging_action_id", _actionId];
