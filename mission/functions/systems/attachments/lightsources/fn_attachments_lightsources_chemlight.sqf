/*
    File: fn_attachments_lightsources_chemlight.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Sets up the two lightsources we'll use for making chemlights useful
        instead of completely blinding to player.

        Needs to be remote Exec'd on all clients to get them to see the lights properly.

    Parameter(s):
        _lightSources - The two light source vehicles we'll be modifying. 
                        **Must** have been created on the server with createVehicle.
        _classname - Chemlight class name (tells us the color)

    Returns: nothing
    Example(s): cba
*/

params ["_lightSources", "_classname"];

if !((count _lightSources) isEqualTo 2) exitWith {
  diag_log format ["ERROR: Attachments: chemlights need two lightsource attachments! lightSources=%1", _lightSources];
};

private _colorAmbient = [0, 0, 0];
private _colorLight = [0, 0, 0];

switch (true) do { 
  case ((toLower _classname) find "green" > -1) : {
    _colorAmbient = [0, 0.3, 0];
    _colorLight = [0, 1, 0];
  }; 
  case ((toLower _classname) find "blue" > -1) : {
    _colorAmbient = [0, 0.3, 0.3];
    _colorLight = [0, 0.5, 1];
  };
  case ((toLower _classname) find "yellow" > -1) : {
    _colorAmbient = [0.3, 0.3, 0];
    _colorLight = [1, 1, 0];
  };
  case ((toLower _classname) find "red" > -1) : {
    _colorAmbient = [0.3, 0, 0];
    _colorLight = [1, 0, 0];
  };
  default {
  	// black (no light)
    _colorAmbient = [0, 0, 0];
    _colorLight = [0, 0, 0];
  };
};

// very dim light 270 degrees around front of player extending out about 10-20m
// meant to be an "aura" of light emitted from player's chemlight lighting up the
// general vicinity
private _lightSourceOne = _lightSources select 0;
_lightSourceOne setLightIntensity 900;
_lightSourceOne setLightAmbient _colorAmbient;
_lightSourceOne setLightColor _colorLight;
_lightSourceOne setLightConePars [270, 2, 0.75];
_lightSourceOne setLightAttenuation [0, 50, 4, 3, 0, 15];

// light up the area directly in front of the player
// simulate the chemlight's light landing on ground in front of player
// (arma just spams 360 of light from chemlights)
private _lightSourceTwo = _lightSources select 1;
_lightSourceTwo setLightIntensity 900;
_lightSourceTwo setLightAmbient _colorAmbient;
_lightSourceTwo setLightColor _colorLight;
_lightSourceTwo setLightConePars [180, 30, 20];

nil;