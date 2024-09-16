/*
	File: fn_zones_create_site_wreck.sqf
	Author: @dijksterhuis
	Public: No
	
	Description:
		Creates an 'Wreck' site in the given zone.
		A 'Wreck' site is 1x Wrecked Blufor Helo object with bodies around it.

		The bodies need to have the "Recover Tags" holdAction run on them.
		The Wreck itself needs to be destroyed with the "Destroy Task" holdAction.
	
	Parameter(s):
		_zone - Zone marker name [STRING]
	
	Returns:
		Task data store [NAMESPACE]
	
	Example(s):
		[[0, 0, 0]] call vn_mf_fnc_zones_create_site_wreck
*/

params ["_pos"];

private _hmapParams = [
	createHashMapFromArray [
		["wreckClass", "vn_air_f4b_wreck"],
		["maxBodies", 2],
		["minBodies", 1]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_f100d_01_wreck"],
		["maxBodies", 1],
		["minBodies", 1]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_uh1c_01_wreck"],
		["maxBodies", 6],
		["minBodies", 3]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_uh1d_01_wreck"],
		["maxBodies", 6],
		["minBodies", 3]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_uh1d_med_wreck"],
		["maxBodies", 6],
		["minBodies", 3]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_oh6a_01_wreck"],
		["maxBodies", 4],
		["minBodies", 2]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_ch34_01_wreck"],
		["maxBodies", 6],
		["minBodies", 3]
	],
	createHashMapFromArray [
		["wreckClass", "vn_air_ah1g_01_wreck"],
		["maxBodies", 2],
		["minBodies", 1]
	]
];


[
	"wreck",
	_pos,
	"hq",
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;
		private _spawnData = selectRandom _hmapParams;

		/////////////////////////////////////////////////////////////////////////////////
		// Spawn Wreck Objects
		/////////////////////////////////////////////////////////////////////////////////

		private _wreckObj = (_spawnData get "wreckClass") createVehicle _pos;

		/////////////////////////////////////////////////////////////////////////////////
		// Spawn Body Objects
		/////////////////////////////////////////////////////////////////////////////////

		private _bodiesN = (_spawnData get "minBodies") max (
			ceil random (_spawnData get "maxBodies")
		);

		// get positions to spawn bodies
		// spawn in the random body class, also randomising body direction
		// TODO: radius is half what the site radius is defined as, not sure why we need to do this
		private _bodyObjs = (
        	[_pos, 4, _bodiesN] call vn_mf_fnc_sample_positions_circle
        )
			apply {

				private _bodyRandom = selectRandom [
					"Land_vn_b_prop_body_01",
					"Land_vn_b_prop_body_01_02",
					"Land_vn_b_prop_body_02",
					"Land_vn_b_prop_body_02_02"
				];

				private _bodyObj = _bodyRandom createVehicle _x;
				_bodyObj setDir (random 360);
				_bodyObj;
			}
		;

		/////////////////////////////////////////////////////////////////////////////////
		// Fixup objects and persist in vars
		/////////////////////////////////////////////////////////////////////////////////

		private _objects = _bodyObjs + [_wreckObj];

		_objects
			apply {
				[_x] call vn_mf_fnc_sites_utils_normalise_object_placement;
				[_x] call vn_mf_fnc_sites_object_zfixer_add_object;
				[_x, true] call para_s_fnc_enable_dynamic_sim;
			}
		;

		vn_site_objects append _objects;

		/////////////////////////////////////////////////////////////////////////////////
		// Random traps
		/////////////////////////////////////////////////////////////////////////////////

		if (random 1 < 0.3) then {

			// create a larger amount of punji traps than camps
			private _traps = ([9, ceil random 12] call vn_mf_fnc_range)
				apply {
					createMine [
						"vn_mine_punji_02",
						_pos,
						[],
						10
					]
				}
			;

			// deletes the mines once the zone is completed
			vn_site_objects append _traps;
		};

		/////////////////////////////////////////////////////////////////////////////////
		// Conditional AI Objective
		/////////////////////////////////////////////////////////////////////////////////

		// 20% chance to spawn an ambush
		if (random 1 < 0.2) then {
			_siteStore setVariable ["aiObjectives", [[_spawnPos, 0.5, 1] call para_s_fnc_ai_obj_request_ambush]];
		};

		/////////////////////////////////////////////////////////////////////////////////
		// Markers
		/////////////////////////////////////////////////////////////////////////////////

		private _markerPos = _spawnPos getPos [10 + random 20, random 360];

		private _mainMarker = createMarker [format ["Wreck_%1", _siteId], _markerPos];
		_mainMarker setMarkerType "o_plane";
		_mainMarker setMarkerText "Wreck";
		_mainMarker setMarkerAlpha 0;

		private _partialMarkerPos = _spawnPos getPos [10 + random 40, random 360];
		private _markerPartial = createMarker [format ["PartialWreck_%1", _siteId], _partialMarkerPos];
		_markerPartial setMarkerType "o_unknown";
		_markerPartial setMarkerAlpha 0;

		/////////////////////////////////////////////////////////////////////////////////
		// Finalise
		/////////////////////////////////////////////////////////////////////////////////

		_siteStore setVariable ["aiObjectives", []];
		_siteStore setVariable ["markers", [_mainMarker]];
		_siteStore setVariable ["partialMarkers", [_markerPartial]];
		_siteStore setVariable ["objectsToDestroy", _objects];
	},
	//Teardown condition check code
	{
		//Check if we need to teardown every 15 seconds.
		15 call _fnc_periodicallyAttemptTeardown;
	},
	//Teardown condition
	{
		params ["_siteStore"];
		[_siteStore] call vn_mf_fnc_sites_utils_std_check_teardown;
	},
	//Teardown code
	{
		params ["_siteStore"];
		[_siteStore] call vn_mf_fnc_sites_utils_std_teardown;
	}
] call vn_mf_fnc_sites_create_site;
