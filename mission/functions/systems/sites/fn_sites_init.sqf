/*
    File: fn_sites_init.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Starts the sites system, which is responsible for managing all of the AI controlled installations and building new ones.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_sites_init
*/
vn_mf_s_max_camps_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_camps_per_zone");
vn_mf_s_max_aa_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_aa_per_zone");
vn_mf_s_max_artillery_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_artillery_per_zone");
vn_mf_s_max_water_supply_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_water_supply_per_zone");
vn_mf_s_max_radars_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_radars_per_zone");
vn_mf_s_max_fortifications_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_fortifications_per_zone");
vn_mf_s_max_tunnels_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_tunnels_per_zone");
vn_mf_s_max_vehicle_depots_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_vehicle_depots_per_zone");
vn_mf_s_max_fuel_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_fuel_per_zone");

// factory and HQ have minimum radius of 55. 
// Some radars seem to be larger than 55 as well.
// Add 20 for safety / reliability / QoL.
vn_mf_sites_minimum_distance_between_sites = 75;

vn_mf_g_sites_partial_discovery_radius = 300;
publicVariable "vn_mf_g_sites_partial_discovery_radius";
vn_mf_g_sites_discovery_radius = 50;
publicVariable "vn_mf_g_sites_discovery_radius";
vn_mf_g_sites_scout_action_cooldown = 30;
publicVariable "vn_mf_g_sites_scout_action_cooldown";

missionNamespace setVariable ["side_sites_hq", []];
missionNamespace setVariable ["side_sites_factory", []];
missionNamespace setVariable ["current_hq", objNull];
missionNamespace setVariable ["current_factory", objNull];

missionNamespace setVariable ["sites", []];
publicVariable "sites";

private _loadSuccessful = [] call vn_mf_fnc_sites_load;

[] call vn_mf_fnc_sites_aa_reveal_targets;
