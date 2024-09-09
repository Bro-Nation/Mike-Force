#define CONDITION_HAS_RANK { $STR_vn_mf_buildingMenu_condition_hasRank, "player getVariable ['vn_mf_db_rank',0] >= getNumber(_config >> 'rank')"}
#define CONDITION_IS_ENGINEER { $STR_vn_mf_buildingMenu_condition_isEngineer, "player getUnitTrait 'engineer'"}
#define CONDITION_IS_ON_FOOT { $STR_vn_mf_buildingMenu_condition_rnFoot, "isNull objectParent player"}
#define CONDITION_NOT_IN_RESTRICTED_ZONE { $STR_vn_mf_buildingMenu_condition_inRestrictedZone, "vn_mf_markers_blocked_areas findIf {_pos inArea _x} isEqualTo -1"}
#define CONDITION_IS_ACAV { $STR_vn_mf_buildingMenu_condition_inACav, "!(player getVariable ['vn_mf_db_player_group', 'MikeForce'] in ['MikeForce', 'GreenHornets', 'SpikeTeam'])"}
#define CONDITION_IS_DAC_CONG { $STR_vn_mf_buildingMenu_condition_inDacCong, "player getVariable ['vn_mf_db_player_group', 'MikeForce'] isEqualTo 'DacCong'"}

//Icon Classes for Vehicle Spawner
#define VEHICLE_ICON_BOAT "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_mf_boat_ca.paa"
#define VEHICLE_ICON_PLANE "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_mf_plane_ca.paa"
#define VEHICLE_ICON_HELO "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_heli_ca.paa"
#define VEHICLE_ICON_CAR "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_car_ca.paa"
#define VEHICLE_ICON_STATIC "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_mg_ca.paa"
#define VEHICLE_ICON_TANK "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_tank_ca.paa"
#define VEHICLE_ICON_TRUCK "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_truck_ca.paa"
#define VEHICLE_ICON_SUPPLY "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_ammo_ca.paa"
#define VEHICLE_ICON_ARMOUR "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_tank_ca.paa"


//Takes "Capacity" in supply units, and "Lifetime" in seconds.
#define DAYS_TO_SECONDS(days) (days * 86400)
#define HOURS_TO_SECONDS(hours) (hours * 3600)
#define MINUTES_TO_SECONDS(minutes) (minutes * 60)
#define SUPPLY_CAPACITY(capacity, lifetime) \
	supply_capacity = capacity; \
	supply_consumption = __EVAL(capacity / lifetime)

class Land_vn_guardhouse_01
{
	name = "STR_vn_mf_checkpoint";
	type = "checkpoints";
	categories[] = {"functional", "buildings"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));

	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_guardhouse_01";
		};
		class middle_state
		{
			object_class = "Land_vn_guardhouse_01";
		};
		class final_state
		{
			object_class = "Land_vn_guardhouse_01";
		};
	};

	class features
	{
		class respawn {};
	};
};

class Land_vn_tent_mash_01_04
{
	name = "STR_vn_mf_aid_post";
	type = "aid";
	categories[] = {"medical", "functional", "tents"};
	rank = 0;
	SUPPLY_CAPACITY(1000, HOURS_TO_SECONDS(2));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_tent_mash_01_04";
		};
		class middle_state
		{
			object_class = "Land_vn_tent_mash_01_04";
		};
		class final_state
		{
			object_class = "Land_vn_tent_mash_01_04";
		};
	};
};

class Land_vn_tent_mash_02_03
{
	name = "STR_vn_mf_aid_post";
	type = "aid";
	categories[] = {"medical", "functional", "tents"};
	rank = 0;
	SUPPLY_CAPACITY(1000, HOURS_TO_SECONDS(2));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "land_vn_tent_mash_02_03";
		};
		class middle_state
		{
			object_class = "Land_vn_tent_mash_02_03";
		};
		class final_state
		{
			object_class = "Land_vn_tent_mash_02_03";
		};
	};
};

class Land_vn_tent_mash_01
{
	name = "STR_vn_mf_aid_post";
	type = "aid";
	categories[] = {"medical", "functional", "tents"};
	rank = 0;
	SUPPLY_CAPACITY(1000, HOURS_TO_SECONDS(2));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_tent_mash_01";
		}
		class middle_state
		{
			object_class = "Land_vn_tent_mash_01";
		};
		class final_state
		{
			object_class = "Land_vn_tent_mash_01";
		};
	};
};

class vn_b_ammobox_supply_07
{
	name = "STR_vn_mf_ammoresupply";
	type = "ammocrates";
	categories[] = {"resupply", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	nearby[] = {"ammo"};
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_ammobox_supply_07";
		};
		class middle_state
		{
			//TODO: Fix this, this shouldn't able to resupply in middle state.
			object_class = "vn_b_ammobox_supply_07";
		};
		class final_state
		{
			object_class = "vn_b_ammobox_supply_07";
		};
	};

	class features
	{
		class maintenance
		{
			canRearm = 1;
		};
	};
};

