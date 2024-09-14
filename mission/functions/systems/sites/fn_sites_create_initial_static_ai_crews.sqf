/*
    File: fn_sites_create_initial_static_ai_crews.sqf
    Author: @dijksterhuis
    Public: No
    
    Description:
		Creates new AI groups to crew specific static weapons within an AO.
		This happens immediately after all sites have been spawned, so that
		we can have AI on the sites and ready to go before players are on
		the ground -- which is when AI will start being spawned otherwise.

		These AI units will dismounted from the static weapon when the unit
		dies, allowing paradigm managed AI to come in and mount the statics
		later.

		I've nerfed from crewing ALL static weapons to just AA/Arty statics
		for now. See how they take it.
    
    Parameter(s):
		None

    Returns:
		None
    
    Example(s):
		[] call vn_mf_fnc_sites_create_initial_static_ai_crews
*/

private _initialMountedAiGroups = vn_site_objects
	select {
		(typeOf _x) in [
			// mortar / art obj
			'vn_o_nva_navy_static_mortar_type63',
			'vn_o_nva_65_static_mortar_type53',
			'vn_o_nva_static_d44_01',
			'vn_o_nva_navy_static_mortar_type63',
			'vn_o_nva_65_static_mortar_type53',
			'vn_o_nva_static_d44_01',
			// more mortars?
			"vn_o_nva_navy_static_mortar_type63",
			"vn_o_nva_navy_static_mortar_type53",
			"vn_o_nva_65_static_mortar_type53",
			"vn_o_nva_65_static_mortar_type63",
			"vn_o_nva_static_mortar_type53",
			"vn_o_nva_static_mortar_type63",
			"vn_o_vc_static_mortar_type53",
			"vn_o_vc_static_mortar_type63",
			"vn_o_nva_65_static_d44",
			"vn_o_nva_65_static_d44_01",
			"vn_o_nva_navy_static_d44",
			"vn_o_nva_navy_static_d44_01",
			"vn_o_nva_static_d44",
			"vn_o_nva_static_d44_01",
			"vn_o_vc_static_d44",
			"vn_o_vc_static_d44_01",
			// AA
			'vn_o_nva_navy_static_zpu4',
			'vn_o_nva_65_static_zpu4',
			"vn_o_nva_static_zpu4"
		];
	}
	apply {
		// force enable simulation otherwise the AI can't shoot
		// for some reason
		_x enableSimulationGlobal true;
		private _grpCrew = createVehicleCrew _x;

		// TODO: Refactor paradigm fn_loadbal_create_squad.sqf into two functions:
		// * fn_loadbal_change_group_owner.sqf
		// * fn_loadbal_create_squad.sqf (calls fn_loadbal_change_group_owner)

		//Set the squad's locality to the headless client with highest FPS
		// Or the server if no headless clients
		private _selectedClient = call para_s_fnc_loadbal_suggest_host;

		_grpCrew setGroupOwner _selectedClient;
		_grpCrew setVariable ["groupClientOwner", _selectedClient];

		(units _grpCrew)
			apply {
				_x addEventHandler ["Killed", {
					params ["_unit", ""];
					// force eject the crew when killed
					moveOut _unit;
					[_unit] call para_s_fnc_cleanup_add_items;
				}];

				// TODO: Refactor paradigm fn_loadbal_create_squad.sqf into two functions:
				// * fn_loadbal_change_group_owner.sqf
				// * fn_loadbal_create_squad.sqf (calls fn_loadbal_change_group_owner)

				//Update the owner variable if the group changes locality.
				//Can't run this on the group itself - need to use the units in it.
				_x addEventHandler ["Local", {
					params ["_unit", "_isLocal"];
					if (_isLocal) then {
						group _unit setVariable ["groupClientOwner", clientOwner, true];
					};
				}];
			};

		// initialise the behaviour system to trick the owner into processing these AI
		// with the paradigm AI behaviour scripts.

		// see: paradigm/server/ai_objectives/fn_ai_obj_request_defend.sqf
		_grpCrew setVariable ["orders", ["defend", getPos ((units _grpCrew) select 0)], true];

		// see: paradigm/global/ai_behavior/fn_ai_run_behaviours_all_groups.sqg
		_grpCrew setVariable ["behaviourEnabled", true];

		_x;
	};

/*
persist so we can delete easily if there are issues with the AI.

command below will delete all AI units that were initially spawned
in on AA/Mortars without deleting the static weapon the AI unit was
a crew member of.

in server side debug console:

```sqf
(missionNamespace getVariable "siteInitialMountedAiGroups") apply {
    (crew _x) apply {deleteVehicle _x}
}
```
*/
missionNamespace setVariable ["siteInitialMountedAiGroups", _initialMountedAiGroups];

