/*
    File: fn_sites_utils_add_disable_weapon_action.sqf
    Author: Tylervip 
    Public: Yes
    
    Description:
        Adds a "Disable Weapon" action to a static weapon for multiplayer compatibility.
    
    Parameter(s):
        _weapon - Static weapon object to add action to
    
    Returns:
        Nothing
    
    Example(s):
        _weapon call vn_mf_fnc_sites_utils_add_disable_weapon_action
*/

params ["_weapon"];

_weapon enableWeaponDisassembly false;

private _actionId = [
    _weapon,
    "Disable Weapon",
    "custom\holdactions\holdAction_interact_ca.paa",
    "custom\holdactions\holdAction_interact_ca.paa",
    "player distance _target < 3 && alive _target",
    "player distance _target < 3 && alive _target",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
        [_target, 1] remoteExec ["setDamage", 2];
        hint "Weapon disabled.";
    },
    {},
    [],
    1,
    100,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _weapon];

_weapon setVariable ["disableWeaponActionId", _actionId, true];