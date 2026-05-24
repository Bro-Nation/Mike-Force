/*
    setup_popup_target.sqf
    Adds the popup target hit handlers to a target object.

    Params: [_target]
*/

private _target = objNull;

if (_this isEqualType []) then {
    if ((count _this) > 0) then {
        private _candidate = _this select 0;
        if (_candidate isEqualType objNull) then {
            _target = _candidate;
        };
    };
} else {
    if (_this isEqualType objNull) then {
        _target = _this;
    };
};

if (isNull _target) exitWith {};

if (_target getVariable ["mf_popupConfigured", false]) exitWith {};
_target setVariable ["mf_popupConfigured", true];

_target addEventHandler ["HitPart", {
    [(_this select 0)] execVM "training\scripts\PopUpTarget.sqf";
}];

_target addEventHandler ["Hit", {
    (_this select 0) animate ["Terc", 1];
}];

_target addEventHandler ["HitPart", {
    private _spr = "Sign_Sphere10cm_F" createVehicle [0, 0, 0];
    _spr setPosASL (_this select 0 select 3);

    private _shooter = _this select 0 select 1;
    if (_shooter isEqualType objNull && {!isNull _shooter}) then {
        private _temp = _shooter getVariable ["hitMarkers", []];
        _temp pushBack _spr;
        _shooter setVariable ["hitMarkers", _temp];
    };
}];
