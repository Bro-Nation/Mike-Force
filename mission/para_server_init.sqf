/*
    File: para_server_init.sqf
    Author: Savage Game Design
    Public: Yes

    Description:
        Called to initialise the server on game start.

    Parameter(s):
        None

    Returns:
        None

    Example(s):
        //In description.ext
        use_paradigm_init = 1;
*/

/*
=========================================================================================
init: `vn_mf_fnc_server_init_backend`
=========================================================================================
WARNING: YOU WILL NOT HAVE THIS DURING LOCAL DEVELOPMENT. This always generates an error
when running locally. It's a server-side only mod.

I don't actually know what this does.

TODO: Check on server what this is.
=========================================================================================
*/

call vn_mf_fnc_server_init_backend;

/*
=========================================================================================
job: `restart_messages`
=========================================================================================
WARNING: YOU WILL NOT HAVE THIS DURING LOCAL DEVELOPMENT. This always generates an error
when running locally. It's a server-side only mod.

Every minute check if we need to send out a restart message.
=========================================================================================
*/

["restart_messages", vn_mf_fnc_server_process_restart, [], 60] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
job: `update_whitelist`
=========================================================================================
Sets up the Bro-Nation whitelisting for teams. Reads from the backend MySQL database via
extDB3 and loads the player UIDs into a `publicVariable` so we can check whether a player
can join a specific team or not.
=========================================================================================
*/

call para_s_fnc_init_whitelist;
["update_whitelist", para_s_fnc_init_whitelist, [], 120] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
job: `update_curators`
=========================================================================================
Update the curator whitelist every 5 minutes. Reads from the backend MySQL database via
extDB3 and loads the player UIDs into a `publicVariable` so we can check whether a player
can access the zeus interface (TODO: public variables for authN is probably a bad idea!).

Also does a few fancy things like checking if the Zeus player has the correct modspack
loaded etc.
=========================================================================================
*/

call para_s_fnc_curator_populate;
["update_curators", para_s_fnc_curator_populate, [], 300] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
init: `para_s_fnc_curator_update_objects`
=========================================================================================
Creates a job which update the objects available for interaction in the zeus interface.

Basically stops curators having to right click > edit mission objects > all objects
whenever the mission has created something new.
=========================================================================================
*/

[10] call para_s_fnc_curator_update_objects;

/*
=========================================================================================
job: `sysmsg_admin` & `sysmsg_generic`
=========================================================================================
Sets up two 'sysmsg' jobs which send random messages to players over system chat at
different intervals.

    - 'sysmsg_admin' -- critical stuff like server rules.
    - 'sysmsg_generic' -- advertising and brief explaninations to players of how to do X

=========================================================================================
*/

["sysmsg_admin", vn_mf_fnc_sysmsg_print_admin, [], 3000] call para_g_fnc_scheduler_add_job;
["sysmsg_generic", vn_mf_fnc_sysmsg_print_others, [], 6666] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
conf: A BUNCH OF STUFF
=========================================================================================
The main server side configuration starts happening here and goes on for a bit.

I'm not going to document all of this just now.

----
TODO: Someone needs to go through and work out if all of these are actually necessary.

TODO: These should ideally be moved up to the top of the file. First get global
configuration, then apply that configuration during service inits.
=========================================================================================
*/

private _gamemode_config = (missionConfigFile >> "gamemode");

private _wipeSave = (["wipe_save", 0] call BIS_fnc_getParamValue) > 0;
if (_wipeSave) then {
    ["CLEAR"] call para_s_fnc_profile_db;
};

vn_mf_enableRanks = (["enable_ranks", 0] call BIS_fnc_getParamValue) > 0;
publicVariable "vn_mf_enableRanks";

// Create traits hashmap for reference by traits system
private _traits = (_gamemode_config >> "traits") call BIS_fnc_getCfgSubClasses;
vn_mf_traits_map = createHashMap;
{
    vn_mf_traits_map set [_x,[]];
}forEach _traits;
publicVariable "vn_mf_traits_map";

