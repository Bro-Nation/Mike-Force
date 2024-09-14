/*
	File: para_player_init_client.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Called on the client after player_init_server has finished.
		Serverside player initialisation is done at this point.
		It is safe to access the player object in this function.
		Used for setting up UI elements, local event handlers, etc.

		Load order:
			- para_player_preload_client.sqf - Called as soon as possible on the client.
			- para_player_loaded_client.sqf - Called on client as soon as the player is ready
			- para_player_init_server.sqf - Serverside player initialisation.
			- para_player_init_client.sqf - Clientside player initialisation.
			- para_player_postinit_server.sqf - Called on server once all player initialisation is done.

	Parameter(s):
		_player - Player to initialise [OBJECT]
		_didJIP - Whether the player joined in progress [BOOLEAN]

	Returns:
		None

	Example(s):
		//description.ext
		use_paradigm_init = 1;
*/

private _transitionsTotal = count (
	((preprocessFile "para_player_init_client.sqf") splitString ";") select {"call _fnc_tick_loading_screen" in _x}
);

private _loadingTickProgress = 0;
private _img = "welcomeBasic";

private _fnc_tick_loading_screen = {
	params ["_loadingTicks"];

	/*

	This function is called to progress the loading screen at various points while player client is init'd.

	tl;dr --
	- steps the progress bar on screen based on total progress
	- changes the displayed text
		- random string contents selection
		- random text colour selection
		- text size (based on progress -- bigger text as progress bar increases)
	- switches the image after 33% / 66% loaded

	*/

	_loadingTicks = _loadingTicks + 1;
	private _progress = _loadingTicks / (_transitionsTotal + 1);

	progressLoadingScreen _progress;

	// this logic is a bit nasty -- we really need to track progression through a DAG.
	// but hackiness is fine for the moment. i could spend time working out a better 
	// way of organising this code, but it's really not that big of a deal right now.
	if (_progress > 0.3333 && !(_img in ["patreonBasic", "patreonSupporters"])) then {
		[getText (missionConfigFile >> "gamemode" >> "loadingScreens" >> "patreonBasic"), 5002] call vn_mf_fnc_update_loading_screen;
		_img = "patreonBasic";
	};
	if (_progress > 0.6666 && !(_img in ["patreonSupporters"])) then {
		[getText (missionConfigFile >> "gamemode" >> "loadingScreens" >> "patreonSupporters"), 5002] call vn_mf_fnc_update_loading_screen;
		_img = "patreonSupporters";
	};

	private _loadingText = selectRandom [
		"STR_vn_mf_loading1",
		"STR_vn_mf_loading2",
		"STR_vn_mf_loading3",
		"STR_vn_mf_loading4",
		"STR_vn_mf_loading5",
		"STR_vn_mf_loading6",
		"STR_vn_mf_loading7",
		"STR_vn_mf_loading8",
		"STR_vn_mf_loading9",
		"STR_vn_mf_loading10",
		"STR_vn_mf_loading11",
		"STR_vn_mf_loading12",
		"STR_vn_mf_loading13",
		"STR_vn_mf_loading14",
		"STR_vn_mf_loading15",
		"STR_vn_mf_loading16",
		"STR_vn_mf_loading17"
	];

	private _textSize = 0.5 + _progress;
	private _textColour = selectRandom [
		"#4C563F",
		"#ECA80D",
		"#C5C5C5",
		"#808080",
		"#FF7705"
	];

	[
		parseText format [
			"<t size='%1' font='tt2020base_vn' color='%2'>%3</t>",
			1.33,
			_textColour,
			localize _loadingText
		]
	] call vn_mf_fnc_update_loading_screen;
	uiSleep 0.45;

	_loadingTicks
};

params ["_player", "_didJIP"];

_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

player createDiaryRecord ["Diary", [localize "STR_vn_mf_howtobuild", localize "STR_vn_mf_howtobuild_long"], taskNull, "", false];
player createDiaryRecord ["Diary", [localize "STR_vn_mf_other_keys", localize "STR_vn_mf_other_keys_long"], taskNull, "", false];

// Instantiate the main scheduler
[] call para_g_fnc_scheduler_subsystem_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

call para_g_fnc_event_subsystem_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

