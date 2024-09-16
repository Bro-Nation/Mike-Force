class capture_zone : task
{
	taskcategory = "PRI";
	tasktitle = "Capture Zone";
	taskname = "Capture Zone";
	taskdesc = "Defeat hostile forces and sites the marked zone. Sites spawn inside the yellow circle.";
	tasktype = "attack";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\p\vn_ui_mf_task_p1.jpg";
	rankpoints = 30;

	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_pri_capture";
		timeout = -1;
	};

	class destroy_hq_sites
	{
		taskname = "Destroy HQ Supply Line";
		taskdesc = "Destroy HQ supplies and the sites they're delivered to. You might find intel inside for the locations to the rest of the sites!";
	};

	// TODO: @dijksterhuis: All references to this need cleaning up at a later date to stop referring to the "Factory"
	// https://github.com/Bro-Nation/Mike-Force/pull/400
	class destroy_factory_sites
	{
		taskname = "Destroy Depot Supply Line";
		taskdesc = "Destroy Depot supplies and the sites they're delivered to. You might find intel inside for the locations to the rest of the sites!";
	};

	class build_fob
	{
		taskname = "Build FOB";
		taskdesc = "Build a situation room to establish a Forward Operating Base.";
	};

	class build_respawn
	{
		taskname = "Build FOB Respawn Point";
		taskdesc = "Build a respawn so we can reinforce the Forward Operating Base.";
	};

	class build_landing_pad
	{
		taskname = "Build FOB Landing Pad";
		taskdesc = "Build a landing pad so helos can land near the FOB. Emphasis on near!";
	};

	class build_rearm_repair_refuel
	{
		taskname = "Build FOB Rearm/Repair/Refuel Station";
		taskdesc = "Build a Vehicle Rearm/Repair/Refuel location at the FOB. Possibly next to the helipad.";
	};

	class build_flag
	{
		taskname = "Build FOB Flag";
		taskdesc = "Build a flag to take ownership of this Forward Operating Base.";
	};
};

class prepare_zone : task
{
	taskcategory = "PRI";
	tasktitle = "Prepare for next zone";
	taskname = "Prepare for next zone";
	taskdesc = "Get ready for the next zone!";
	tasktype = "repair";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\p\vn_ui_mf_task_p1.jpg";
	rankpoints = 30;

	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_pri_prepare";
		timeout = -1;
	};
	class rtb
	{
		taskname = "Return To Base";
		taskdesc = "Return to base to regroup and rearm for the next zone.";
	};
	class go_away_rtb
	{
		taskname = "Leave The Zone!";
		taskdesc = "Charlie isn't ready yet! Leave the blue zone immediately!";
	};
	class prepare
	{
		taskname = "Prepare Your Assault";
		taskdesc = "Co-ordinate, plan and prepare to fight enemy forces in the zone.";
	};
	class go_away_prepare
	{
		taskname = "Leave The Zone!";
		taskdesc = "Charlie still isn't ready yet! Leave the blue zone immediately!";
	};
};

class build_fob : task
{
	taskcategory = "PRI";
	tasktitle = "Build FOB";
	taskname = "Build FOB";
	taskdesc = "Build an FOB to begin claiming zones within %1ms of it.";
	taskformatdata = "[mf_s_baseZoneUnlockDistance]";
	tasktype = "repair";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\p\vn_ui_mf_task_p1.jpg";
	rankpoints = 10;

	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_pri_build_fob";
		timeout = -1;
	};

	//Data for subtasks. These are specific to the script.
	class build
	{
		taskname = "Build a HQ";
		taskdesc = "Construct a HQ building to create a base.";
	};
};
