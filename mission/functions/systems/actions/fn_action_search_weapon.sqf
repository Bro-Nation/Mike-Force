/*
	File: fn_action_search_weapon.sqf
	Author: tylervip
	Public: No

	Description:
		Adds a hold action to search a nearby cage for a weapon.
		30% chance to find something. Of that, 1% chance it is a gun, otherwise a knife.

	Parameter(s): none

	Returns:
		action id index [Number]

	Example(s):
		call vn_mf_fnc_action_search_weapon;
*/

private _actionText = "Search for Weapon";
private _actionIdleIcon = "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa";
private _actionProgressIcon = _actionIdleIcon;

private _conditionToShow = "!([player] call vn_fnc_revive_incap) && ((primaryWeapon player) isEqualTo '') && ((handgunWeapon player) isEqualTo '') && ((secondaryWeapon player) isEqualTo '') && ({ private _n = toLower (vehicleVarName _x); (_n find 'vn_mf_capture' == 0) || (_n find 'vn_dc_capture' == 0) } count (nearestObjects [player, [], 1, false]) > 0)";
private _conditionToProgress = _conditionToShow;

private _codeOnStart = {
	[player, "AinvPknlMstpSnonWrflDr_medic3_old"] remoteExecCall ["switchMove", -2];
};

private _codeOnTick = {};

private _codeOnComplete = {
	if (random 1 < 0.3) then {
        if (random 1 < 0.01) then {
            player addWeapon "vn_m1911";
            hint "You found a gun!";
            sleep 1;
            hint "";
        } else {
            player addWeapon "vn_m_fighting_knife_01";
            hint "You found a knife!";
            sleep 1;
            hint "";
        };
	} else {
        hint "You found nothing.";
        sleep 1;
        hint "";
	};
	[player, ""] remoteExecCall ["switchMove", -2];
};

private _codeOnInterrupted = {
	[player, ""] remoteExecCall ["switchMove", -2];
};

[
	player,
	_actionText,
	_actionIdleIcon,
	_actionProgressIcon,
	_conditionToShow,
	_conditionToProgress,
	_codeOnStart,
	_codeOnTick,
	_codeOnComplete,
	_codeOnInterrupted,
	[],
	8,
	100,
	false,
	false
] call BIS_fnc_holdActionAdd;
