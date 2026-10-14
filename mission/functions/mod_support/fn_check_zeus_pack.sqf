private _hasPack = isClass (configFile >> "CfgPatches" >> "zen_main") && {isClass (configFile >> "CfgPatches" >> "cba_main")};

player setVariable ["hasZeusPack", _hasPack];

if (!_hasPack) then {
    private _img = "<img size='6' image='custom\patches\duty_officer.paa' align='center'/>";
    private _text = "<br/><t color='#ff0000' size='3' shadow='1' shadowColor='#000000' align='center'>Warning!</t><br/>You must have the Bro-Nation Zeus Pack and CBA_A3 enabled to have curation access.<br/>";
    hint parseText (_img + _text);
};

_hasPack