/*
	File: eh_MarkerDeleted.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
	    EVent Handler for when a player deletes a marker
	
	Parameter(s): none
	
	Returns: nothing
*/

params ["_marker", "_local"];

if (!(_local)) exitWith {};
if (!(visibleMap)) exitWith {};
if (_marker in vn_mf_player_markers) exitWith  {};
if (_marker in vn_mf_player_markers_vehicle_markers) exitWith { };

private _text = markerText _marker;
if (_text == "") exitWith { };

{
	private _inMACV = [_x, "MACV"] call para_g_fnc_db_check_whitelist;
	private _instigatorIsMACV = [player] call para_g_fnc_db_check_curator;
	//if (_instigatorIsMACV) then { continue };
	if !(_inMACV) then { continue };
	
	[format ["[MACV] %1 has deleted a map marker. Contents: '%2'", name player, _text]] remoteExec ["systemChat", _x];
	if (localNamespace getVariable ["vn_adminLogEnabled", true]) then {
		["AdminLog", [format ["%1 has deleted a map marker.", name player]]] remoteExec ["para_c_fnc_show_notification", _x];
	};
} forEach allPlayers;