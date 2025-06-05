#include "..\ui\icons.inc"

// respawnType in vehicle configs determines whether players have
// to recover a destroyed vehicle or not
#define SPAWN_TYPE_RESPAWN "RESPAWN"
#define SPAWN_TYPE_WRECK "WRECK"

// `time` in the vehicle configs determines how long
// players have to wait for a new vehicle to spawn,
// whether that is after wreck recovery (wreck type) 
// or after destruction (respawn types)
#define SPAWN_TIME_SHORT 10
#define SPAWN_TIME_MEDIUM 30
#define SPAWN_TIME_LONG 60

#define UNLOCKED {}
#define LOCKED_PUBLIC_HELOS {"MACV", "DacCong", "GreenHornets", "3rdMEU", "MilitaryPolice", "QuarterHorse", "Frogmen", "Muskets", "SatansAngels", "633rdCSG", "7thCAV", "TigerForce", "SASR", "ARVN"}
#define LOCKED_LIMITED_ARMOR {"MACV", "DacCong", "3rdMEU", "QuarterHorse", "ACAV", "TigerForce", "ARVN"}

#define LOCKED_MACV_DACCONG {"MACV", "DacCong"}
#define LOCKED_ANZAC {"MACV", "DacCong", "SASR"}
#define LOCKED_ARVN {"MACV", "DacCong", "ARVN"}
#define LOCKED_MILITARY_POLICE {"MACV", "DacCong", "MilitaryPolice"}
#define LOCKED_MUSKETS {"MACV", "DacCong", "Muskets"}
#define LOCKED_BLACKHORSE {"MACV", "DacCong", "QuarterHorse"}
#define LOCKED_SATANS_ANGELS {"MACV", "DacCong", "SatansAngels"}
#define LOCKED_7THCAV {"MACV", "DacCong", "7thCAV"}
#define LOCKED_TIGER_FORCE {"MACV", "DacCong", "TigerForce"}
#define LOCKED_UDT {"MACV", "DacCong", "Frogmen"}
#define LOCKED_633RD {"MACV", "DacCong", "633rdCSG"}
#define LOCKED_USMC {"MACV", "DacCong", "3rdMEU"}
#define LOCKED_PRESS {"MACV", "DacCong", "PressCorp"}

// #define LOCKED_SCOUT_MG {"MACV", "DacCong", "7thCAV", "Muskets"}
// #define LOCKED_ONLY_WLUS {"MACV", "DacCong", "3rdMEU", "MilitaryPolice", "QuarterHorse", "Frogmen", "Muskets", "SatansAngels", "633rdCSG", "7thCAV", "TigerForce", "SASR", "ARVN"}

/*
**Code is read more often than it is written.**

A NOTE ON NAMING CONVENTIONS -------------------------------------------------------------------

All classes here use a naming convention following this pattern: locking_type_subtype_othersubtypes

- locking --> who the vehicle is locked to, if any
- whether the vehidle is ground (grnd), air (air), static weapon (statics) or a boat (boats)
- subtypes are: firesupport, transport, patrol, utility etc.
- further subtypes are things like: custom, light, heavy, medium, airport etc.

A NOTE ON ORDERING -------------------------------------------------------------------

each class is sorted in the following order

1. whitelisting (unlocked first, then public-ish, then WLUs alphabetically)
2. inherited from template above first, then custom spawners
3. ground -> air
4. light -> heavy

please try to stick to that order in future so it's easy to find things!
*/


class spawn_point_types {

	class unlocked_air_transport_light {

		name = "Helicopters (Scout) [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = UNLOCKED;