class vn_b_ammobox_supply_08
{
	name = "STR_vn_mf_repairresupply";
	type = "resupplycrates";
	categories[] = {"resupply", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	nearby[] = {"repair"};
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_ammobox_supply_08";
		};
		class middle_state
		{
			//TODO: Fix this, should not be able to rearm in middle state
			object_class = "vn_b_ammobox_supply_08";
		};
		class final_state
		{
			object_class = "vn_b_ammobox_supply_08";
		};
	};

	class features
	{
		class maintenance
		{
			canRepair = 1;
		};
	};
};

class vn_b_ammobox_supply_09
{
	name = "STR_vn_mf_fuelresupply";
	type = "refuelcrates";
	categories[] = {"resupply", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	nearby[] = {"fuel"};
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_ammobox_supply_09";
		};
		class middle_state
		{
			//TODO: FIx this, hsould not be able to refuel in middle state.
			object_class = "vn_b_ammobox_supply_09";
		};
		class final_state
		{
			object_class = "vn_b_ammobox_supply_09";
		};
	};

	class features
	{
		class maintenance
		{
			canRefuel = 1;
		};
	};
};

class Land_vn_bunker_small_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bunker_small_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bunker_small_01";
		};
		class final_state
		{
			object_class = "Land_vn_bunker_small_01";
		};
	};
};

class Land_vn_bunker_big_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bunker_big_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bunker_big_01";
		};
		class final_state
		{
			object_class = "Land_vn_bunker_big_01";
		};
	};
};

class Land_vn_bunker_big_02
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bunker_big_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bunker_big_02";
		};
		class final_state
		{
			object_class = "Land_vn_bunker_big_02";
		};
	};
};

class Land_vn_b_trench_wall_01_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	offset[] = {0,6.5,0};
	//max_segments = 3;
	min_distance = 7;
	max_distance = 15;
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_01_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_01_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_01_01";
		};
	};
};
class Land_vn_b_trench_wall_01_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_01_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_01_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_01_02";
		};
	};
};

class Land_vn_b_trench_wall_01_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_01_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_01_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_01_03";
		};
	};
};

class Land_vn_b_trench_wall_03_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_03_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_03_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_03_01";
		};
	};
};

class Land_vn_b_trench_wall_03_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_03_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_03_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_03_02";
		};
	};
};

class Land_vn_b_trench_wall_03_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_03_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_03_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_03_03";
		};
	};
};

class Land_vn_b_trench_wall_05_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_05_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_05_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_05_01";
		};
	};
};

class Land_vn_b_trench_wall_05_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_05_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_05_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_05_02";
		};
	};
};

class Land_vn_b_trench_wall_05_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_05_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_05_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_05_03";
		};
	};
};

class Land_vn_b_trench_wall_10_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_10_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_10_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_10_01";
		};
	};
};

class Land_vn_b_trench_wall_10_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_10_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_10_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_10_02";
		};
	};
};

class Land_vn_b_trench_wall_10_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_wall_10_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_wall_10_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_wall_10_03";
		};
	};
};

class Land_vn_b_trench_tee_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_tee_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_tee_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_tee_01";
		};
	};
};

class Land_vn_b_trench_stair_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_stair_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_stair_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_stair_01";
		};
	};
};

class Land_vn_b_trench_stair_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_stair_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_stair_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_stair_02";
		};
	};
};

class Land_vn_b_trench_revetment_tall_09
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_revetment_tall_09_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_revetment_tall_09";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_revetment_tall_09";
		};
	};
};

class Land_vn_b_trench_revetment_tall_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_revetment_tall_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_revetment_tall_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_revetment_tall_03";
		};
	};
};

class Land_vn_b_trench_revetment_90_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_revetment_90_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_revetment_90_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_revetment_90_01";
		};
	};
};

class Land_vn_b_trench_revetment_05_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_revetment_05_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_revetment_05_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_revetment_05_01";
		};
	};
};

class Land_vn_b_trench_firing_05
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_firing_05_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_firing_05";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_firing_05";
		};
	};
};

class Land_vn_b_trench_firing_04
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_firing_04_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_firing_04";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_firing_04";
		};
	};
};

class Land_vn_b_trench_firing_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_firing_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_firing_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_firing_03";
		};
	};
};

class Land_vn_b_trench_firing_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_firing_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_firing_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_firing_02";
		};
	};
};

class Land_vn_b_trench_firing_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_firing_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_firing_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_firing_01";
		};
	};
};

class Land_vn_o_trench_firing_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_trench_firing_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_trench_firing_01";
		};
		class final_state
		{
			object_class = "Land_vn_o_trench_firing_01";
		};
	};
};

class Land_vn_b_trench_end_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_end_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_end_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_end_01";
		};
	};
};

class Land_vn_b_trench_cross_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_cross_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_cross_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_cross_02";
		};
	};
};

class Land_vn_b_trench_cross_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(250, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_cross_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_cross_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_cross_01";
		};
	};
};

class Land_vn_b_trench_corner_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications","nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_corner_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_corner_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_corner_01";
		};
	};
};


class Land_vn_b_trench_bunker_06_02
{
	name = "";
	type = "bunkers";
	categories[] = {"tents", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_06_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_06_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_06_02";
		};
	};
};

class Land_vn_b_trench_bunker_06_01
{
	name = "";
	type = "bunkers";
	categories[] = {"tents", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_06_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_06_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_06_01";
		};
	};
};

