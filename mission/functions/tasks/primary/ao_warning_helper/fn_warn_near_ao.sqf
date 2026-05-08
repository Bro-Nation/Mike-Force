/*
	File: fn_warn_near_ao.sqf
	Author: tylervip
	Public: yes

	Description:
		Warn players who enter the prepare-task warning ring.
		Each player is warned once per approach and becomes eligible
		again after leaving the warning ring.

	Parameter(s):
		_tds - Task datastore [Namespace]
		_playersInWarningArea - Players currently in warning ring [Array]

	Returns: nothing

	Example(s):
		[_tds, _playersInWarningArea] call vn_mf_fnc_task_pri_prepare_warn_near_ao;
*/

params ["_tds", "_playersInWarningArea"];

// DAC (EAST) should not receive this warning.
_playersInWarningArea = _playersInWarningArea select {side _x != east};

private _dynamicText = _tds getVariable [
	"warningDynamicText",
	"<t size='2' color='#FF0000' align='center'>WARNING: You are getting close to the AO. Stay out of the AO!</t>"
];

private _currentWarningUIDs = (_playersInWarningArea apply {getPlayerUID _x}) select {_x != ""};
private _warnedUIDs = _tds getVariable ["warningWarnedPlayerUIDs", []];

// Players can receive a warning again only after they leave the warning ring.
_warnedUIDs = _warnedUIDs select {_x in _currentWarningUIDs};

private _newPlayersToWarn = _playersInWarningArea select {
	private _uid = getPlayerUID _x;
	(_uid != "") && !(_uid in _warnedUIDs)
};

if ((count _newPlayersToWarn) > 0) then {
	{
		[_dynamicText, 6] remoteExec ["vn_mf_fnc_ui_warning_dynamic_text", _x];

		private _uid = getPlayerUID _x;
		if (_uid != "") then {
			_warnedUIDs pushBackUnique _uid;
		};
	} forEach _newPlayersToWarn;
};

_tds setVariable ["warningWarnedPlayerUIDs", _warnedUIDs];
