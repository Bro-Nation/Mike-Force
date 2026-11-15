/*
    File: fn_ui_sub_menu.sqf
    Author: Savage Game Design
    Public: Yes

    Description:
	Enhanced Arma3 Inventory - Dynamic inventory (Double-Click) sub menu.

    Parameter(s):
	_main_control - Player [STRING, defaults to DEFAULTVALUE]
	_idc - Player [NUMBER, defaults to DEFAULTVALUE]

    Returns:
	NOTHING

    Example(s):
	_this call vn_mf_fnc_ui_sub_menu;
*/

private ["_activeControl","_bg","_btn_arr","_buffer","_button_gen","_config","_control","_display","_eventCode","_interactActions","_interactedItem","_logicCheck","_magCount","_mainConfig","_mainMissionConfig","_pos","_repack","_repackConfig","_repackMissionConfig","_selectedItemConfig","_selectedItemMissionConfig","_start_idc","_thisItem","_thisItemType","_y2d"];


_interactActions = [];
_magCount = 1;
_thisItemType = 0;

// remove any previous array
_activeControl = uiNamespace getVariable ["vn_mf_active_button_control", controlNull];
if (!isNull _activeControl) then
{
    _activeControl ctrlShow false;
    ctrlDelete _activeControl;
};

params ["_main_control","_idc"];

// find selected item
['selectItem',_main_control,_idc] call vn_mf_fnc_armor_calc;

