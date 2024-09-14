/*
	File: fn_create_water_supply_buildings.sqf
	Author: Cerebral
	Public: No
	
	Description:
		Creates buildings for a water supply.
	
	Parameter(s):
		_position - Position [Position]
	
	Returns: nothing
	
	Example(s): none
	
	0: STRING	- Classname
	1: ARRAY	- Position [delta X, delta Y, z]
	2: NUMBER	- Azimuth
	3: NUMBER	- Fuel
	4: NUMBER	- Damage
	5: ARRAY	- Return from BIS_fnc_getPitchBank (only if 2nd param is true)
	6: STRING	- vehicleVarName
	7: STRING	- Initialization commands
	8: BOOLEAN	- Enable simulation
	9: BOOLEAN	- Position is ASL
*/

params ["_position"];

private _tunnelWS = "vn_o_ammobox_02" createVehicle _position;

private _vehicles = _tunnelWS; //[_tunnel select 0];
private _units = [];// _tunnel select 1;
private _groups = []; //[_tunnel select 2];

[[_vehicles, _units, _groups], [_tunnel select 0]]
