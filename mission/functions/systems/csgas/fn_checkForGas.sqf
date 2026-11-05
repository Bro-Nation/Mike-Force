/*
    File: fn_checkForGas.sqf
    Author: S. Cooper
    Public: No

    Description:
        Checks for gas exposure

    Parameter(s): Object (Unit to check for exposure)

    Returns: Boolean

    Example(s): none
*/

params ["_unit"];

_gas = (63 allObjects 3) select {_unit distance _x <= 10 && (getModelInfo _x # 0) isEqualTo "vn_cs_gas_yellow.p3d"}; 
 
if (count _gas > 0) then 
{ 
    if (!(goggles _unit == "vn_b_acc_m17_01" || goggles _unit == "vn_b_acc_m17_02")) then
    {
        [_unit] call vn_mf_fnc_gasUnit;
    };

    true;
} else {
    false;
}; 