		class categories {
			class cayuse {
				name = "OH-6A";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_oh6a_01",
				};
			};
		};
	};

	class unlocked_air_transport_all {

		name = "Helicopters (Transport) [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = UNLOCKED;

		class categories {
			class cayuse {
				name = "OH-6A";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_oh6a_01",
				};
			};

			/*
			classnames of unarmed *_uh1c_* are NOT UH-1C birds!
			UH-1C is CAS designation!

			tl;dr the cdlc classnames were wrong on release ;)
			*/

			class uh1b {
				name = "UH-1B";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1b_01_09",
					"vn_i_air_uh1c_07_01",
					"vn_b_air_uh1c_07_02",
					"vn_b_air_uh1c_07_05",
					"vn_b_air_uh1c_07_06",
					"vn_b_air_uh1c_07_07",
				};
			};
			class uh1d {
				name = "UH-1D";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1d_04_09", //cia
					"vn_b_air_uh1d_02_02",
					"vn_b_air_uh1d_02_03",
					"vn_b_air_uh1d_02_04",
					"vn_b_air_uh1d_02_05",
					"vn_b_air_uh1d_02_06",
					"vn_b_air_uh1d_02_07",
					"vn_i_air_uh1d_02_01",
				};
			};
			class uh1ef {
				name = "UH-1E/UH-1F";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1f_01_03",
					"vn_b_air_uh1c_07_03",
					"vn_b_air_uh1c_07_04",
				};
			};
			class ch47 {
				name = "CH-47";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ch47_01_01",
					"vn_b_air_ch47_01_02",
					"vn_b_air_ch47_02_01",
					"vn_b_air_ch47_03_01",
					"vn_b_air_ch47_03_02",
					"vn_b_air_ch47_04_01",
				};
			};
			class ch34 {
				name = "CH-34";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_i_air_ch34_01_02",
					"vn_i_air_ch34_02_02",
					"vn_b_air_ch34_01_01",
					"vn_b_air_ch34_03_01",
				};
			};
		};
	};

	class unlocked_grnd_transport_light {

		name = "Jeeps/Mules [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = UNLOCKED;

		class categories {
			class m151_us {
				name = "M151A1 Unarmed (US Army)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_01",
					"vn_b_wheeled_m151_02",
				};
			};
			class m151_mp {
				name = "M151A1 Unarmed (Military Police)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_01_mp",
					"vn_b_wheeled_m151_02_mp",
				};
			};
			class mule {
				name = "M274 Mule Unarmed";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m274_01_01",
					"vn_b_wheeled_m274_01_02",
					"vn_b_wheeled_m274_02_01",
					"vn_b_wheeled_m274_02_02",
				};
			};
			class m151_armed {
				name = "M151A1 Armed";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_mg_02",
					"vn_b_wheeled_m151_mg_03",
					"vn_b_wheeled_m151_mg_04",
					"vn_b_wheeled_m151_mg_05",
				};
			};
			class m151_armed_mp {
				name = "M151A1 Armed (Military Police)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_mg_02_mp",
					"vn_b_wheeled_m151_mg_03_mp",
				};
			};
			class mule_armed {
				name = "M274 Mule (Armed)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m274_mg_01_01",
					"vn_b_wheeled_m274_mg_02_01", 
					"vn_b_wheeled_m274_mg_03_01",
				};
			};
		};
	};

	class unlocked_grnd_transport_trucks {

		name = "Trucks (Unarmed) [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = UNLOCKED;

		class categories {
			class trucks_us {
				name = "Trucks (US Army)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_01",
					"vn_b_wheeled_m54_01_sog",
					"vn_b_wheeled_m54_01_usmc",
					"vn_b_wheeled_m54_02",
					"vn_b_wheeled_m54_02_usmc",
					"vn_b_wheeled_m54_02_sog",
					"vn_b_wheeled_m54_03",
					"vn_b_wheeled_m54_03_usmc",
				};
			};
		};
	};

	class unlocked_grnd_transport_heavy {

		name = "APCs/Trucks [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = UNLOCKED;

		class categories {
			class apc {
				name = "APC (M113/M577)";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m113_01",
					"vn_b_armor_m113_acav_01",
					"vn_b_armor_m113_acav_02",
					"vn_b_armor_m113_acav_03",
					"vn_b_armor_m113_acav_04",
					"vn_b_armor_m113_acav_05",
					"vn_b_armor_m577_01",
					"vn_b_armor_m577_02",
				};
			};
			class trucks {
				name = "Trucks (M54/M109)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_01",
					"vn_b_wheeled_m54_01_sog",
					"vn_b_wheeled_m54_01_usmc",
					"vn_b_wheeled_m54_02",
					"vn_b_wheeled_m54_02_usmc",
					"vn_b_wheeled_m54_02_sog",
					"vn_b_wheeled_m54_03",
					"vn_b_wheeled_m54_03_usmc",
				};
			};
		};
	};
	class unlocked_grnd_utility {

		name = "Trucks (Utility/Transport) [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = UNLOCKED;

		class categories {
			class ammo {
				name = "M54 Ammo Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_ammo",
					"vn_i_wheeled_m54_ammo",
					"vn_b_wheeled_m54_ammo_usmc",
				};
			};
			class fuel {
				name = "M54 Fuel Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_fuel",
					"vn_i_wheeled_m54_fuel",
					"vn_b_wheeled_m54_fuel_usmc",
				};
			};
			class repair {
				name = "M54 Repair Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_repair",
					"vn_i_wheeled_m54_repair",
					"vn_b_wheeled_m54_repair_usmc",
				};
			};
			class trucks {
				name = "M54/M109 Transport Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_01",
					"vn_b_wheeled_m54_01_sog",
					"vn_b_wheeled_m54_01_usmc",
					"vn_b_wheeled_m54_02",
					"vn_b_wheeled_m54_02_usmc",
					"vn_b_wheeled_m54_02_sog",
					"vn_b_wheeled_m54_03",
					"vn_b_wheeled_m54_03_usmc",
				};
			};
		};
	};
	class unlocked_grnd_airport {

		name = "Airport Vehicles [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = UNLOCKED;

		class categories {
			class mule {
				name = "M274 Mule (Airport)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m274_01_03",
				};
			};
			class trucks {
				name = "Trucks (Airport)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_01_airport",
				};
			};
			class utility {
				name = "Utility (Airport)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_repair_airport",
					"vn_b_wheeled_m54_ammo_airport",
					"vn_b_wheeled_m54_fuel_airport",
				};
			};
		};
	};

	class unlocked_grnd_firesupport_trucks {

		name = "Firesupport (Trucks) [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = UNLOCKED;

		class categories {
			class m54 {
			 	name = "M54 Trucks (US Army)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_mg_01",
					"vn_b_wheeled_m54_mg_02",
					"vn_b_wheeled_m54_mg_03",
				};
			};
		};
	};

	class unlocked_boats_small {

		name = "Small Boats [Public]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = UNLOCKED;

		class categories {
			class pbr {
				name = "PBR";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"vn_b_boat_12_01",
					"vn_b_boat_12_02",
					"vn_b_boat_12_03",
					"vn_b_boat_12_04",
					"vn_b_boat_13_01",
					"vn_b_boat_13_02",
					"vn_b_boat_13_03",
					"vn_b_boat_13_04",
				};
			};
			class boat {
				name = "Stab";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"vn_b_boat_09_01",
					"vn_b_boat_10_01",
					"vn_b_boat_11_01",
				};
			};
			class RHIB {
				name = "RHIB";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"B_Boat_Transport_01_F",
				};
			};
		};
	};

	// green hornets + all wlus /////////////////////////////////////////////////////////////////////

	class greenhornets_air_transport_all: unlocked_air_transport_all {

		name = "Helicopters (Transport) [GH/WLUs]";
		lockTeams[] = LOCKED_PUBLIC_HELOS;
	};

	// acav + some wlus /////////////////////////////////////////////////////////////////////////

	class acav_grnd_transport_heavy: unlocked_grnd_transport_heavy {

		name = "APCs/Trucks [ACAV/WLUs]";
		lockTeams[] = LOCKED_LIMITED_ARMOR;
	};

	class acav_grnd_firesupport_heavy {

		name = "Tanks & APCs [ACAV/WLUs]";
		respawnType = SPAWN_TYPE_WRECK;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_LIMITED_ARMOR;

		class categories {
			class tanks {
				name = "Tanks";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m48_01_01",
					"vn_b_armor_m67_01_01",  // @dijksterhuis: flame tank -- blackhorse etc question
					"vn_b_armor_m41_01_01",
					"vn_b_armor_m48_01_02",
					"vn_b_armor_m41_01_02",
				};
			};
			class apc_us {
				name = "APCs (US Army/ACAV)";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m113_01",
					"vn_b_armor_m113_acav_01",
					"vn_b_armor_m113_acav_02",
					"vn_b_armor_m113_acav_03",
					"vn_b_armor_m113_acav_04",
					"vn_b_armor_m113_acav_05",
					"vn_b_armor_m113_acav_06",
				};
			};
			class apc_rok {
				name = "APCs (ROK)";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m113_01_rok_army",
					"vn_b_armor_m113_acav_01_rok_army",
					"vn_b_armor_m113_acav_02_rok_army",
					"vn_b_armor_m113_acav_03_rok_army",
					"vn_b_armor_m113_acav_04_rok_army",
					"vn_b_armor_m113_acav_05_rok_army",
					"vn_b_armor_m113_acav_06_rok_army",
				};
			};
			class apc_arvn {
				name = "APCs (ARVN)";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_i_armor_m113_01",
					"vn_i_armor_m113_acav_01",
					"vn_i_armor_m113_acav_02",
					"vn_i_armor_m113_acav_03",
					"vn_i_armor_m113_acav_04",
					"vn_i_armor_m113_acav_05",
					"vn_i_armor_m113_acav_06",
				};
			};
			class apc_fank {
				name = "APCs (FANK)";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_i_armor_m113_01",
					"vn_i_armor_m113_acav_01_fank_71",
					"vn_i_armor_m113_acav_02_fank_71",
					"vn_i_armor_m113_acav_03_fank_71",
					"vn_i_armor_m113_acav_06_fank_71",
				};
			};
			class apc_anzac {
				name = "APCs (ANZAC)";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m113_01_aus_army",
				};
			};
		};
	};

	class acav_statics_large {

		name = "Static Weapons [ACAV/WLUs]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_LIMITED_ARMOR;

		class categories {
			class tow {
				name = "Anti-Tank";
				icon = VEHICLE_ICON_STATIC;
				vehicles[] = {
					"vn_b_army_static_m40a1rr",
					"vn_b_sf_static_m40a1rr",
					"vn_b_army_static_tow",
					"vn_b_sf_static_tow",
					 // @dijksterhuis: disabled until i confirm whether an anti-tank 105 should be here?
					// "vn_b_army_static_m101_01",
				};

			};
			class anti_air {
				name = "Anti-Aircraft";
				icon = VEHICLE_ICON_STATIC;
				vehicles[] = {
					"vn_i_fank_70_static_zgu1_01",
					"vn_b_navy_static_l60mk3",
					"vn_b_navy_static_l70mk2",
					// these m45s are all different skins
					"vn_b_army_static_m45",
					"vn_i_fank_71_static_m45",
					"vn_b_sf_static_m45",
				};
			};
			class mg {
				name = "Anti-Personnel";
				icon = VEHICLE_ICON_STATIC;
				vehicles[] = {
					"vn_b_army_static_m2_high",
					"vn_b_army_static_m2_scoped_high",
					"vn_b_army_static_m2_low",
					"vn_b_army_static_m2_scoped_low",
					"vn_b_army_static_m60_high",
					"vn_b_army_static_m60_low",
					"vn_b_army_static_mk18",
				};
			};
		};
	};

	// 633rd //////////////////////////////////////////////////////////////////////////////

	class 633rd_grnd_ambulance {

		name = "Ambulance [633rd]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_633RD;

		class categories {
			class ambulance {
				name = "Nee Naw Nee Naw";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_lr2a_03_aus_army",
				};
			};
		};
	};
