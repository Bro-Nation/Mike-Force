/*
    File: fn_post_init.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Executes the post init routine.

    Parameter(s): none

    Returns: nothing

    Example(s): none
*/

#include "..\..\..\config\defines.hpp"

// determine what type of client or server we are dealing with
_target_scope = call para_g_fnc_custom_scope;
_target_scope call vn_mf_fnc_init_mission_handlers;

[] spawn vn_mf_fnc_init_comms;

[] call vn_mf_fnc_adv_revive_params;

call vn_mf_fnc_chat_init;
[player, "vn_mine_limpet_01_mag"] call vn_mf_fnc_uwChargeAddAction;