params ["_player"];

// No interface not a player
if(!hasInterface) exitWith {
    diag_log format ["[CURATOR] ERROR: Player %1 (%2) does not have an interface, cannot init curator", name _player, _playerUID];
    false;
};

// Missing zeus pack
if (!([] call vn_mf_fnc_check_zeus_pack)) exitWith {
    diag_log format ["[CURATOR] Player %1 missing required mods (ZEN/CBA)", name _player];
    false
};

true;