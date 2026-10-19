/*
	File: fn_soundranging_attach_local_fired_handler.sqf
	Author: Tylervip
	Public: No

	Description:
		Installs a local Fired event handler on a static weapon and relays the shot
		to the server when the object is owned by a client. The shot feeds both
		sound ranging (enemy guns) and counter-battery (player guns in an FSB).

	Parameter(s):
		_entity - Static weapon to monitor [OBJECT]

	Returns:
		Nothing
*/
params [["_entity", objNull, [objNull]]];

if (isNull _entity) exitWith {};
if !(local _entity) exitWith {};
if !(_entity isKindOf "StaticWeapon") exitWith {};
if (_entity getVariable ["vn_mf_soundranging_has_fired_event", false]) exitWith {};

_entity setVariable ["vn_mf_soundranging_has_fired_event", true, false];

_entity addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	if (isNull _unit) exitWith {};

	if (isServer) then {
		[_unit] call vn_mf_fnc_soundranging_on_fired;
		[_unit] call vn_mf_fnc_counterarty_on_player_fire;
	} else {
		[_unit] remoteExecCall ["vn_mf_fnc_soundranging_on_fired", 2];
		[_unit] remoteExecCall ["vn_mf_fnc_counterarty_on_player_fire", 2];
	};
}];
