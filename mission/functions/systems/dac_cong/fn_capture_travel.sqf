/*
    File: fn_capture_travel.sqf
    Author: Legend
	modified: tylyervip
    Public: No

    Description:
	Capture target player and strip/send them to the cages with the DAC.

    Parameter(s):
		_target - [PLAYER]
		_player - [PLAYER]
		_destinationMarker - [STRING] marker where both players are teleported

    Returns: nothing

    Example(s):
	[_target, _player, "mf_dc_spawnpoint_daccong_aotunnel"] call vn_mf_fnc_capture_travel;
*/
params ["_target", "_player", ["_destinationMarker", "mf_dc_spawnpoint_daccong_aotunnel"]];

if !(isPlayer _target) exitWith {};

{
	removeAllAssignedItems player;
	removeAllItems player;
	removeGoggles player;
	removeHeadgear player;
	removeAllWeapons player;
	removeVest player;
	removeBackpack player;
	//temporarily moved aside player forceAddUniform "vn_o_uniform_nva_army_01_01" (selectRandom ["vn_b_uniform_macv_01_01","vn_b_uniform_macv_01_02","vn_b_uniform_macv_01_03","vn_b_uniform_macv_01_04","vn_b_uniform_macv_01_05","vn_b_uniform_macv_01_06"])
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";
	player addItem "vn_o_item_firstaidkit";

} remoteExec ["call", _target];

private _destinationName = if (_destinationMarker isEqualTo "mf_dc_respawn_daccong_powcamp") then {
	"POW camp"
} else {
	"the tunnels"
};

private _message = format ["%1 captured %2 and moved them to %3!", name _player, name _target, _destinationName];
private _nearbyCages = (nearestObjects [getPos _target, [], 10, false]) select {
	private _varName = toLower (vehicleVarName _x);
	(_varName isEqualTo "vn_mf_capture") || {(_varName find "vn_mf_capture") == 0}
};
if (count _nearbyCages != 0) exitWith {
	["CagesTooClose", ["Prisoner is already captured!"]] remoteExec ["para_c_fnc_show_notification", _player];
};

	["POWCapturedByOpfor", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];

private _resolveDestinationPos = {
	params ["_destinationName"];
	private _markerPos = getMarkerPos _destinationName;
	if !(_markerPos isEqualTo [0, 0, 0]) exitWith {
		_markerPos
	};

	private _destinationObject = missionNamespace getVariable [_destinationName, objNull];
	if (!isNull _destinationObject) exitWith {
		getPosATL _destinationObject
	};

	[0, 0, 0]
};

private _findCaptureLogicNearMarker = {
	params ["_markerPos"];
	private _captureCandidates = (nearestObjects [_markerPos, [], 100, false]) select {
		private _varName = toLower (vehicleVarName _x);
		(_varName isEqualTo "vn_mf_capture") || {(_varName find "vn_mf_capture") == 0}
	};
	if (count _captureCandidates > 0) then {
		_captureCandidates select 0
	} else {
		objNull
	}
};

private _isTunnelDestination = _destinationMarker isEqualTo "mf_dc_spawnpoint_daccong_aotunnel";
if (_isTunnelDestination) then {
	// Captor teleports to spawnpoint
	private _dacTunnelSpawn = missionNamespace getVariable ["mf_dc_spawnpoint_daccong_aotunnel", objNull];
	_player setPosATL (getPosATL _dacTunnelSpawn vectorAdd [0,0,1]);
	_player setUnitFreefallHeight 32000;
	_player setVariable ["inTunnel", true, true];

	// Prisoner teleports to tunnel logic (cage) - find nearest Logic within 50m of marker
	private _markerPos = [_destinationMarker] call _resolveDestinationPos;
	if (_markerPos isEqualTo [0, 0, 0]) exitWith {
		["CagesTooClose", ["Destination not found."]] remoteExec ["para_c_fnc_show_notification", _player];
	};
	private _captureLogic = [_markerPos] call _findCaptureLogicNearMarker;
	private _cagePos = if (isNull _captureLogic) then {
		_markerPos
	} else {
		getPosASL _captureLogic
	};

	_target setPosASL _cagePos;
	["start"] remoteExec ["vn_mf_fnc_capture_captive_monitor", _target];
	_target setUnitFreefallHeight 32000;
	_target setVariable ["inTunnel", true, true];
} else {
	// POW camp - find nearest Logic within 50m of marker
	private _markerPos = [_destinationMarker] call _resolveDestinationPos;
	if (_markerPos isEqualTo [0, 0, 0]) exitWith {};

	private _captureLogic = [_markerPos] call _findCaptureLogicNearMarker;
	private _cagePos = if (isNull _captureLogic) then {
		_markerPos
	} else {
		getPosASL _captureLogic
	};

	_target setPosASL _cagePos;
	["start"] remoteExec ["vn_mf_fnc_capture_captive_monitor", _target];
	_player setPosASL _markerPos;
};


