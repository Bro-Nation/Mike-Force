/*
    File: fn_tr_supportTask_create.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by control.
		Gathers all information from missionRequest Page and sends the Mission Request to the Server.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_create
*/

disableSerialization;

private _isDebugPos = (
    (vn_tr_supportMissionInfo # 1) isEqualTo []
    || (vn_tr_supportMissionInfo # 1) isEqualTo [0, 0]
    || (vn_tr_supportMissionInfo # 1) isEqualTo [0, 0, 0]
);
if (_isDebugPos) exitWith {
    [] spawn {
        hint "You must select a position on the map to create a support task!";
        sleep 5;
        hintSilent "";
    };
};

//disable the Request Button, after clicking it
VN_TR_SUPREQ_CTASK_IDC ctrlEnable false;

//send request to Server
//["Classname",[Coords],"TeamName"]
["supporttaskcreate", vn_tr_supportMissionInfo] call para_c_fnc_call_on_server;

//clear TempVar
vn_tr_supportMissionInfo = ["",[],[]];

VN_TR_SUPREQ_TASK_CTRL lbSetCurSel 0;
VN_TR_SUPREQ_TEAM_CTRL lbSetCurSel 0;
