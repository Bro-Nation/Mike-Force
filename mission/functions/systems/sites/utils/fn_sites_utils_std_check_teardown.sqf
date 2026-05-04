/*
	File: fn_sites_utils_std_check_teardown.sqf
	Author: "DJ" Dijksterhuis
	Public: No
	
	Description:
		Checks if an object is within a specified radius.
	
	Parameter(s):
		_siteStore - Site to check the teardown condition of.
		_radius - [OPTIONAL] radius of search area for aliveness.
	
	Returns:
		true if object is alive within radius, false otherwise
	
	Example(s):
 		[_siteStore] call vn_mf_fnc_sites_utils_std_check_teardown;
 		[_siteStore, 25] call vn_mf_fnc_sites_utils_std_check_teardown;
*/

params ["_siteStore", ["_radius", 50]];

private _pos = getPos _siteStore;
private _objects = _siteStore getVariable "objectsToDestroy";

/*
Note for future people.
-------

if the object isn't alive then it has been destroyed. 
good job GI.

-------

we need to ignore objects a player has loaded into a vehicle
with the logistics module.

When a player loads a mortar/zpu etc into a vehicle with the 
advanced logistics module, the object is hidden and attached
to the player.

the module also sets the getVariable `log_inventory_loaded`
variable on the object to `true`.

-------

if an object has been moved out of the site radius, then 
someone is either trolling, or was able to walk into the site
and walk out with the objects to destroy.

in either case, opfor no longer have the object.
*/

private _existingObject = _objects findIf {

	private _objIsAlive = alive _x;
	private _objNotLogisticsd = !(_x getVariable ["log_inventory_loaded", false]);
	private _objWithinSiteRadius = count ([_x] inAreaArray [_pos, _radius, _radius, 0, false]) > 0;
	private _objExemptFromRadius = _x getVariable ["exemptFromRadiusCheck", false];

	if (_objExemptFromRadius) then {
		(_objIsAlive && _objNotLogisticsd)
	} else {
		(_objIsAlive && _objNotLogisticsd && _objWithinSiteRadius)
	};
};

_existingObject == -1