
#define NOTIFY_COLOR_BLACK {0,0,0,1}
#define NOTIFY_COLOR_WHITE {1,1,1,1}
#define NOTIFY_COLOR_WHITE_DULL {0.9,0.9,0.9,1}
#define NOTIFY_COLOR_ORANGE {0.8,0.5,0,1}
#define NOTIFY_COLOR_RED {0.8,0.06,0,1}
#define NOTIFY_COLOR_RED_HEAVY {1,0.3,0.2,1}
#define NOTIFY_COLOR_GREEN {0.7,1,0.3,1}
#define NOTIFY_COLOR_GREEN_HEAVY {0,1,0,0.6}


class CfgNotifications
{
	#include "..\paradigm\Client\configs\notifications.hpp"

	class Error {
		priority = 8;
		color[] = NOTIFY_COLOR_RED_HEAVY;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class BaseAttackImminent
	{
		title = $STR_vn_mf_notification_title_base_attack;
		description = $STR_vn_mf_notification_desc_base_attack_imminent;
		priority = 7;
		color[] = {0.8,0.06,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class BaseAttackPreparing
	{
		title = $STR_vn_mf_notification_title_base_attack;
		description = $STR_vn_mf_notification_desc_base_attack_preparing;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackImminent
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_imminent;
		priority = 7;
		color[] = {0.8,0.06,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackPreparing
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_preparing;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackShortened
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_shortened;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackLost
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_lost;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackExtended
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_extended;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};


	class NewSupportRequest
	{
		title = $STR_vn_mf_notification_title_new_support_request;
		description = "%2";
		priority = 6;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa";
	};

	class Support_Transport_AllOnboard
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_all_onboard;
		priority = 8;

		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class Support_Transport_Complete
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_complete;
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class Support_Transport_PlayersDead
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_players_dead;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class Support_Transport_TooClose
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_too_close;
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class Support_Transport_WrongLocation
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_wrong_location;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class TrainingSucceeded
	{
		title = $STR_vn_mf_notification_title_training;
		description = $STR_vn_mf_trainingcomplete;
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class TrainingFailedOneTraitPerTeam
	{
		title = $STR_vn_mf_notification_title_training;
		description = "%1 is limited to %2 player(s) with this role and %3 player(s) already have it.";
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class TrainingFailedOneTraitPerPlayer
	{
		title = $STR_vn_mf_notification_title_training;
		description = $STR_vn_mf_onetraitperplayer;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class TrainingFailedTeamNotAllowedTrait
	{
		title = $STR_vn_mf_notification_title_training;
		description = "%1 is not allowed to select this role.";
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class VehicleLockedToTeam
	{
		title = $STR_vn_mf_notification_title_vehicle_locked;
		description = $STR_vn_mf_vehicle_locked_to_team;
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

		class VehicleLockedToTeamMessage
	{
		title = $STR_vn_mf_notification_title_vehicle_locked;
		description = "%1";
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class ZoneCompleted
	{
		title = $STR_vn_mf_notification_title_zone_completed;
		description = "%1";
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class EmptyFoodItem
	{
		title = $STR_vn_mf_notification_title_empty_food_item;
		description = $STR_vn_mf_notification_desc_empty_food_item;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class NoFireZone 
	{
		title = "No Fire Zone";
		description = "Do not fire your weapon near the arsenal. Use the Gun Range!";
		priority = 8;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class NoExplosives 
	{
		title = "No Explosives";
		description = "Please equip a satchel or breaching charge!";
		priority = 8;
		color[] = {1,0,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class RadioTapStart
	{
		title = "Radio Tap Started";
		description = "Listening for radio chatter...";
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa";
	};

	class RadioTapFailed
	{
		title = "Radio Tap Failed";
		description = "You need explosives training and a wiretap kit!";
		priority = 8;
		color[] = {1,0,0,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class RadioTapSuccess
	{
		title = "Radio Tap Success";
		description = "Revealed nearby site(s)";
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class FireInTheHole
	{
		title = "Satchel Charge Set";
		description = "Get the heck outta dodge, its gonna blow!";
		priority = 8;
		duration = 10;
		color[] = {1,0,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class POWCapturedRed
	{
		title = $STR_vn_mf_notification_title_captured_pow;
		description = "%1";
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class POWCapturedBlue
	{
		title = $STR_vn_mf_notification_title_captured_pow;
		description = "%1";
		priority = 8;
		color[] = {0.2,0.3,1,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class CampBurnt
	{
		title = $STR_vn_mf_notification_burnt_camp;
		description = "%1";
		priority = 8;
		color[] = {0.2,1,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class CagesTooClose
	{
		title = $STR_vn_mf_notification_error;
		description = "%1";
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class AttackPreparing
	{
		title = $STR_vn_mf_notification_title_ao_attack;
		description = $STR_vn_mf_notification_desc_ao_attack_imminent;
		priority = 8;
		color[] = {0,0.06,0.8,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class AttackPreparingFailed
	{
		title = $STR_vn_mf_notification_title_ao_attack;
		description = "%1";
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class FriendlyFire
	{
		title = $STR_vn_mf_notification_title_friendly_fire;
		description = "%1";
		priority = 8;
		duration = 10;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class CommsEnabled
	{
		title = "Comms";
		description = "Enabled/Switched ::: %1";
		sound = "";
		soundClose = "";
		priority = 9;
		duration = 0.8;
		color[] = NOTIFY_COLOR_WHITE_DULL;
		iconPicture = "\A3\ui_f\data\map\markers\military\pickup_CA.paa";
	};

	class CommsDisabled : CommsEnabled
	{
		title = "Comms";
		description = "Disabled ::: %1";
		color[] = NOTIFY_COLOR_BLACK;
		iconPicture = "\A3\ui_f\data\map\markers\military\pickup_CA.paa";
	};

	class AdminLog
	{
		title = $STR_vn_mf_notification_title_admin_log;
		description = "%1";
		// @dijksterhuis: Reduced priority because there are so many notifications
		priority = 1;
		sound = ""; // testing
		soundClose = "";
		duration = 3;
		color[] = {0,0.8,0.8,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class ServerRestart 
	{
		title = "Scheduled Restart";
		description = "%1";
		priority = 8;
		color[] = {0.1,0.8,0.1,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class DacCongCapturingFlag
	{
		title = "Protect The Flag!";
		description = "Dac Cong are capturing the flag!";
		priority = 6;
		color[] = {1,0,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class DacCongCapturedFlag
	{
		title = "Flag Captured!";
		description = "You are failure! Dac Cong have captured the flag!";
		priority = 6;
		color[] = {1,0,0,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class BlueforRaisingFlag
	{
		title = "Raising Flag!";
		description = "Bluefor are raising the flag.";
		priority = 6;
		color[] = {0.2,0.3,1,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class BlueforRaisedFlag
	{
		title = "Raised Flag!";
		description = "Bluefor have raised the flag!";
		priority = 6;
		color[] = {0.2,0.3,1,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class NoDriverForSpawnerLocator: Error
	{
		title = "Locating Vehicle Spawner";
		description = "Cannot locate vehicle's spawner -- you are not the driver / pilot / co-pilot.";
		priority = 1;
		sound = "";
		soundClose = "";
		duration = 3;
	};

	class NoVehicleForSpawnerLocator : NoDriverForSpawnerLocator
	{
		description = "Cannot locate vehicle's spawner -- you are not driving a spawned vehicle.";
	};

	class SiteDestroyTaskActionsError: Error
	{
		title = "Error";
		description = "SiteDestroyTaskActionsError: please try again due to server desync.";
	};

	class ErrorEmotesBase
	{
		title = "Emotes Menu";
		description = "%1";
		priority = 1;
		sound = "";
		soundClose = "";
		duration = 3;
		color[] = NOTIFY_COLOR_RED_HEAVY;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class ErrorEmotesPlayerIncap: ErrorEmotesBase
	{
		description = "Cannot use emotes while incapacitated.";
	};

	class ErrorEmotesPlayerDead: ErrorEmotesBase
	{
		description = "Cannot use emotes while dead.";
	};

	class ErrorEmotesInVehicle: ErrorEmotesBase
	{
		description = "Cannot use emotes while in a vehicle.";
	};

	class ErrorEmotesInWater: ErrorEmotesBase
	{
		description = "Cannot use emotes while swimming.";
	};

	class ErrorEmotesNotOnGround: ErrorEmotesBase
	{
		description = "Cannot use emotes when not on the ground.";
	};

	class ErrorNotWhitelistedForTeam: Error
	{
		title = "Team Whitelisting";
		description = "Not whitelisted for %1 -- setting team to Mike Force.";
	};

	class ErrLightsourceAttachChemlightNotPermitted
	{
		title = "Light Source Attachment";
		description = "Only Spike Team units can attach chemlights.";
		priority = 3;
		color[] = NOTIFY_COLOR_RED_HEAVY;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class LightsourceAttachLosingEnergy : ErrLightsourceAttachChemlightNotPermitted
	{
		title = "Light Source Attachment";
		description = "Attached light source is running out of battery/energy.";
		color[] = NOTIFY_COLOR_ORANGE;
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class LightsourceAttachOutOfEnergy : ErrLightsourceAttachChemlightNotPermitted {
		title = "Light Source Attachment";
		description = "Attached light source ran out of battery/energy!";
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class IntelError: Error {
		title = "Intel Not Collected";
		description = "Keep looking at the intel object until it disappears!";
		priority = 8;
	};

	class IntelSuccess
	{
		title = "Intel Collected";
		description = "One of the pieces of intelligence has been collected!";
		priority = 3;
		color[] = NOTIFY_COLOR_GREEN;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

};
