/*
    File: fn_tr_playerInfo_ribbon_exit.sqf
    Author: Savage Game Design
    Modified: @dijksterhuis
    Public: No
    
    Description:
		Called by exiting the Ribbon control.
		Resets the Ribbon Info Control and preview Control to the previously selected one (if set).
    
    Parameter(s):
		0:	CONTROL		-	Control to get the "text" and other info from
    
    Returns: nothing
    
    Example(s): none
*/


#include "..\..\..\..\..\config\ui\ui_def_base.inc"
params["_ctrl_src"];
_ctrl_preview = VN_TR_PLAYERINFO_MEDAL_RIBBON_CTRL;
//set img
_icon = _ctrl_preview getVariable ["curIcon", ""];
_ctrl_preview ctrlSetText _icon;
//set description text
_text = _ctrl_preview getVariable ["text", ""];
VN_TR_PLAYERINFO_REWARD_TEXT_CTRL ctrlSetStructuredText parseText format["<t size='0.65' >%1</t>", _text];
//set tooltip (name)
_tooltip = _ctrl_preview getVariable ["name", ""];
_tooltip = if(isLocalized _tooltip)then{localize _tooltip}else{_tooltip};
_ctrl_preview ctrlSetToolTip _tooltip;
//re-adjust size
_ctrl_preview ctrlCommit 0;