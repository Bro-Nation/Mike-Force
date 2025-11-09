/*
	File: fn_create_factory_buildings.sqf
	Author: Cerebral
	Public: No
	
	Description:
		Creates buildings for a PAVN Factory.
	
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

vn_mf_radar_compositions = [];
vn_mf_radar_compositions_default = [];

if(toLower(worldName) in ["cam_lao_nam", "vn_khe_sanh", "vn_the_bra"])then {
    vn_mf_radar_compositions_default = [
        [
            ["vn_o_static_rsna75",[0.995117,2.03516,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_wheeled_z157_04",[-8.69873,-9.60986,0.220597],122.685,1,0,[0,-0],"","",true,false],
            //["vn_o_wheeled_z157_03_nvam",[9.63037,11,0.18],315.4,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[-10.1553,-20.1553,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[9.71045,-22.8848,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[0.59375,25.1338,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[20.3359,16.9004,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-20.543,17.0474,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-24.0186,-14.6758,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[24.5225,-14.6973,1],0,1,0,[0,0],"","",true,false]   
        ],
        [
            ["vn_o_static_rsna75",[-0.589355,5.50098,1],0,1,0,[0,0],"","",true,false],
            //["vn_o_wheeled_z157_03_nvam",[14.1787,5.66113,0.18],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[2.85205,16.5156,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[9.25586,-14.6748,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_wheeled_z157_04",[-17.6123,4.27295,0.220597],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[-6.99414,-17.6045,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[-16.3066,18.6685,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-4.70654,28.75,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-22.771,-18.3096,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[26.5952,-14.0947,1],0,1,0,[0,0],"","",true,false]   
        ] ];
    vn_mf_radar_compositions = [
        [
            ["vn_o_static_rsna75",[0.995117,2.03516,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_wheeled_z157_04",[-8.69873,-9.60986,0.220597],122.685,1,0,[0,-0],"","",true,false],
            //["vn_o_wheeled_z157_03_nvam",[9.63037,11,0.18],315.4,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[-10.1553,-20.1553,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[9.71045,-22.8848,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[0.59375,25.1338,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[20.3359,16.9004,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-20.543,17.0474,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-24.0186,-14.6758,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[24.5225,-14.6973,1],0,1,0,[0,0],"","",true,false]
        ],
        [
            ["vn_o_static_rsna75",[-0.589355,5.50098,1],0,1,0,[0,0],"","",true,false],
            //["vn_o_wheeled_z157_03_nvam",[14.1787,5.66113,0.18],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[2.85205,16.5156,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[9.25586,-14.6748,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_wheeled_z157_04",[-17.6123,4.27295,0.220597],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[-6.99414,-17.6045,1],0,1,0,[0,0],"","",true,false],
            ["vn_o_nva_navy_static_zpu4",[-16.3066,18.6685,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-4.70654,28.75,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[-22.771,-18.3096,1],0,1,0,[0,0],"","",true,false],
            ["vn_sa2",[26.5952,-14.0947,1],0,1,0,[0,0],"","",true,false]
        ]
    ];
};

private _site_objs = [selectRandom vn_mf_radar_compositions, 0.5] call vn_mf_fnc_sites_objmapper_dynamic_grass;

{
    if (_x isKindOf "vn_sa2") then {
        _x addMagazines ["vn_sa2_mag_x4", 100];
    };
    
    if (_x isKindOf "GRAD_envelope_giant") then {
        _x setVectorUp (surfaceNormal getPos _x);
    };
    
    if (_x isKindOf "Land_vn_o_trench_firing_01") then {
        _x setVectorUp (surfaceNormal getPos _x);
    };
} forEach _site_objs;

_site_objs