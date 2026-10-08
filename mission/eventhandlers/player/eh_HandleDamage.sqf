params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];

// Gas damage check

	_exposed = [_unit] call vn_mf_fnc_checkForGas;
	if (_projectile == "" && _directHit == false && _exposed == true) then 
	{
		0;
	} else 
	{

	};

if (_hitPoint == "incapacitated" && _instigator != objNull && _unit != _instigator) then 
{
	
	private _sideCheck = (side _unit == side _instigator);
	private _instigatorIsCurator = [_instigator] call para_g_fnc_db_check_curator;
	private _message = format ["[MACV] %1 has friendly fired %2.", name _instigator, name _unit];

	

	if (_instigatorIsCurator) exitWith {}; 

	if (_sideCheck) then {
		{
			private _inMACV = [_x, "MACV"] call para_g_fnc_db_check_whitelist;
			if !(_inMACV) then { continue };
			systemChat _message;
			[_message] remoteExec ["systemChat", _x];
		} forEach allPlayers;

		diag_log format["[!] Friendly fire name:%1 (UID:%2) incapacitated %3 (UID:%4) with %5",name _instigator, getPlayerUID _instigator, name _unit, getPlayerUID _unit, _projectile];
		["FriendlyFire", ["Check your fire! You've incapacitated a fellow soldier."]] remoteExec ["para_c_fnc_show_notification", _instigator];
	};

	
};

