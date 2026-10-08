/*
    fn_deploy_one_ropes.sqf

    Author: TernaryOperator

    Wrapper function for calling vn_mf_fnc_deploy_helo_ropes with the number of ropes we want because keys.hpp can't pass parameters to called functions

    Params:
        NONE

    Returns:
        NONE

    Usage:

        [] call vn_mf_fnc_deploy_one_ropes;

    Locality:
        Local (since player is inherently local)
*/

[player, 1] call vn_mf_fnc_deploy_helo_ropes;