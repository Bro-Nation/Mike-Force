/*
    File: fn_log_performance_data.sqf
    Author: Savage Game Design
    Public: No
    Modified By: "DJ" Dijksterhuis

    Description:
      Logs a 3x lines of performance data
        - Server performance, e.g. server FPS
        - Gamemode statistics, e.g. AI count
        - Player network stats, e.g. maximum player desync 

    Parameter(s): None

    Returns: Nothing

    Example(s):
		call vn_mf_fnc_init_performance_logging
*/

// common defs to avoid duplicate calls / changed data between calls

private _allPlayers = allPlayers;
private _allUnits = allUnits;

private _fnc_get_sum = {
  params ["_arr"];
  private _v = 0;
  _arr apply {_v = _v + _x};
  _v
};

private _fnc_get_average = {
  params ["_arr"];

  private _sum = [_arr] call _fnc_get_sum;
  private _c = count _arr;

  if (_c == 0) exitWith {selectMax []}; // hack: returns <null>
  _sum / _c
};

// server/headless performance

private _headlessClients = _allPlayers select {(getUserInfo (getPlayerID _x)) select 7};
private _headlessClientsDesyncs = _headlessClients apply {((getUserInfo (getPlayerID _x)) select 9) select 2};

private _messageServer = format [
  "Server: UptimeMins:%1, FPSMin:%2, FPSAv:%3, Scripts:[spawn: %4, execVM: %5, exec: %6, execFSM: %7], HCs:%8, HCsDesync:%9",
  diag_tickTime / 60, // natural time since arma was started, not ingame time
  diag_fpsMin, // minimum server FPS over the last 16 frames
  diag_fps, // average server FPS over last 16 frames
  diag_activeScripts select 0,
  diag_activeScripts select 1,
  diag_activeScripts select 2,
  diag_activeScripts select 3, // active scripts in THIS frame
  _headlessClients,
  _headlessClientsDesyncs // a value above 0 means that the HC has disconnected
];

["INFO", _messageServer] call para_g_fnc_log;

// gamemode performance

private _deadUnitCount = {!alive _x} count _allUnits;
private _enemyUnitCount = {side _x == east} count _allUnits;
private _vehicleCount = count vehicles;

private _messageGame = format [
  "Game: Players:%1, DeadUnits:%2, EnemyUnits:%3, AllUnits:%4, AllVehicles:%5, RespawnVehQueue:%6",
  count _allPlayers,
  _deadUnitCount,
  _enemyUnitCount,
  count _allUnits,
  _vehicleCount,
  count vn_mf_spawn_points_to_respawn
];

["INFO", _messageGame] call para_g_fnc_log;

// players networking

private _playerNetworkData = _allPlayers select {!((getUserInfo (getPlayerID _x)) select 7)} apply {(getUserInfo (getPlayerID _x)) select 9};

private _allPing = _playerNetworkData apply {_x select 0};
private _allBandwidth = _playerNetworkData apply {_x select 1};
private _allDesync = _playerNetworkData apply {_x select 2};

private _messageNetwork = format [
  "PlayersNet (min/avg/max): Ping: %2/%3/%4 | Bandwidth: %5/%6/%7 | Desync: %8/%9/%10",
  count _allPlayers,
  selectMax _allPing,
  [_allPing] call _fnc_get_average,
  selectMin _allPing,
  selectMax _allBandwidth,
  [_allBandwidth] call _fnc_get_average,
  selectMin _allBandwidth,
  selectMax _allDesync,
  [_allDesync] call _fnc_get_average,
  selectMin _allDesync
];

["INFO", _messageNetwork] call para_g_fnc_log;
