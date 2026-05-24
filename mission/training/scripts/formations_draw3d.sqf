FT_poles = allMissionObjects "Land_SurveyMarker_01_post_F" select {
    !isNil { _x getVariable "FT_index" }
};

// Tweak these to control label placement and size.
FT_labelHeightOffset = 2.5;
FT_labelTextSize = 0.1;

addMissionEventHandler ["Draw3D", {
    private _player = player;

    {
        private _pole = _x;

        if (_player distance _pole > 5) then {
            continue;
        };

        private _index = _pole getVariable ["FT_index", -1];
        if !(_index isEqualType 0) then {
            continue;
        };

        private _pos = getPosATL _pole;
        _pos set [2, (_pos select 2) + FT_labelHeightOffset];

        drawIcon3D [
            "",
            [1, 1, 1, 1],
            _pos,
            0,
            0,
            0,
            format ["#%1", _index],
            1,
            FT_labelTextSize,
            "PuristaBold"
        ];
    } forEach FT_poles;
}];