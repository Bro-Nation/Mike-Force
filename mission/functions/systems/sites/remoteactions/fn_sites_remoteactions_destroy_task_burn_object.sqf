/*
	File: fn_action_destroy_task.sqf
	Author: Cerebral
	Modified: @dijksterhuis
	Public: No
	
	Description:
		Client-side create and modify the light/particle sources
		for setting tents on fire at campsites.
	
	Parameter(s):
		- _task -- the object the is going to be set on fire
		- _delay -- how long we wait to delete the object
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_action_destroy_task;
*/

params ["_task", ["_delay", 10]];

[_task, _delay] spawn {
	scriptName "vn_mf_bn_client_burn_shelter";
	params ["_task", "_delay"];

	// Light
	private _light = "#lightpoint" createVehicleLocal getpos _task; 
	// Fire 1 (orange base)
	private _fire1 = "#particlesource" createVehicleLocal getpos _task;
	// fire 2 (red top part)
	private _fire2 = "#particlesource" createVehicleLocal getpos _task;
	// Smoke part 1
	private _smoke1 = "#particlesource" createVehicleLocal getpos _task;
	// Smoke part 2
	private _smoke2 = "#particlesource" createVehicleLocal getpos _task;

	_light setLightDayLight true; 
	_light setLightColor [5, 2.5, 0]; 
	_light setLightBrightness 0.1; 
	_light setLightAmbient [5, 2.5, 0]; 
	_light lightAttachObject [_task, [0, 0, 0]]; 
	_light setLightAttenuation [3, 0, 0, 0.6]; 

	_fire1 setParticleParams [ 
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard", 
	0, 1, [0, 0, -0.5], [0, 0, 1], 1, 1, 0.9, 0.3, [01], 
	[[1,1,1,-2],[1,1,1,0]], 
	[0.2, 0.1, 0.1], 0, 0, "", "", _fire1, rad -45]; 
	_fire1 setParticleRandom [0.05, [0, 0, 0], [1, 1, 0], 1, 0.5, [0,0,0,0], 1, 0]; 
	_fire1 setDropInterval 0.03; 
	// damages players standing on the fire
	_fire1 setParticleFire [1, 1, 0.1]; 

	_fire2 setParticleParams [ 
	["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 10, 32], "", "Billboard", 
	0, 1, [0, 0, 0.5], [0, 0, 0.25], 1, 1, 0.9, 0.3, [1, 1, 0.75, 0.5], 
	[[1,1,1, 0.0], [1,1,1, 0.3], [1,1,1, 0.0], [1,1,1, 1.0]], 
	[0.4, 0.3, 0.2, 0.1], 0, 0, "", "", _fire2, rad -45]; 
	_fire2 setParticleRandom [0.1, [0.5, 0.5, 0], [1, 1, 0], 1, 0, [0,0,0,0], 1, 0]; 
	_fire2 setDropInterval 0.03; 

	_smoke1 setParticleParams [
		["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 1], "", "Billboard",
		1, 10, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10],
		[[0.3, 0.3, 0.3, 0.33], [0.4, 0.4, 0.4, 0.33], [0.2, 0.2, 0, 0]],
		[0, 1], 1, 0, "", "", _smoke1];
	_smoke1 setParticleRandom [0, [0, 0, 0], [0.33, 0.33, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
	_smoke1 setDropInterval 0.5;

	private _timer = 0;
	private _previousValue = 0.9;
  	
  	/*
  	make everything look a bit more realisitc

  	randomise over the course of the delay period ...
  	- the light source attentuation
  	- the size of the flames
  	- the color of the flames
  	*/

  	while {_timer <= (_delay / 0.05)} do {
  
		private _r = selectRandom [1, -1];
		_light setLightAttenuation [0, 0, 0, _previousValue  + (_r * 0.05)];
		_fire1 setParticleRandom [0.05, [0, 0, 0], [1, 1, 0], 1, 0.5 + (_r * 0.1), [(_r * 0.5),(_r * 0.1),0,0], 1, 0]; 
		_fire2 setParticleRandom [0.05, [0, 0, 0], [1, 1, 0], 1, 0.5 + (_r * 0.25), [(_r * 0.5),(_r * 0.1),0,0], 1, 0]; 

		sleep 0.05;
		_timer = _timer + 1;
	};
 
 	/*
 	the 'task' or shelter needs to be deleted server-side after the delay period is finished.
 	this guarantees that it deletes and that clients don't try to delete it multiple times.

 	everything else we can delete client side
 	*/
 	lightDetachObject _light;
	deleteVehicle _light;
	deleteVehicle _fire1;
	sleep 0.6;
	deleteVehicle _fire2;
	deleteVehicle _smoke1;
};