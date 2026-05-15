/*
	File: fn_monitor_food_crate.sqf
	Author: tylervip
	Public: yes

	Description:
		Monitors a spawned food crate and deletes it once all cargo has been removed.

	Parameter(s):
	_crate - Food crate object to monitor [OBJECT]

	Returns: nothing

	Example(s):
		[_crate] call vn_mf_fnc_monitor_food_crate
*/

if (!isServer) exitWith {};

params ["_crate"];

if (isNull _crate) exitWith {};
if (_crate getVariable ["vn_mf_food_crate_monitoring", false]) exitWith {};

_crate setVariable ["vn_mf_food_crate_monitoring", true, false];

[_crate] spawn {
	params ["_crate"];

	private _fnc_hasCargo = {
		params ["_crate"];

		(({_x > 0} count ((getItemCargo _crate) select 1)) > 0)
			|| (({_x > 0} count ((getMagazineCargo _crate) select 1)) > 0)
			|| (({_x > 0} count ((getWeaponCargo _crate) select 1)) > 0)
			|| (({_x > 0} count ((getBackpackCargo _crate) select 1)) > 0)
	};

	waitUntil {
		sleep 30;
		isNull _crate || {!alive _crate} || {!([_crate] call _fnc_hasCargo)}
	};

	if (!isNull _crate) then {
		deleteVehicle _crate;
	};
};