/*
	File: fn_action_macv_force_recover_wreck.sqf
	Author: 'DJ' Dijksterhuis
	Public: No
	
	Description:
		MACV players can walk up to a vehicle spawner sign and force recovery of a wrecked vehicle.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_macv_force_recover_wreck;
*/

// player is curator
// looking at a spawner sign
// less than 3m from the sign
// vehicle for spawn point is recorded as WRECKED client side

private _conditionToShow = [
	"(missionNamespace getVariable ['curatorUIDs', []] findIf { _x == getPlayerUID player} > -1)",
	"(typeOf cursorTarget == 'vn_signad_sponsors_f')",
	"(player distance cursorTarget <= 3)",
	"(vn_mf_veh_asset_spawn_points_client get (cursorTarget getVariable 'veh_asset_spawnPointId') get 'status' get 'state' == 'WRECKED')"
] joinString " && ";

[
	player,
	"vn_mf_action_curator_recover_wreck",
	format [
		"<t color='#A04406'>%1</t>",
		"[ADMIN] Recover Wreck"
	],  // title
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[cursorTarget getVariable "veh_asset_spawnPointId"] remoteExec ["vn_mf_fnc_veh_asset_bn_curator_force_recover_wrecked_vehicle", 2];
	},  // script
	nil,  // arguments
	1.5,  // priority
	true,  // showWindow
	true,  // hideOnUse
	"",  // shortcut
	_conditionToShow,  // condition
	5,  // radius
	false,  // unconscious
	"",  // selection
	""  // memoryPoint
] call vn_mf_fnc_action_addAction;