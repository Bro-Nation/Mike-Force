class defend_counterattack : task
{
	taskcategory = "PRI";
	tasktitle = "Defend from Counterattack";
	taskname = "Defend from Counterattack";
	taskdesc = "The enemy is preparing a counterattack, hold the zone at all costs.";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_defend_counterattack";
		timeout = -1;
	};

	class prepare_zone 
	{
		taskname = "Prepare for Attack";
		taskdesc = "The enemy will launch their attack soon. Set up defenses.";
	};

	class defend_zone
	{
		taskname = "Hold the Zone";
		taskdesc = "Hold the zone for 30 minutes, or until hostiles are eliminated.";
	};

	class defend_fob
	{
		taskname = "Defend the FOB";
		taskdesc = "Defend the FOB from counterattack for 30 minutes, or hostile forces are eliminated.";
	};

	class defend_flag
	{
		taskname = "Defend the Flag";
		taskdesc = "Don't let the flag get taken down!";
	};
};

class defend_base : task
{
	taskcategory = "PRI";
	tasktitle = "Defend FOB from Attack";
	taskname = "Defend FOB from Attack";
	taskdesc = "The enemy is preparing to attack an FOB. Prepare to defend it!";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_defend_base";
		timeout = -1;
	};

	class prepare_base 
	{
		taskname = "Prepare for Attack";
		taskdesc = "The enemy will launch their attack soon. Set up defenses.";
	};

	class defend_base
	{
		taskname = "Defend the FOB";
		taskdesc = "Defend the FOB until all hostiles have been eliminated.";
	};
};


class defend_main_base : task
{
	taskcategory = "PRI";
	tasktitle = "Defend Main Base from Attack";
	taskname = "Defend Main Base from Attack";
	taskdesc = "The enemy is preparing to attack our main base! Prepare to defend it!";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_defend_main_base";
		timeout = -1;
	};

	class defend_respawn_1
	{
		taskname = "Defend Base 1";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_2
	{
		taskname = "Defend Base 2";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_3
	{
		taskname = "Defend Base 3";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_4
	{
		taskname = "Defend Base 4";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_5
	{
		taskname = "Defend Base 5";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_6
	{
		taskname = "Defend Base 6";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_7
	{
		taskname = "Defend Base 7";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_8
	{
		taskname = "Defend Base 8";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};

	class defend_respawn_9
	{
		taskname = "Defend Base 9";
		taskdesc = "Enemy forces are attacking the base. Defend it!";
	};
};


