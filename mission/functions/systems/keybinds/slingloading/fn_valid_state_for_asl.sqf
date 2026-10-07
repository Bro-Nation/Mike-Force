/*
    fn_asl_check_support

    Author: Bro-Nation Dev Team

    Checks whether the given player is in a helicopter or VTOL supported by
    Advanced Sling Loading (ASL), and verifies that the required ASL functions
    are available on the current machine.

    Params:
        _player          (OBJECT) - player whose vehicle should be checked
                                Default: objNull

    Returns:
        BOOL - true if the player is in an ASL-supported helicopter or VTOL
            and all required ASL functions are available
            false otherwise

    Behaviour:

        The function checks that the player:

            1. Is a valid object.
            2. Is currently inside a vehicle.
            3. Is inside a helicopter or VTOL.
            4. Has the required ASL functions available.
            5. Is inside a vehicle supported by ASL.

        If the required ASL functions are unavailable, the player receives:

            "No ASL Support on this machine"

        All other failed checks return false silently.

        A successful check returns true.

    Supported Vehicles:

        The vehicle must inherit from either:

            Helicopter
            VTOL_Base_F

        and must also be recognised by ASL_Is_Supported_Vehicle.

    ASL Functions Checked:

        ASL_Deploy_Ropes_Index
        ASL_Deploy_Ropes
        ASL_Extend_Ropes
        ASL_Get_Active_Ropes
        ASL_Get_Ropes_Count
        ASL_Get_Sling_Load_Points
        ASL_Is_Supported_Vehicle
        ASL_Shorten_Ropes

    Usage:

        [player] call fn_asl_check_support;

        Example:

            if ([player] call fn_asl_check_support) then {
                // ASL is available and the vehicle is supported
            };

    Locality:

        Safe to call on any machine.

        The function only checks ASL availability and vehicle support on the
        machine where it is executed. It does not perform any remote execution.

*/

params [
    ["_player", objNull, [objNull]]
];

if (isNull _player) exitWith { false };

private _heli = vehicle _player;

// Not in a vehicle at all
if (_heli isEqualTo _player) exitWith { false };

// In a vehicle but it's not a helicopter *or* VTOL (unlikely to be an issue on vietnam but just in case)
if !((_heli isKindOf "Helicopter") || {_heli isKindOf "VTOL_Base_F"}) exitWith { false };

// Check we have ASL available and that the functions we need exist
private _aslFns = [
    "ASL_Deploy_Ropes_Index",
    "ASL_Deploy_Ropes",
    "ASL_Extend_Ropes",
    "ASL_Get_Active_Ropes_With_Cargo",
    "ASL_Get_Active_Ropes",
    "ASL_Get_Ropes_Count",
    "ASL_Get_Sling_Load_Points",
    "ASL_Is_Supported_Vehicle",
    "ASL_Release_Cargo",
    "ASL_Retract_Ropes",
    "ASL_Shorten_Ropes"
];

if (({isNil _x} count _aslFns) > 0) exitWith {
    systemChat "No ASL Support on this machine";
    false
};

// Vehicle must have ASL Support
if !([_heli] call ASL_Is_Supported_Vehicle) exitWith {
    false
};

// We have ASL and it's method interface matches what we expected
true;