/*
	File: fn_veh_asset_client_locate_vehicle_spawn_point.sqf
	Author: 'DJ' Dijksterhuis
	Public: No
	
	Description:
		Draws an icon on screen for 10 seconds showing players where to park their vehicle.

		Executes client-side.
	
	Parameter(s): none
	
	Returns:
	
	Example(s):
		call vn_mf_fnc_veh_asset_client_locate_vehicle_spawn_point;
*/


private _playerInVehicle = (vehicle player != player);
private _playerIsDriver = ((assignedVehicleRole player select 0) == 'driver');
private _playerIsCopilot = (getNumber ([_vehicle, _vehicle unitTurret _player] call BIS_fnc_turretConfig >> "isCopilot") > 0);
private _vehicleIsVehAssetManaged = !(((vehicle player) getVariable ['veh_asset_spawnPointId', false]) isEqualTo false);
private _draw3DInactive = ((player getVariable ['veh_asset_spawnPoint_draw3d_active', false]) isEqualTo false);

// player not in a vehicle etc
if !(_playerInVehicle && _vehicleIsVehAssetManaged) exitWith {["NoVehicleForSpawnerLocator", []] call para_c_fnc_show_notification}; 

// player is not driver
if !(_playerIsDriver || _playerIsCopilot) exitWith {["NoDriverForSpawnerLocator", []] call para_c_fnc_show_notification}; 

// icon currently drawn on screen, don't let players spam it
if !(_draw3DInactive) exitWith {false};

private _spawnPointId = (vehicle player) getVariable ['veh_asset_spawnPointId', false];
private _spawnPointPos = vn_mf_veh_asset_spawn_points_client get _spawnPointId get 'spawnLocation' get 'pos';
private _iconPos = [_spawnPointPos select 0, _spawnPointPos select 1, 1];  // reset z position

// stop player spamming the event handler and draw icon
player setVariable ["veh_asset_spawnPoint_draw3d_active", true];

// spawn so we can sleep
private _scriptHandle = [getPos player, _iconPos] spawn {

	private _eventHandlerId = addMissionEventHandler [
		"draw3D",
		{

			drawIcon3D [
				"\A3\ui_f\data\map\markers\handdrawn\end_CA.paa",  // icon
				[1, 1, 1, 0.6],  // color rgb-a
				_thisArgs select 1,  // AGL position
				1,  // width
				1,  // height
				0,  // angle
				"Vehicle's Spawn Point",  // text
				2,  // 0 - noshadow, 1 - shadow, 2 - outline
				0.035,  // text size
				"RobotoCondensed",  // font
				"center",  // text align
				true,  // drawSideArrows
				0,  // text offset x
				0  // text offset y
			];
		},
		[_this select 0, _this select 1]
	];
	// wait then remove the event handler -- remove the icon from display
	sleep 15;
	removeMissionEventHandler ["draw3D", _eventHandlerId];
	player setVariable ["veh_asset_spawnPoint_draw3d_active", false];
};


