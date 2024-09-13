/*
    File: fn_curator_set_group_owner_headless.sqf
    Author: @dijkterhuis
    Public: No

    Description:
        Automatically changes the ownership of any AI group to
        any available headless client (or server if no headless
        clients exists).

        Means the headless clients should stop battling to take
        ownership of groups.

        Needs to be run on the SERVER.

    Parameter(s): none

    Returns: nothing

    Example(s): none
*/

params ["_curator", "_group"];

diag_log format [
	"[+]: Curator: Group created: curator=%1 group=%2 originalMachineOwner=%3",
	_curator,
	_group,
	groupOwner _group
];

/*
Set the squad's locality to the client with highest FPS

NOTE: The switch from local client ownership to headless/server
ownership is not immediate. It can take a couple of seconds to
complete.
*/
private _selectedClient = call para_s_fnc_loadbal_suggest_host;
_group setGroupOwner _selectedClient;
_group setVariable ["groupClientOwner", _selectedClient, true];

(units _group)
	apply {
		_x addEventHandler ["Local", {
			params ["_unit", "_isLocal"];
			if (_isLocal) then {

				diag_log format [
					"[+] Curator created unit has changed locality, setting owner back to server: unit=%1 group=%2",
					_unit,
					group _unit
				];

				private _selectedClient = call para_s_fnc_loadbal_suggest_host;
				(group _unit) setGroupOwner _selectedClient;
				(group _unit) setVariable ["groupClientOwner", _selectedClient, true];
			};
		}];
	};