class Land_vn_b_trench_bunker_05_02
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "tents"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_05_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_05_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_05_02";
		};
	};
};

class Land_vn_b_trench_bunker_05_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "tents"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_05_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_05_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_05_01";
		};
	};
};

class Land_vn_b_trench_bunker_04_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_04_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_04_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_04_01";
		};
	};
};

class Land_vn_b_trench_bunker_03_04
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_03_04_part0";
		};
		class middle_state
		{
			object_class = "vn_b_trench_bunker_03_04_part1";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_03_04";
		};
	};
	class features
	{
		class base_starter {};
	};
};

class Land_vn_b_trench_bunker_03_03
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "medical", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_03_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_03_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_03_03";
		};
	};
};

class Land_vn_b_trench_bunker_03_02
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_03_02_part0";
		};
		class middle_state
		{
			object_class = "vn_b_trench_bunker_03_02_part1";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_03_02";
		};
	};
	class features
	{
		class supply_depot
		{
			supplyChange = 2500;
		};
	};
};

class Land_vn_b_trench_bunker_03_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "storage"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_03_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_03_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_03_01";
		};
	};
	class features
	{
		class supply_depot
		{
			supplyChange = 1500;
		};
	};
};

class Land_vn_b_trench_bunker_02_04
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "barracks"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_02_04_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_02_04";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_02_04";
		};
	};
	class features
	{
		class supply_depot
		{
			supplyChange = 500;
		};
	};
};

class Land_vn_b_trench_bunker_02_03
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "barracks"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_02_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_02_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_02_03";
		};
	};
	class features
	{
		class supply_depot
		{
			supplyChange = 500;
		};
	};
};

class Land_vn_b_trench_bunker_02_02
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "barracks"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_02_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_02_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_02_02";
		};
	};
	class features
	{
		class supply_depot
		{
			supplyChange = 500;
		};
	};
};

class Land_vn_b_trench_bunker_02_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "storage"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_02_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_02_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_02_01";
		};
	};
	class features
	{
		class supply_depot
		{
			supplyChange = 1000;
		};
	};
};

class Land_vn_b_trench_bunker_01_03
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "barracks"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_01_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_01_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_01_03";
		};
	};
};

class Land_vn_bagbunker_01_large_green_f
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			// deliberately wrong so we can get the green/red wireframe
			object_class = "vn_bunker_big_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bagbunker_01_large_green_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagbunker_01_large_green_f";
		};
	};
};

class Land_vn_bagbunker_01_small_green_f
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			// deliberately wrong so we can get the green/red wireframe
			object_class = "vn_bunker_small_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bagbunker_01_small_green_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagbunker_01_small_green_f";
		};
	};
};

class Land_vn_b_trench_bunker_01_02
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "barracks"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_01_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_01_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_01_02";
		};
	};
};

class Land_vn_b_trench_bunker_01_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "barracks"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_bunker_01_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_bunker_01_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_bunker_01_01";
		};
	};
	class features
	{
		class respawn {};
	};
};

class Land_vn_b_trench_90_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_90_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_90_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_90_02";
		};
	};
};

class Land_vn_b_trench_90_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(400, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_90_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_90_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_90_01";
		};
	};
};

class Land_vn_b_trench_45_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_45_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_45_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_45_02";
		};
	};
};

class Land_vn_b_trench_45_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(400, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_45_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_45_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_45_01";
		};
	};
};

class Land_vn_b_trench_20_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(300, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_20_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_20_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_20_02";
		};
	};
};

class Land_vn_b_trench_20_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_20_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_20_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_20_01";
		};
	};
};

class Land_vn_b_trench_05_03
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_05_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_05_03";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_05_03";
		};
	};
};

class Land_vn_b_trench_05_02
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_05_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_05_02";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_05_02";
		};
	};
};

class Land_vn_b_trench_05_01
{
	name = "";
	type = "trenches";
	categories[] = {"trenches", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_trench_05_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_trench_05_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_trench_05_01";
		};
	};
};

class Land_vn_b_mortarpit_01
{
	name = "";
	type = "mortarpits";
	categories[] = { "fortifications", "bunkers"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_mortarpit_01_part0";
		};
		class middle_state
		{
			object_class = "vn_b_mortarpit_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_b_mortarpit_01";
		};
	};
};

class Land_vn_b_helipad_01
{
	name = "";
	type = "helipads";
	categories[] = {"helipads"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};

	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_helipad_01_part0";
		};
		class middle_state
		{
			object_class = "vn_b_helipad_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_b_helipad_01";
		};
	};

	class features
	{
		class wreck_recovery {};
	};
};

class Land_vn_b_gunpit_01
{
	name = "";
	type = "gunpits";
	categories[] = {"fortifications", "bunkers"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_gunpit_01_part0";
		};
		class middle_state
		{
			object_class = "vn_b_gunpit_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_b_gunpit_01";
		};
	};
};

class Land_vn_b_foxhole_01
{
	name = "";
	type = "foxholes";
	categories[] = {"trenches", "fortifications", "nonAcav", "bunkers"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_b_foxhole_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_b_foxhole_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_foxhole_01";
		};
	};
};