/*
	class 633rd_air_transport_heavy {

		name = "Helicopters (Heavy) [633rd]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_633RD;

		class categories {
			class ch47 {
				name = "CH-47";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ch47_01_01",
					"vn_b_air_ch47_01_02",
					"vn_b_air_ch47_02_01",
					"vn_b_air_ch47_03_01",
					"vn_b_air_ch47_03_02",
					"vn_b_air_ch47_04_01",
				};
			};
			class ch34 {
				name = "CH-34";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_i_air_ch34_01_02",
					"vn_i_air_ch34_02_02",
					"vn_b_air_ch34_01_01",
					"vn_b_air_ch34_03_01",
				};
			};
		};
	};
*/
	class 633rd_air_transport_custom {

		name = "Helicopters [633rd]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_633RD;

		class categories {
			class utility {
				name = "Utility Lift";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_oh6a_01",
					"vn_b_air_uh1d_02_03",
					"vn_b_air_uh1f_01_03",
				};
			};		
			class medical {
				name = "Medical Lift";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1b_01_03",
					"vn_b_air_uh1d_01_03",
					"vn_b_air_ch47_02_01",
				};
			};
			class heavy {
				name = "Heavy Lift";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ch47_01_01",
					"vn_b_air_ch47_03_01",
					"vn_b_air_ch47_04_01",
					"vn_i_air_ch34_01_02",
					"vn_i_air_ch34_02_02",
					"vn_b_air_ch34_01_01",
					"vn_b_air_ch34_03_01",
				};
			};	
		};
	};
