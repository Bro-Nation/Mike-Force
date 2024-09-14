/*
	File: para_player_preload_client.sqf
	Author: Savage Game Design
	Public: Yes
	
	Description:
		Called on the client once the player has joined the game.
		Called *before* the player is ready to be initialised.
		DO NOT ACCESS `player` OR OTHERWISE SET THINGS UP IN THIS FUNCTION

		This is exists to do very early setup on the client.
		For example, setting global variables, accessing the UI/loading screens.
		DO NOT ACCESS THE PLAYER OBJECT.

		Load order:
			- para_player_preload_client.sqf - Called as soon as possible on the client.
			- para_player_loaded_client.sqf - Called on client as soon as the player is ready
			- para_player_init_server.sqf - Serverside player initialisation.
			- para_player_init_client.sqf - Clientside player initialisation.
			- para_player_postinit_server.sqf - Called on server once all player initialisation is done.
	
	Parameter(s):
		None
	
	Returns:
		None
	
	Example(s):
		//In description.ext
		use_paradigm_init = 1;
*/

//Give the player a black screen while the loading happens.
cutText ["", "BLACK FADED", 0, false];
//Disable their sound.
0 fadeSound 0;
//Play some intro music
0 fadeMusic 0;
playMusic selectRandom [
	"vn_trippin",
	"vn_up_here_looking_down",
	"vn_drafted",
	"vn_unsung_heroes",
	"vn_blues_for_suzy",
	"vn_voodoo_girl",
	"vn_tequila_highway",
	"vn_there_it_is",
	"vn_kitty_bar_blues",
	"vn_fire_in_the_sky",
	"vn_freedom_bird",
	"vn_dont_cry_baby"
];
4 fadeMusic 1;

/*
force enable hud here, not in description.ext otherwise players cannot toggle HUD in game

> Since Arma 3 v1.50 there is a Description.ext's showHUD[] array param that is identical
> in format to the extended showHUD command.
>
> When present, it will disable showHUD command entirely, allowing mission makers to
> permanently alter visibility of some HUD elements.
>
> https://community.bistudio.com/wiki/showHUD

*/
showHUD [
	true,	// Scripted HUD (same as showHUD command)
	true,	// Vehicle + soldier info
	true,	// Vehicle radar
	true,	// Vehicle compass
	true,	// Tank direction indicator
	true,	// Commanding menu
	true,	// Group Bar
	true,	// HUD Weapon Cursors
	true,	// Vehicle display panels
	true,	// System chat kill notifications
	false	// Draw3D
];
