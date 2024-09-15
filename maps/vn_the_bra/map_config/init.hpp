class map_config {
	max_camps_per_zone = 3;
	max_wrecks_per_zone = 2;
	max_aa_per_zone = 5;
	max_artillery_per_zone = 4;
	max_fortifications_per_zone = 0;
	max_tunnels_per_zone = 3;
	max_radars_per_zone = 2;
	max_water_supply_per_zone = 2;
	max_vehicle_depots_per_zone = 3;
	max_fuel_per_zone = 2;
	starting_zones[] = {"zone_nam_phat", "zone_ban_pakha", "zone_ban_dac_maruk"};
	bn_zone_radius = 1000;
	class zones {
		#include "zones.hpp"
	};
};
