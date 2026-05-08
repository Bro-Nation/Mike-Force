/*
	File: fn_ui_warning_dynamic_text.sqf
	Author: tylervip
	Public: yes

	Description:
		Displays centered dynamic warning text on the local client.

	Parameter(s):
		_message - Warning message in structured text format [String]
		_duration - Time to display message in seconds [Number, defaults to 2]

	Returns: nothing

	Example(s):
		["<t size='2' color='#FF0000' align='center'>Warning</t>"] remoteExec ["vn_mf_fnc_ui_warning_dynamic_text", player];
		["<t size='2' color='#FF0000' align='center'>Warning</t>", 8] remoteExec ["vn_mf_fnc_ui_warning_dynamic_text", player];
*/

params ["_message", ["_duration", 2]];

if (_message isEqualTo "") exitWith {};

[_message, -1, -1, _duration, 1, 0] spawn BIS_fnc_dynamicText;
