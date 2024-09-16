/*
	File: fn_color_confname_to_rgba.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Converts a color Config Name like ColorRed or ColorBlack to RGBA values.

	Parameter(s):
		_colorConfName - Name of the Color class in CfgMarkerColors.

	Returns:
		Array of color data in RGBA format

	Example(s):
		["ColorRed"] call vn_mf_fnc_color_confname_to_rgba;
*/

params ["_colorConfName"];

private _colorConf = getArray (
  configFile >> "CfgMarkerColors" >> _colorConfName >> "color"
);
private _colorRGBA = _colorConf call BIS_fnc_colorConfigToRGBA;

_colorRGBA