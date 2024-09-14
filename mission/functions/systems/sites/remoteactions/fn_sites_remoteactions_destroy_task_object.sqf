/*
	File: sites_remoteactions_destroy_task_object.sqf
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
		[_object, "vn_mine_m112_remote_ammo_scripted"] spawn vn_mf_fnc_sites_remoteactions_destroy_task_object;
*/

params ["_task", "_explosiveClassname"];

sleep 30;
private _bomb = createVehicle [_explosiveClassname, getPos _task, [], 0, "CAN_COLLIDE"];
_bomb setDamage 1;
deleteVehicle _task;
