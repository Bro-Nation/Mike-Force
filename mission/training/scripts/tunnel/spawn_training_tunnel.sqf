/*
    File: spawn_training_tunnel.sqf
    Author: Tylervip
    Public: Yes

    Description:
        Spawns a fresh training tunnel instance using training-only variables.
        Supports multiple objective anchors named inTunnel_training_objective_0,
        inTunnel_training_objective_1, and so on.

    Parameter(s):
        None

    Returns:
        Nothing

    Example(s):
        [] execVM "training\scripts\tunnel\spawn_training_tunnel.sqf"
*/

if (!isServer) exitWith {};

private _fnc_addHoldActionRemote = {
    params ["_actionArgs", "_jipId"];
    _actionArgs remoteExec ["BIS_fnc_holdActionAdd", 0, _jipId];
};

private _trainingTeleport = missionNamespace getVariable ["inTunnelTeleport_training", objNull];
private _trainingObjectives = [];

// Gather objective anchors using numbered naming convention.
{
    private _name = vehicleVarName _x;
    if (_name find "inTunnel_training_objective_" == 0) then {
        _trainingObjectives pushBack _x;
    };
} forEach allMissionObjects "All";

if (_trainingObjectives isEqualTo []) then {
    // Backward compatible fallback for old single-object name.
    private _singleObjective = missionNamespace getVariable ["inTunnel_training_objective", objNull];
    if (!isNull _singleObjective) then {
        _trainingObjectives pushBack _singleObjective;
    };
};

_trainingObjectives = _trainingObjectives apply { [vehicleVarName _x, _x] };
_trainingObjectives sort true;
_trainingObjectives = _trainingObjectives apply { _x select 1 };

private _trainingObjective = if (_trainingObjectives isEqualTo []) then { objNull } else { selectRandom _trainingObjectives };

if (isNull _trainingTeleport) exitWith {
    systemChat "Training tunnel: missing object inTunnelTeleport_training.";
};

if (isNull _trainingObjective) exitWith {
    systemChat "Training tunnel: missing objective anchor (use inTunnel_training_objective_0, _1, ...).";
};

if !(("training_tunnel_spawn" in allMapMarkers)) exitWith {
    systemChat "Training tunnel: missing marker training_tunnel_spawn.";
};

private _objectiveSpawnPos = getPosATL _trainingObjective;
private _spawnPos = markerPos "training_tunnel_spawn";
private _spawnDir = markerDir "training_tunnel_spawn";

private _tunnelClosed = ["Land_vn_o_trapdoor_01", _spawnPos] call para_g_fnc_create_vehicle;
private _tunnelOpen = ["Land_vn_o_trapdoor_02", _spawnPos] call para_g_fnc_create_vehicle;

_tunnelClosed setDir _spawnDir;
_tunnelOpen setPosWorld (getPosWorld _tunnelClosed);
_tunnelOpen setDir (getDir _tunnelClosed);
_tunnelOpen setVectorDirAndUp [vectorDir _tunnelClosed, vectorUp _tunnelClosed];

_tunnelClosed setVariable ["linkedOpenTunnel_training", _tunnelOpen, true];
_tunnelOpen setVariable ["linkedClosedTunnel_training", _tunnelClosed, true];
_tunnelOpen hideObjectGlobal true;

// Bind this training tunnel to the fixed training teleport.
_tunnelOpen setVariable ["exitTeleport_training", _trainingTeleport, true];
_trainingTeleport setVariable ["linkedTunnel_training", _tunnelOpen, true];
_trainingTeleport setVariable ["exitPosition_training", getPosATL _tunnelOpen, true];

// Exit tunnel hold action.
private _jipExit = format ["tunnels_exit_training_%1", netId _trainingTeleport];
[
    [
        _trainingTeleport,
        "Exit Tunnel",
        "\a3\ui_f\data\igui\cfg\actions\ladderup_ca.paa",
        "\a3\ui_f\data\igui\cfg\actions\ladderup_ca.paa",
        "(_target getVariable ['tunnelActive_training', false]) && player distance _target < 10",
        "player distance _target < 10",
        {},
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];

            private _source = _target getVariable ["linkedTunnel_training", objNull];
            if (!isNull _source) then {
                _caller setPosATL getPosATL _source;
                _caller setUnitFreefallHeight 100;
                _caller setVariable ["inTunnel_training", false, true];
                _caller setVariable ["tunnelExitTeleport_training", objNull, true];
            } else {
                private _fallbackPos = _target getVariable ["exitPosition_training", []];
                if (_fallbackPos isNotEqualTo []) then {
                    _caller setPosATL _fallbackPos;
                    _caller setUnitFreefallHeight 100;
                    _caller setVariable ["inTunnel_training", false, true];
                    _caller setVariable ["tunnelExitTeleport_training", objNull, true];
                };
            };
        },
        {},
        [],
        2,
        100,
        false,
        false
    ],
    _jipExit
] call _fnc_addHoldActionRemote;

_trainingTeleport setVariable ["exitJipId_training", _jipExit, true];
_trainingTeleport setVariable ["tunnelActive_training", true, true];

// Closed trapdoor actions (training-only variables).
private _isTrappedTraining = random 1 < 0.75;
_tunnelClosed setVariable ["trapActive_training", _isTrappedTraining, true];
_tunnelClosed setVariable ["trapChecked_training", false, true];

