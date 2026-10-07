/*
	File: add_custom_keybinds.sqf
	Author: Bronation Development Team
	Public: Yes

	Description:
        Called from wherever the player is local in an init script
		Uses CBA addKeybind and lets you call into existing code or wrappers around them
        Useful for things like sling load interactions which are painful via the scrollmenu

		See: https://cbateam.github.io/CBA_A3/docs/files/keybinding/fnc_addKeybind-sqf.html

		Players can set their own keybinds replacing the defaults like any other addon.
		The part that really matters is _action (parameter two) been consistent

	Parameter(s):
		None

	Returns:
		None

	Example(s):
		[player] call vn_mf_fnc_literally_any_valild_function;
*/

// What category they appear in the keybindings menu
private _bro_nation_group_name = "Bro-nation Custom Keybinds";

[
	_bro_nation_group_name, 
	"bn_release_cargo", 
	["Release Sling Cargo", "Release all ASL cargo from the helicopter you are in"],
	{
		[player] call vn_mf_fnc_release_cargo_via_shortcut;
		false
	}, 
	{}, 
	[0xD2, [false, false, false]] // Default - Numpad Zero
] call CBA_fnc_addKeybind;

[
	_bro_nation_group_name,
	"bn_extend_ropes",
	["Extend Sling Ropes", "Extend all ASL ropes on the helicopter you are in"],
	{
		[player] call vn_mf_fnc_extend_ropes;
		false
	},
	{},
	    [0xCF, [false, false, false]]   // default: End
] call CBA_fnc_addKeybind;

[
	_bro_nation_group_name,
	"bn_shorten_ropes",
	["Shorten Sling Ropes", "Shorten all ASL ropes on the helicopter you are in"],
	{
		[player] call vn_mf_fnc_shorten_ropes;
		false
	},
	{},
	    [0xC7, [false, false, false]]   // default: Home
] call CBA_fnc_addKeybind;

[
    _bro_nation_group_name,
    "bn_deploy_1_ropes",
    ["Deploy 1 Sling Rope", "Deploy ASL ropes on the helicopter you are in"],
    {
        [player, 1] call vn_mf_fnc_deploy_helo_ropes;
        false
    },
    {},
    [0x02, [false, false, true]] // Left Alt + 1
] call CBA_fnc_addKeybind;

[
    _bro_nation_group_name,
    "bn_deploy_2_ropes",
    ["Deploy 2 Sling Ropes", "Deploy ASL ropes on the helicopter you are in"],
    {
        [player, 2] call vn_mf_fnc_deploy_helo_ropes;
        false
    },
    {},
    [0x03, [false, false, true]] // Left Alt + 2
] call CBA_fnc_addKeybind;

[
    _bro_nation_group_name,
    "bn_deploy_3_ropes",
    ["Deploy 3 Sling Ropes", "Deploy ASL ropes on the helicopter you are in"],
    {
        [player, 3] call vn_mf_fnc_deploy_helo_ropes;
        false
    },
    {},
    [0x04, [false, false, true]] // Left Alt + 3
] call CBA_fnc_addKeybind;

[
    _bro_nation_group_name,
    "bn_retract_and_release",
    ["Jettison & Retract", "Dumps payload if any and retracts all ropes in one go"],
    {
		systemChat "Dumping and retracting all ropes";
        [player, 3] call vn_mf_fnc_retract_all_ropes;
		

        false
    },
    {},
    [0x29, [false, false, true]] // Left Alt + `
] call CBA_fnc_addKeybind;

[
    _bro_nation_group_name,
    "bn_delete_bodies",
    ["Delete Vehicle Bodies", "Delete all dead bodies inside vehicle"],
    {
		systemChat "Deleting bodies from your vehicle";

        [player] remoteExecCall ["vn_mf_fnc_delete_dead_vehicle_occupants", 2];
		
        false
    },
    {},
    [0x12, [false, false, true]] // Left Alt + `
] call CBA_fnc_addKeybind;