/*
    File: fn_veh_asset_describe_status.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Creates a text description of a spawnpoint's current status.
    
    Parameter(s):
	   	_spawnPointId - ID of the spawnpoint whose status should be described [HashMap]
    
    Returns:
	   	Description of the spawnpoint [String]
    
    Example(s):
		["32"] call vn_mf_fnc_veh_#sset_describe_status;
*/

params ["_spawnPointId"];

private _spawnPoint = vn_mf_veh_asset_spawn_points_client get _spawnPointId;

if (isNil "_spawnPoint") exitWith { "" };

private _vehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];
private _vehicleType = typeOf _vehicle;
private _vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName");
if (_vehicleName isEqualTo "") then {_vehicleName = "vehicle"};


private _status = _spawnPoint getOrDefault ["status", createHashMap];
private _state = _status getOrDefault ["state", "UNKNOWN"];
private _vehiclePos = getPos _vehicle;
private _vehiclePosDisplay = format ["Grid: %1 %2", floor ((_vehiclePos select 0) / 100), floor ((_vehiclePos select 1) / 100)];


private _fnc_getTimeRemaining = {
	private _endTime = _status getOrDefault ["finishesAt", 0];
	private _timeRemaining = (_endTime - serverTime) max 0;
	private _minutes = floor (_timeRemaining / 60);
	private _seconds = floor (_timeRemaining - (_minutes * 60));
	if (_minutes > 0) exitWith {
		format ["%1 minutes", _minutes];
	};
	
	format ["%1 seconds", _seconds];
};

if (_state isEqualTo "IDLE") exitWith {
	format ["%1 is currently deployed and not in use. %2", _vehicleName, _vehiclePosDisplay]
};

if (_state isEqualTo "REPAIRING") exitWith {
	format ["The %1 is repairing and will be sent to the respawn queue in %2.", _vehicleName, call _fnc_getTimeRemaining];
};

if (_state isEqualTo "RESPAWNING") exitWith {
	format ["The %1 will be sent to the respawn queue in %2.", _vehicleName, call _fnc_getTimeRemaining];
};

if (_state isEqualTo "WRECKED") exitWith {
	format ["The %1 is currently wrecked. Bringing the wreck to recovery point at the main base or a FOB. %2", _vehicleName, _vehiclePosDisplay];
};

if (_state isEqualTo "QUEUED") exitWith {
	format ["The %1 is in the respawn queue and will be created in %2", _vehicleName, call _fnc_getTimeRemaining];
};

if (_state isEqualTo "DISABLED") exitWith {
	format ["The %1 is currently disabled, needs repairs from an engineer. %2", _vehicleName, _vehiclePosDisplay];
};

if (_state isEqualTo "ACTIVE") exitWith {
	format ["The %1 is currently deployed and in use. %2", _vehicleName, _vehiclePosDisplay];
};

if (_state isEqualTo "ADMINLOCKED") exitWith {
	format ["Spawner has been locked by an Admin, either due to bugs or bad behaviour."]
};

"The current state of this spawn point is unknown."