class Land_vn_o_tower_01
{
	name = "";
	type = "towers";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_tower_01_part0";
		};
		class middle_state
		{
			object_class = "vn_o_tower_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_o_tower_01";
		};
	};
};


class Land_vn_o_tower_02
{
	name = "";
	type = "towers";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_tower_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_tower_02";
		};
		class final_state
		{
			object_class = "Land_vn_o_tower_02";
		};
	};
};

class Land_vn_o_tower_03
{
	name = "";
	type = "towers";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_tower_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_tower_03";
		};
		class final_state
		{
			object_class = "Land_vn_o_tower_03";
		};
	};
};

class Land_vn_cave_01
{
	name = "";
	type = "caves";
	categories[] = {"caves", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(2000, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_cave_01_part0";
		};
		class middle_state
		{
			object_class = "vn_cave_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_cave_01";
		};
	};
};

class Land_vn_cave_02
{
	name = "";
	type = "caves";
	categories[] = {"caves", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(2000, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_cave_02_part0";
		};
		class middle_state
		{
			object_class = "vn_cave_02_part1";
		};
		class final_state
		{
			object_class = "Land_vn_cave_02";
		};
	};
};

class Land_vn_cave_03
{
	name = "";
	type = "caves";
	categories[] = {"caves", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(2000, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_cave_03_part0";
		};
		class middle_state
		{
			object_class = "vn_cave_03_part1";
		};
		class final_state
		{
			object_class = "Land_vn_cave_03";
		};
	};
};

class Land_vn_cave_04
{
	name = "";
	type = "caves";
	categories[] = {"caves", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(2000, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_cave_04_part0";
		};
		class middle_state
		{
			object_class = "vn_cave_04_part1";
		};
		class final_state
		{
			object_class = "Land_vn_cave_04";
		};
	};
};

class Land_vn_steeldrum_bbq_01
{
	name = "";
	type = "props";
	categories[] = {"decorative", "sanitation"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_steeldrum_bbq_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_steeldrum_bbq_01";
		};
		class final_state
		{
			object_class = "Land_vn_steeldrum_bbq_01";
		};
	};
};

class Land_vn_o_bunker_01
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_bunker_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_bunker_01";
		};
		class final_state
		{
			object_class = "Land_vn_o_bunker_01";
		};
	};
};

class Land_vn_o_bunker_02
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_bunker_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_bunker_02";
		};
		class final_state
		{
			object_class = "Land_vn_o_bunker_02";
		};
	};
};

class Land_vn_o_bunker_03
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_bunker_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_bunker_03";
		};
		class final_state
		{
			object_class = "Land_vn_o_bunker_03";
		};
	};
};

class Land_vn_o_bunker_04
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "fortifications", "shelters", "tents", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_bunker_04_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_bunker_04";
		};
		class final_state
		{
			object_class = "Land_vn_o_bunker_04";
		};
	};
};

class Land_vn_o_platform_01
{
	name = "";
	type = "platforms";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_platform_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_platform_01";
		};
		class final_state
		{
			object_class = "Land_vn_o_platform_01";
		};
	};
};

class Land_vn_b_tower_01
{
	name = "";
	type = "platforms";
	categories[] = {"towers", "shelters"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_b_tower_01";
		};
		class middle_state
		{
			object_class = "Land_vn_b_tower_01";
		};
		class final_state
		{
			object_class = "Land_vn_b_tower_01";
		};
	};
};

class Land_vn_o_platform_03
{
	name = "";
	type = "platforms";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_platform_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_platform_03";
		};
		class final_state
		{
			object_class = "Land_vn_o_platform_03";
		};
	};
};

class Land_vn_bridge_bailey_01
{
	name = "STR_vn_mf_bridgebailey01";
	type = "bridges";
	categories[] = {"bridges"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	rotation = -90;
	offset[] = {22.19,0,0};
	max_segments = 10;
	min_distance = 15;
	max_distance = 30;
	check_pos_start[] = {-10.386,0.14209,-0.55};
	check_pos_stop[] = {10.386,0.14209,-0.55};

	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bridge_bailey_01_part0";
		};
		class middle_state
		{
			object_class = "vn_bridge_bailey_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_bridge_bailey_01";
		};
	};
};

class Land_vn_bridge_bailey_02
{
	name = "STR_vn_mf_bridgebailey02";
	type = "bridges";
	categories[] = {"bridges"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	rotation = -90;
	offset[] = {22.19,0,0};
	max_segments = 10;
	min_distance = 15;
	max_distance = 30;
	check_pos_start[] = {-10.386,0.14209,-0.55};
	check_pos_stop[] = {10.386,0.14209,-0.55};
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bridge_bailey_02_part0";
		};
		class middle_state
		{
			object_class = "vn_bridge_bailey_02_part1";
		};
		class final_state
		{
			object_class = "Land_vn_bridge_bailey_02";
		};
	};
};