//Set whether the building system needs vehicles (fuel/repair/rearm, etc) nearby to build certain structures.
para_l_buildables_require_vehicles = [false, true] select (["buildables_require_vehicles", 1] call BIS_fnc_getParamValue);
publicVariable "para_l_buildables_require_vehicles";
vn_mf_dawnLength = ["dawn_length", 1200] call BIS_fnc_getParamValue;
vn_mf_dayLength = ["day_length", 9000] call BIS_fnc_getParamValue;
vn_mf_duskLength = ["dusk_length", 1200] call BIS_fnc_getParamValue;
vn_mf_nightLength = ["night_length", 1800] call BIS_fnc_getParamValue;

//Set whether stamia is enabled
vn_mf_param_enable_stamina = (["param_enable_stamina", 0] call BIS_fnc_getParamValue) > 0;
vn_mf_param_set_stamina = (["param_set_stamina", 1] call BIS_fnc_getParamValue);
publicVariable "vn_mf_param_enable_stamina";
publicVariable "vn_mf_param_set_stamina";

//Set whether withstand is always available.
vn_revive_withstand_allow = (["always_allow_withstand", 1] call BIS_fnc_getParamValue) > 0;
publicVariable "vn_revive_withstand_allow";
//Set number of bandages needed to withstand.
vn_revive_withstand_amount = 4;
publicVariable "vn_revive_withstand_amount";
//Set number of max players per team
vn_mf_max_players_acav = ["max_players_acav", 99] call BIS_fnc_getParamValue;
vn_mf_max_players_greenhornets = ["max_players_greenhornets", 99] call BIS_fnc_getParamValue;;
vn_mf_max_players_mikeforce = ["max_players_mikeforce", 99] call BIS_fnc_getParamValue;;
vn_mf_max_players_spiketeam = ["max_players_spiketeam", 99] call BIS_fnc_getParamValue;;
publicVariable "vn_mf_max_players_acav";
publicVariable "vn_mf_max_players_greenhornets";
publicVariable "vn_mf_max_players_mikeforce";
publicVariable "vn_mf_max_players_spiketeam";
//Disable RTO Support if desired
private _airSupport = ["enable_air_support", 1] call BIS_fnc_getParamValue;
private _artySupport = ["enable_arty_support", 1] call BIS_fnc_getParamValue;
if (_airSupport != 0 || _artySupport != 0) then {
  if (_airSupport == 0) then {
    vn_artillery_config_array set [0, nil];
  };
  if (_airSupport == 2) then {
    private _airArray = vn_artillery_config_array select 0;
    _airArray resize 1;
    _airArray select 0 select 1 resize 2;
    vn_artillery_config_array set [0, _airArray];
  };
  if (_artySupport == 0) then {
    vn_artillery_config_array set [2, nil];
  };
};

//TODO: Parameterise these
vn_mf_campAttackFrequency = 600;
vn_mf_counterAttackTime = 3600;
vn_mf_counterAttackShortenedTime = 600;
vn_mf_counterattackBaseInfantryMultiplier = 3;
vn_mf_counterattackCampInfantryMultiplier = 6;
para_s_bf_respawn_supply_cost = 50;

vn_dc_adhoc_respawns = [];
publicVariable "vn_dc_adhoc_respawns";

vn_site_objects = [];

// Set desired number of simultaneously active zones.
vn_mf_targetNumberOfActiveZones = 1;
// Set number of enemies per player. Scale the default value by the percentage set in the config options.
para_g_enemiesPerPlayer = ((["ai_scaling", 100] call BIS_fnc_getParamValue) / 100) * 2;
//Global variable, so it needs syncing across the network.
publicVariable "para_g_enemiesPerPlayer";

