/*
	File: fn_soundranging_cleanup.sqf
	Author: Tylervip
	Public: No

	Description:
		Removes expired detections and inactive towers from server tracking.

	Parameter(s):
		None

	Returns:
		Nothing
*/
if (!isServer) exitWith {};

private _cutoff = serverTime - 180;
private _detections = missionNamespace getVariable ["vn_mf_soundranging_detections", []];
private _prunedDetections = _detections select {(_x # 0) > _cutoff};
missionNamespace setVariable ["vn_mf_soundranging_detections", _prunedDetections];

private _towers = missionNamespace getVariable ["vn_mf_soundranging_towers", []];
private _validTowers = _towers select {
	!isNull _x
	&& {_x getVariable ["para_s_building_functional", false]}
	&& {
		private _tower = (_x getVariable ["para_g_objects", []]) param [0, objNull];
		!isNull _tower && {alive _tower}
	}
};
missionNamespace setVariable ["vn_mf_soundranging_towers", _validTowers];
