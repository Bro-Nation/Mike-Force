/*
	File: fn_sites_create_compositions_fuel.sqf
	Author: Spoffy
	Date: 2020-05-23
	Last Update: 2020-07-01
	Public: No
	
	Description:
		Creates buildings for a PAVN HQ.
	
	Parameter(s):
		_position - Position [Position]
	
	Returns: nothing
	
	Example(s): none
	
	0: STRING	- Classname
	1: ARRAY	- Position [delta X, delta Y, z]
	2: NUMBER	- Azimuth
	3: NUMBER	- Fuel
	4: NUMBER	- Damage
	5: ARRAY	- Return from BIS_fnc_getPitchBank (only if 2nd param is false)
	6: STRING	- vehicleVarName
	7: STRING	- Initialization commands
	8: BOOLEAN	- Enable simulation
	9: BOOLEAN	- Position is ASL
*/

params ["_position"];

vn_mf_sites_compositions_fuel = [
	createHashMapFromArray [
		["Author","@legend"],
		["TerrainHindingKinds",""],
		["MaximumAllowedTerrainGradient",10],
		["WaterSpawn",0],
		["Name","Fuel-1a"],
		["Type","Fuel"],
		["Composition",[
			["vn_b_prop_prc77_01",[2.22266,-0.302734,0.449738],215.104,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[-1.46094,2.42725,0],191.491,1,0,[0,0],"","",false,false],
			["Land_cargo_house_slum_F",[-1.86328,-2.12549,0],204.683,1,0,[0,0],"","",false,false],
			["Land_vn_t_albizia_f",[4.73242,1.58057,0],0,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[5.12109,-3.0249,0],89.8582,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[-3.72266,-6.07617,0],5.56971,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[-1.67188,7.10156,-0.0750008],333.306,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[5.01367,5.50195,-0.0750008],20.2401,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_high_01",[2.57617,-7.34326,-0.0750008],159.54,1,0,[0,-0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[-8.32422,-1.521,-0.0750084],225.1,1,0,[0,0],"","",false,false]
		]]
	],
	createHashMapFromArray [
		["Author","@legend"],
		["TerrainHindingKinds",""],
		["MaximumAllowedTerrainGradient",10],
		["WaterSpawn",0],
		["Name","Fuel-1b"],
		["Type","Fuel"],
		["Composition",[
			["vn_b_prop_prc77_01",[2.22266,-0.302734,0.449738],215.104,1,0,[0,0],"","",false,false],
			["Land_cargo_house_slum_F",[-1.86328,-2.12549,0],204.683,1,0,[0,0],"","",false,false],
			["Land_vn_t_albizia_f",[4.73242,1.58057,0],0,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[5.12109,-3.0249,0],89.8582,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[-3.72266,-6.07617,0],5.56971,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[-1.67188,7.10156,-0.0750008],333.306,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[5.01367,5.50195,-0.0750008],20.2401,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_high_01",[2.57617,-7.34326,-0.0750008],159.54,1,0,[0,-0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[-8.32422,-1.521,-0.0750084],225.1,1,0,[0,0],"","",false,false]
		]]
	],
	createHashMapFromArray [
		["Author","@legend"],
		["TerrainHindingKinds",""],
		["MaximumAllowedTerrainGradient",10],
		["WaterSpawn",0],
		["Name","NULL"],
		["Type","Fuel-2"],
		["Composition",[
			["Land_Slum_House02_F",[-0.0839844,-0.458496,0.23],0,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[5.13086,-1.29785,0],270.022,1,0,[0,0],"","",false,false],
			["vn_b_prop_prc77_01",[-4.18359,3.57471,0],0,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[-0.541016,-5.87451,0],180.435,1,0,[0,0],"","",false,false],
			["vn_o_nva_65_static_zpu4",[-6.4082,-2.09717,-0.0750008],215.041,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[3.18359,6.30322,-0.0750074],33.8837,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[5.31055,-6.63379,-0.0750074],118.87,1,0,[0,-0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[-6.78906,5.25488,-0.0750008],310.753,1,0,[0,0],"","",false,false],
			["Land_vn_t_fagussylvatica_2s",[-2.96094,4.39502,0],240.417,1,0,[0,0],"","",false,false]
		]]
	],
	createHashMapFromArray [
		["Author","@legend"],
		["TerrainHindingKinds",""],
		["MaximumAllowedTerrainGradient",10],
		["WaterSpawn",0],
		["Name","NULL"],
		["Type","Fuel-3"],
		["Composition",[
			["Land_vn_tank_rust_f",[-1.91406,1.28809,0],162.65,1,0,[0,-0],"","",false,false],
			["Land_cargo_house_slum_F",[-0.701172,-2.38379,0],163.056,1,0,[0,-0],"","",false,false],
			["Land_vn_tank_rust_f",[-2.81836,4.41846,0],163.176,1,0,[0,-0],"","",false,false],
			["vn_b_prop_prc77_01",[-4.83789,-2.92773,0],81.246,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[-6.96289,-0.313965,-0.0750074],251.73,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[4.15625,6.48877,-0.0750008],63.4053,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[-2.51953,-7.51855,-0.0750074],207.258,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_high_01",[3.50781,-6.98193,-0.0750008],95.2579,1,0,[0,-0],"","",false,false],
			["Land_vn_t_juglansregia_2s",[5.38672,-2.68311,0],0,1,0,[0,0],"","",false,false]
		]]
	],
	createHashMapFromArray [
		["Author","@legend"],
		["TerrainHindingKinds",""],
		["MaximumAllowedTerrainGradient",10],
		["WaterSpawn",0],
		["Name","NULL"],
		["Type","Fuel-4"],
		["Composition",[
			["Land_vn_tank_rust_f",[1.46094,-1.53857,0],359.268,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[1.48047,1.68408,0],359.268,1,0,[0,0],"","",false,false],
			["Land_vn_tank_rust_f",[1.625,-4.88965,0],359.268,1,0,[0,0],"","",false,false],
			["Land_vn_slum_house01_f",[-4.31836,-1.29248,0],88.5042,1,0,[0,0],"","",false,false],
			["vn_o_nva_65_static_zpu4",[-0.992188,6.56299,-0.0750008],69.7135,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_high_01",[6.71875,0.749023,-0.0750008],95.2579,1,0,[0,-0],"","",false,false],
			["vn_b_prop_prc77_01",[-5.7793,-3.94092,0],0,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_dshkm_low_01",[-6.74023,3.5708,-0.0750008],313.581,1,0,[0,0],"","",false,false],
			["vn_o_nva_navy_static_m1910_low_01",[-3.65039,-6.8374,-0.0750074],225.1,1,0,[0,0],"","",false,false],
			["Land_vn_pine_tree_01",[6.51367,-1.2998,0],0,1,0,[0,0],"","",false,false]
		]]
	]
];


private _selectedHMap = selectRandom vn_mf_sites_compositions_fuel;

private _randAngle = [1, 360] call BIS_fnc_randomInt;
private _site_objs = [_position, _randAngle, _selectedHMap get "Composition", 0] call BIS_fnc_objectsMapper;

_site_objs;