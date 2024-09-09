/*
    File: fn_tr_teamInfo_callback_update.sqf
    Author: Savage Game Design
    Modified: @dijksterhuis
    Public: No
    
    Description:
		Spawned by the Server.
		Updates the ctrl in the TaskRoster with the correct emblem/sign.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		[] remoteExec ["vn_mf_fnc_tr_teamInfo_callback_update", _playerObj];
*/

if!(remoteExecutedOwner isEqualTo 2) exitWith {systemchat str ["Team Update: Not send by Server! - OwnerID:", remoteExecutedOwner]};

disableSerialization;
#include "..\..\..\..\..\config\ui\ui_def_base.inc"

_stopTime = diag_tickTime + 2;
waitUntil {!isNull VN_DISP_TR_TASKROSTER or (diag_tickTime > _stopTime)};
if(diag_tickTime > _stopTime) exitWith { systemchat str ["Team Update: TIMEOUT "]; };

// taskroster team page is currently open
// update the team info with player's new team info
call vn_mf_fnc_tr_teamInfo_show;