/*
=========================================================================================
init: `vn_mf_fnc_marker_init`
=========================================================================================
Read map markers from the map and populate appropriate arrays for use in later server
system initialisation. Creates a bunch of public server-side arrays for areas like:
`no_sites`, `zone`, `wreck_recovery`, `supply_officer_initial`, `blocked_area`, etc.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising markers";
call vn_mf_fnc_marker_init;

// restore enlisted player counter
(["GET", "enlisted_counter", 745001] call para_s_fnc_profile_db) params ["",["_enlisted_counter",0]];
vn_mf_enlisted_counter = _enlisted_counter;

//Initialise task list
vn_mf_tasks = [];
//Counts the number of tasks that have been created, to let us have unique IDs.
vn_mf_taskCounter = 0;
//Build the lists of secondary tasks, so we can create them later.
//Tasks without a marker aren't valid secondary tasks.
vn_mf_secondaryTaskConfigs = "getText (_x >> 'taskCategory') == 'SEC' && getText (_x >> 'taskname') != ''" configClasses (missionConfigFile >> "gamemode" >> "tasks");

//Create a lookup for tasks by zone and team
vn_mf_secondaryTasksBySide = false call para_g_fnc_create_namespace;
vn_mf_secondaryTasksBySide setVariable ["MikeForce", []];
vn_mf_secondaryTasksBySide setVariable ["SpikeTeam", []];
vn_mf_secondaryTasksBySide setVariable ["GreenHornets", []];
vn_mf_secondaryTasksBySide setVariable ["ACAV", []];


// vn_mf_allowed_functions = ("isClass _x && getNumber _x >> 'rec' isEqualTo 1" configClasses (missionConfigFile >> "cfgfunctions" >> "vn_mf" >> "rehandler") apply {configName _x});

vn_mf_default_awards = [];
{
    vn_mf_default_awards pushBack [configName _x, -1];
} forEach ("isClass(_x)" configClasses (missionConfigFile >> "gamemode" >> "awards_config"));

// setup game optimizations server side
setviewdistance (getNumber(_gamemode_config >> "performance" >> "setviewdistance"));
setobjectviewdistance (getArray(_gamemode_config >> "performance" >> "setobjectviewdistance")); // this also controls ai target range
setterraingrid (getNumber(_gamemode_config >> "performance" >> "setterraingrid"));
(getArray(_gamemode_config >> "performance" >> "enableenvironment")) params ["_ambientlife","_ambientsound"];
enableenvironment [[false,true] select _ambientlife,[false,true] select _ambientsound];

/*
=========================================================================================
init: `vn_mf_fnc_respawn_points_init`
=========================================================================================
Set up respawn points for players
=========================================================================================
*/

[] call vn_mf_fnc_respawn_points_init;

/*
=========================================================================================
init: `para_g_fnc_scheduler_subsystem_init`
=========================================================================================
Starts the paradigm scheduler. The scheduler will spawn a specific 'job' function every
N seconds.

**A BUNCH OF THINGS WILL NOT WORK IF THIS ISN'T STARTED.**
=========================================================================================
*/

diag_log "VN MikeForce: Starting scheduler";
[] call para_g_fnc_scheduler_subsystem_init;

/*
=========================================================================================
init: `para_g_fnc_event_subsystem_init`
=========================================================================================
Start the event dispatcher, so anything relying on events can fire.

This is essentially a way to get custom Event Handlers without having to mod the base
game. Pretty useful actually. We should do more with this as events are way cheaper for
server performance than scheduled/periodic jobs.
=========================================================================================
*/

call para_g_fnc_event_subsystem_init;

/*
=========================================================================================
init: `para_s_fnc_cleanup_subsystem_init`
=========================================================================================
Deletes bodies, objects and gear after a certain amount of time.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Cleanup Routine";
[
    createHashmapFromArray [
        ["minPlayerDistance", ["cleanup_min_player_distance", 400] call BIS_fnc_getParamValue],
        ["maxBodies", ["cleanup_max_bodies", 50] call BIS_fnc_getParamValue],
        ["cleanPlacedGear", ["cleanup_placed_gear", 1] call BIS_fnc_getParamValue > 0],
        ["placedGearCleanupTime", ["cleanup_placed_gear_lifetime", 300] call BIS_fnc_getParamValue],
        ["cleanDroppedGear", ["cleanup_dropped_gear", 1] call BIS_fnc_getParamValue > 0],
        ["droppedGearCleanupTime", ["cleanup_dropped_gear_lifetime", 300] call BIS_fnc_getParamValue]
    ]
] call para_s_fnc_cleanup_subsystem_init;

/*
=========================================================================================
init: `vn_mf_fnc_group_init`
=========================================================================================
Creates and initialize groups and duty officers. Group init here mostly refers to setting
up various variables. Duty officers obviously for switching roles and teams. Similar to
the supply officers (see way down below) the duty officers are civialian AI with damage
turned off and movement diabled.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising groups and duty officers";
call vn_mf_fnc_group_init;

/*
=========================================================================================
run: `vn_mf_secondaryTasksBySide`
=========================================================================================
TODO: Dead code? These variables aren't use anywhere.
=========================================================================================
*/

