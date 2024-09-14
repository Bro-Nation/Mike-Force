/*
	File: sites_remoteactions_destroy_task.sqf
	Author: Cerebral
	Modified: @dijksterhuis
	Public: No
	
	Description:
		Destroys a site's asset based on the type of asset, via the `destroy_task` holdAction

		This runs server side. It needs to do several client side remoteExecs to:
		- remove the player's explosive mag from inventory
		- set up the fire light/particle sources for burning a shelter
		- Send various paradigm notifications to players

		Currently implemented:
		- Burning shelters at campsites
		- Destroying dac cong respawns
		- Blowing up a paradigm built building
		- Blowing up a basic object, like an ammo crate or a mortar
	
	Parameter(s):
		- _task - the object that needs to be destroyed (player is looking at)
		- _player - player doing the destroying
	
	Returns:
	
	Example(s):
		[_object, _player] call vn_mf_fnc_sites_remoteactions_destroy_task;
*/

params ["_task", "_player"];


/*
Magazines in arma are not the same as ammo which does the firing.
Even a breaching charge etc has ammo, and the ammo is what explodes.
the magazine is what is in the player's inventory. 
the ammo is what detonates.
*/
private _neededExplosiveTypesHmap = createHashMapFromArray [
	["vn_mine_satchel_remote_02_mag", "vn_mine_satchelcharge_02_ammo_scripted"],
	["vn_mine_m112_remote_mag","vn_mine_m112_remote_ammo_scripted"], 
	["vn_mine_limpet_01_mag", "vn_mine_limpet_01_ammo_scripted"],
	["vn_mine_bangalore_mag", "vn_mine_bangalore_ammo_scripted"]
]; 

private _fnc_take_explosive_ammo_from_inventory_mags = {
	params ["_player", "_availableExplosives"];
	[_player, (_availableExplosives select 0)] remoteExec ["removeMagazine", _player];
	private _explosive = _neededExplosiveTypesHmap get (_availableExplosives select 0);

	_explosive
};

private _mags = magazines _player; 
private _playerExplosives = _mags select {_x in _neededExplosiveTypesHmap};
private _playerLighters = _mags arrayIntersect ["vn_b_item_lighter_01"];

private _nearPlayers = ((getPos _task) nearObjects ["Man", 50]) select {isPlayer _x};

switch (true) do { 

	/*
	has a light and task is a shelter
	burn the shelter by spawning a bunch of particles client side
	onces 10 seconds are up then destory the task from the server.
	*/
	case (((count _playerLighters) > 0) && (typeOf _task == "Land_vn_o_shelter_06")): {

		// client side -- show fire effects for X seconds.
		[_task, 10] remoteExec ["vn_mf_fnc_sites_remoteactions_destroy_task_burn_object", _nearPlayers];
		// server side -- delete the shelter after X seconds.
		[_task, 10] spawn {
			params ["_task", "_delay"];
			sleep _delay;
			deleteVehicle _task;
		};
		["CampBurnt", ["The tent has been set on fire!"]] remoteExec ["para_c_fnc_show_notification", _player];
	};

	/* no explosives? no explosions. */
	case ((count _playerExplosives) isEqualTo 0): {
		["NoExplosives"] remoteExec ["para_c_fnc_show_notification", _player];
	};

	/* has explosives and task is dc respawn. deref the respawn then destroy the object */
	case (((count _playerExplosives) > 0) && (typeOf _task == "Land_vn_o_platform_04")): {

		private _explosive = [_player, _playerExplosives] call _fnc_take_explosive_ammo_from_inventory_mags;
		[_task] call vn_mf_fnc_sites_remoteactions_destroy_task_dc_respawn;
		[_task, _explosive] spawn vn_mf_fnc_sites_remoteactions_destroy_task_object;
		_nearPlayers apply {["FireInTheHole"] remoteExec ["para_c_fnc_show_notification", _x]};
	}; 

	/* has explosives and task is a paradigm built building. deref the paradigm building then destroy the object */
	case (((count _playerExplosives) > 0) && !(isNull (_task getVariable ["para_g_building", objNull]))): {

		private _explosive = [_player, _playerExplosives] call _fnc_take_explosive_ammo_from_inventory_mags;
		[_task, _explosive] spawn vn_mf_fnc_sites_remoteactions_destroy_task_para_building;
		_nearPlayers apply {["FireInTheHole"] remoteExec ["para_c_fnc_show_notification", _x]};
	}; 

	/* has explosives and task is a basic arma object. just destroy the object */
	case (((count _playerExplosives) > 0) && !(isNull _task)): {

		private _explosive = [_player, _playerExplosives] call _fnc_take_explosive_ammo_from_inventory_mags;
		[_task, _explosive] spawn vn_mf_fnc_sites_remoteactions_destroy_task_object;
		_nearPlayers apply {["FireInTheHole"] remoteExec ["para_c_fnc_show_notification", _x]};
	}; 

	default {
		/*
		tl;dr -- please report to dev team.
		players should not have been able to make this notification appear.
		if they have, something is wrong in either
		-- the switch logic above
		-- the destroy_task holdAction (new classname added to the list and no new logic here?)
		*/

		// TODO: Need to make this notification!
		["SiteDestroyTaskActionsError"] remoteExec ["para_c_fnc_show_notification", _player];
	}; 
};
