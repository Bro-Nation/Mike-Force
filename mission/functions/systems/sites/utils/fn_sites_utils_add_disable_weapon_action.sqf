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
[_weapon, [
	"Disable Weapon",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_target, 1] remoteExec ["setDamage", 0];
		[_target, _actionId] remoteExec ["removeAction", _target];
	},
	nil,
	2,
	false,
	true,
	"",
	"_this distance _target < 5"
]] remoteExec ["addAction", 0];