//Read pow cage locations and populate arrays 
call vn_mf_fnc_pow_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// add display event handlers
call para_c_fnc_init_display_event_handler;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// add player event handlers
call para_c_fnc_init_player_event_handlers;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

call vn_mf_fnc_active_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// @dijksterhuis: we should only need to call this once? -- when the player joins?
// only reason to keep adding actions after attach to player would be if the actions
// are removed from player object.
call vn_mf_fnc_action_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;
// ["action_manager", vn_mf_fnc_action_init, [], 5] call para_g_fnc_scheduler_add_job;

// Set up arsenal clean up trash cans.
call vn_mf_fnc_arsenal_trash_cleanup_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// create UI
0 spawn vn_mf_fnc_ui_create;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// master loop
0 spawn para_c_fnc_compiled_loop_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

private _lastTeamName = player getVariable ["vn_mf_db_player_group", "MikeForce"];
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

private _respawnMarker = format ["mf_respawn_%1", _lastTeamName]; 
if (side player == east) then 
{
	_respawnMarker = format ["mf_dc_respawn_%1", _lastTeamName]; 
};
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

if (_lastTeamName == "SatansAngels" && toLower(worldName) in ["cam_lao_nam"]) then {
	player setPosATL [20152.6,67.6535,123.54];
} else {
	player setPos getMarkerPos _respawnMarker;
};
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

//Setup teleporters
call vn_mf_fnc_action_teleport;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// apply health effects
call vn_mf_fnc_health_effects;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

private _respawnDelay = ["respawn_delay", 20] call BIS_fnc_getParamValue;
setplayerrespawntime _respawnDelay;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// Start player marker subsystem
private _useMarkers = (["allow_map_markers", 1] call BIS_fnc_getParamValue) > 0;
if (_useMarkers) then {
	call vn_mf_fnc_player_markers_subsystem_init;
};
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// Initalize marker info UI
[] call para_c_fnc_zone_marker_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// Start AI processing for local player, if we're not a LAN server (as then serverside processing will kick in)
if (!isServer) then {
	call para_g_fnc_ai_create_behaviour_execution_loop;
};
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// Set up automatic view distance scaling for performance
[] call para_c_fnc_perf_enable_dynamic_view_distance;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// starting rank
vn_mf_starting_rank = player getVariable ["vn_mf_db_rank",0];

// init awards array
vn_mf_default_awards = [];
{
    vn_mf_default_awards pushBack [configName _x, -1];
} forEach ("isClass(_x)" configClasses (missionConfigFile >> "gamemode" >> "awards_config"));
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

// initialize tools controller
call para_c_fnc_tool_controller_init;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

//call vn_mf_fnc_admin_arsenal;

// This is used for showing values of food and water in the arsenal
call vn_mf_fnc_enable_arsenal_food_drink_overlay;
_loadingTickProgress = [_loadingTickProgress] call _fnc_tick_loading_screen;

//LOADING COMPLETE
//Start tidying up ready for play.

enableEnvironment [false, true];

// end loading screen
progressLoadingScreen 1;
endLoadingScreen;

// Fade in
cutText ["", "BLACK IN", 4];
// Bring sound back to normal
4 fadeSound 1;
// Fade out the music
8 fadeMusic 0;
// Restore the music volume in the near future.
[] spawn {sleep 8; playMusic ""; 2 fadeMusic 1};

"vn_holdActionAdd_layer" cutText ["","PLAIN"];

[] spawn
{
	while {true} do
	{
		uiSleep 0.5;
		[] call para_c_fnc_set_aperture_based_on_light_level;
	};
};