class Land_vn_bridge_bailey_03
{
	name = "STR_vn_mf_bridgebailey03";
	type = "bridges";
	categories[] = {"bridges"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	rotation = -90;
	offset[] = {22.19,0,0};
	max_segments = 10;
	min_distance = 15;
	max_distance = 30;
	check_pos_start[] = {-10.386,0.14209,-0.55};
	check_pos_stop[] = {10.386,0.14209,-0.55};
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bridge_bailey_03_part0";
		};
		class middle_state
		{
			object_class = "vn_bridge_bailey_03_part1";
		};
		class final_state
		{
			object_class = "Land_vn_bridge_bailey_03";
		};
	};
};

class Land_vn_bridge_bailey_04
{
	name = "STR_vn_mf_bridgebailey04";
	type = "bridges";
	categories[] = {"bridges"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	rotation = -90;
	offset[] = {22.19,0,0};
	max_segments = 10;
	min_distance = 15;
	max_distance = 30;
	check_pos_start[] = {-10.386,0.14209,-0.55};
	check_pos_stop[] = {10.386,0.14209,-0.55};
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bridge_bailey_04_part0";
		};
		class middle_state
		{
			object_class = "vn_bridge_bailey_04_part1";
		};
		class final_state
		{
			object_class = "Land_vn_bridge_bailey_04";
		};
	};
};

class Land_vn_o_platform_04
{
	name = "";
	type = "platforms";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_platform_04_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_platform_04";
		};
		class final_state
		{
			object_class = "Land_vn_o_platform_04";
		};
	};

	class features
	{
		class respawn {};
	};
};

class Land_vn_o_platform_05
{
	name = "";
	type = "towers";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(300, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_platform_05_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_platform_05";
		};
		class final_state
		{
			object_class = "Land_vn_o_platform_05";
		};
	};
};

class Land_vn_o_platform_06
{
	name = "";
	type = "towers";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(300, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_platform_06_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_platform_06";
		};
		class final_state
		{
			object_class = "Land_vn_o_platform_06";
		};
	};
};

class Land_vn_o_shelter_01
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_shelter_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_shelter_01";
		};
		class final_state
		{
			object_class = "Land_vn_o_shelter_01";
		};
	};
};

class Land_vn_o_shelter_02
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_shelter_02_part0";
		};
		class middle_state
		{
			object_class = "vn_o_shelter_02_part1";
		};
		class final_state
		{
			object_class = "Land_vn_o_shelter_02";
		};
	};
};

class Land_vn_o_shelter_03
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_shelter_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_shelter_03";
		};
		class final_state
		{
			object_class = "Land_vn_o_shelter_03";
		};
	};
};

class Land_vn_o_shelter_04
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_shelter_04_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_shelter_04";
		};
		class final_state
		{
			object_class = "Land_vn_o_shelter_04";
		};
	};
};

class Land_vn_o_shelter_05
{
	name = "";
	type = "bunkers";
	categories[] = {"bunkers", "shelters", "fortifications", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_shelter_05_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_shelter_05";
		};
		class final_state
		{
			object_class = "Land_vn_o_shelter_05";
		};
	};
};

class Land_vn_camonet_nato
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_camonet_nato";
		};
		class middle_state
		{
			object_class = "Land_vn_camonet_nato";
		};
		class final_state
		{
			object_class = "Land_vn_camonet_nato";
		};
	};
};

class Land_vn_camonetb_east
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_camonetb_east";
		};
		class middle_state
		{
			object_class = "Land_vn_camonetb_east";
		};
		class final_state
		{
			object_class = "Land_vn_camonetb_east";
		};
	};
};

class Land_vn_camonet_east
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_camonet_east_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_camonet_east";
		};
		class final_state
		{
			object_class = "Land_vn_camonet_east";
		};
	};
};

class Land_vn_camonetb_nato
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "shelters", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_camonetb_nato";
		};
		class middle_state
		{
			object_class = "Land_vn_camonetb_nato";
		};
		class final_state
		{
			object_class = "Land_vn_camonetb_nato";
		};
	};
};

class Land_vn_o_wallfoliage_01
{
	name = "";
	type = "shelters";
	categories[] = {"tents", "fortifications", "fences", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_wallfoliage_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_wallfoliage_01";
		};
		class final_state
		{
			object_class = "Land_vn_o_wallfoliage_01";
		};
	};
};

class Land_vn_o_snipertree_01
{
	name = "";
	type = "trees";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_snipertree_01_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_snipertree_01";
		};
		class final_state
		{
			object_class = "Land_vn_o_snipertree_01";
		};
	};
};

class Land_vn_o_snipertree_02
{
	name = "";
	type = "trees";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_snipertree_02_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_snipertree_02";
		};
		class final_state
		{
			object_class = "Land_vn_o_snipertree_02";
		};
	};
};

class Land_vn_o_snipertree_03
{
	name = "";
	type = "trees";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_snipertree_03_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_snipertree_03";
		};
		class final_state
		{
			object_class = "Land_vn_o_snipertree_03";
		};
	};
};

class Land_vn_o_snipertree_04
{
	name = "";
	type = "trees";
	categories[] = {"towers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_snipertree_04_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_o_snipertree_04";
		};
		class final_state
		{
			object_class = "Land_vn_o_snipertree_04";
		};
	};
};

class Land_vn_razorwire_f
{
	name = "";
	type = "fences";
	categories[] = {"fences", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_razorwire_f_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_razorwire_f";
		};
		class final_state
		{
			object_class = "Land_vn_razorwire_f";
		};
	};
};

