/*
    Author: Cerebral
	Remake: Tylervip 
    Description:
        Authoritative curator initialization.
        - UID check happens only on the server (source of truth)
        - Module creation + assignment happens only on the server
        - Safe with dynamically updating curatorUIDs from database
*/

params [["_player", objNull, [objNull]]];

if (isNull _player || {!isPlayer _player}) exitWith {
    diag_log "[CURATOR] ERROR: Invalid player object passed to curator_init";
};

// =============================================================================
// CLIENT SIDE
// =============================================================================

if (!isServer) exitWith {
    private _skipLocalZeusCheck = !isMultiplayer;

    if (hasInterface && {!_skipLocalZeusCheck} && {!call vn_mf_fnc_check_zeus_pack}) exitWith {
        diag_log format ["[CURATOR] Player %1 missing required mods (ZEN/CBA)", name _player];
    };

    [_player] remoteExecCall ["vn_mf_fnc_curator_init", 2];
};

// =============================================================================
// SERVER SIDE (authoritative)
// =============================================================================

BIS_fnc_endMission = {};

private _playerUID = getPlayerUID _player;

if (_playerUID isEqualTo "") exitWith {
    diag_log format ["[CURATOR] ERROR: Could not get UID for %1", _player];
};

// Always read the latest list from missionNamespace (database-backed)
private _curators = missionNamespace getVariable ["curatorUIDs", []];
private _playerIsCurator = (_curators findIf {_x isEqualTo _playerUID}) > -1;

if (!_playerIsCurator) exitWith {
    diag_log format [
        "[CURATOR] Player %1 (%2) not in curator list. Current UIDs: %3",
        name _player, _playerUID, _curators
    ];
};

private _curVarName = _playerUID + "_Cur";
private _myCurObject = missionNamespace getVariable [_curVarName, objNull];

diag_log format [
    "[CURATOR] Server init for %1 (%2). Existing curator object: %3",
    name _player, _playerUID, _myCurObject
];

// Create the curator module if it doesn't exist yet
if (isNull _myCurObject) then {
    if (isNil "MikeFrcCur_group") then {
        MikeFrcCur_group = createGroup sideLogic;
        publicVariable "MikeFrcCur_group";
    };

    _myCurObject = MikeFrcCur_group createUnit [
        "ModuleCurator_F",
        [0, 90, 90],
        [],
        0.5,
        "NONE"
    ];

    _myCurObject setVariable ["showNotification", false];
    _myCurObject setVariable ["BIS_fnc_initModules_activate", true, true];

    // Wait for module init (with timeout)
    private _moduleInitTimeout = diag_tickTime + 5;
    waitUntil {
        sleep 0.1;
        _myCurObject getVariable ["BIS_fnc_moduleInit_status", false]
        || diag_tickTime > _moduleInitTimeout
    };

    if !(_myCurObject getVariable ["BIS_fnc_moduleInit_status", false]) then {
        diag_log format ["[CURATOR] WARNING: Module init timed out for %1", _myCurObject];
    };

    // Add all available addons
    private _cfg = configFile >> "CfgPatches";
    private _newAddons = [];
    for "_i" from 0 to (count _cfg - 1) do {
        _newAddons pushBack configName (_cfg select _i);
    };

    if (_newAddons isNotEqualTo []) then {
        _myCurObject addCuratorAddons _newAddons;
    };

    // Store globally
    missionNamespace setVariable [_curVarName, _myCurObject, true];

    diag_log format ["[CURATOR] Created curator object %1 for %2", _myCurObject, _playerUID];
};

// Handle respawn / re-assignment
unassignCurator _myCurObject;

// Wait for unassignment to propagate
private _timeout = diag_tickTime + 5;
waitUntil {
    sleep 0.1;
    isNull (getAssignedCuratorUnit _myCurObject) || diag_tickTime > _timeout
};

// Assign to the player
_player assignCurator _myCurObject;

// Verify assignment
_timeout = diag_tickTime + 10;
waitUntil {
    sleep 0.3;
    getAssignedCuratorUnit _myCurObject isEqualTo _player
    || diag_tickTime > _timeout
};

<<<<<<< Updated upstream
		diag_log format ["[CURATOR] Init for %1 (%2). Existing curator object: %3", name _thePlayer, _playerUID, _myCurObject];

		// Create curator object if it doesn't exist
		if (isNull _myCurObject) then {
			if (isNil "MikeFrcCur_group") then {
				MikeFrcCur_group = createGroup sideLogic;
			};

			_myCurObject = MikeFrcCur_group createUnit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];
			_myCurObject setVariable ["showNotification", false];

			// If the module is created via code (rather than in eden) then init won't always be called
			// i.e. zeus interface will load but not be fully initialised, this is closer to what
			// placing Game Master in Eden would be since that would call the init
			_myCurObject setVariable ["BIS_fnc_initModules_activate", true, true];

			private _moduleInitTimeout = diag_tickTime + 5;
			waitUntil {
				sleep 0.1;
				_myCurObject getVariable ["BIS_fnc_moduleInit_status", false]
					|| diag_tickTime > _moduleInitTimeout
			};

			if !(_myCurObject getVariable ["BIS_fnc_moduleInit_status", false]) then {
				diag_log format [
					"[CURATOR] Module initialization timed out for %1",
					_myCurObject
				];
			};

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
=======
if (getAssignedCuratorUnit _myCurObject isEqualTo _player) then {
    _myCurObject setVariable ["owner", _playerUID, true];
    diag_log format [
        "[CURATOR] SUCCESS: %1 (%2) assigned to %3",
        name _player, _playerUID, _myCurObject
    ];
} else {
    diag_log format [
        "[CURATOR] ERROR: Failed to assign %1 (%2) to %3. Currently assigned: %4",
        name _player,
        _playerUID,
        _myCurObject,
        getAssignedCuratorUnit _myCurObject
    ];
>>>>>>> Stashed changes
};