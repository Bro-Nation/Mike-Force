/*
    fn_mainHeliLoadout.sqf
    MAIN SCRIPT

    - Clears heli inventory on spawn
    - Adds per-heli parachute loadout
    - Keeps parachutes refilled
    - Allows players to put items back
*/

params ["_heli"];
if (isNull _heli) exitWith {};
if !(_heli isKindOf "Helicopter") exitWith {};

private _type = typeOf _heli;

private _smallHeliTypes = [
    "vn_b_air_oh6a_01"
];

// Prevent running twice on same heli
if (_heli getVariable ["MAIN_script_applied", false]) exitWith {};
_heli setVariable ["MAIN_script_applied", true, true];

// --------------------------------------------------
// Determine parachute counts per helicopter
// --------------------------------------------------

private _totalParas = switch (true) do {
    case (_type in _smallHeliTypes): {8};
    default {16};
};

private _half = floor (_totalParas / 2);

// Store refill targets on the heli
_heli setVariable ["MAIN_para_target_B", _half, true];
_heli setVariable ["MAIN_para_target_BA18", _half, true];

// --------------------------------------------------
// Initial inventory setup
// --------------------------------------------------

clearWeaponCargoGlobal _heli;
clearMagazineCargoGlobal _heli;
clearItemCargoGlobal _heli;
clearBackpackCargoGlobal _heli;

if (_half > 0) then {
    _heli addBackpackCargoGlobal ["B_Parachute", _half];
    _heli addBackpackCargoGlobal ["vn_b_pack_ba18_01", _half];
};

// --------------------------------------------------
// Auto-refill logic (server-side poll every 15s)
// InventoryClosed fires on clients only, so use a
// spawn loop here to stay server-local.
// --------------------------------------------------

[_heli] spawn {
    params ["_heli"];
    while { alive _heli } do {
        sleep 15;
        if (!alive _heli) exitWith {};

        private _targetB    = _heli getVariable ["MAIN_para_target_B", 0];
        private _targetBA18 = _heli getVariable ["MAIN_para_target_BA18", 0];

        private _bpCargo = getBackpackCargo _heli;

        private _bpIdx = (_bpCargo select 0) find "B_Parachute";
        private _currentB = if (_bpIdx >= 0) then {
            (_bpCargo select 1) select _bpIdx
        } else {
            0
        };

        private _itIdx = (_bpCargo select 0) find "vn_b_pack_ba18_01";
        private _currentBA18 = if (_itIdx >= 0) then {
            (_bpCargo select 1) select _itIdx
        } else {
            0
        };

        if (_currentB < _targetB) then {
            _heli addBackpackCargoGlobal ["B_Parachute", _targetB - _currentB];
        };

        if (_currentBA18 < _targetBA18) then {
            _heli addBackpackCargoGlobal ["vn_b_pack_ba18_01", _targetBA18 - _currentBA18];
        };
    };
};

