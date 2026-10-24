// Loop for CS Gas Checks
[] spawn {
    while {true} do {
        sleep 1;
        {
            [_x] call vn_mf_fnc_checkForGas;
        } forEach allUnits;
    };
};
