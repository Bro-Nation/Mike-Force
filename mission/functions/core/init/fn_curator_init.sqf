/*
    Author: Cerebral
	Remake: Tylervip 
    Description:
        Authoritative curator initialization.
        - UID check happens only on the server (source of truth)
        - Module creation + assignment happens only on the server
        - Dedicated servers use the database whitelist; local hosts whitelist their player
*/

params [["_player", objNull, [objNull]]];

if(!isServer) exitWith {
    diag_log format ["[CURATOR] Attempted to run on a client, aborting"];
};

if (isNull _player || {!isPlayer _player}) exitWith {
    diag_log "[CURATOR] ERROR: Invalid player object passed to curator_init";
};

BIS_fnc_endMission = {};

private _playerUID = getPlayerUID _player;

if (_playerUID isEqualTo "") exitWith {
    diag_log format ["[CURATOR] ERROR: Could not get UID for %1", _player];
};

// Refresh the local development whitelist after the host player is available.
if (!isDedicated) then {
    call para_s_fnc_curator_populate;
};

// Always read the latest list from missionNamespace
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
    private _curatorClass = configFile >> "CfgVehicles" >> "ModuleCurator_F";
    if (isClass _curatorClass) then {
        if (isNil "MikeFrcCur_group" || {isNull MikeFrcCur_group}) then {
            MikeFrcCur_group = createGroup sideLogic;
        };

        if (isNull MikeFrcCur_group) then {
            diag_log format ["[CURATOR] ERROR: Could not create a sideLogic group for %1", _playerUID];
        } else {
            _myCurObject = MikeFrcCur_group createUnit [
                "ModuleCurator_F",
                [0, 90, 90],
                [],
                0.5,
                "NONE"
            ];

            if (isNull _myCurObject) then {
                diag_log format [
                    "[CURATOR] ERROR: createUnit returned <NULL-object> for %1 (group: %2, server: %3, dedicated: %4)",
                    _playerUID,
                    MikeFrcCur_group,
                    isServer,
                    isDedicated
                ];
            } else {
                _myCurObject setVariable ["showNotification", false];
                _myCurObject setVariable ["BIS_fnc_initModules_activate", true, true];

                private _moduleInitTimeout = diag_tickTime + 5;
                waitUntil {
                    sleep 0.1;
                    _myCurObject getVariable ["BIS_fnc_moduleInit_status", false]
                    || diag_tickTime > _moduleInitTimeout
                };

                if (isNull _myCurObject) then {
                    diag_log format ["[CURATOR] ERROR: Curator module for %1 became null during initialization.", _playerUID];
                } else {
                    if !(_myCurObject getVariable ["BIS_fnc_moduleInit_status", false]) then {
                        diag_log format ["[CURATOR] WARNING: Module init timed out for %1", _myCurObject];
                    };

                    private _cfg = configFile >> "CfgPatches";
                    private _newAddons = [];
                    for "_i" from 0 to (count _cfg - 1) do {
                        _newAddons pushBack configName (_cfg select _i);
                    };

                    if (_newAddons isNotEqualTo []) then {
                        _myCurObject addCuratorAddons _newAddons;
                    };

                    missionNamespace setVariable [_curVarName, _myCurObject, true];

                    diag_log format ["[CURATOR] Created curator object %1 for %2", _myCurObject, _playerUID];
                };
            };
        };
    } else {
        diag_log "[CURATOR] ERROR: ModuleCurator_F is unavailable in CfgVehicles on the server.";
    };
};

if (isNull _myCurObject) exitWith {
    diag_log format ["[CURATOR] ERROR: Aborting curator assignment for %1; no curator module was created.", _playerUID];
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
};