_interactedItem = uiNamespace getVariable ["vn_mf_interacted_item",[]];
if !(_interactedItem isEqualTo []) then
{
    _thisItem = _interactedItem select 1;

    // load action configs
    _mainMissionConfig = (missionConfigFile >> "CfgItemInteractions");
    _mainConfig = (configfile >> "CfgItemInteractions");
    // find item classes
    _selectedItemConfig = (_mainConfig >> _thisItem);
    _selectedItemMissionConfig = (_mainMissionConfig >> _thisItem);
    // prefer mission config over main
    if (isClass _selectedItemMissionConfig) then{
        _selectedItemConfig = _selectedItemMissionConfig;
    };

    // load ammo repack configs
    _repackConfig = (_mainConfig >> "AllAmmoSettings");
    _repackMissionConfig = (_mainMissionConfig >> "AllAmmoSettings");
    // prefer mission config over main
    if (isClass _repackMissionConfig) then
    {
	    _repackConfig = _repackMissionConfig;
    };
    _repack = getArray(_repackConfig >> "interactActions");


    // get actual item config
    _config = (configfile >> "CfgWeapons" >> _thisItem);
    if (isClass (_config)) then
    {
        _thisItemType = getNumber(_config >> "type");
    }
    else
    {
        _config = (configfile >> "CfgMagazines" >> _thisItem);
        _thisItemType = getNumber(_config >> "type");
        _magCount = getNumber(_config >> "count");
    };

    _interactActions = getArray(_selectedItemConfig >> "interactActions");

    private _resolvedMove = [_idc, _thisItem] call vn_mf_fnc_inventory_resolve_move;
    private _moveSource = _resolvedMove param [0, objNull];
    if (isNull _moveSource) then {
        switch (_idc) do {
            case 619: { _moveSource = backpackContainer player; };
            case 633: { _moveSource = uniformContainer player; };
            case 638: { _moveSource = vestContainer player; };
            case 632: { _moveSource = [player] call vn_mf_fnc_inventory_ground_holder; };
            case 640: { _moveSource = uiNamespace getVariable ["vn_mf_active_inventory_container", objNull]; };
            default { _moveSource = objNull; };
        };
    };
    private _moveSourceCount = if (isNull _moveSource) then { 0 } else { [_moveSource, _thisItem] call vn_mf_fnc_inventory_count };
    private _playerInventoryCount = 0;
    {
        private _slotContainer = switch (_x) do {
            case 619: { backpackContainer player };
            case 633: { uniformContainer player };
            case 638: { vestContainer player };
            default { objNull };
        };

        if !(isNull _slotContainer) then {
            _playerInventoryCount = _playerInventoryCount + ([_slotContainer, _thisItem] call vn_mf_fnc_inventory_count);
        };
    } forEach [619, 633, 638];

    private _selectedStackQty = if ((_idc in [619,633,638]) || {isNull _moveSource}) then {
        _playerInventoryCount
    } else {
        _moveSourceCount
    };

    private _dropSourceQty = if (_idc in [619,633,638]) then {
        _playerInventoryCount
    } else {
        _moveSourceCount
    };

    private _allMoveQty = _selectedStackQty max 0;

    if ((_idc in [619,633,638,640]) && {_dropSourceQty > 2}) then {
        _interactActions pushBack [
            "STR_vn_mf_drop_all",
            format ["['%1', %2, %3, 'drop'] call vn_mf_fnc_inventory_move_stack;", _thisItem, _idc, _dropSourceQty],
            format ["(%1 > 0)", _dropSourceQty],
            0,
            ""
        ];
    };

    if ((_idc in [619,633,638,640]) && {_dropSourceQty > 5}) then {
        _interactActions pushBack [
            "STR_vn_mf_drop_5",
            format ["['%1', %2, %3, 'drop'] call vn_mf_fnc_inventory_move_stack;", _thisItem, _idc, 5],
            format ["(%1 > 5)", _dropSourceQty],
            0,
            ""
        ];
    };

    if ((_idc in [619,633,638,640]) && {_dropSourceQty > 10}) then {
        _interactActions pushBack [
            "STR_vn_mf_drop_10",
            format ["['%1', %2, %3, 'drop'] call vn_mf_fnc_inventory_move_stack;", _thisItem, _idc, 10],
            format ["(%1 > 10)", _dropSourceQty],
            0,
            ""
        ];
    };

    if (_allMoveQty > 2) then {
        _interactActions pushBack [
            "STR_vn_mf_move_all",
            format ["['%1', %2, %3, 'move'] call vn_mf_fnc_inventory_move_stack;", _thisItem, _idc, _allMoveQty],
            format ["(%1 > 0)", _allMoveQty],
            0,
            ""
        ];
    };

    if (_selectedStackQty > 5) then {
        _interactActions pushBack [
            "STR_vn_mf_move_5",
            format ["['%1', %2, %3, 'move'] call vn_mf_fnc_inventory_move_stack;", _thisItem, _idc, 5],
            format ["(%1 > 5)", _selectedStackQty],
            0,
            ""
        ];
    };

    if (_selectedStackQty > 10) then {
        _interactActions pushBack [
            "STR_vn_mf_move_10",
            format ["['%1', %2, %3, 'move'] call vn_mf_fnc_inventory_move_stack;", _thisItem, _idc, 10],
            format ["(%1 > 10)", _selectedStackQty],
            0,
            ""
        ];
    };

    // ammo repack
    _disallowRepack =  getNumber(_selectedItemConfig >> "disallowRepack");
    if (_disallowRepack isEqualTo 0) then
    {
	    if (_magCount > 1) then
	    {
		    {_interactActions pushBack _x} forEach _repack;
	    };
    };

    private _chemlightsAttach = getArray (
        _mainMissionConfig >> "AttachmentsChemlights" >> "interactActions"
    );

    private _flashlightsAttach = getArray (
        _mainMissionConfig >> "AttachmentsFlashlights" >> "interactActions"
    );

    // light source attachments -- see: functions\systems\attachments

    if ((toLower _thisItem) find "chemlight" > -1) then {
        {_interactActions pushBack _x} forEach _chemlightsAttach;
    };


	// Flashlights!
    if (_thisItem in ["vn_mx991", "vn_mx991_red"]) then {
        {_interactActions pushBack _x} forEach _flashlightsAttach;
    };

    // build menu
    if !(_interactActions isEqualTo []) then
    {
        _display = ctrlParent (_main_control select 0);
        _pos = getMousePosition;

        _control = _display ctrlCreate ["RscControlsGroupNoScrollbars", 5678910];
        uiNamespace setVariable ["vn_mf_active_button_control", _control];

        _control ctrlSetPosition [(_pos select 0)-0.03,(_pos select 1)-0.03,1,1];
        _control ctrlCommit 0;

        _bg = _display ctrlCreate ["RscButtonTextOnly", 12349,_control];
        _bg ctrlSetPosition [0,0,1,1];
        _bg ctrlCommit 0;
        _bg ctrlAddEventHandler ["MouseEnter",
	{
            _activeControl = uiNamespace getVariable ["vn_mf_active_button_control", controlNull];
            if !(isNull _activeControl) then {
                _activeControl ctrlShow false;
            };
        }];

        _buffer = _display ctrlCreate ["RscButtonTextOnly", 12345,_control];
        _buffer ctrlSetPosition [0.02,0.02,0.25,0.0625 + (0.0625 * (count _interactActions))];
        _buffer ctrlAddEventHandler ["ButtonClick",
	{
            _activeControl = uiNamespace getVariable ["vn_mf_active_button_control", controlNull];
            if !(isNull _activeControl) then {
                _activeControl ctrlShow false;
            };
        }];

        _buffer ctrlCommit 0;

        _y2d = 0.06;
        _btn_arr = [];
        _start_idc = 12346;
        {
            _x params [["_btn_text",""],["_btn_code",""],["_btn_condition","true"],["_btn_mode",0],["_btn_fail_code",""]];
            _logicCheck  = call compile _btn_condition;
            // mode 0 = do not show button if condition is not met.
            // mode 1 = show button but execute alternate code when clicked.
            switch (_btn_mode) do
	    {
                case 1:
		{
                    _button_gen = _display ctrlCreate ["RscButtonMenu", _start_idc,_control];
                    _start_idc = _start_idc + 1;
                    _button_gen ctrlSetPosition [0.06,_y2d,0.20,0.06];
                    _button_gen ctrlSetText localize _btn_text;
                    _button_gen ctrlCommit 0;
                    if (_logicCheck) then
		    {
                        _eventCode = _btn_fail_code;
                        if !(_btn_fail_code find "vn_mf_fnc_inventory_move_stack" > -1) then {
                            _eventCode = format["_thisItem = '%1'; _thisItemType = %2;",_thisItem,_thisItemType] + _btn_fail_code;
                        };
                        _button_gen ctrlAddEventHandler ["ButtonClick",_eventCode];
                    } else {
                        _eventCode = _btn_code;
                        if !(_btn_code find "vn_mf_fnc_inventory_move_stack" > -1) then {
                            _eventCode = format["_thisItem = '%1'; _thisItemType = %2;",_thisItem,_thisItemType] + _btn_code;
                        };
                        _button_gen ctrlAddEventHandler ["ButtonClick",_eventCode];
                    };
                    _button_gen ctrlAddEventHandler ["ButtonClick","(uiNamespace getVariable ['vn_mf_active_button_control', controlNull]) ctrlShow false;"];
                    _y2d = _y2d + 0.0625;
                    _btn_arr pushBack _button_gen;
                };
                default
		{
			if (_logicCheck) then
			{
				_button_gen = _display ctrlCreate ["RscButtonMenu", _start_idc,_control];
				_start_idc = _start_idc + 1;
				_button_gen ctrlSetPosition [0.06,_y2d,0.20,0.06];
				_button_gen ctrlSetText localize _btn_text;
				_button_gen ctrlCommit 0;
				_eventCode = _btn_code;
				if !(_btn_code find "vn_mf_fnc_inventory_move_stack" > -1) then {
					_eventCode = format["_thisItem = '%1'; _thisItemType = %2;",_thisItem,_thisItemType] + _btn_code;
				};
				_button_gen ctrlAddEventHandler ["ButtonClick",_eventCode];
				_button_gen ctrlAddEventHandler ["ButtonClick","(uiNamespace getVariable ['vn_mf_active_button_control', controlNull]) ctrlShow false;"];
				_y2d = _y2d + 0.0625;
				_btn_arr pushBack _button_gen;
			};
                };
            };
        } forEach _interactActions;

        reverse _btn_arr;
        uiNamespace setVariable ["vn_mf_active_controls", ([_control,_bg,_buffer] + _btn_arr) ];
        {ctrlSetFocus _x} forEach (uiNamespace getVariable ["vn_mf_active_controls", []]);
    };
};
