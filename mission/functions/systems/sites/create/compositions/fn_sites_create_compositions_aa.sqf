/*
	File: fn_create_aa_buildings.sqf
	Author: Cerebral
	Public: No
	
	Description:
		Creates a aa encampment at the given position.
	
	Parameter(s):
		_position - Position of the aa [Position3D]
	
	Returns:
		Array containing the aa buildings [Array]
	
	Example(s): none
*/

params ["_position"];

vn_mf_aa_compositions = [
	[
		["vn_o_nva_navy_static_zpu4",[0,0,0],0,0,0,[],"","",true,false]
	],
	[
		["vn_o_nva_static_zpu4",[0,0,0],0,0,0,[],"","",true,false]
	],
	[
		["vn_o_nva_65_static_zpu4",[0,0,0],0,0,0,[],"","",true,false]
	],
	[
		["vn_o_nva_navy_static_zpu4",[2.5,2.5,0],0,0,0,[],"","",true,false],
		["vn_o_nva_navy_static_zpu4",[-2.5,-2.5,0],180,0,0,[],"","",true,false]
	],
	[
		["vn_o_nva_static_zpu4",[2.5,2.5,0],0,0,0,[],"","",true,false],
		["vn_o_nva_static_zpu4",[-2.5,-2.5,0],180,0,0,[],"","",true,false]
	],
	[
		["vn_o_nva_65_static_zpu4",[2.5,2.5,0],0,0,0,[],"","",true,false],
		["vn_o_nva_65_static_zpu4",[-2.5,-2.5,0],180,0,0,[],"","",true,false]
	],
        [  
                ["vn_o_nva_65_static_zpu4",[5,5,0],0,0,0,[],"","",true,false],
		["vn_o_nva_65_static_zpu4",[-5,5,0],90,0,0,[],"","",true,false],
		["vn_o_nva_65_static_zpu4",[0,-5,0],180,0,0,[],"","",true,false]
	],	
	[  
                ["vn_o_nva_navy_static_zpu4",[5,5,0],0,0,0,[],"","",true,false],
		["vn_o_nva_navy_static_zpu4",[-5,5,0],90,0,0,[],"","",true,false],
		["vn_o_nva_navy_static_zpu4",[0,-5,0],180,0,0,[],"","",true,false]
	]		
];

private _randomAngle = [0,360] call BIS_fnc_randomInt;
private _aaObjects = [_position, _randomAngle, selectRandom vn_mf_aa_compositions] call vn_mf_fnc_sites_create_objects_with_tree_removal;
_aaObjects