private _jipWires = format ["tunnels_training_wires_%1", netId _tunnelClosed];
private _jipOpen = format ["tunnels_training_open_%1", netId _tunnelClosed];
private _jipDisableTrap = format ["tunnels_training_disabletrap_%1", netId _tunnelClosed];

[
    [
        _tunnelClosed,
        "<t color='#ffc444'>Look for Wires</t>",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
        "((player getUnitTrait 'scout_multiple') || (player getUnitTrait 'explosiveSpecialist')) && !(_target getVariable ['trapChecked_training', false]) && player distance _target < 5",
        "player distance _target < 5",
        {},
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
            _arguments params [["_disableTrapJipId", ""]];

            private _isTrapped = _target getVariable ["trapActive_training", false];
            if (_isTrapped) then {
                hint "You found a trip wire! Disable the trap before opening.";

                [
                    _target,
                    "<t color='#ff4444'>Disable Trap</t>",
                    "\a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_takemine_ca.paa",
                    "\a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_takemine_ca.paa",
                    "((player getUnitTrait 'explosiveSpecialist') && (('vn_b_item_toolkit' in (backpackItems player)) || ('vn_b_item_trapkit' in (backpackItems player)) || ('MineDetector' in (backpackItems player)) || ('vn_b_item_toolkit' in (vestItems player)) || ('vn_b_item_trapkit' in (vestItems player)) || ('MineDetector' in (vestItems player)) || ('vn_b_item_toolkit' in (uniformItems player)) || ('vn_b_item_trapkit' in (uniformItems player)) || ('MineDetector' in (uniformItems player)))) && (_target getVariable ['trapActive_training', false]) && player distance _target < 5",
                    "player distance _target < 5",
                    {},
                    {},
                    {
                        params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
                        _target setVariable ["trapActive_training", false, true];
                        hint "Trap disabled. Safe to open.";
                    },
                    {},
                    [],
                    8,
                    100,
                    true,
                    false
                ] remoteExec ["BIS_fnc_holdActionAdd", 0, _disableTrapJipId];
            } else {
                hint "No wires found. Tunnel appears safe.";
            };

            _target setVariable ["trapChecked_training", true, true];
        },
        {},
        [_jipDisableTrap],
        4,
        100,
        true,
        false
    ],
    _jipWires
] call _fnc_addHoldActionRemote;

[
    [
        _tunnelClosed,
        "Open Tunnel",
        "custom\holdactions\holdAction_interact_ca.paa",
        "custom\holdactions\holdAction_interact_ca.paa",
        "player distance _target < 5",
        "player distance _target < 5",
        {},
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
            private _linkedOpen = _target getVariable ["linkedOpenTunnel_training", objNull];
            if (isNull _linkedOpen) exitWith {};

            private _isTrapped = _target getVariable ["trapActive_training", false];
            [_target, _linkedOpen, _isTrapped] remoteExecCall ["vn_mf_fnc_tunnels_open_tunnel_server", 2];
        },
        {},
        [],
        3,
        100,
        true,
        false
    ],
    _jipOpen
] call _fnc_addHoldActionRemote;

_tunnelClosed setVariable ["wiresJipId_training", _jipWires, true];
_tunnelClosed setVariable ["openJipId_training", _jipOpen, true];
_tunnelClosed setVariable ["disableTrapJipId_training", _jipDisableTrap, true];

// Open trapdoor enter action for all players.
private _jipEnter = format ["tunnels_enter_training_%1", netId _tunnelOpen];
[
    [
        _tunnelOpen,
        "Enter Tunnel",
        "\a3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa",
        "\a3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa",
        "player distance _target < 5",
        "player distance _target < 5",
        {},
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
            private _exitTeleport = _target getVariable ["exitTeleport_training", objNull];
            if (isNull _exitTeleport) exitWith { hint "No tunnel exit assigned"; };

            _caller setVariable ["inTunnel_training", true, true];
            _caller setVariable ["tunnelExitTeleport_training", _exitTeleport, true];
            _caller setUnitFreefallHeight 32000;
            _caller setPosATL (getPosATL _exitTeleport vectorAdd [0,0,-3]);

            [_caller, 100] execVM "training\scripts\tunnel\training_fall_protection_monitor.sqf";
        },
        {},
        [],
        2,
        100,
        false,
        false
    ],
    _jipEnter
] call _fnc_addHoldActionRemote;

_tunnelOpen setVariable ["enterJipId_training", _jipEnter, true];

// Objective box at tunnel objective point (re-created every spawn).
private _objectiveObject = [
    selectRandom ["vn_o_ammobox_02"],
    _objectiveSpawnPos
] call para_g_fnc_create_vehicle;

_objectiveObject allowDamage false;
[_objectiveObject] spawn {
    sleep 5;
    (_this select 0) allowDamage true;
};

[_objectiveObject, _objectiveSpawnPos] spawn {
    params ["_crate", "_originPos"];
    while {!isNull _crate} do {
        if ((_crate distance _originPos) > 3) then {
            _crate allowDamage false;
            _crate setPosATL _originPos;
            sleep 1;
            _crate allowDamage true;
        };
        sleep 15;
    };
};

_objectiveObject setVariable ["exemptFromRadiusCheck", true];
_objectiveObject setVariable ["originSpawnPos", _objectiveSpawnPos, true];

missionNamespace setVariable ["vn_mf_training_tunnel_closed", _tunnelClosed, true];
missionNamespace setVariable ["vn_mf_training_tunnel_open", _tunnelOpen, true];
missionNamespace setVariable ["vn_mf_training_tunnel_objective_obj", _objectiveObject, true];