{
    private _taskConfig = _x;
    //Add the task to appropriate team arrays for the zone
    {
        vn_mf_secondaryTasksBySide getVariable _x pushBack configName _taskConfig;
    } forEach (getArray (_taskConfig >> 'taskGroups'));
} forEach (vn_mf_secondaryTaskConfigs);

/*
=========================================================================================
job: `save_profiledb`
=========================================================================================
Write the contents of `profileNamespace` to the $profile.vars file, i.e. flush data from
memory to disk for persistance between server restarts.

Disk write ops are the slowest of all data storage ops. Please avoid setting the job
schedule time to a low number! Lower periodic job runs means writing to disk more often.

Seeting lower job times *probably* has performance impacts. I'm not 100% sure as I don't
know the internals of Arma3 and whether they set a 'lock' on the data in memory while
writing. Locks -- https://en.wikipedia.org/wiki/Lock_(computer_science)

This might not be required as the `saveProfileNamespace` command is called automatically
'when the game is closed'. But i don't know whether 'when the game is closed' includes
server restarts, which basically are a termination of the running Arma3 process.
https://community.bistudio.com/wiki/saveProfileNamespace
=========================================================================================
*/

diag_log "VN MikeForce: Initialising 'save_profiledb' job.";
["save_profiledb", {["SAVE"] call para_s_fnc_profile_db}, [], 60] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
run & job: `save_time_elapsed`
=========================================================================================
Initialise public variables and start the job to track how much game time has elapsed.

The public variable `para_g_totalgametime` is only used by

    1. `vn_mf_fnc_display_location_time` -- display on player's screen where they are
    near and how long the mission has run for.

    2. `para_s_fnc_profile_db` -- run TTL expiry on speciofic keys on the
    profileNamespace KV store. Although there is no Mike Force or Paradigm
    system/function which uses profile_db TTL expiry. So this is mostly redundent.
=========================================================================================
*/

diag_log "VN MikeForce: Starting game time monitor";
missionNamespace setVariable ["para_g_totalgametime",["GET", "game_time", 0] call para_s_fnc_profile_db select 1,true];
diag_log format ["VN MikeForce: Total Game Time - %1", para_g_totalgametime];
["save_time_elapsed", {call vn_mf_fnc_save_time_elapsed}, [], 5] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
init: `para_s_fnc_building_system_init`
=========================================================================================
1. Initialises a bunch of variables and systems for building.
2. Recreates buildings that existed before restart (loaded from the profile DB).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising building system";
call para_s_fnc_building_system_init;

/*
=========================================================================================
run: `vn_mf_fnc_create_supply_officer`
=========================================================================================
Creates the actual supply officer objects which players can use to get build/medical/ammo
supplies etc.
=========================================================================================
*/

diag_log "VN MikeForce: Creating supply officers";
// spawn supply officers
{
    [_x] call vn_mf_fnc_create_supply_officer;
} forEach vn_mf_markers_supply_officer_initial;

/*
=========================================================================================
job: `building_state_tracker`
=========================================================================================
Tracks the current state of buildings, this includes running the 'tick' that reduces the
current supply of the building/base. On top of that, when buildings reach 0% supply they
become 'deconstructed'. Also handles building deletion (I *think*).

Also WRITES current buildings in the mission to the profile DB for persistence through
restarts.
=========================================================================================
*/

diag_log "VN MikeForce: Starting building state tracker";
["building_state_tracker", {call para_s_fnc_building_state_tracker}, [], 60] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
run: 'chopped trees'
=========================================================================================
Like `para_s_fnc_building_system_init`, but this is for any trees that were cut down
before a server restarts.

Important when players have built a FOB in an heavy forest area and they want to use it
again after a server restart!
=========================================================================================
*/

