private _result = false;

if (!(isClass (configFile >> "CfgPatches" >> "zen_main")) || !(isClass (configFile >> "CfgPatches" >> "cba_main"))) exitWith {  
	// Bro-Nation Zeus Pack is not loaded so we can't use the curator system 
	_imag  = "<img size='6'  image='custom\patches\duty_officer.paa' align='center'/>"; 
	_text = "<br/><t color='#ff0000' size='3' shadow='1' shadowColor='#000000' align='center'>Warning!</t><br/>You must have the Bro-Nation Zeus Pack and CBA_A3 enabled to have curation access.<br/>"; 
	hint parseText (_imag + _text); 

	player setVariable ["hasZeusPack", false];

	_result
}; 

player setVariable ["hasZeusPack", true];

_result = true;
_result