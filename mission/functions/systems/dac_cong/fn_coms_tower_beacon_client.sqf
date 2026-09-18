/*
    File: fn_coms_tower_beacon_client.sqf
    Author: Legend
    Public: No

    Description:
        Client-side ambient beacon for coms towers.
        Plays a periodic 3D beep from the nearest built coms tower,
        with loudness increasing as the player gets closer.

    Parameter(s):
        None

    Returns:
        Nothing
*/

if (!hasInterface) exitWith {};
if (!isNil {missionNamespace getVariable "vn_mf_coms_tower_beacon_loop"}) exitWith {};

missionNamespace setVariable ["vn_mf_coms_tower_beacon_loop", true];

[] spawn {
    private _loopInterval = missionNamespace getVariable ["vn_mf_coms_tower_beacon_loop_interval", 30];
    private _scanInterval = 5;
    private _sideCheckInterval = 10;
    private _maxRange = 300;
    private _minRange = 40;
    private _minVolume = 0.12;
    private _maxVolume = 2.0;
    private _soundPath = "a3\sounds_f\sfx\beep_target.wss";
    private _defaultAudibleSides = [west];

    private _nextScanAt = 0;
    private _nextLoopAt = time + 2;
    private _nextSideCheckAt = 0;
    private _trackedTower = objNull;
    private _isEligibleListener = true;
    private _isOpforListener = false;
    private _supportRadius = missionNamespace getVariable ["vn_mf_opfor_support_access_radius", 500];
    private _towerMarkerName = format ["vn_mf_opfor_coms_tower_%1", getPlayerUID player];
    private _towerRadiusMarkerName = format ["vn_mf_opfor_coms_tower_radius_%1", getPlayerUID player];

    private _removeLocalTowerMarkers = {
        if (_towerMarkerName in allMapMarkers) then {
            deleteMarkerLocal _towerMarkerName;
        };
        if (_towerRadiusMarkerName in allMapMarkers) then {
            deleteMarkerLocal _towerRadiusMarkerName;
        };
    };

    private _updateLocalTowerMarkers = {
        params ["_tower"];

        if (isNull _tower) exitWith {
            call _removeLocalTowerMarkers;
        };

        private _towerPos = getPos _tower;

        if !(_towerMarkerName in allMapMarkers) then {
            createMarkerLocal [_towerMarkerName, _towerPos];
            _towerMarkerName setMarkerTypeLocal "mil_triangle";
            _towerMarkerName setMarkerColorLocal "ColorRed";
            _towerMarkerName setMarkerTextLocal "";
        } else {
            _towerMarkerName setMarkerPosLocal _towerPos;
        };

        if !(_towerRadiusMarkerName in allMapMarkers) then {
            createMarkerLocal [_towerRadiusMarkerName, _towerPos];
            _towerRadiusMarkerName setMarkerShapeLocal "ELLIPSE";
            _towerRadiusMarkerName setMarkerBrushLocal "Border";
            _towerRadiusMarkerName setMarkerColorLocal "ColorRed";
            _towerRadiusMarkerName setMarkerAlphaLocal 0.9;
            _towerRadiusMarkerName setMarkerSizeLocal [_supportRadius, _supportRadius];
        } else {
            _towerRadiusMarkerName setMarkerPosLocal _towerPos;
        };
    };

    while {true} do {
        uiSleep 2;

        if (!isNull player && {alive player}) then {
            if (time >= _nextSideCheckAt) then {
                _nextSideCheckAt = time + _sideCheckInterval;
                private _audibleSides = missionNamespace getVariable ["vn_mf_coms_tower_beacon_audible_to_sides", _defaultAudibleSides];
                _isEligibleListener = (side player) in _audibleSides;
                _isOpforListener = (side player) isEqualTo east;
            };

            // Tower scan and marker update runs for everyone — sound eligibility is checked separately below.
            if (time >= _nextScanAt) then {
                _nextScanAt = time + _scanInterval;

                private _candidateTowers = [];
                private _activeZones = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];
                private _aoMarker = _activeZones param [0, ""];
                if (_aoMarker in allMapMarkers) then {
                    private _aoCenter = markerPos _aoMarker;
                    private _aoRadius = getNumber (missionConfigFile >> "map_config" >> "bn_zone_radius") + 100;
                    _candidateTowers = nearestObjects [_aoCenter, ["Land_vn_ttowersmall_2_f"], _aoRadius, true];
                };
                private _builtTowers = _candidateTowers select {
                    alive _x && {
                        private _building = _x getVariable ["para_g_building", objNull];
                        !isNull _building && {_building getVariable ["para_g_building_constructed", false]}
                    }
                };

                if (_builtTowers isEqualTo []) then {
                    _trackedTower = objNull;
                } else {
                    _trackedTower = _builtTowers param [0, objNull];
                };

                // Markers are OPFOR-only; non-OPFOR players never see them.
                if (_isOpforListener) then {
                    [_trackedTower] call _updateLocalTowerMarkers;
                } else {
                    call _removeLocalTowerMarkers;
                };
            };

            // Beacon sound is only played for eligible sides (Bluefor by default).
            if (_isEligibleListener && {time >= _nextLoopAt}) then {
                _nextLoopAt = time + _loopInterval;

                if (!isNull _trackedTower && {alive _trackedTower}) then {
                    private _dist = player distance _trackedTower;
                    if (_dist <= _maxRange) then {
                        private _clampedDist = (_dist max _minRange) min _maxRange;
                        private _proximity = 1 - ((_clampedDist - _minRange) / (_maxRange - _minRange));
                        private _volume = _minVolume + ((_maxVolume - _minVolume) * _proximity);

                        playSound3D [_soundPath, _trackedTower, false, getPosASL _trackedTower, _volume, 1, _maxRange];
                    };
                };
            };
        };
    };
};
