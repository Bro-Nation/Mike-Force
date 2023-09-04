class map_config {
	starting_zones[] = {"zone_sofia"};
	max_camps_per_zone = 5;
	max_aa_per_zone = 10;
	max_artillery_per_zone = 3;
	max_fortifications_per_zone = 0;	
	max_radars_per_zone = 2;
	max_water_supply_per_zone = 2;
	max_tunnels_per_zone = 3;
	max_vehicle_depots_per_zone = 3;
	bn_zone_radius = 700;
	class zones {
		#include "zones.hpp"
	};
};
