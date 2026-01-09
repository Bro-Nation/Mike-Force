/*
    File: eh_Draw3D.sqf
    Author: Savage Game Design
    modified by: Tylervip // added Toggle Integration
    Public: No

    Description:
        Draw 3D Player Icons with Wheel Menu Toggle

    Activated by mission draw3D EH elsewhere.
*/

//  Ensure toggle variable exists (default ON)
if (isNil { localNamespace getVariable "vn_showPlayerIcons" }) then {
    localNamespace setVariable ["vn_showPlayerIcons", true];
};

//  Team checks
private _inMACV = [player, "MACV"] call para_g_fnc_db_check_whitelist;
private _inMP   = [player, "MilitaryPolice"] call para_g_fnc_db_check_whitelist;

//  Draw if toggle is ON + player belongs to allowed group
if ((localNamespace getVariable ["vn_showPlayerIcons", true]) && (_inMACV || _inMP)) then 
{
    private _offset = [0,0,0];

    {
        if (_x == player) then { continue };
        if !(side _x == side player) then { continue };

        private _screenPosition = worldToScreen (_x modelToWorldVisual _offset);
        if (_screenPosition isEqualTo []) then { continue };

        if (player distance _x > 100) then { continue };

        private _pos = ASLToAGL getPosASLVisual _x;
        drawIcon3D
        [
            "",
            [1,1,0,1],     // Yellow text
            _pos,
            1,
            1,
            0,
            name _x,
            0,
            0.04,
            "RobotoCondensed",
            "center",
            true
        ];

    } forEach playableUnits;
};