/*
	File: fn_soundranging_is_artillery_target.sqf
	Author: Tylervip
	Public: No

	Description:
		Checks whether an object is supported enemy artillery.

	Parameter(s):
		_object - Object to check [OBJECT]

	Returns:
		True if the object is supported artillery [BOOL]
*/
params [["_object", objNull, [objNull]]];

if (isNull _object || {!alive _object}) exitWith {false};

private _artilleryClasses = [
	"vn_o_nva_navy_static_mortar_type63",
	"vn_o_nva_navy_static_mortar_type53",
	"vn_o_nva_65_static_mortar_type53",
	"vn_o_nva_65_static_mortar_type63",
	"vn_o_nva_static_mortar_type53",
	"vn_o_nva_static_mortar_type63",
	"vn_o_vc_static_mortar_type53",
	"vn_o_vc_static_mortar_type63",
	"vn_o_nva_65_static_d44",
	"vn_o_nva_65_static_d44_01",
	"vn_o_nva_navy_static_d44",
	"vn_o_nva_navy_static_d44_01",
	"vn_o_nva_static_d44",
	"vn_o_nva_static_d44_01",
	"vn_o_vc_static_d44",
	"vn_o_vc_static_d44_01",
	"vn_o_vc_static_h12",
	"vn_o_nva_static_h12",
	"vn_o_nva_65_static_h12",
	"vn_o_kr_static_h12"
];

private _isArtillery = (typeOf _object in _artilleryClasses) || {
	_object isKindOf "vn_howitzer_base" && {(side _object) isEqualTo east}
} || {
	_object isKindOf "vn_rocket_h12_launcher" || {typeOf _object isEqualTo "vn_rocket_h12_launcher"}
};

_isArtillery
