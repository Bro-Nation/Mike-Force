/*
	File: fn_group_init.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates and initialize groups and duty officers
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		call vn_mf_fnc_group_init;
*/

vn_mf_duty_officers = [];
vn_mf_groups = [];

// Load team config once for compatibility with existing systems.
private _groups = "true" configClasses (_gamemode_config >> "teams" );

// Keep team arrays initialized, even though duty officer spawning is marker-driven.
{
	private _groupName = configName _x;
	missionNamespace setVariable [_groupName, []];
	publicVariable _groupName;
	vn_mf_groups pushBack _groupName;
} forEach _groups;

private _groupConfigByMarker = createHashMap;
{
	_groupConfigByMarker set [toLower (configName _x), _x];
} forEach _groups;

// Spawn duty officers from all map markers named duty_officer_*
private _dutyOfficerMarkers = allMapMarkers select { (toLower _x) find "duty_officer_" isEqualTo 0 };
_dutyOfficerMarkers sort true;

{
	private _marker = _x;
	private _groupKey = toLower (_marker select [13]);
	private _config = _groupConfigByMarker getOrDefault [_groupKey, configNull];
	private _class = "vn_b_men_army_01";
	if !(isNull _config) then
	{
		private _configuredClass = getText(_config >> "unit");
		if (_configuredClass isNotEqualTo "") then
		{
			_class = _configuredClass;
		};
	};

	private _location = getMarkerPos _marker;
	private _direction = markerDir _marker;

	if !(_location isEqualTo [0,0,0]) then
	{
		// duty officer agent
		private _agent = createAgent [_class, _location, [], 0, "CAN_COLLIDE"];
		_agent allowDamage false;
		_agent setDir _direction;

		_id = _agent spawn {
			removeAllWeapons _this;
			_this switchmove "";
			uiSleep 1;
			_this enableSimulationGlobal false;
			_this disableAI "ALL";
			_this setCaptive true;
		};

		if ((toLower _marker) isEqualTo "duty_officer_satansangels") then //gotta do jank cause it's a prop
		{
			vehicle _agent setVehiclePosition [_location,[],0,"None"];
		};

		//Set up custom interaction overlay
		_agent setVariable ["#para_InteractionOverlay_ConfigClass", "DutyOfficer", true];

		// save duty officers to array for later use
		vn_mf_duty_officers pushBack _agent;
	};
} forEach _dutyOfficerMarkers;

// broadcast duty officers
publicVariable "vn_mf_duty_officers";


