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

diag_log format ["[SUPPORT UI] tr_supportTask_create start payload=%1", vn_tr_supportMissionInfo];

private _isOpfor = (player getVariable ["vn_mf_db_player_group", "MikeForce"]) isEqualTo "DacCong";

private _isDebugPos = (
    (vn_tr_supportMissionInfo # 1) isEqualTo []
    || (vn_tr_supportMissionInfo # 1) isEqualTo [0, 0]
    || (vn_tr_supportMissionInfo # 1) isEqualTo [0, 0, 0]
);
if (_isDebugPos && !_isOpfor) exitWith {
    [] spawn {
        hint "You must select a position on the map to create a support task!";
        sleep 5;
        hintSilent "";
    };
};

if (_isOpfor && _isDebugPos) then {
	vn_tr_supportMissionInfo set [1, [0,0,0]];
	// Do NOT override index 2 here - preserve the player's direction selection
};

//disable the Request Button, after clicking it
if (!isNull VN_TR_SUPREQ_CTASK_CTRL) then {
    VN_TR_SUPREQ_CTASK_CTRL ctrlEnable false;
};

private _taskClass = vn_tr_supportMissionInfo # 0;
if (_taskClass isEqualTo "") then {
    private _sel = lbCurSel VN_TR_SUPREQ_TASK_CTRL;
    if (_sel >= 0) then {
        private _fallbackClass = VN_TR_SUPREQ_TASK_CTRL lnbData [_sel, 0];
        if !(_fallbackClass isEqualTo "") then {
            vn_tr_supportMissionInfo set [0, _fallbackClass];
            _taskClass = _fallbackClass;
            diag_log format ["[SUPPORT UI] task class recovered from list selection: %1", _taskClass];
        };
    };
};

if (_taskClass isEqualTo "") exitWith {
    diag_log format ["[SUPPORT UI] Aborted submit: empty task class payload=%1", vn_tr_supportMissionInfo];
};

diag_log format [
    "[SUPPORT UI] Submit request by %1 (%2) payload=%3",
    name player,
    getPlayerUID player,
    vn_tr_supportMissionInfo
];

//send request to Server
//["Classname",[Coords],"TeamName"]
["supporttaskcreate", +vn_tr_supportMissionInfo] call para_c_fnc_call_on_server;
diag_log "[SUPPORT UI] supporttaskcreate sent to server";

if (_isOpfor) then {
    [] spawn {
        sleep 0.5;
        call vn_mf_fnc_tr_supportTask_show;
    };
};

//clear TempVar
vn_tr_supportMissionInfo = ["",[],[]];

VN_TR_SUPREQ_TASK_CTRL lbSetCurSel 0;
VN_TR_SUPREQ_TEAM_CTRL lbSetCurSel -1;
