params ["_lightsource", "_classname", "_vectorDir"];

private _colorAmbient = [0, 0, 0];
private _colorLight = [0, 0, 0];

switch (_classname) do { 
	case "vn_mx991": {
		_colorAmbient = [00.03515625, 0.029296875, 0.0234375];
		_colorLight = [0.703125, 0.5859375, 0.46875];
	}; 
	case "vn_mx991_red": {
		_colorAmbient = [0.03515625, 0.01953125, 0.00390625];
		_colorLight = [0.8, 0.19921875, 0];
	};
	default {
		_colorAmbient = [0, 0, 0];
		_colorLight = [0, 0, 0];
	}; 
};

_lightsource setLightIntensity 4500; 
_lightsource setLightAmbient _colorAmbient; 
_lightsource setLightColor _colorLight; 
_lightsource setLightConePars [100, 60, 20];
_lightsource setLightDayLight false;
_lightsource setLightUseFlare true;
_lightsource setLightFlareSize 0.8;
_lightsource setLightFlareMaxDistance 150;
_lightsource setLightAttenuation [1, 0, 0, 5, 1, 50];
_lightsource setVectorDirAndUp [_vectorDir apply {_x * -1}, [0, 0, 1]];