class Land_vn_czechhedgehog_01_f
{
	name = "";
	type = "fences";
	categories[] = {"fences", "fortifications", "nonAcav"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_czechhedgehog_01_f_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_czechhedgehog_01_f";
		};
		class final_state
		{
			object_class = "Land_vn_czechhedgehog_01_f";
		};
	};
};

class Land_vn_bagfence_long_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_bagfence_long_f_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_long_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_long_f";
		};
	};
};

class Land_vn_bagfence_corner_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_corner_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_corner_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_corner_f";
		};
	};
};

class Land_vn_bagfence_end_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_end_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_end_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_end_f";
		};
	};
};

class Land_vn_bagfence_round_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_round_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_round_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_round_f";
		};
	};
};

class Land_vn_bagfence_short_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_short_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_short_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_short_f";
		};
	};
};

class Land_vn_sandbagbarricade_01_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_sandbagbarricade_01_f";
		};
		class middle_state
		{
			object_class = "Land_vn_sandbagbarricade_01_f";
		};
		class final_state
		{
			object_class = "Land_vn_sandbagbarricade_01_f";
		};
	};
};

class Land_vn_sandbagbarricade_01_half_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_sandbagbarricade_01_half_f";
		};
		class middle_state
		{
			object_class = "Land_vn_sandbagbarricade_01_half_f";
		};
		class final_state
		{
			object_class = "Land_vn_sandbagbarricade_01_half_f";
		};
	};
};

class Land_vn_sandbagbarricade_01_hole_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_sandbagbarricade_01_hole_f";
		};
		class middle_state
		{
			object_class = "Land_vn_sandbagbarricade_01_hole_f";
		};
		class final_state
		{
			object_class = "Land_vn_sandbagbarricade_01_hole_f";
		};
	};
};

class Land_vn_bagfence_01_long_green_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			// deliberately wrong so we get the wireframe of a similar object shape
			object_class = "vn_bagfence_long_f_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_01_long_green_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_01_long_green_f";
		};
	};
};

class Land_vn_bagfence_01_end_green_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_01_end_green_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_01_end_green_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_01_end_green_f";
		};
	};
};

class Land_vn_bagfence_01_corner_green_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_01_corner_green_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_01_corner_green_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_01_corner_green_f";
		};
	};
};

class Land_vn_bagfence_01_short_green_f
{
	name = "";
	type = "walls";
	categories[] = {"fortifications", "nonAcav", "fences"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_bagfence_01_short_green_f";
		};
		class middle_state
		{
			object_class = "Land_vn_bagfence_01_short_green_f";
		};
		class final_state
		{
			object_class = "Land_vn_bagfence_01_short_green_f";
		};
	};
};

class Land_vn_d_fallentrunk_clear_f
{
	name = "";
	type = "walls";
	categories[] = {"fences", "nonAcav", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(100, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_d_fallentrunk_clear_f_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_d_fallentrunk_clear_f";
		};
		class final_state
		{
			object_class = "Land_vn_d_fallentrunk_clear_f";
		};
	};
};

class Land_vn_fireplace_f
{
	name = "";
	type = "lighting";
	categories[] = {"lighting", "nonAcav", "sanitation"};
	rank = 0;
	SUPPLY_CAPACITY(20, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_fireplace_f_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_fireplace_f";
		};
		class final_state
		{
			object_class = "Land_vn_fireplace_f";
		};
	};
};

