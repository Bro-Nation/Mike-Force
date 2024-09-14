/*
	File: fn_zones_update_zone.sqf
	Author: 'DJ' Dijksterhuis
	Public: Yes
	
	Description:
		Updates data about a zone.
	
	Parameter(s):
		_zone - Id of zone to update [STRING]
		_struct - struct reference for what data to update in the struct [???]
		_value - data to update the struct entry with [ANY]
	
	Returns:
		Nothing.
	
	Example(s):
		["zone_ba_ria", struct_zone_m_task, "capture"] call vn_mf_fnc_zones_update_zone;
		["zone_ba_ria", struct_zone_m_captured, true] call vn_mf_fnc_zones_update_zone;
*/

params ["_zone", "_struct", "_value"];
localNamespace getVariable [_zone, []] set [_struct, _value];
// save new data to DB immediately
// (otherwise we have to wait up to 30 seconds for the zone manager job)
[localNamespace getVariable _zone] call vn_mf_fnc_zones_save_zone;