[] spawn
{
	uiSleep 1;
	private _version = getText(missionConfigFile >> "version");
	private _lastVersion = (["GET", "last_version", ""] call para_s_fnc_profile_db) select 1;
	//Open welcome screen for new players
	private _welcomeScreenEnabled = ["para_enableWelcomeScreen"] call para_c_fnc_optionsMenu_getValue;
	private _versionHasChanged = _lastVersion == "" || _lastVersion != _version;

	if (_versionHasChanged) then {
		// TODO: Add a button in the task roster?
		// createDialog "para_ChangelogScreen";
		["SET", "last_version", _version] call para_s_fnc_profile_db;
	};

	if (_welcomeScreenEnabled) exitWith {

		// createDialog "para_WelcomeScreen";

		// show task roster instead of the default Mike Force welcome screen
		// initial page has more relevant information for Bro Nation.
		createDialog "vn_tr_disp_taskRoster_Main";

		// hint to players about disabling the task roster automatically showing on server join
		hintSilent parseText
		(
			[
				"<t align='left' size='1.3'>How To Disable Task Roster Menu on Server Join</t><br/><br/>",
				"<t align='left'>1. Press ESCAPE to open the pause menu.</t><br/>",
				"<t align='left'>2. Click on GAMEMODE OPTIONS (top left).</t><br/>",
				"<t align='left'>3. Untick the 'Show Welcome screen' option.</t><br/>",
				"<t align='left'>4. Click 'OK'.</t><br/>"
			] joinString ""
		);

		// hints do not disappear when other UI elements are open.
		// their default 30 second timer gets paused.
		[] spawn {
			sleep 10;
			hintSilent "";
		};
	};
};

// Re-enable simulation
if (typeOf player != "VirtualCurator_F") then {
	player enableSimulation true;
};

//enabling and setting stamina
if(vn_mf_param_enable_stamina == false) then{
    player enableStamina false;
}
else{
    player enableStamina true;
	switch (vn_mf_param_set_stamina) do
	{
		case 0: {setStaminaScheme "Normal"};
		case 1: {setStaminaScheme "Default"};
		case 2: {setStaminaScheme "FastDrain"};
		case 3: {setStaminaScheme "Exhausted"};
	};
};

// Marker Discovery
// @dijksterhuis: Disabled in favour of radio wiretap feature.
// [] call vn_mf_fnc_sites_subsystem_client_init;

// Tutorial System
[] call vn_mf_fnc_tutorial_subsystem_client_init;


//Add Master Arm addAction for Boats and Land Vehicles
if hasInterface then
{
    // Remove action to re-add it later
    private _old_action_id = player getVariable ["vn_mf_masterarm_action_id", -1];
    if (_old_action_id > -1) then { player removeAction _old_action_id; player setVariable ["vn_mf_masterarm_action_id", -1]; };

    private _action =
    [
        localize "STR_VN_MASTER_ARM_OPEN_ACTION",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            ["init"] call VN_fnc_masterarm;
        },
        [],
        -100,
        true,
        true,
        "",
        toString {
            private _vehicle = vehicle _this;
            local _vehicle && {
                !(_vehicle isKindOf 'Air' || _vehicle isKindOf 'Man') && {
                    speed _vehicle <= 5 && {
                        driver _vehicle == _this && {vn_fnc_masterarm_action_objects findif {(_vehicle distance _x) < 25} > -1}
                    }
                }
            }
        },
        25
    ];

    if (player getVariable ["vn_mf_masterarm_action_id", -1] <= -1) then
    {
        private _action_id = player addAction _action;
        player setVariable ["vn_mf_masterarm_action_id",_action_id];
    };

    private _vn_action = player getVariable ["vn_mf_masterarm_event_respawn",-1];
    if (_vn_action <= -1) then
    {
        private _retun = player addEventHandler ["Respawn",
            {
            _this spawn
            {
                params ["_unit", "_corpse"];

                waitUntil {player == _unit};

                _corpse removeAction (_corpse getVariable ["vn_mf_masterarm_action_id", -1]);
                _corpse setVariable ["vn_mf_masterarm_action_id", -1];

                // Add new actions to player
                [] spawn vn_fnc_masterarm_actions;
            };
            }];
        player setVariable ["vn_mf_masterarm_event_respawn",_retun];
    };
};

//DEV (ToDo): Until client Scheduler is added:
[]spawn
{
	"para_infopanel" cutRsc ["para_infopanel", "PLAIN", -1, true];
	while{true}do
	{
		uisleep 0.5;
		[] call para_c_fnc_infopanel_handler;
	};
};

["InitializePlayer", [player]] call para_c_fnc_dynamicGroups;

// display location + current game time
call vn_mf_fnc_display_location_time;

// monitor "life" of attached light source objects on a player
// sends a warning when about to run out, and then removes them
call vn_mf_fnc_attachments_client_battery_monitor_init;

// initialise the emotes wheel menu
[player] call vn_mf_fnc_emotes_init;
