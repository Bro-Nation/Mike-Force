/*
    File: fn_eject_and_parachute.sqf
    Author: Tylervip
    Public: yes

    Description:
        Adds an action to a vehicle that allows players to eject with a parachute from the vehicle.
        For CH-47, the pilot and co-pilot use emergency eject (GETOUT) via remoteExec.

    Parameter(s):
        _vehicle - Vehicle to add the eject action to [OBJECT]  
*/

params ["_vehicle"];
if (isNull _vehicle) exitWith {};

// Add the action to the vehicle
_vehicle addAction [
    "<t color='#ffffffff'>Eject with Parachute</t>",
    {
        params ["_target", "_caller"];
        private _player  = _caller;
        private _vehicle = _target;

        if (isNull _player || isNull _vehicle) exitWith {};

        // --- Store original backpack and items ---
        private _oldBackpackClass = backpack _player;
        private _oldBackpackItems = backpackItems _player;

        // --- List of parachute backpacks ---
        private _parachutes = [
            "vn_i_pack_parachute_01",
            "vn_o_pack_parachute_01",
            "vn_b_parachute_01",
            "vn_b_parachute_01_02",
            "vn_b_parachute_02",
            "vn_i_parachute_01",
            "vn_o_parachute_01",
            "vn_1_parachute_01",
            "vn_b_pack_ba18_01",
            "vn_b_pack_ba22_01",
            "vn_b_pack_t10_01",
            "B_Parachute"
        ];

        private _foundClass = "";
        private _cargo = getBackpackCargo _vehicle;

        // --- Search vehicle cargo for a parachute ---
        if (typeName _cargo == "ARRAY" && {count _cargo == 2}) then {
            private _classes = _cargo select 0;
            private _counts  = _cargo select 1;

            for "_i" from 0 to (count _classes - 1) do {
                private _cls = _classes select _i;
                if (_foundClass == "" && {_parachutes find _cls != -1} && {(_counts select _i) > 0}) then {
                    _foundClass = _cls;
                    _counts set [_i, (_counts select _i) - 1];
                };
            };

            if (_foundClass == "") exitWith { hintSilent "No parachute found in helicopter cargo!"; };

            // --- Update cargo with remaining items ---
            private _newClasses = [];
            private _newCounts  = [];

            for "_j" from 0 to (count _classes - 1) do {
                private _c = _classes select _j;
                private _n = _counts  select _j;
                if (_n > 0) then {
                    _newClasses pushBack _c;
                    _newCounts  pushBack _n;
                };
            };

            clearBackpackCargoGlobal _vehicle;

            for "_k" from 0 to (count _newClasses - 1) do {
                _vehicle addBackpackCargoGlobal [
                    _newClasses select _k,
                    _newCounts  select _k
                ];
            };
        };

        if (_foundClass == "") exitWith {};

        removeBackpack _player;
        _player addBackpack _foundClass;
        
        //ch47 ejcet work around
        if ((typeOf _vehicle) find "vn_b_air_ch47" != -1) then {
           //{ [_x] remoteExec ["moveOut", _x] } forEach [driver _vehicle, _vehicle turretUnit [0]]; 
            if (vehicle _player unitTurret _player isEqualTo [-1] || vehicle _player unitTurret _player isEqualTo [0]) then
            {
                [_player] remoteExec ["moveOut", _player];
            } else {
                _player action ["EJECT", _vehicle];
            };
        } else {
            _player action ["EJECT", _vehicle];
        };

        waitUntil { vehicle _player != _vehicle };
        sleep 0.5;

        // --- Restore original backpack/items ---
        [_player, _oldBackpackClass, _oldBackpackItems, _foundClass] spawn {
            params ["_p", "_oldClass", "_oldItems", "_parachuteClass"];

            waitUntil { (backpack _p != _parachuteClass) || {!alive _p} };

            if (backpack _p == _parachuteClass) then {
                removeBackpack _p;
            };

            if (!isNil "_oldClass" && {_oldClass != ""}) then {
                _p addBackpack _oldClass;
                { _p addItemToBackpack _x } forEach _oldItems;
            };
        };

    },
    nil,
    1.5,
    false,
    true,
    "",
    "_this in crew _target && ((getPosASL player select 2) - (getTerrainHeightASL (getPosASL player))) > 100"
];