/*
	class 633rd_air_dustoff_medical_custom {

		name = "Helicopters (Dust-off/Medevac) [633rd]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_633RD;

		class categories {
			class uh1 {
				name = "UH-1 Medical";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1b_01_03",
					"vn_b_air_uh1d_01_03",
				};
			};
			class ch47 {
				name = "Ch-47 Medical";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ch47_02_01",
				};
			};
		};
	};*/

	// 7th cav //////////////////////////////////////////////////////////////////////////

	class 7thcav_grnd_transport_light: unlocked_grnd_transport_light {
		name = "Jeeps/Mules [7th Cav]";
		lockTeams[] = LOCKED_7THCAV;
	};

	class 7thcav_grnd_transport_heavy: unlocked_grnd_transport_heavy {
		name = "APCs/Truck [7th Cav]";
		lockTeams[] = LOCKED_7THCAV;
	};

	class 7thcav_air_transport_custom {

		name = "Helicopters (Transport) [7th Cav]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_7THCAV;

		class categories {
			class 7thcav {
				name = "7th CAV";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_oh6a_01",
					"vn_b_air_oh6a_02",
					"vn_b_air_uh1c_07_02",
					"vn_b_air_uh1d_02_02",					
					"vn_b_air_ch47_01_02",
					"vn_b_air_ch47_03_02",
				};
			};
		};
	};

	// arvn ////////////////////////////////////////////////////////////////////////////////

	class arvn_statics_custom {

		name = "Static Weapons [ARVN]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_ARVN;

		class categories {
			class static {
				name = "Static Weapons";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_i_static_m45",
					"vn_i_static_tow",
					"vn_i_static_m101_01",
				};
			};
		};
	};

	class arvn_grnd_transport_light {

		name = "Transport (Light) [ARVN]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_ARVN;

		class categories {
			class m151 {
				name = "M151A1";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_i_wheeled_m151_mg_01",
					"vn_i_wheeled_m151_mg_06",
				};
			};
		};
	};

	class arvn_grnd_firesupport_light_custom {

		name = "Fire Support [ARVN]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_ARVN;

		class categories {
			class armor {
				name = "Armor";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_i_armor_m125_01",
					"vn_i_armor_m132_01",
					"vn_i_armor_m113_acav_06",
					"vn_i_armor_m113_acav_05",
					"vn_i_armor_m113_acav_04",
				};
			};
		};
	};

	class arvn_grnd_firesupport_heavy_custom {
		name = "Fire Support (Heavy) [ARVN]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_ARVN;
		class categories {
			class tanks {
				name = "Tanks";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
                    "vn_i_armor_type63_01",
                    "vn_i_armor_m67_01_01",
                    "vn_i_armor_m48_01_01",
                    "vn_i_armor_m41_01"
				};
			};
		};
	};

	class arvn_air_transport_custom {
		name = "Helicopters (Transport) [ARVN]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_ARVN;
		class categories {
			class arvn {
				name = "ARVN";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_i_air_ch34_01_02",
					"vn_i_air_ch34_02_02",
					"vn_i_air_uh1c_07_01",
					"vn_i_air_uh1d_02_01",
				};
			};
		};
	};

	// anzac ////////////////////////////////////////////////////////////////////

	class anzac_grnd_transport_light_custom {
		name = "Transport (Light) [ANZAC]";

		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_ANZAC;

		class categories {
			class dirtranger_t {
				name = "Dirt Ranger (Transport)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_lr2a_01_aus_army",
					"vn_b_wheeled_lr2a_02_aus_army",
				};
			};
			class dirtranger_p {
				name = "Dirt Ranger (Armed)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_lr2a_mg_01_aus_army",
					"vn_b_wheeled_lr2a_mg_02_aus_army",
					"vn_b_wheeled_lr2a_mg_03_aus_army"
				};
			};
						class apc_aus {
				name = "APC";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m113_01_aus_army",
					"vn_b_armor_m125_01_aus_army",
					"vn_b_armor_m577_01_aus_army"
				};
			};
		};
	};

	class anzac_air_transport_custom : unlocked_air_transport_all {

		name = "Helicopters (Transport) [ANZAC]";
		lockTeams[] = LOCKED_ANZAC;

		class categories : categories {
			class raaf {
				name = "Slicks (RAAF)";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1d_01_06",
					"vn_b_air_uh1d_02_06",
					"vn_b_air_uh1c_07_06",
				};
			};
			class cayuse : cayuse {};
			class uh1b {};
			class uh1d {};
			class uh1ef {};
			class ch47 : ch47 {};
			class ch34 : ch34 {};
		};
	};

	// blackhorse /////////////////////////////////////////////////////////////////

	class blackhorse_air_transport_all: unlocked_air_transport_all {
		name = "Helicopters (Transport) [Blackhorse]";
		lockTeams[] = LOCKED_BLACKHORSE;
	};

	class blackhorse_statics_105s_custom {

		name = "Artillery (105s) [Blackhorse]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_BLACKHORSE;

		class categories {
			class m101 {
				name = "M101";
				icon = VEHICLE_ICON_STATIC;
				vehicles[] = {
					"vn_b_army_static_m101_01",
					"vn_b_army_static_m101_02",
				};
			};
		};
	};

	class blackhorse_grnd_firesupport_custom {

		name = "Fire Support [Blackhorse]";
		respawnType = SPAWN_TYPE_WRECK;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_BLACKHORSE;

		class categories {
			class tanks {
				name = "Tanks";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m67_01_01",
					"vn_b_armor_m48_01_01",
					"vn_b_armor_m41_01_01",
				};
			};

			class m113 {
				name = "M113";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m132_01",
					"vn_b_armor_m113_acav_05",
					"vn_b_armor_m113_acav_06",
					"vn_b_armor_m125_01",
					"vn_b_armor_m113_01",
					"vn_b_armor_m113_acav_01",
					"vn_b_armor_m113_acav_02",
					"vn_b_armor_m113_acav_03",
					"vn_b_armor_m113_acav_04",
				};
			};

			class trucks {
				name = "Trucks (Armed)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_mg_03",
					"vn_b_wheeled_m54_mg_01",
					"vn_b_wheeled_m54_mg_02",
				};
			};

			class trucks_us {
				name = "M54 Transport Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_02_sog",
					"vn_b_wheeled_m54_03",
				};
			};

			class ammo {
				name = "M54 Ammo Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_ammo",
				};
			};
		};
	};

	// berchesgarden extras
	class blackhorse_grnd_transport_heavy: unlocked_grnd_transport_heavy {
		name = "APCs/Trucks [Blackhorse]";
		lockTeams[] = LOCKED_BLACKHORSE;
	};

	class blackhorse_grnd_utility: unlocked_grnd_utility {
		name = "Trucks (Utility/Transport) [Blackhorse]";
		lockTeams[] = LOCKED_BLACKHORSE;
	};

	// military police ////////////////////////////////////////////////////////////////

	class mp_air_transport_medium {

		name = "Slicks [Military Police]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MILITARY_POLICE;

		class categories {
			class slicks {
				name = "Slicks";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1d_02_01",
					"vn_b_air_uh1c_07_01",
				};
			};
		};
	};

	class mp_grnd_transport_light {

		name = "Transport [Military Police]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_MILITARY_POLICE;

		class categories {
			class patrol {
				name = "M151A1 Patrol";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_mg_02_mp",
					"vn_b_wheeled_m151_mg_03_mp",
					"vn_b_wheeled_m151_mg_04_mp",
					"vn_b_wheeled_lr2a_02_nz_army",
					"vn_b_wheeled_lr2a_02_aus_army",
				};
			};
			class transport {
				name = "M151A1 Transport";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_01_mp",
					"vn_b_wheeled_m151_02_mp",
				};
			};
			class truck {
				name = "M54 Transport";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_01",
					"vn_b_wheeled_m54_02",
				};
			};
		};
	};

	// macv ///////////////////////////////////////////////////////////////////////////

	class macv_air_transport_custom : unlocked_air_transport_all {
		
		name = "Helicopters (Transport) [MACV]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories : categories {
			class cia {
				name = "MACV / CIA";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					// "B_Heli_Light_01_F", // disabled as it contains modern gear
					"vn_b_air_uh1d_04_09",
					"vn_b_air_uh1d_04_09",
				};
			};
			class cayuse : cayuse {};
			class uh1b : uh1b {};
			class uh1d : uh1d {};
			class uh1ef : uh1ef {};
			class ch47 : ch47 {};
			class ch34 : ch34 {};
		};
	};

	// muskets ////////////////////////////////////////////////////////////////////////

	class muskets_air_transport_all: unlocked_air_transport_all {

		name = "Helicopters (Transport) [Muskets]";
		lockTeams[] = LOCKED_MUSKETS;

	};

	class muskets_air_firesupport_all_custom {

		name = "Helicopters (CAS) [Muskets]";
		respawnType = SPAWN_TYPE_WRECK;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_MUSKETS;

		class categories {
			class oh6a {
				name = "OH-6A";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_oh6a_02",
					"vn_b_air_oh6a_03",
					"vn_b_air_oh6a_05",
				};
			};
			class ah1g {
				name = "AH-1G";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ah1g_06",
					"vn_b_air_ah1g_01",
				};
			};
			class uh1 {
				name = "UH-1";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1c_02_01",
					"vn_b_air_uh1c_04_01",
					"vn_b_air_uh1c_03_01",
					"vn_b_air_uh1e_02_04",
					"vn_b_air_uh1c_05_01",
					"vn_b_air_uh1c_06_01",
					"vn_b_air_uh1c_01_01",
					"vn_b_air_uh1d_03_06",
					"vn_b_air_uh1e_01_04",
				};
			};
			class ch34 {
				name = "CH-34";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ch34_04_01",
				};
			};
			class ch47 {
				name = "ACH-47";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_ach47_01_01",
				};
			};

		};
	};

	// satans angels /////////////////////////////////////////////////////////////////

	class satansangels_air_jets_runway_custom {

		name = "Jets (All) [Satan's Angels]";
		respawnType = SPAWN_TYPE_WRECK;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_SATANS_ANGELS;

		class categories {
			class f100 {
				name = "F100";
				icon = VEHICLE_ICON_PLANE;
				vehicles[] = { 
					"vn_b_air_f100d_at",
				};
			};
			class f4 {
				name = "F4 Phantom II";
				icon = VEHICLE_ICON_PLANE;
				vehicles[] = {
					"vn_b_air_f4c_at",
					"vn_b_air_f4b_navy_at",
				};
			};
		};
	};

	class satansangels_air_jets_carrier_custom {

		name = "Jets (Naval) [Satan's Angels]";
		respawnType = SPAWN_TYPE_WRECK;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_SATANS_ANGELS;

		class categories {
			class f4 {
				name = "F4B Phantom II";
				icon = VEHICLE_ICON_PLANE;
				vehicles[] = {
					"vn_b_air_f4b_navy_at",
				};
			};
		};
	};

	// tigers ///////////////////////////////////////////////////////////////////////////

	class tigerforce_grnd_transport_light: unlocked_grnd_transport_light  {

		name = "Jeeps/Mules [Tiger Force]";
		lockTeams[] = LOCKED_TIGER_FORCE;

	};

	// TODO: Should Tiger Force have a mortar + flame thrower APC?
	// TODO: Should tiger force have APCs at all?!

	// TODO: This has been hacked a bit to mostly replicate the grnd_transport_light 
	// spawner so i can avoid messing around with the mission.sqm to avoid any merge
	// conflicts with huckleberry. we'll deal with this one a little later, but have
	// nerfed the available APCs too.
	// after speaking to huck they weren't supposed to have APCs at all, and defo
	// not the flame/mortar one. and we missed that. so leaving them with one
	// transport APC before saying "hey do you even need APCs" seems like a sensible
	// comprimise
	class tigerforce_grnd_firesupport_light: unlocked_grnd_transport_light {

		name = "Fire Support [Tiger Force]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_TIGER_FORCE;
		
		class categories : categories {
			class m151_us {};
			class m151_mp {};
			class mule {};
			class m151_armed : m151_armed {};
			class mule_armed : mule_armed {};
			class apc {
				name = "APC";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m113_01",
					// "vn_b_armor_m113_acav_06",  // disabled by @dijksterhuis after speaking to huck
					// "vn_b_armor_m125_01",  // disabled by @dijksterhuis after speaking to huck
				};
			};
		};
	};
	class tigerforce_air_transport_custom : unlocked_air_transport_all {

		name = "Helicopters (Transport) [Tiger Force]";
		lockTeams[] = LOCKED_TIGER_FORCE;

		class categories : categories {
			class sog {
				name = "Tiger Force";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_uh1c_07_07",
					"vn_b_air_uh1d_02_07",
				};
			};
			class cayuse : cayuse {};
			class uh1b {};
			class uh1d {};
			class uh1ef {};
			class ch47 : ch47 {};
			class ch34 {};
		};
	};

	// udt /////////////////////////////////////////////////////////////////////////////////

	class udt_grnd_transport_light: unlocked_grnd_transport_light  {
		name = "Jeeps/Mules [UDT]";
		lockTeams[] = LOCKED_UDT;
	};
	class udt_air_transport_custom : unlocked_air_transport_all {

		name = "Helicopters (Transport) [UDT]";
		lockTeams[] = LOCKED_UDT;

		class categories : categories {
			class udt {
				name = "UH-1";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					 "vn_b_air_uh1c_07_05",
					 "vn_b_air_uh1d_02_05",
				};
			};
			class cayuse : cayuse {};
			class uh1b {};
			class uh1d {};
			class uh1ef {};
			class ch47 : ch47 {};
			class ch34 {};
		};
	};
	class udt_boats_nasty {

		name = "Nasty Boats [UDT]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_LONG;
		lockTeams[] = LOCKED_UDT;

		class categories {
			class nasty {
				name = "Nasty";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"vn_b_boat_05_01",
					"vn_b_boat_05_02",
					"vn_b_boat_06_01",
					"vn_b_boat_06_02",
				};
			};
		};
	};
	class udt_boats_small {

		name = "Small Boats [UDT]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_UDT;

		class categories {
			class pbr {
				name = "PBR";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"vn_b_boat_12_01",
					"vn_b_boat_12_02",
					"vn_b_boat_12_03",
					"vn_b_boat_12_04",
					"vn_b_boat_13_01",
					"vn_b_boat_13_02",
					"vn_b_boat_13_03",
					"vn_b_boat_13_04",
				};
			};
			class boat {
				name = "Stab";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"vn_b_boat_09_01",
					"vn_b_boat_10_01",
					"vn_b_boat_11_01",
				};
			};
			class RHIB {
				name = "RHIB";
				icon = VEHICLE_ICON_BOAT;
				vehicles[] = {
					"B_Boat_Transport_01_F",
				};
			};
		};
	};

	// usmc ///////////////////////////////////////////////////////////////////////

	class usmc_grnd_combined_custom {

		name = "Ground Vehicles [USMC]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_USMC;

		class categories {
			class m54_t {
				name = "M54 Trucks";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_b_wheeled_m54_01_usmc",
					"vn_b_wheeled_m54_02_usmc",
					"vn_b_wheeled_m54_03_usmc",
					"vn_b_wheeled_m54_repair_usmc",
					"vn_b_wheeled_m54_ammo_usmc",
					"vn_b_wheeled_m54_fuel_usmc",
				};
			};
			class m151a {
				name = "M151A1 Jeeps";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_b_wheeled_m151_01_usmc",
					"vn_b_wheeled_m151_02_usmc",
					"vn_b_wheeled_m151_mg_02_usmc",
					"vn_b_wheeled_m151_mg_03_usmc",
					"vn_b_wheeled_m151_mg_04_usmc",
				};
			};
			class m113 {
				name = "APC";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_b_armor_m125_01",
					"vn_b_armor_m132_01",
					"vn_b_armor_m113_acav_06",
				};
			};
			class usmctank {
				name = "Tanks";
				icon = VEHICLE_ICON_TANK;
				vehicles[] = {
					"vn_b_armor_m48_01_02",
					"vn_b_armor_m41_01_02",
					"vn_b_armor_m67_01_02",
				};
			};
		};
	};

	class usmc_air_transport_custom {

		name = "Helicopters (Transport) [USMC]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_MEDIUM;
		lockTeams[] = LOCKED_USMC;

		class categories {
			class usmc {
				name = "USMC";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					 "vn_b_air_uh1c_07_04",
					 "vn_b_air_uh1d_02_04",
					 "vn_b_air_uh1e_03_04",
					 "vn_b_air_ch34_03_01",
				};
			};
			class cayuse {
				name = "OH-6A";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_b_air_oh6a_01",
				};
			};
		};
	};

	// PRESS /////////////////////////////////////////////////////////////////////////

		class press_civilian {

		name = "Transport (Light) [PRESS]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_PRESS;

		class categories {
			class civilian {
				name = "Cars";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_c_car_01_01",
					"vn_c_car_02_01",
					"vn_c_car_03_01",
				};
			};
		};
	};

	// DAC /////////////////////////////////////////////////////////////////////////

	class dac_car {

		name = "Transport (Light/Trucks) [Dac Cong]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories {
			class btr40_unarmed {
				name = "BTR-40 (Unarmed)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_o_wheeled_btr40_01",
				};
			};
			class btr40_armed {
				name = "BTR-40 (Armed)";
				icon = VEHICLE_ICON_CAR;
				vehicles[] = {
					"vn_o_wheeled_btr40_mg_01",
					"vn_o_wheeled_btr40_mg_02",
					"vn_o_wheeled_btr40_mg_03",
					"vn_o_wheeled_btr40_mg_04",
					"vn_o_wheeled_btr40_mg_05",
					"vn_o_wheeled_btr40_mg_06",
				};
			};
			class z157 {
				name = "Z-157 (Transport)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_o_wheeled_z157_01",
					"vn_o_wheeled_z157_02",
					"vn_o_wheeled_z157_03",
					"vn_o_wheeled_z157_04",
				};
			};
			class z157_util {
				name = "Z-157 (Utility)";
				icon = VEHICLE_ICON_TRUCK;
				vehicles[] = {
					"vn_o_wheeled_z157_ammo",
					"vn_o_wheeled_z157_fuel",
					"vn_o_wheeled_z157_repair",
				};
			};
		};
	};
	class dac_apc {

		name = "APCs [Dac Cong]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories {
			class btr50 {
				name = "BTR-50";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_o_armor_btr50pk_01",
					"vn_o_armor_btr50pk_02",
					"vn_o_armor_btr50pk_03",
				};
			};
			class m113 {
				name = "M113";
				icon = VEHICLE_ICON_ARMOUR;
				vehicles[] = {
					"vn_o_armor_m113_01",
				};
			};
		};
	};

	class dac_armor {

		name = "Tanks [Dac Cong]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories {
			class t63 {
				name = "T63";
				icon = VEHICLE_ICON_TANK;
				vehicles[] = {
					"vn_o_armor_type63_01",
				};
			};
			class m41 {
				name = "M41";
				icon = VEHICLE_ICON_TANK;
				vehicles[] = {
					"vn_o_armor_m41_01",
				};
			};
			class pt76 {
				name = "PT76";
				icon = VEHICLE_ICON_TANK;
				vehicles[] = {
					"vn_o_armor_pt76a_01",
					"vn_o_armor_pt76b_01",
				};
			};
			class t54 {
				name = "T54";
				icon = VEHICLE_ICON_TANK;
				vehicles[] = {
					"vn_o_armor_t54b_01",
				};
			};
			class ot54 {
				name = "OT54";
				icon = VEHICLE_ICON_TANK;
				vehicles[] = {
					"vn_o_armor_ot54_01",
				};
			};
		};
	};

	class dac_jet {

		name = "Jets [Dac Cong]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories {
			class mig19 {
				name = "MiG-19";
				icon = VEHICLE_ICON_PLANE;
				vehicles[] = {
					"vn_o_air_mig19_at",
					"vn_o_air_mig19_bmb",
					"vn_o_air_mig19_cas",
					"vn_o_air_mig19_cap",
					"vn_o_air_mig19_gun",
					"vn_o_air_mig19_hbmb",
					"vn_o_air_mig19_mr",
				};
			};
			class mig21_1 {
				name = "MiG-21 (1/2)";
				icon = VEHICLE_ICON_PLANE;
				vehicles[] = {
					"vn_o_air_mig21_at",
					"vn_o_air_mig21_atgm",
					"vn_o_air_mig21_bmb",
					"vn_o_air_mig21_cas",
					"vn_o_air_mig21_cap",
				};
			};
			class mig21_2 {
				name = "MiG-21 (2/2)";
				icon = VEHICLE_ICON_PLANE;
				vehicles[] = {
					"vn_o_air_mig21_gun",
					"vn_o_air_mig21_hbmb",
					"vn_o_air_mig21_hcas",
					"vn_o_air_mig21_mr",
				};
			};
		};
	};


	class dac_helo {

		name = "Helicopters [Dac Cong]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories {
			class mi2p {
				name = "Mi-2P (Unarmed Transport)";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_o_air_mi2_01_01",
					"vn_o_air_mi2_01_02",
					"vn_o_air_mi2_01_03",
				};
			};
			class mi2m {
				name = "Mi-2M (Medical Transport)";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_o_air_mi2_02_01",
					"vn_o_air_mi2_02_02",
				};
			};
			class mi2us {
				name = "Mi-2US (Armed Transport)";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_o_air_mi2_03_01",
					"vn_o_air_mi2_03_02",
					"vn_o_air_mi2_03_03",
					"vn_o_air_mi2_03_04",
					"vn_o_air_mi2_03_05",
					"vn_o_air_mi2_03_06",
				};
			};
			class mi2urn {
				name = "Mi-2URN (Viper)";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_o_air_mi2_04_01",
					"vn_o_air_mi2_04_02",
					"vn_o_air_mi2_04_03",
					"vn_o_air_mi2_04_04",
					"vn_o_air_mi2_04_05",
					"vn_o_air_mi2_04_06", 
				};
			};
			class mi2urp {
				name = "Mi-2URP (Salamander)";
				icon = VEHICLE_ICON_HELO;
				vehicles[] = {
					"vn_o_air_mi2_05_01",
					"vn_o_air_mi2_05_02",
					"vn_o_air_mi2_05_03",
					"vn_o_air_mi2_05_04",
					"vn_o_air_mi2_05_05",
					"vn_o_air_mi2_05_06",
				};
			};
		};
	};
	class dac_static {

		name = "Static Emplacements [Dac Cong]";
		respawnType = SPAWN_TYPE_RESPAWN;
		time = SPAWN_TIME_SHORT;
		lockTeams[] = LOCKED_MACV_DACCONG;

		class categories {
			class statics {
				name = "Statics";
				icon = VEHICLE_ICON_STATIC;
				vehicles[] = {
					"vn_o_nva_static_zgu1_01",
					"vn_o_nva_static_zpu4",
					"vn_o_nva_static_d44_01",
				};
			};
		};
	};
};
