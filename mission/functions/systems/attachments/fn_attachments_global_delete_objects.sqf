/*
    File: fn_attachments_global_delete_all.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Delete lightsources and attached objects.

        createVehicle is global, so this should sync across everyone and everything.

        also resets the JIP queue.

    Parameter(s): none.
    Returns: nothing
    Example(s):
        [player] call vn_mf_fnc_attachments_global_delete_all;
*/
params ["_player"];

private _obs = attachedObjects _player select {
	toLower (typeOf _x) in [
		"#lightreflector",
		"chemlight_red",
		"chemlight_blue",
		"chemlight_green",
		"chemlight_yellow",
		"chemlight_blue_lit",
		"chemlight_green_lit",
		"chemlight_yellow_lit",
		"chemlight_red_lit",
		"vn_mx991",
		"vn_mx991_red",
		"vn_b_item_mx991_01"
	]
} apply {deleteVehicle _x};