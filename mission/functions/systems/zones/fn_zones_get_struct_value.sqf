/*
	File: fn_zones_get_struct_value.sqf
	Author: 'DJ' Dijksterhuis
	Public: Yes
	
	Description:
		Helper to avoid having to deal with local namespace manually
	
	Parameter(s):
		_zone - Id of zone to update [STRING]
		_struct - struct reference for what data to get from the struct [???]
	
	Returns:
		FValue for the struct attribute for the zone
	
	Example(s):
		["zone_ba_ria", struct_zone_m_task] call vn_mf_fnc_zones_get_struct_value;
		["zone_ba_ria", struct_zone_m_captured] call vn_mf_fnc_zones_get_struct_value;
*/

params ["_zone", "_struct"];
(localNamespace getVariable _zone) select _struct
