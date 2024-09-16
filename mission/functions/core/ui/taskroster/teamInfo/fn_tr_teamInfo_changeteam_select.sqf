/*
    File: fn_tr_teamInfo_changeteam_select.sqf
    Author: @dijksterhuis
    Public: No

    Description:
		Fired when a team is selected in the task roster teamInfo page's team select listbox.

    Parameter(s): none

    Returns: nothing

    Example(s):
    	// in a UI button 'OnButtonClick' field
    	[] call vn_mf_fnc_tr_teamInfo_changeteam_select;
*/

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

private _index = lnbCurSelRow VN_TR_SHOWTEAMINFO_RHS_CHANGETEAM_LISTBOX_CTRL;
private _selectedTeam = VN_TR_SHOWTEAMINFO_RHS_CHANGETEAM_LISTBOX_CTRL lnbData [_index, 0];
["changeteam", [_selectedTeam]] call para_c_fnc_call_on_server;

/*
DO NOT REDRAW THE UI HERE AFTER UPDATE

the 'changeteam' function called on the server will remoteExec spawn a `vn_mf_tr_overview_team_update`
on the client, updating the current task roster view (team selection/information).
*/