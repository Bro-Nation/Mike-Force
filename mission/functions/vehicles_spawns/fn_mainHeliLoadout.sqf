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

// Only approved helicopter types
if !(typeOf _heli in [
    "vn_b_air_oh6a_01",
    "vn_b_air_uh1d_02_03",
    "vn_b_air_ch47_04_01"
]) exitWith {};

// Prevent running twice on same heli
if (_heli getVariable ["MAIN_script_applied", false]) exitWith {};
_heli setVariable ["MAIN_script_applied", true, true];

// --------------------------------------------------
// Determine parachute counts per helicopter
// --------------------------------------------------

private _totalParas = switch (typeOf _heli) do {
    case "vn_b_air_oh6a_01": {8};
    case "vn_b_air_uh1d_02_03": {16};
    case "vn_b_air_ch47_04_01": {16};
    default {0};
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
// Prevent duplicate refill event handlers
// --------------------------------------------------

if (_heli getVariable ["MAIN_refill_EH", false]) exitWith {};
_heli setVariable ["MAIN_refill_EH", true, true];

// --------------------------------------------------
// Auto-refill logic (soft minimum, no blocking)
// --------------------------------------------------

_heli addEventHandler ["InventoryClosed", {
    params ["_veh", "_unit"];

    private _targetB    = _veh getVariable ["MAIN_para_target_B", 0];
    private _targetBA18 = _veh getVariable ["MAIN_para_target_BA18", 0];

    // ---- Count B_Parachute backpacks ----
    private _bpCargo = getBackpackCargo _veh;
    private _bpIdx = (_bpCargo select 0) find "B_Parachute";
    private _currentB = if (_bpIdx >= 0) then {
        (_bpCargo select 1) select _bpIdx
    } else {
        0
    };

    // ---- Count BA-18 items ----
    private _itCargo = getBackpackCargo _veh;
    private _itIdx = (_itCargo select 0) find "vn_b_pack_ba18_01";
    private _currentBA18 = if (_itIdx >= 0) then {
        (_itCargo select 1) select _itIdx
    } else {
        0
    };

    // ---- Refill only if below target ----
    if (_currentB < _targetB) then {
        _veh addBackpackCargoGlobal [
            "B_Parachute",
            _targetB - _currentB
        ];
    };

    if (_currentBA18 < _targetBA18) then {
        _veh addBackpackCargoGlobal [
            "vn_b_pack_ba18_01",
            _targetBA18 - _currentBA18
        ];
    };
}];

