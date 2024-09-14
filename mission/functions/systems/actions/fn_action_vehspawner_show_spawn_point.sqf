/*
	File: fn_action_vehspawner_show_spawn_point.sqf
	Author: 'DJ' Dijksterhuis
	Public: No
	
	Description:
		MACV players can walk up to a vehicle spawner sign and force the vehicle position back to spawn point.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_macv_force_reset_vehicle;
*/

// player is curator
// looking at a spawner sign
// less than 3m from the sign
// vehicle for spawn point is recorded as IDLE client side

// private _role = assignedVehicleRole player select 0;

private _conditionToShow = [
	// player is in a vehicle
	"(vehicle player != player)",
	// player is the driver
	"((assignedVehicleRole player select 0) == 'driver')",
	// player's vehicle was created by mike force veh spawner system
	"!(((vehicle player) getVariable ['veh_asset_spawnPointId', false]) isEqualTo false)",
	// draw3d is not already shown in the display
	"((player getVariable ['veh_asset_spawnPoint_draw3d_active', false]) isEqualTo false)"
] joinString " && ";

player addAction
[
	"Locate Vehicle's Spawn Point",  // title
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		call vn_mf_fnc_veh_asset_client_locate_vehicle_spawn_point;
	},  	// script
	nil,	// arguments
	0,		// priority -- set to 0 because not going to be needed in combat
	false,	// showWindow
	true, 	// hideOnUse
	"CommandingMenuSelect9",  // shortcut
	_conditionToShow,  // condition
	5, 		// radius
	false,  // unconscious
	"",  	// selection
	""  	// memoryPoint
];