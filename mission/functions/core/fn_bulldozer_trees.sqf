/*
    vn_mf_bulldozer_trees
    Adds a toggle blade action to a vehicle, slows it when the blade is down, clears trees/bushes ahead, and auto-raises the blade after a set time.
*/

params ["_veh"];

if (isNull _veh) exitWith {};

// --- CONFIGURATION ---
private _radius = 5;         // meters around front of vehicle to clear
private _delay = 5;          // seconds before hiding/deleting trees
private _frontOffset = 2;    // meters ahead of vehicle
private _interval = 0.2;     // loop interval
private _slowSpeed = 10;     // max speed when blade is lowered (m/s)
private _bladeTime = 60;     // seconds blade stays down automatically

// --- INITIALIZATION ---
_veh setVariable ["bladeDown", false, true];
_veh setVariable ["bladeTimer", 0, true];

// --- ADD TOGGLE ACTION ---
_veh addAction [
    "<t color='#FFA500'>Toggle Blade</t>",  // orange text
    {
        params ["_target", "_caller", "_id"];

        // Only the driver can toggle
        if (_caller == driver _target) then {
            private _down = !(_target getVariable ["bladeDown", false]);
            _target setVariable ["bladeDown", _down, true];
            if (_down) then {
                hint "Blade lowered";
                _target setVariable ["bladeTimer", 0, true]; // reset timer
            } else {
                hint "Blade raised";
            };
        } else {
            hint "Only driver can toggle the blade!";
        };
    },
    nil, 10, true, true, "", "_this distance _target < 3"
];

// --- MAIN LOOP ---
[_veh, _radius, _delay, _frontOffset, _interval, _slowSpeed, _bladeTime] spawn {
    params ["_veh", "_radius", "_delay", "_frontOffset", "_interval", "_slowSpeed", "_bladeTime"];

    while {alive _veh} do {
        if (_veh getVariable ["bladeDown", false]) then {
            // --- Slow vehicle ---
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

            // --- Blade timer ---
            private _time = _veh getVariable ["bladeTimer", 0];
            _time = _time + _interval;
            _veh setVariable ["bladeTimer", _time, true];

            // Auto-raise blade
            if (_time >= _bladeTime) then {
                if (_veh getVariable ["bladeDown", false]) then {
                    _veh setVariable ["bladeDown", false, true];
                    hint "Blade automatically raised to stop lag";
                    _veh setVariable ["bladeTimer", 0, true];
                };
            };
        };
        sleep _interval;
    };
};