/*
    File: fn_teleport.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Moves player to another camp or location.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!
    
    Parameter(s):
		_location - Position [Position]
		_agent - Not used [Object]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_objectName","_destinationName"];

private _baseConfig = missionConfigFile >> "gamemode" >> "teleporters";
private _objectConfig = _baseConfig >> "objects" >> _objectName;
private _destinationConfig = _baseConfig >> "destinations" >> _destinationName;

if (!isClass _objectConfig || !isClass _destinationConfig) exitWith {};

private _object = missionNamespace getVariable [_objectName, objNull];
//Works with objNull, as distance2D returns a huge number.
if (_player distance2D _object > 20) exitWith {};

private _destination = getMarkerPos getText (_destinationConfig >> "position_marker");
if (_destination isEqualTo [0,0,0]) exitWith {};

private _newLocation = _destination findEmptyPosition [3,20,typeOf _player];
if (_newLocation isEqualTo []) then {_newLocation = _destination};

remoteExecCall ["vn_mf_fnc_display_location_time",_player];

if(_destinationName isEqualTo "satansangels_base") then {
  if ((toLower worldName) isEqualTo "cam_lao_nam") then {
    _player setPosATL [20152.6,67.6535,123.54];
  }
  else
  {
    _player setPos _newLocation;
  };
}
else
{
  //traing server 
  if (_destinationName isEqualTo "rappelrange_top_base") then {
    _player setPosATL (_destination vectorAdd [0,0,34]);
  }
  else
  {
    _player setPos _newLocation;
  };
};