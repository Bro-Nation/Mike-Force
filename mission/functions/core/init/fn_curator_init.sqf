params ["_player"];

BIS_fnc_endMission = {};

private _curators = missionNamespace getVariable ["curatorUIDs", []];
private _playerUID = getPlayerUID _player;
private _playerIsCurator = _curators findIf { _x == _playerUID } > -1;

if (!_playerIsCurator) exitWith {
	diag_log format ["[CURATOR] Player %1 (%2) not in curator list. UIDs: %3", name _player, _playerUID, _curators];
};

// Check if the player has the required mods
private _hasZeusPack = call vn_mf_fnc_check_zeus_pack;
if (!_hasZeusPack) exitWith {
	diag_log format ["[CURATOR] Player %1 missing required mods (ZEN/CBA)", name _player];
};

[_player] call {
	[0, {
		params ["_thePlayer"];

		if (isNull _thePlayer) exitWith {
			diag_log "[CURATOR] ERROR: Player object is null on server";
		};

		private _playerUID = getPlayerUID _thePlayer;
		if (_playerUID == "") exitWith {
			diag_log format ["[CURATOR] ERROR: Could not get UID for %1", _thePlayer];
		};

		private _curVarName = _playerUID + "_Cur";
		private _myCurObject = missionNamespace getVariable [_curVarName, objNull];

		diag_log format ["[CURATOR] Init for %1 (%2). Existing curator object: %3", name _thePlayer, _playerUID, _myCurObject];

		// Create curator object if it doesn't exist
		if (isNull _myCurObject) then {
			if (isNil "MikeFrcCur_group") then {
				MikeFrcCur_group = createGroup sideLogic;
			};

			_myCurObject = MikeFrcCur_group createUnit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];
			_myCurObject setVariable ["showNotification", false];

			// Add all addons to curator
			private _cfg = configFile >> "CfgPatches";
			private _newAddons = [];
			for "_i" from 0 to (count _cfg - 1) do {
				_newAddons pushBack (configName (_cfg select _i));
			};
			if (count _newAddons > 0) then {
				_myCurObject addCuratorAddons _newAddons;
			};

			missionNamespace setVariable [_curVarName, _myCurObject, true];
			publicVariable "MikeFrcCur_group";

			diag_log format ["[CURATOR] Created curator object %1 for %2", _myCurObject, _playerUID];
		};

		// Unassign current curator owner (handles respawn — old body may still be assigned)
		unassignCurator _myCurObject;

		// Wait for unassignment to propagate (with timeout)
		private _timeout = diag_tickTime + 5;
		waitUntil {
			sleep 0.1;
			isNull (getAssignedCuratorUnit _myCurObject) || diag_tickTime > _timeout
		};

		// Assign curator to the player
		_thePlayer assignCurator _myCurObject;

		// Verify assignment succeeded (with timeout)
		_timeout = diag_tickTime + 10;
		waitUntil {
			sleep 0.3;
			getAssignedCuratorUnit _myCurObject == _thePlayer || diag_tickTime > _timeout
		};

		if (getAssignedCuratorUnit _myCurObject == _thePlayer) then {
			_myCurObject setVariable ["owner", _playerUID];
			diag_log format ["[CURATOR] SUCCESS: %1 (%2) assigned to %3", name _thePlayer, _playerUID, _myCurObject];
		} else {
			diag_log format ["[CURATOR] ERROR: Failed to assign %1 (%2) to %3. Current assigned unit: %4", name _thePlayer, _playerUID, _myCurObject, getAssignedCuratorUnit _myCurObject];
		};

	}, _this] call CBA_fnc_globalExecute;
};