class Land_vn_pierwooden_01_dock_f
{
	name = "";
	type = "piers";
	categories[] = {};
	rank = 0;
	SUPPLY_CAPACITY(1500, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_pierwooden_01_dock_f_part0";
		};
		class middle_state
		{
			object_class = "vn_pierwooden_01_dock_f_part1";
		};
		class final_state
		{
			object_class = "Land_vn_pierwooden_01_dock_f";
		};
	};
	class features
	{
		class vehicle_spawning
		{
			class vehicle_class
			{
				class light_boats
				{
					icon = VEHICLE_ICON_BOAT;
					name = "STR_vn_mf_vic_boat_light";

					class vn_o_boat_01_mg_00
					{
						// VC short Wooden boat with MG
						/*Array currently unused, only the first number is used*/
						cost[] = {{"BuildingSupplies", 200}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 120;
					};

					class vn_o_boat_02_mg_00
					{
						// VC Long wooden boat with MG
						cost[] = {{"BuildingSupplies", 300}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 120;
					};

					class vn_o_boat_08_01
					{
						// VC Long transport boat. NO GUN
						cost[] = {{"BuildingSupplies", 150}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 120;
						//side = "WEST";
					};

					class vn_b_boat_11_01
					{
						// STAB Mk18
						cost[] = {{"BuildingSupplies", 500}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 300;
					};

					class vn_b_boat_9_01
					{
						// STAB M60
						cost[] = {{"BuildingSupplies", 400}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 300;
					};

					class vn_b_boat_10_01
					{
						// STAB M2
						cost[] = {{"BuildingSupplies", 400}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 300;
					};
				};
				class heavy_boats
				{
					icon = VEHICLE_ICON_BOAT;
					name = "STR_vn_mf_vic_boat_heavy";

					class vn_b_boat_06_01
					{
						// Nasty Boat with 40mm gun
						cost[] = {{"BuildingSupplies", 1000}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 300;
					};

					class vn_b_boat_05_01
					{
						// Nasty Boat with mortar
						cost[] = {{"BuildingSupplies", 1000}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 300;
					};

					class vn_b_boat_13_04
					{
						//PBR Mk18
						cost[] = {{"BuildingSupplies", 750}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 120;
					};

					class vn_b_boat_12_03
					{
						// PBR M60
						cost[] = {{"BuildingSupplies", 750}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 120;
						//side = "WEST";
					};
				};
			};

			spawnPositionModelSpace[] = {0,12,-2};
			spawnDirectionModelSpace = 270;
		};
	};
};

class vn_o_vc_spiderhole_01
{
	name = "";
	type = "spiderholes";
	categories[] = {"nonAcav", "bunkers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_spiderhole_01_part0";
		};
		class middle_state
		{
			object_class = "vn_o_vc_spiderhole_01";
		};
		class final_state
		{
			object_class = "vn_o_vc_spiderhole_01";
		};
	};
};

class vn_o_vc_spiderhole_02
{
	name = "";
	type = "spiderholes";
	categories[] = {"nonAcav", "bunkers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_spiderhole_02_part0";
		};
		class middle_state
		{
			object_class = "vn_o_vc_spiderhole_02";
		};
		class final_state
		{
			object_class = "vn_o_vc_spiderhole_02";
		};
	};
};

class vn_o_vc_spiderhole_03
{
	name = "";
	type = "spiderholes";
	categories[] = {"nonAcav", "bunkers", "shelters", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_o_spiderhole_03_part0";
		};
		class middle_state
		{
			object_class = "vn_o_vc_spiderhole_03";
		};
		class final_state
		{
			object_class = "vn_o_vc_spiderhole_03";
		};
	};
};

class vn_b_prop_fmradio_01
{
	name = "";
	type = "radio";
	categories[] = {"decorative"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_radio_part0";
		};
		class middle_state
		{
			object_class = "Land_vn_radio";
		};
		class final_state
		{
			object_class = "vn_b_prop_fmradio_01";
		};
	};
	class features
	{
		class radio {};
	};
};

class vn_sign_town_d_11_01
{
	name = "";
	type = "buildings";
	categories[] = {"buildings", "functional", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(2000, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_sign_town_d_11_01";
		};
		class middle_state
		{
			object_class = "vn_sign_town_d_11_01";
		};
		class final_state
		{
			object_class = "vn_sign_town_d_11_01";
		};
	};
	class features
	{
		class vehicle_spawning
		{
			class vehicle_class
			{
				class statics
				{
					icon = VEHICLE_ICON_STATIC;
					name = "STR_vn_mf_vic_static";

					class vn_o_nva_static_zpu4
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_nva_navy_static_d44
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_pl_static_mortar_type53
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_nva_static_type56rr
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_nva_static_sgm_low_01
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_nva_navy_static_dshkm_low_02
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_nva_navy_static_at3
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};
				};
				class armour
				{
					icon = VEHICLE_ICON_ARMOUR;
					name = "STR_vn_mf_vic_armour";

					class vn_o_armor_type63_01
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_armor_pt76b_01
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_armor_t54b_01
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_armor_ot54_01
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_o_armor_btr50pk_02
					{
						cost[] = {{"BuildingSupplies", 10}};
						cooldown = 5;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};
				};
			};
			spawnPositionModelSpace[] = {0,10,0.5};
			spawnDirectionModelSpace = 270;
		};
	};
};

class Land_vn_hut_river_03
{
	name = "";
	type = "buildings";
	categories[] = {"buildings", "functional", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(2000, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_hut_river_03";
		};
		class middle_state
		{
			object_class = "Land_vn_hut_river_03";
		};
		class final_state
		{
			object_class = "Land_vn_hut_river_03";
		};
	};
	class features
	{
		class vehicle_spawning
		{
			class vehicle_class
			{
				class light_boats
				{
					icon = VEHICLE_ICON_BOAT;
					name = "STR_vn_mf_vic_boat_light";
					class vn_o_boat_01_mg_03
					{
						// Boat rpd
						cost[] = {{"BuildingSupplies", 5}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 5;
						//side = "EAST";
					};
					class vn_o_boat_02_mg_03
					{
						// long boat dp27
						cost[] = {{"BuildingSupplies", 5}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 5;
						//side = "EAST";
					};
				};
				class heavy_boats
				{
					icon = VEHICLE_ICON_BOAT;
					name = "STR_vn_mf_vic_boat_heavy";
					class vn_o_boat_03_01
					{
						// long boat dp27
						cost[] = {{"BuildingSupplies", 5}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 5;
						//side = "EAST";
					};
					class vn_o_boat_03_02
					{
						// long boat dp27
						cost[] = {{"BuildingSupplies", 5}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 5;
						//side = "EAST";
					};
					class vn_o_boat_04_01
					{
						// long boat dp27
						cost[] = {{"BuildingSupplies", 5}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 5;
						//side = "EAST";
					};
					class vn_o_boat_04_02
					{
						// long boat dp27
						cost[] = {{"BuildingSupplies", 5}};
						icon = VEHICLE_ICON_BOAT;
						cooldown = 5;
						//side = "EAST";
					};
				};
			};
			spawnPositionModelSpace[] = {2,15,-2};
			spawnDirectionModelSpace = 270;
		};
	};
};

class Land_Shed_06_F
{
	name = "";
	type = "buildings";
	categories[] = {"buildings"};
	rank = 0;
	SUPPLY_CAPACITY(200, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		/*
		the Land_vn_shed_06_f object does not have
		corresponding partX assets so it cannot show
		wireframe stages during the player build.
		*/
		class initial_state
		{
			object_class = "Land_vn_shed_06_f";
		};
		class middle_state
		{
			object_class = "Land_vn_shed_06_f";
		};
		class final_state
		{
			object_class = "Land_vn_shed_06_f";
		};
	};
};

/*
class Land_vn_usaf_revetment_helipad_02
{
	name = "STR_vn_mf_vehicle_workshop";
	type = "buildings";
	categories[] = {"buildings", "functional"};
	rank = 0;
	SUPPLY_CAPACITY(300, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};

	class build_states
	{
		class initial_state
		{
			object_class = "Land_vn_usaf_revetment_helipad_02";
		};
		class middle_state
		{
			object_class = "vn_b_helipad_01_part1";
		};
		class final_state
		{
			object_class = "Land_vn_usaf_revetment_helipad_02";
		};
	};

	class features
	{
		class vehicle_spawning
		{
			class vehicle_class
			{
				class trucks
				{
					icon = VEHICLE_ICON_TRUCK;
					name = "STR_vn_mf_vic_truck";

					class vn_b_wheeled_m54_02
					{
						/*Array currently unused, only the first number is used
						cost[] = {{"BuildingSupplies", 500}};
						cooldown = 300;
						icon = VEHICLE_ICON_TRUCK;
						//side = "WEST";
					};
				};
				class cars
				{
					icon = VEHICLE_ICON_CAR;
					name = "STR_vn_mf_vic_car";

					class vn_b_wheeled_m151_01
					{
						cost[] = {{"BuildingSupplies", 250}};
						cooldown = 120;
						icon = VEHICLE_ICON_CAR;
						//side = "WEST";
					};

					class vn_b_wheeled_m151_mg_04
					{
						cost[] = {{"BuildingSupplies", 500}};
						cooldown = 300;
						icon = VEHICLE_ICON_CAR;
						//side = "WEST";
					};
				};
				class statics
				{
					icon = VEHICLE_ICON_STATIC;
					name = "STR_vn_mf_vic_static";

					class vn_b_sf_static_m2_high
					{
						cost[] = {{"BuildingSupplies", 100}};
						cooldown = 60;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_b_ammobox_wpn_01
					{
						cost[] = {{"BuildingSupplies", 100}};
						cooldown = 60;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};
				};
				class supplies
				{
					icon = VEHICLE_ICON_SUPPLY;
					name = "STR_vn_mf_vic_supply";

					class vn_b_ammobox_wpn_03
					{
						cost[] = {{"BuildingSupplies", 100}};
						cooldown = 60;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};

					class vn_b_ammobox_wpn_06
					{
						cost[] = {{"BuildingSupplies", 100}};
						cooldown = 60;
						icon = VEHICLE_ICON_STATIC;
						//side = "WEST";
					};
				};
			};

			spawnPositionModelSpace[] = {4,0,-0.8};
			spawnDirectionModelSpace = 90;
		};
	};
};*/

class vn_flag_pavn
{
	name = "";
	type = "flag";
	categories[] = {"flags", "nv"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_DAC_CONG
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_flag_pavn";
		};
		class middle_state
		{
			object_class = "vn_flag_pavn";
		};
		class final_state
		{
			object_class = "vn_flag_pavn";
		};
	};
};

class vn_flag_usa
{
	name = "";
	type = "flag";
	categories[] = {"flags"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_flag_usa";
		};
		class middle_state
		{
			object_class = "vn_flag_usa";
		};
		class final_state
		{
			object_class = "vn_flag_usa";
		};
	};
};

class vn_flag_aus
{
	name = "";
	type = "flag";
	categories[] = {"flags"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_flag_aus";
		};
		class middle_state
		{
			object_class = "vn_flag_aus";
		};
		class final_state
		{
			object_class = "vn_flag_aus";
		};
	};
};

class vn_flag_nz
{
	name = "";
	type = "flag";
	categories[] = {"flags"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_flag_nz";
		};
		class middle_state
		{
			object_class = "vn_flag_nz";
		};
		class final_state
		{
			object_class = "vn_flag_nz";
		};
	};
};

class vn_flag_arvn
{
	name = "";
	type = "flag";
	categories[] = {"flags"};
	rank = 0;
	SUPPLY_CAPACITY(50, DAYS_TO_SECONDS(1));
	resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};
	class build_states
	{
		class initial_state
		{
			object_class = "vn_flag_arvn";
		};
		class middle_state
		{
			object_class = "vn_flag_arvn";
		};
		class final_state
		{
			object_class = "vn_flag_arvn";
		};
	};
};
