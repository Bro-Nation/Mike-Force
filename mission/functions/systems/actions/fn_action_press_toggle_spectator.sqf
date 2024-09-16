/*
	File: fn_action_press_toggle_spectator.sqf
	Author: 'DJ' Dijksterhuis
	Public: No
	
	Description:
		Press Corp members can enter (and exit!) spectator mode.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_press_toggle_spectator;
*/

// TODO: Do we grant moderators access to this instead of zeus?

private _conditionToShow = [
	"((player getVariable ['vn_mf_db_player_group', 'MikeForce']) isEqualTo 'PressCorp')",
	"((player distance2D (getMarkerPos 'mf_respawn_presscorp')) < 25)"
] joinString "&&";

player addAction
[
	format [
		"<t color='#0663A1' size='0.85' font='tt2020base_vn_bold'>%1</t>",
		"[PRESSCORP] Spectate"
	],  // title
	{
		params ["_target", "_caller", "_actionId", "_arguments"];

		// disable HUD to remove paradigm UI elements
		// if `hud_enabled` is not set assume the hud is enabled
		// (player probably hasn't used the keybind yet)
		if (player getVariable ["hud_enabled", true]) then {
			[] call vn_mf_fnc_ui_hud_toggle;
		};

		// hide the player and disable simulation
		player enableSimulationGlobal false;
		player hideObjectGlobal true;

		// start the spectator mode
		player setVariable ["vn_mf_press_close_spectator", false];
		["Initialize", [player, [west]]] call BIS_fnc_EGSpectator;

		// set up a spawn running a loop every 0.5 seconds checking whether
		// the player wants to close the spectator interface.
		// if so, renable simulation, renable the HUD, close spectator mode
		// and remove the above event handler
		[player] spawn {
			params ["_player"];

			// create an event handler that checks for the ZERO key being pressed
			// when pressed, set a variable on the player indicating we need to close the UI

			private _eh = (findDisplay 60492) displayAddEventHandler ["KeyDown", {
				params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
				// ESCAPE key is key 1
				if (_key isEqualTo 1) exitWith {
					// this is using `player` on purpose!
					// the `_player` variable does not exist in the event handler's scope!
					player setVariable ["vn_mf_press_close_spectator", true];
					true;
				};
			}];

			// wait until the player has pressed the key to exit spectator mode
			while {!(_player getVariable ["vn_mf_press_close_spectator", false])} do {
				sleep 0.5;
			};

			// reset everything
			_player enableSimulationGlobal true;
			_player hideObjectGlobal false;
			[] call vn_mf_fnc_ui_hud_toggle;

			// remove the display's event handler then exit out of spectator mode
			(findDisplay 60492) displayRemoveEventHandler ["KeyDown", _eh];
			["Terminate"] call BIS_fnc_EGSpectator;

		};
	},  // script
	nil,  // arguments
	-10,  // priority
	true,  // showWindow
	true,  // hideOnUse
	"",  // shortcut
	_conditionToShow,
	1,  // radius
	false,  // unconscious
	"",  // selection
	""  // memoryPoint
];
