/*
    File: fn_emotes_emote_toggle.sqf
    Author: @dijksterhuis
    Public: No
    
    Description:
    	Toggle the player doing an animation from the wheel menu.

    	This is called client side.

    	May require remoteExec, but arma3 docs say `switchMove`,
    	`playMoveNow` and `playMove` all have global effect.

		https://community.bistudio.com/wiki/switchMove
    	https://community.bistudio.com/wiki/playMoveNow
    	https://community.bistudio.com/wiki/playMove
    
    Parameter(s):
		- _player: OBJECT: player we're going to animate
		- _method: STRING: enum indicating how we're going to activating 
			the emote animation
		- _emote: STRING | ARRAY[STRING]: the 1x animation we'll switch to,
			or the sequence of animations to add to the queue
    
    Returns:
	   	Nothing
    
    Example(s):
    	// make the player point upwards via `switchMove`
    	// generally only used when the animation causes a loop.
    	// hence the enum.
		[player, "loop", "Acts_Pointing_Up"] call vn_mf_fnc_emotes_emote_toggle;

		// animation for a carrier ATC player to tell an aircraft to slow down
		[
			player,
			"seq",
			[
				"Acts_JetsMarshallingSlow_in",
				"Acts_JetsMarshallingSlow_loop",
				"Acts_JetsMarshallingSlow_out"
			]
		] call vn_mf_fnc_emotes_emote_toggle;
*/

params ["_player", "_method", "_emote"];

// reset
_player switchMove "";

if (_method == "loop") exitWith {
	_player switchMove _emote;
};

if (_method == "play") exitWith {
	_player playMoveNow _emote;
};

if (_method == "seq") exitWith {
	if !(_emote isEqualType []) exitWith {false};
	_player switchMove (_emote select 0);
	_player playMoveNow (_emote select 0);
	private _emotes = +_emote;
	_emotes deleteAt 0;
	_emotes apply {_player playMove _x};
};