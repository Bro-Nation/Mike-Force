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

        // Wait until fully out of the vehicle
        waitUntil { vehicle _player != _vehicle || !alive _player };
        if (!alive _player) exitWith {};

        // Wait for parachute deployment (altitude safety)
        waitUntil {
            "parachute" in toLower typeOf (vehicle _player) ||
            !alive _player ||
            (getPosASL _player select 2) < 10
        };

        if (!alive _player || !("parachute" in toLower typeOf (vehicle _player))) exitWith {
            // Failed to open chute – restore original backpack if possible
            if (_oldBackpackClass != "") then {
                removeBackpack _player;
                _player addBackpack _oldBackpackClass;
                { _player addItemToBackpack _x } forEach _oldBackpackItems;
            };
        };

        sleep 0.1; // Improves reliability of the bag attachment

        // Create temporary bag holder only if player had a backpack
        private _bagHolder = objNull;
        if (_oldBackpackClass != "") then {
            _bagHolder = "WeaponHolderSimulated" createVehicle (vehicle _player modelToWorld [0, -0.6, 0.425]);
            _bagHolder addBackpackCargoGlobal [_oldBackpackClass, 1];
            _bagHolder attachTo [vehicle _player, [0, 0.75, 0]];
            [_bagHolder, [180, -90, 180]] call BIS_fnc_setObjectRotation;
        };

        // Restore original backpack once the parachute is gone (or player dies)
        [_player, _oldBackpackClass, _oldBackpackItems, _bagHolder] spawn {
            params ["_p", "_oldClass", "_oldItems", "_bag"];

            waitUntil {
                !("parachute" in toLower typeOf (vehicle _p)) ||
                !alive _p
            };

            if (!isNull _bag) then {
                deleteVehicle _bag;
            };

            if (alive _p && {_oldClass != ""}) then {
                removeBackpack _p;
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
    "_parachutes = [
            'vn_i_pack_parachute_01','vn_o_pack_parachute_01','vn_b_parachute_01','vn_b_parachute_01_02',
            'vn_b_parachute_02','vn_i_parachute_01','vn_o_parachute_01','vn_1_parachute_01',
            'vn_b_pack_ba18_01','vn_b_pack_ba22_01','vn_b_pack_t10_01','B_Parachute'
        ]; _this in crew _target && ((getPosASL player select 2) - (getTerrainHeightASL (getPosASL player))) > 100 && !((backpack _this) in _parachutes) && {
        // Check vehicle cargo for at least one parachute
        private _cargo = getBackpackCargo _target;
        if !(_cargo isEqualType [] && {count _cargo == 2}) exitWith {false};

        private _classes = _cargo select 0;
        private _counts  = _cargo select 1;
        private _hasPara = false;

        {
            if (_x in _parachutes && {(_counts select _forEachIndex) > 0}) then {_hasPara = true};
        } forEach _classes;

        _hasPara
    }"
];
