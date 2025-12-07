[] spawn {
    _previousChannel = getPlayerChannel player;

    sleep 0.01;
    [2] call vn_mf_fnc_teams_comms_change_channel;
    if (_previousChannel == getPlayerChannel player) exitWith {};
    waitUntil {inputAction "pushToTalk" == 0};
    
    setCurrentChannel _previousChannel;
};
