/*
    File: fn_bulldozer_trees.sqf
    Author: Tylervip
    Public: yes

    Adds a toggle blade action to a vehicle, slows it when the blade is down,
    clears trees/bushes ahead, and auto-raises the blade after a set time.

    Parameter(s):
        0: OBJECT - vehicle

    Example:
        [_tank] remoteExecCall ["vn_mf_fnc_bulldozer_trees", 0, _tank];
*/

params ["_veh"];

if (isNull _veh) exitWith {};

// --- CONFIGURATION ---
private _radius = 5;         // meters around front of vehicle to clear
private _delay = 5;          // seconds before hiding/deleting trees
private _frontOffset = 2;    // meters ahead of vehicle
private _interval = 0.5;     // loop interval
private _slowSpeed = 10;     // max speed when blade is lowered (m/s)
private _bladeTime = 60;     // seconds blade stays down automatically

// --- INITIALIZATION ---
// Server only, so JIP clients running this function don't reset the blade state
if (isServer) then {
    _veh setVariable ["bladeDown", false, true];
};

// --- ADD TOGGLE ACTION ---
_veh addAction [
    "<t color='#FFA500'>Toggle Blade</t>",  // orange text
    {
        params ["_target", "_caller", "_id"];
        // Only the driver can toggle
        private _driver = driver _target;
        if (_caller == _driver) then {
            private _down = !(_target getVariable ["bladeDown", false]);
            _target setVariable ["bladeDown", _down, true];

            if (local _target) then {
                if (_down) then {
                    hintSilent "Blade lowered";
                } else {
                    hintSilent "Blade raised";
                };
            };
        } else {
            if (local _target) then {
                hintSilent "Only driver can toggle the blade!";
            };
        };
    },
    nil, 10, true, true, "", "driver _target == _this"
];

// --- MAIN LOOP ---
[_veh, _radius, _delay, _frontOffset, _interval, _slowSpeed, _bladeTime] spawn {
    params ["_veh", "_radius", "_delay", "_frontOffset", "_interval", "_slowSpeed", "_bladeTime"];

    private _downSince = -1;

    while {alive _veh} do {
        private _bladeDown = _veh getVariable ["bladeDown", false];

        // --- Slow vehicle (setVelocity needs the vehicle to be local) ---
        if (_bladeDown && { local _veh }) then {
            private _spd = speed _veh;
            if (_spd > _slowSpeed) then {
                private _vel = velocity _veh;
                private _factor = _slowSpeed / _spd;
                _veh setVelocity [
                    (_vel select 0) * _factor,
                    (_vel select 1) * _factor,
                    (_vel select 2) * _factor
                ];
            };
        };

        // --- Server only: tree clearing and auto-raise timer ---
        if (isServer) then {
            if (!_bladeDown) then {
                _downSince = -1;
            } else {
                if (_downSince < 0) then { _downSince = time; };

            // --- Bulldoze trees/bushes ---
            private _frontPos = _veh modelToWorld [0, _frontOffset, 0];
            private _objs = nearestTerrainObjects [_frontPos, ["TREE", "BUSH"], _radius, false];

            {
                if (!(_x getVariable ["bulldozed", false])) then {
                    _x setVariable ["bulldozed", true];
                    _x setDamage 1;
                    [_x, _delay] spawn {
                        params ["_obj", "_d"];
                        sleep _d;
                        if (!isNull _obj) then {
                            _obj hideObjectGlobal true;
                            deleteVehicle _obj;
                        };
                    };
                };
            } forEach _objs;

            // Auto-raise blade
            if (time - _downSince >= _bladeTime) then {
                _veh setVariable ["bladeDown", false, true];
                _downSince = -1;
                private _drv = driver _veh;
                if (!isNull _drv && { isPlayer _drv }) then {
                    ["Blade automatically raised"] remoteExecCall ["hintSilent", _drv];
                };
            };
            };
        };
        sleep _interval;
    };
};