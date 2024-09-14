params ["_player"];

private _curators = missionNamespace getVariable ["curatorUIDs", []];
private _playerIsCurator = _curators findIf { _x == getPlayerUID _player} > -1;

private _myCurObject = objNull;

if(_playerIsCurator == false) exitWith {};

// call vn_mf_fnc_check_zeus_pack with remoteExec to check if the player has the required mods
private _hasZeusPack = call vn_mf_fnc_check_zeus_pack;
if (_hasZeusPack == false) exitWith {};

[_player] call {
	[0, {
		params ["_thePlayer"];
		private _playerUID = getPlayerUID _thePlayer;
		private _curVarName = _playerUID+"_Cur";
		_myCurObject = missionNamespace getVariable [_curVarName, objNull];
		
		if (isNull _myCurObject) then {
			if (isNil "MikeFrcCur_group") then {MikeFrcCur_group = creategroup sideLogic;};
			_myCurObject = MikeFrcCur_group createunit["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];	//Logic Server
			_myCurObject setVariable ["showNotification",false];
			
			missionNamespace setVariable [_curVarName, _myCurObject, true];
			publicVariable "MikeFrcCur_group";
			unassignCurator _myCurObject;
			_cfg = (configFile >> "CfgPatches");
			_newAddons = [];

			for "_i" from 0 to((count _cfg) - 1) do {
				_name = configName(_cfg select _i);
				_newAddons pushBack _name;
			};

			if (count _newAddons > 0) then {_myCurObject addCuratorAddons _newAddons};
			diag_log format ["[+] Curator object created %1.", _myCurObject];
		};

		unassignCurator _myCurObject;
		sleep 0.4;
		_thePlayer assignCurator _myCurObject;
		diag_log format ["[+] Player %1 added to %2.", _thePlayer, _myCurObject];

	}, _this] call CBA_fnc_globalExecute;
};

