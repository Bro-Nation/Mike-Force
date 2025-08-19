*/*
    File: fn_addHangarLights.sqf
    Author: Legend
    Public: No

    Description: Adds light clusters grouped by hangar


    Parameter(s):
        none.

    Returns: nothing

    Example(s):
        call fn_addHangarLights;
*/

{
    private _pos = _x;

    private _reflector = "#lightreflector" createVehicleLocal [0, 0, 0];
    _reflector setPosASL _pos;
    _reflector setLightColor [400, 300, 240];
    _reflector setLightAmbient [4, 3, 2.5];
    _reflector setLightIntensity 10;
    _reflector setLightConePars [120, 70, 1];
    _reflector setLightVolumeShape ["a3\data_f\VolumeLightFlashlight.p3d", [1, 1, 1]];
    _reflector setVectorDirAndUp [[0, 0, -1], [0, 1, 0]];

    private _glow = "#lightpoint" createVehicleLocal [0, 0, 0];
    _glow setPosASL _pos;
    _glow setLightColor [400, 300, 240];
    _glow setLightAmbient [4, 3, 2.5];
    _glow setLightUseFlare true;
    _glow setLightFlareSize 0.5;
    _glow setLightFlareMaxDistance 250;
    _glow setLightIntensity 10;
    _glow setLightAttenuation [0, 0.1, 0.2, 0.8, 110, 150, 1];
} forEach [
    // 7TH CAV
    [16002.0,7119.23,23.2478],
    [16013.1,7119.08,23.2748],
    [16002.0,7120.60,23.2748],
    [16002.1,7128.05,23.2748],
    [16002.0,7129.43,23.2748],
    [16002.2,7136.90,23.2748],
    [16002.2,7138.29,23.2748],
    [16013.1,7120.44,23.2748],
    [16013.2,7127.90,23.2748],
    [16013.2,7129.29,23.2748],
    [16013.2,7136.74,23.2748],
    [16013.3,7138.13,23.2748],

    // Muskets
    [15902.3,6817.18,23.4761],
    [15902.3,6818.55,23.5031],
    [15902.4,6825.99,23.5031],
    [15902.5,6827.38,23.5031],
    [15902.6,6834.84,23.5031],
    [15902.6,6836.22,23.5031],
    [15913.4,6816.93,23.5031],
    [15913.4,6818.31,23.5031],
    [15913.5,6825.77,23.5031],
    [15913.5,6827.15,23.5031],
    [15913.7,6834.58,23.5031],
    [15913.7,6835.99,23.5031],

    // Spike Team
    [15951.1,6816.01,23.4730],
    [15951.2,6817.39,23.5000],
    [15951.4,6824.86,23.5000],
    [15951.4,6826.20,23.5000],
    [15951.6,6833.72,23.5000],
    [15951.6,6835.06,23.5000],
    [15962.2,6815.73,23.5000],
    [15962.3,6817.10,23.5000],
    [15962.5,6824.54,23.5000],
    [15962.5,6825.91,23.5000],
    [15962.7,6833.35,23.5000],
    [15962.7,6834.76,23.5000],

    // Supply
    [15714.8,7131.76,23.3400],
    [15714.8,7144.98,23.3400],
    [15714.8,7158.19,23.3400],
    [15735.6,7144.79,24.2420],
    [15723.4,7131.77,24.2420],
    [15723.5,7144.96,24.2420],
    [15735.5,7131.58,24.2420],
    [15723.5,7158.19,24.2420],
    [15744.2,7144.76,23.3400],
    [15744.2,7131.56,23.3400],
    [15735.6,7157.99,24.2420],
    [15744.2,7158.00,23.3400]
];
