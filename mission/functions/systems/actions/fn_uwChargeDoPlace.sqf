/*
    File: fn_adv_explosives_water_doPlace.sqf
    Author: veteran29
    Modified By: 04 SN S. "Scoop" Cooper
    Date: 2022-03-25
    Public: Yes

    Description:
        Handle in water explosive placement.

    Parameter(s):
        _unit       - Unit placing the explosive                    [OBJECT]
        _magazine   - Magazine that is used to place the explosive  [STRING]

    Returns:
        Action ID [NUMBER]

    Example(s):
        [player, "vn_mine_limpet_01_mag"] call vn_fnc_adv_explosives_water_addAction;
*/

params ["_unit", "_magazine"];


private _ammoClass = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");

private _ammo = createVehicle [_ammoClass, position player, [], 0, "CAN_COLLIDE"];


// try to attach the explosive to the object
[_unit, _ammo, 2.1] call vn_mf_fnc_uwChargePlacement;


// abort if explosive was not attached to anything
if (isNull attachedTo _ammo) exitWith {
    deleteVehicle _ammo;

    titleText [localize "STR_VN_ADV_EXPLOSIVES_ACT_ATTACH_ERROR", "PLAIN", -1, false];
    titleFadeOut 2;
};

// block the action temporarily upon placement
vn_explosive_actionInProgress = true;
[] spawn {sleep 2;vn_explosive_actionInProgress = false;};

_unit playActionNow "PutDown";
getArray (configFile >> "CfgAmmo" >> _ammoClass >> "soundActivation") params ["_soundPath", "_soundVolume", "_soundFreq", "_soundDist"];
playSound3D [_soundPath, _ammo, false, _ammo, _soundVolume, _soundFreq, _soundDist];

// "use" the magazine
_unit removeMagazine _magazine;

// assign the mine to the unit and make it known
_unit addOwnedMine _ammo;
side group _unit revealMine _ammo;

_ammo // return
