/*
	File: fn_soundranging_map_button.sqf
	Author: Tylervip
	Public: No

	Description:
		Manages the sound-ranging map guess button and its persistent cooldown.

	Parameter(s):
		_mode - "show" | "hide" | "start_cooldown" [STRING]

	Returns:
		Nothing
*/
params [["_mode", "show", [""]]];

if (!hasInterface) exitWith {};

private _ctrlId = 884200;
private _displayId = 12;
private _cooldownSecs = 10;
private _display = findDisplay _displayId;
private _ctrl = controlNull;
if (!isNull _display) then {
	_ctrl = _display displayCtrl _ctrlId;
};

private _fnc_applyState = {
	params ["_ctrl"];
	if (isNull _ctrl) exitWith {};

	private _until = missionNamespace getVariable ["vn_mf_sr_guess_cooldown_until", 0];
	private _armed = missionNamespace getVariable ["vn_mf_sr_guess_armed", false];

	if (time < _until) then {
		_ctrl ctrlEnable false;
		_ctrl ctrlSetText format ["COOLDOWN: %1s", ceil (_until - time)];
	} else {
		if (_armed) then {
			_ctrl ctrlEnable false;
			_ctrl ctrlSetText "CLICK MAP...";
		} else {
			_ctrl ctrlEnable true;
			_ctrl ctrlSetText "MAKE GUESS";
		};
	};
};

private _fnc_startTimerLoop = {
	params ["_displayId", "_ctrlId"];

	if (missionNamespace getVariable ["vn_mf_sr_guess_timer_running", false]) exitWith {};
	missionNamespace setVariable ["vn_mf_sr_guess_timer_running", true];

	[_displayId, _ctrlId] spawn {
		params ["_displayId", "_ctrlId"];

		while {true} do {
			private _until = missionNamespace getVariable ["vn_mf_sr_guess_cooldown_until", 0];
			if (time >= _until) exitWith {
				missionNamespace setVariable ["vn_mf_sr_guess_timer_running", false];
				private _display = findDisplay _displayId;
				if (!isNull _display) then {
					private _ctrl = _display displayCtrl _ctrlId;
					if (
						!isNull _ctrl
						&& {!(missionNamespace getVariable ["vn_mf_sr_guess_armed", false])}
					) then {
						_ctrl ctrlSetText "MAKE GUESS";
						_ctrl ctrlEnable true;
					};
				};
			};

			private _display = findDisplay _displayId;
			if (!isNull _display) then {
				private _ctrl = _display displayCtrl _ctrlId;
				if (!isNull _ctrl) then {
					_ctrl ctrlEnable false;
					_ctrl ctrlSetText format ["COOLDOWN: %1s", ceil (_until - time)];
				};
			};

			uiSleep 0.2;
		};
	};
};

switch (toLower _mode) do {
	case "hide": {
		if (!isNull _ctrl) then {
			ctrlDelete _ctrl;
		};
		missionNamespace setVariable ["vn_mf_sr_guess_armed", false];
		[false] call vn_mf_fnc_soundranging_set_map_click_handler;
	};

	case "start_cooldown": {
		private _until = time + _cooldownSecs;
		missionNamespace setVariable ["vn_mf_sr_guess_cooldown_until", _until];
		missionNamespace setVariable ["vn_mf_sr_guess_armed", false];
		[false] call vn_mf_fnc_soundranging_set_map_click_handler;

		[_ctrl] call _fnc_applyState;
		[_displayId, _ctrlId] call _fnc_startTimerLoop;
	};

	case "show": {
		if (isNull _display) exitWith {};

		if (isNull _ctrl) then {
			_ctrl = _display ctrlCreate ["RscButton", _ctrlId];
			_ctrl ctrlSetPosition [
				safeZoneX + 0.015 * safeZoneW,
				safeZoneY + 0.25 * safeZoneH,
				0.14 * safeZoneW,
				0.045 * safeZoneH
			];
			_ctrl ctrlSetFontHeight 0.035;
			_ctrl ctrlSetBackgroundColor [0.1, 0.35, 0.1, 0.85];
			_ctrl ctrlSetTextColor [1, 1, 1, 1];
			_ctrl ctrlCommit 0;

			_ctrl ctrlAddEventHandler ["ButtonClick", {
				params ["_ctrl"];

				private _until = missionNamespace getVariable ["vn_mf_sr_guess_cooldown_until", 0];
				if (time < _until) exitWith {
					_ctrl ctrlEnable false;
					_ctrl ctrlSetText format ["COOLDOWN: %1s", ceil (_until - time)];
				};
				if (missionNamespace getVariable ["vn_mf_sr_guess_armed", false]) exitWith {};

				missionNamespace setVariable ["vn_mf_sr_guess_armed", true];
				_ctrl ctrlSetText "CLICK MAP...";
				_ctrl ctrlEnable false;

				[true] call vn_mf_fnc_soundranging_set_map_click_handler;
			}];
		};

		[_ctrl] call _fnc_applyState;

		private _until = missionNamespace getVariable ["vn_mf_sr_guess_cooldown_until", 0];
		if (time < _until) then {
			[_displayId, _ctrlId] call _fnc_startTimerLoop;
		};
	};
};
