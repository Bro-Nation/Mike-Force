/*
    File: fn_capture_player.sqf
    Author: Cerebral
	modified: tylyervip
    Public: No

    Description:
	Capture target player and strip/send them to the selected destination.

    Parameter(s):
		_target - [PLAYER]
		_player - [PLAYER]
		_destinationMarker - [STRING] optional marker destination

    Returns: nothing

    Example(s):
	[_target, _player, "mf_dc_spawnpoint_daccong_aotunnel"] call vn_mf_fnc_capture_player;
*/
params ["_target", "_player", ["_destinationMarker", ""]];

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

private _message = format ["%1 has captured %2!", name _player, name _target];
private _nearbyCages = (nearestObjects [getPos _target, [], 10, false]) select {
	private _varName = toLower (vehicleVarName _x);
	(_varName isEqualTo "vn_mf_capture") || {(_varName find "vn_mf_capture") == 0}
};
if (count _nearbyCages != 0) exitWith {
	["CagesTooClose", ["Prisoner is already captured!"]] remoteExec ["para_c_fnc_show_notification", _player];
};

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

if(_player getVariable 'vn_mf_side' == east) then {
	private _destinationPos = if (
		_destinationMarker != ""
	) then {
		private _destinationAnchorPos = [_destinationMarker] call _resolveDestinationPos;
		if !(_destinationAnchorPos isEqualTo [0, 0, 0]) then {
			private _captureLogic = [_destinationAnchorPos] call _findCaptureLogicNearMarker;
			if (!isNull _captureLogic) then {
				getPosASL _captureLogic
			} else {
				_destinationAnchorPos
			}
		} else {
			selectRandom vn_mf_cages
		}
	} else {
		selectRandom vn_mf_cages
	};

	["POWCapturedRed", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];

	_target setPosASL _destinationPos;
	["start"] remoteExec ["vn_mf_fnc_capture_captive_monitor", _target];
	if (_destinationMarker isEqualTo "mf_dc_spawnpoint_daccong_aotunnel") then {
		_target setUnitFreefallHeight 32000;
		_target setVariable ["inTunnel", true, true];
	};
} else {
	private _cage = selectRandom vn_dc_cages;
	["POWCapturedBlue", [_message]] remoteExec ["para_c_fnc_show_notification", allPlayers];

	_target setPosASL _cage;
	["start"] remoteExec ["vn_mf_fnc_capture_captive_monitor", _target];
};


