/*
  Minimal helper marker drawer — just arrow, main text, and sub text.
  [_posATL, "STR_TITLE", "STR_SUB"] call vn_mf_fnc_spawnHelpMarkers_drawPlaque3D;
*/

params ["_posATL", "_strTitle", ["_strSub",""]];

// --- localize strings
private _title = localize _strTitle;
if (_title isEqualTo _strTitle && {toLower _strTitle find "str_" == 0}) then {_title = "??"};

private _sub = "";
if !(_strSub isEqualTo "") then {
  private _s = localize _strSub;
  if !(_s isEqualTo _strSub && {toLower _strSub find "str_" == 0}) then {_sub = _s;};
};

// --- Width math (for centered text)
private _widthCoef = getNumber (configFile >> "CfgInGameUI" >> "Cursor" >> "activeWidth");
private _w1 = (_title getTextWidth ["RobotoCondensedBold", 0.04]) / _widthCoef;
private _w2 = (_sub   getTextWidth ["RobotoCondensedBold", 0.03]) / _widthCoef;
private _w  = (_w1 max _w2) + 0.016 / _widthCoef;

// --- Txt vertical offsets
private _ofsMain = -2.8;
private _ofsSub  = -1.55;

// ---------- arrow ----------
drawIcon3D [
  "\a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa",
  [1, 1, 1, 1],
  _posATL,
  0.55,
  0.55,
  2
];

// ---------- main text ----------
drawIcon3D [
  "",
  [1, 1, 1, 1],
  _posATL,
  _w, _ofsMain, 0,
  _title,
  2,
  0.04,
  "RobotoCondensedBold",
  "center"
];

// ---------- sub text ----------
drawIcon3D [
  "",
  [0.9, 0.9, 0.9, 1],
  _posATL,
  _w, _ofsSub, 0,
  _sub,
  2,
  0.03,
  "RobotoCondensedBold",
  "center"
];