// Clear Trees
["GET", "chopped_trees", ""] call para_s_fnc_profile_db params ["","_chopped_trees"];
if !(_chopped_trees isEqualType "") then {
    {[_x] call para_s_fnc_fell_tree_initial;} forEach (_chopped_trees # 0);
};

/*
=========================================================================================
vars: `vc units`
=========================================================================================
TODO: Some of these are used in dead code (currently) --

    - `units_vc_officer` --> `fn_task_sec_kill_officer.sqf`
    - `units_vc_marksman` -- `fn_task_sec_clear_minefield.sqf`

We may want to reintroduce these tasks ^ at a later date somehow?
=========================================================================================
*/

//Example unit types. Should be made more dynamic as the gamemode progresses.
unit_civilian = "vn_c_men_20";
units_vc_basic = ["vn_o_men_vc_02","vn_o_men_vc_03","vn_o_men_vc_06", "vn_o_men_vc_12", "vn_o_men_vc_local_16", "vn_o_men_vc_local_12"];
units_vc_officer = ["vn_o_men_vc_01"];
units_vc_smg = ["vn_o_men_vc_06","vn_o_men_vc_05","vn_o_men_vc_04"];
units_vc_marksman = ["vn_o_men_vc_10", "vn_o_men_vc_local_10"];
units_vc_medic = ["vn_o_men_vc_08"];
units_vc_grenadier = ["vn_o_men_vc_07", "vn_o_men_nva_dc_07"];
units_vc_at = ["vn_o_men_vc_14", "vn_o_men_vc_local_28"];
units_vc_mg = ["vn_o_men_vc_11", "vn_o_men_vc_local_11"];

/*
=========================================================================================
vars: `sog units`
=========================================================================================
TODO: Dead code. Completely Unused.
=========================================================================================
*/

units_sog_teamleader = ["vn_b_men_sog_01", "vn_b_men_sog_13"];
units_sog_rto = ["vn_b_men_sog_02", "vn_b_men_sog_14"];
units_sog_medic = ["vn_b_men_sog_03", "vn_b_men_sog_15"];
units_sog_scout = ["vn_b_men_sog_09", "vn_b_men_sog_19"];
units_sog_grenadier = ["vn_b_men_sog_07", "vn_b_men_sog_11"];
units_sog_machinegunner = ["vn_b_men_sog_06", "vn_b_men_sog_16", "vn_b_men_sog_18"];

/*
=========================================================================================
vars: `mines`
=========================================================================================
TODO: Only used by dead code (currently) -- `fn_task_sec_clear_minefield.sqf`

We may want to re-implement this ^ later as some sort of support task.
=========================================================================================
*/

vehicles_nva_helis = ["vn_o_air_mi2_01_01"];
vehicles_nva_planes = [];
vehicles_vc_mortars = ["vn_o_vc_static_mortar_type63"];

/*
=========================================================================================
vars: `crates`
=========================================================================================
TODO: Only used by dead code (currently)

    - `fn_task_sec_destroy_supplies.sqf`
    - `fn_task_sec_destroy_emplacement.sqf`
    - `fn_task_sec_destroy_mortar.sqf`

We may want to re-implement these ^ later as some sort of support task.
=========================================================================================
*/

pavn_ammo_crate = "Land_vn_pavn_weapons_stack2";
aa_emplacement_build_crate = "Land_vn_pavn_weapons_stack3";

/*
=========================================================================================
vars: `mines`
=========================================================================================
TODO: Only used by dead code (currently) -- `fn_task_sec_clear_minefield.sqf`

We may want to re-implement this ^ later as some sort of support task.
=========================================================================================
*/

jungleTraps = [
    "vn_mine_punji_01",
    "vn_mine_punji_02",
    "vn_mine_punji_03"
];

enemyAPMines = [
    "vn_mine_tripwire_arty",
    "vn_mine_tripwire_m16_04",
    "vn_mine_tripwire_f1_04",
    "vn_mine_tripwire_f1_02"
];

enemyATMines = [
    "vn_mine_tm57"
];

friendlyAPMines = [
    "vn_mine_m16",
    "vn_mine_m14",
    "vn_mine_m18_range",
    "vn_mine_m18_x3_range"
];

friendlyATMines = [
    "vn_mine_m15"
];

/*
=========================================================================================
init: `vn_mf_fnc_stats_init`
=========================================================================================
Initialises

    - `player_health_stats` -- tracks things like hunger, thirst and any ailments in a
    paradigm scheduler job

    - `taskCompleted` event handler -- tracking how many tasks a player has completed of
    a specific type (used for player medals etc).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising stats";
[] call vn_mf_fnc_stats_init;

/*
=========================================================================================
init: `para_s_fnc_day_night_subsystem_init`
=========================================================================================
Set up the day/night cycle.

Set date here - it's as good a place as any. Day is just before a full moon, for good
night ops.
=========================================================================================
*/

[vn_mf_dawnLength, vn_mf_dayLength, vn_mf_duskLength, vn_mf_nightLength] call para_s_fnc_day_night_subsystem_init;

/*
=========================================================================================
init: `para_s_fnc_loadbal_subsystem_init`
=========================================================================================
Aggregates headless client FPSes into weighted arrays for use in the load AI balancer.

Essentially makes the game put new Paradigm AI groups on the Headless Client with the
highest average FPS (lowest current load).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Loadbalancer";
[] call para_s_fnc_loadbal_subsystem_init;

/*
=========================================================================================
init: `para_s_fnc_ai_obj_subsystem_init`
=========================================================================================
Start the Paradigm AI objective system. Depends on the load balancer subsystem.

Manages the various AI objectives for assigned units like: attack a position, defend a
position, set up ambush at position, patrol around a position(s) and pursue specific
player targets (tracker teams).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising AI Objectives";
[
    ["hardAiLimit", ["hard_ai_limit", 100] call BIS_fnc_getParamValue]
] call para_s_fnc_ai_obj_subsystem_init;

/*
=========================================================================================
init: `para_s_fnc_harass_subsystem_init`
=========================================================================================
Start harassment subsystem. Depends on the AI subsystem.

'Harassment' AI are the 'tracker teams' which dynamically spawn to chase down players and
make the mission feel a bit more alive veruss the standard -- 'go here, get in fight, go
there, get in another fight' gameplay loop.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Harass";
[] call para_s_fnc_harass_subsystem_init;

/*
=========================================================================================
init: `vn_mf_fnc_veh_asset_subsystem_init`
=========================================================================================
Start vehicle asset management subsystem. Sets up some public server-side variables and
stats the `vehicle_asset_manager` paradigm job for processing spawner behaviour.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Vehicle Manager";
[] call vn_mf_fnc_veh_asset_subsystem_init;

/*
=========================================================================================
init: `vn_mf_fnc_veh_create_detection_subsystem_init`
=========================================================================================
Start vehicle creation detection subsystem. TL;DR: Fires the `vehicleCreated` paradigm
event.

TODO: Not sure what this is used for? Do we actually need this? Seems to be Dead Code?
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Vehicle Creation Detection";
[] call vn_mf_fnc_veh_create_detection_subsystem_init;

/*
=========================================================================================
init: `para_g_fnc_ai_behaviour_subsystem_init`
=========================================================================================
TL;DR -- this is the heart of how Mike Force AI units 'do stuff'.

Start the AI behaviour subsystem. AI behaviour determines various group level settings
for AI based on what is currently happening in the field.

The objectives sets the base behaviour as 'orders'. So a 'patrol' objective will assign
the objective's AI groups the 'patrol' behaviour, making the AI groups walk from one
point to another, to another, etc.

During the course of running through the behaviour loop, AI groups can break out into
other behaviours, like moving from 'patrol' to 'attack' when they realise players are
nearby. The AI groups will run towards and start attacking the players, ignoring the
previous 'patrol' orders.

Other things this system does:

    - sets the groups speed, stance, awareness, etc. etc.

    - Pass messages between different AI groups about whether they're in combat or not
    (not-in-combat-yet AI groups can head off to investigate)

    - An extension of the above -- if the AI are in a mortar, they'll start sending
    rounds to the approximate position where the players were reported.

    - 'hold' logic for 'defend' AI objectives -- once the AI groups get bored of standing
    around at their objective to defned they will start patrolling around the location in
    a circle.

    - Tracks whether there are nearby statics that an AI unit could get into, and makes
    them get into the static weapons.

=========================================================================================
*/

diag_log "VN MikeForce: Initialising AI Behaviour";
[] call para_g_fnc_ai_behaviour_subsystem_init;

/*
=========================================================================================
run: `para_g_fnc_localize_slingloaded_objects` event handler
=========================================================================================
Sets up slingloaded item locality on helicopters.

I have no idea about sling loading. I'm a Spike Team main baby.
=========================================================================================
*/

["vehicleCreated", [
    {
        params ["_args", "_vehicle"];
        //Call it on every vehicle - it'll abort if it's not a helicopter.
        [_vehicle] call para_g_fnc_localize_slingloaded_objects;
    },
    []
]] call para_g_fnc_event_add_handler;

/*
=========================================================================================
init: `vn_mf_fnc_zones_init`
=========================================================================================
Initialise the zones in the world.

1. Sets up the public server variables for tracking the state of zones.

2. Sets the map markers for zones to appropriate color / brush (and adds the paradigm
map thing, sorry I can't remember the name of it right now).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Zones";
[] call vn_mf_fnc_zones_init;

/*
=========================================================================================
init: `vn_mf_fnc_sites_object_zfixer_init`
=========================================================================================
Stop objects created by the sites system from falling under terrain.

There are a variety of cases whereby objects spawned in, often with the sites system,
will fall through the world and be inaccessible to players.

This is a bit of a problem when the zone requires these objects be to be destroyed by
players to move to a new primary task. Basically... it creates a soft locked zone.

This is **especially** problematic when an Arty site spawns in on a rice paddy etc.
Even if the terrain objects are cleared away, apparently the terrain is actually lowered
by -0.1m or something, meaning mortars just drop through the world, falling forever and
never actually being destroyed.

So this system basically trackers all objects spawned in by the 'sites' system and checks
whether their ATL position's z-coordinate is less than 0.1. If it is, raise the object up
to a z-coord of 0.1.

It runs every 3 minutes to make sure we avoid the case where things are popping up in
front of players constantly.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Sites Object Z-Fixer";
[] call vn_mf_fnc_sites_object_zfixer_init;

/*
=========================================================================================
init: `vn_mf_fnc_sites_init`
=========================================================================================
Initialise sites - depends on `vn_mf_fnc_zones_init` and the paradigm AI objective
system. Probably a good idea to have the `sites_zfixer` system set up, but it's not a
hard requirement.

Starts the site system. Does not actually SPAWN the sites. Just starts the system which
will allow us to create sites with their compositions and then track their status over
time.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Sites";
[] call vn_mf_fnc_sites_init;

/*
=========================================================================================
init: `vn_mf_fnc_director_init`
=========================================================================================
Initialise the gameplay director - depends on `vn_mf_fnc_zones_init`

This is the heart of the main gameplay logic controlling what happens in zones and which
*tasks* are created when for each zone.

i.e. it triggers the `prepare_zone`, `capture_zone` and `defend_counterattack` tasks for
a zone in a specific way according to the state of the current zone.

Also triggers the next zone when a zone is completed (or picks the first zone if nothing
has been completed e.g. post server restart).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Gameplay Director";
[] call vn_mf_fnc_director_init;

/*
=========================================================================================
init: `vn_mf_fnc_arsenal_safe_zones_init`
=========================================================================================
Arsenal safe zones stop players from shooting each other at the arsenals.

Bullets get deleted within a 50m (?) radius of the relevant arsenals and a notification
sent to the player shooting to stop being a troll.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Safe Zones";
[] call vn_mf_fnc_arsenal_safe_zones_init;

/*
=========================================================================================
job: `veh_asset_respawner_job`
=========================================================================================
Initialise the vehicle respawner job. Handles vehicles being respawned on a vehicle spawn
point.

Depends on the `veh_asset_manager` job (no vehicles will spawn if it was not running).
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Respawn Scheduler";
["veh_asset_respawner_job", {call vn_mf_fnc_veh_asset_respawn_job}, [], 1] call para_g_fnc_scheduler_add_job;

/*
=========================================================================================
init: `vn_mf_fnc_init_performance_logging`
=========================================================================================
Initialises server side performance logging jobs for tracking server load, AI counts, AI
objectives etc.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Performance Logging";
[] call vn_mf_fnc_init_performance_logging;

/*
=========================================================================================
init: `para_c_fnc_dynamicGroups`
=========================================================================================
Sets up the paradigm dynamic groups system, which allows palyers to create and join
custom in-game groups.
=========================================================================================
*/

diag_log "VN MikeForce: Initialising Dynamic Groups";
["Initialize"] call para_c_fnc_dynamicGroups;

BIS_fnc_endMission = {};
BIS_fnc_endMissionServer = {};
