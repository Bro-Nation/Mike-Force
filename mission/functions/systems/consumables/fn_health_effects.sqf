/*
    File: fn_health_effects.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Sets health stats based effects on player.

    Parameter(s): none

    Returns: nothing

    Example(s):
		call vn_mf_fnc_health_effects;
*/

private _fnc_fade_inout_to_color = {
	params [["_color", "BLACK"], ["_fadeDuration", 1 + random 1]];
	[_color, _fadeDuration] spawn {
		params ["_colorS", "_fadeDurationS"];
		[0, _colorS, _fadeDurationS, 1] spawn BIS_fnc_fadeEffect;
		uiSleep _fadeDurationS + 0.1;
		[1, _colorS, _fadeDurationS, 1] spawn BIS_fnc_fadeEffect;
	};

};

private _fnc_get_or_create_vfx_handler = {
	params ["_vfxName", "_vfxCreateArgs"];

	private _vfxHandlersHashMap = player getVariable ["vn_mf_bn_vfx_handles", createHashMap];

	if !(_vfxName in _vfxHandlersHashMap) then {
		_vfxHandlersHashMap set [_vfxName, ppEffectCreate _vfxCreateArgs];
		diag_log format ["Created VFX PostProcessing Handlers for %1: %2", _vfxName, _vfxHandlersHashMap get _vfxName];
	};

	player setVariable ["vn_mf_bn_vfx_handles", _vfxHandlersHashMap];

	_vfxHandlersHashMap getOrDefault [_vfxName, -1]
};

private _fnc_delete_vfx_handlers = {
	params [["_vfxHandlerNamesArr", []]];
	private _vfxHandlersHashMap = player getVariable ["vn_mf_bn_vfx_handles", createHashMap];
	_vfxHandlerNamesArr apply {
		if (_x in _vfxHandlersHashMap) then {
			diag_log format ["Deleting VFX PostProcessing Handler: %1", _x];
			(_vfxHandlersHashMap get _x) ppEffectEnable false;
			ppEffectDestroy (_vfxHandlersHashMap get _x);
			_vfxHandlersHashMap deleteAt _x;
		};
	};

	player setVariable ["vn_mf_bn_vfx_handles", _vfxHandlersHashMap];
};



private _stamina_scheme = "Default";

///////////////////////////////////////////////////////////////////////////////////////////
// THIRSTY ////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

// start player whiting out and getting dizzy -- simulate headache from thirst
if ((player getVariable ["vn_mf_db_thirst", 1]) <= 0.25) then {

	private _blurValue = 0.5 - (player getVariable ["vn_mf_db_thirst", 1]);

  private _blur = ["ThirstBlur", ["dynamicBlur", 397]] call _fnc_get_or_create_vfx_handler;
  _blur ppEffectEnable true;
  _blur ppEffectAdjust [random _blurValue];
  _blur ppEffectCommit 1 + random 1;

} else {
	[["ThirstBlur"]] call _fnc_delete_vfx_handlers;
};

// disable sprinting if player is out of thirst stat
if (player getVariable ["vn_mf_db_thirst", 1] isEqualTo 0) then
{
	if (random 1 < 0.15) then {["WHITE"] call _fnc_fade_inout_to_color};
	_stamina_scheme = "FastDrain";
	player allowSprint false;
}
else
{
	player allowSprint true;
};

///////////////////////////////////////////////////////////////////////////////////////////
// HUNGRY /////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

// start player blacking out -- simulate tiredness
if ((player getVariable ["vn_mf_db_hunger", 1]) <= 0.25) then {
	private _blurValue = 0.25 - (player getVariable ["vn_mf_db_hunger", 1]);
	private _blur = ["HungerBlur", ["dynamicBlur", 398]] call _fnc_get_or_create_vfx_handler;
  _blur ppEffectEnable true;
  _blur ppEffectAdjust [(random _blurValue) / 2];
  _blur ppEffectCommit 1 + random 1;

} else {
	[["HungerBlur"]] call _fnc_delete_vfx_handlers;
};

// force walk if player is out of hunger stat
if (player getVariable ["vn_mf_db_hunger", 1] isEqualTo 0) then
{
	_stamina_scheme = "Exhausted";
	player forceWalk true;
	if (random 1 < 0.2) then {["BLACK"] call _fnc_fade_inout_to_color};
}
else
{
	player forceWalk false;
};

///////////////////////////////////////////////////////////////////////////////////////////
// SICK ///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

// disable sprinting if player has medical condition (attributes) eg. poison or diarrhea
if (count (player getVariable ["vn_mf_db_attributes", []]) isEqualto 0) then
{
  player allowSprint true;
   private _blur = ["SickBlur", ["dynamicBlur", 396]] call _fnc_get_or_create_vfx_handler;
  _blur ppEffectEnable true;
  _blur ppEffectAdjust [random 0.7];
  _blur ppEffectCommit 1 + random 1;
}
else
{
  _stamina_scheme = "Exhausted";
  player allowSprint false;
  [["SickBlur"]] call _fnc_delete_vfx_handlers;
};

///////////////////////////////////////////////////////////////////////////////////////////
// DRUNK //////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

if (count ((player getVariable ["vn_mf_db_attributes", []]) select {_x isEqualto "alcohol"}) > 0) then
{

	// camera shake

	if (random 1 < 0.2) then {
		addCamShake [10 + random 10, 100000, 0.1 + random 1];
	};

	// randomly make the player model move around to simulate losing balance

	if (random 1 < 0.1) then {
		private _action = selectRandom [
			"WalkF",
			"WalkB",
			"WalkL",
			"WalkLB",
			"WalkLF",
			"WalkR",
			"WalkRB",
			"WalkRF"
		];
		player playAction _action;
	};

	/*
	// randomly drop weapon
	// the weapon holder is a bit buggy and hard for players to find
	if (random 1 < 0.01) then {

		private _weaponToDrop = selectRandom [
			primaryWeapon player,
			secondaryWeapon player,
			handgunWeapon player
		];

		// TODO: Server side exec probably needed
		private _weaponHolder = "GroundWeaponHolder_Scripted" createVehicle getPos player;
		player action ["DropWeapon", _weaponHolder, _weaponToDrop];
	};
	*/

	// alter post process VFX

	private _chrom = ["DrunkChrom", ["ChromAberration", 198]] call _fnc_get_or_create_vfx_handler;
  _chrom ppEffectAdjust [random 0.05, random 0.05, false];

  private _blur = ["DrunkBlur", ["dynamicBlur", 197]] call _fnc_get_or_create_vfx_handler;
  _blur ppEffectAdjust [0.1 + random 1.5];

  [_chrom, _blur] ppEffectEnable true;
  [_chrom, _blur] ppEffectCommit 3 + random 2;

  // randomly fade to black

	if (random 1 < 0.05) then {
		["BLACK", 3 + random 3] call _fnc_fade_inout_to_color;
	};

}
else
{
	[["DrunkBlur", "DrunkChrom"]] call _fnc_delete_vfx_handlers;
  resetCamShake;
};

setStaminaScheme _stamina_scheme;
