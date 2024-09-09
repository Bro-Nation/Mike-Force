/*
	File: fn_attach_vest_flashlight.sqf
	Author: Savage Game Design
	Public: No

	Description:

        Does the heavy lifting.

        Attachs a flashlight and a light source to the player.

        Execute this on the server as we need to remoteExecs to other players
        for the light sources to sync up.

	Parameter(s):
        _player - Player we will be attaching to
        _classname - Flashlight class name (tells us the color)

	Returns: nothing

	Example(s): none
*/

params ["_player", "_classname"];

private _colorAmbient = [0, 0, 0];
private _colorLight = [0, 0, 0];
private _vectorDir = [0.555, -1, -0.3];

// the classnames when flashlights are in player inventories cannot be used with
// createVehicle because they do not refer to "AI units"

// create a standard flashlight vehicle, then we'll build a coloured light source
// based on the true classname
private _flashlight = "vn_b_item_mx991_01" createVehicle (_player modelToWorld [0, 0, 0]); 
_flashlight attachTo [_player,  [0.05, 0.1, -0.1], "LeftShoulder", true];
_flashlight setVectorDirAndUp [_vectorDir, [0, -0.1, 0.8]];

private _lightsource = "#lightreflector" createVehicle (_player modelToWorld [0, 0, 0]); 
_lightsource attachTo [_player,  [-0.015, 0.125, 0.09], "LeftShoulder", true];
_lightsource setPosWorld getPosWorld _lightsource;

// execute globally so all players and AI etc can see the light sources
// jip executed to ensure joining players also get the attached light source
private _jipId = [_player] call vn_mf_fnc_attachments_global_get_jip_id;

[_lightsource, _classname, _vectorDir] remoteExec [
    "vn_mf_fnc_attachments_lightsources_flashlight", -2, _jipId
];
