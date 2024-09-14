/*
	File: sites_remoteactions_destroy_task_para_building.sqf
	Author: @dijksterhuis
	Public: No
	
	Description:
		Sets down an explosive **ammo**, then blows it up and deletes the object.

		This **must** be spawn'd because we need to sleep the thread!
	
	Parameter(s):
		- _task - the object which will be deleted
		- _explosiveClassname - the ammo we'll use to cause an explosion
								**MUST** have the `_ammo_scripted` suffix 
								and **MUST** be ammo -- NOT A MAGAZINE!!
	
	Returns:
	
	Example(s):
		[_object, "vn_mine_m112_remote_ammo_scripted"] spawn vn_mf_fnc_sites_remoteactions_destroy_para_building;
*/

params ["_task", "_explosiveClassname"];

private _building = _task getVariable ["para_g_building", objNull];

sleep 15;
private _bomb = createVehicle [_explosiveClassname, getPos _task, [], 0, "CAN_COLLIDE"];
_bomb setDamage 1;
[_building, "onBuildingDeleted", [_building]] call para_g_fnc_building_fire_feature_event;
[_building] call para_s_fnc_building_delete;
