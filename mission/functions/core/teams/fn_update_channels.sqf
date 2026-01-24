/*
    File: fn_update_channels.sqf
    Author: Cerebral
    Modified: @dijksterhuis
    Public: No
    
    Description:

        Update player's chat channels.

		Reference: https://community.bistudio.com/wiki/enableChannel

		base game:

		0 ===> Global
		1 ===> Side
		2 ===> Command
		3 ===> Group
		4 ===> Vehicle
		5 ===> Direct

		custom:

		6 ===> Ground (CC1)
		7 ===> Air (CC2)
		8 ===> ACAV (CC3)
		9 ===> MACV (CC4)

		Note that custom radio channel specific functions like `radioChannelAdd`
		and `radioChannelRemove` will refer to channel 6 as custom channel 1,
		channel 7 as custom channel 2 and channel 8 as custom channel 3.

		Just to keep life interesting.
    
    Parameter(s):
		None
    
    Returns:
	   	Nothing
    
    Example(s):
		call vn_mf_fnc_update_channels.sqf
*/

private _team = player getVariable "vn_mf_db_player_group";

if (side player == east) exitWith {
	1 radioChannelRemove [player];
	2 radioChannelRemove [player];
	3 radioChannelRemove [player];
};
	
4 radioChannelAdd [player];

0 enableChannel [false, false];
1 enableChannel [true, false];
2 enableChannel [false, false];

6 enableChannel [false, false];
7 enableChannel [false, false];
8 enableChannel [false, false];
9 enableChannel [false, false];

switch(_team) do
{
	case "MikeForce" : {
		1 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "SpikeTeam" : {
		1 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "ACAV" : {
		3 radioChannelAdd [player];

		8 enableChannel [true, true];
	};

	case "GreenHornets" : {
		2 radioChannelAdd [player];

		7 enableChannel [true, true];
	};

	case "3rdMEU" : {
		1 radioChannelAdd [player];

		6 enableChannel [true, true];
	};

	case "MilitaryPolice" : {
		1 radioChannelAdd [player];

		6 enableChannel [true, true];
	};

	case "QuarterHorse" : {
		1 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "ARVN" : {
		1 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "Frogmen" : {
		1 radioChannelAdd [player];

		6 enableChannel [true, true];
	};

	case "Muskets" : {
		1 radioChannelAdd [player];
		2 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		7 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "SatansAngels" : {
		1 radioChannelAdd [player];
		2 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		7 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "633rdTASG" : {
		1 radioChannelAdd [player];
		2 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		7 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "Montagnard" : {
		1 radioChannelAdd [player];

		6 enableChannel [true, true];
	};

	case "TigerForce" : {
		1 radioChannelAdd [player];

		6 enableChannel [true, true];
	};

	case "7thCAV" : {
		1 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "SASR" : {
		1 radioChannelAdd [player];
		2 radioChannelAdd [player];

		6 enableChannel [true, true];
		7 enableChannel [true, true];
	};

	case "PressCorp" : {
		1 radioChannelAdd [player];
		2 radioChannelAdd [player];
		3 radioChannelAdd [player];

		6 enableChannel [true, true];
		7 enableChannel [true, true];
		8 enableChannel [true, true];
	};

	case "MACV" : {
		1 radioChannelAdd [player];
		2 radioChannelAdd [player];
		3 radioChannelAdd [player];

		0 enableChannel [true, true];
		6 enableChannel [true, true];
		7 enableChannel [true, true];
		8 enableChannel [true, true];
		9 enableChannel [true, true];
	};
};

// enable global chanel for curators
if ((missionNamespace getVariable ['curatorUIDs', []]) findIf { _x == getPlayerUID player } > -1) then {
    0 enableChannel [true, true];
};