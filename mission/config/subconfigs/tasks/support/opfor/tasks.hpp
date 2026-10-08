// OPFOR support cooldown tuning (seconds), one value per individual support call.
#define OPFOR_CD_FOOT_SQUAD 60
#define OPFOR_CD_FOOT_UNIT 120
#define OPFOR_CD_FOOT_BATTALION 180
#define OPFOR_CD_ARMOR_SINGLE 120
#define OPFOR_CD_ARMOR_DUO 180
#define OPFOR_CD_ARMOR_COLUMN 240
#define OPFOR_CD_ROTARY_SINGLE 120
#define OPFOR_CD_ROTARY_SECTION 180
#define OPFOR_CD_ROTARY_FLIGHT 240
#define OPFOR_CD_FIXED_SINGLE 180
#define OPFOR_CD_FIXED_ELEMENT 240
#define OPFOR_CD_FIXED_SQUADRON 300
#define OPFOR_CD_STRELLA_SUPPORT 600

class support_opfor_task : support_task
{
	creationfunction = "vn_mf_fnc_create_support_opfor_troops";
	// Optional per-task cooldown in seconds. If omitted, the team default
	// vn_mf_opfor_support_team_cooldown is used.
};

class support_opfor_foot_squad : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Foot Soldiers - Squad";
	taskname = "Foot Soldiers - Squad";
	taskdesc = "Create a squad of foot soldiers. Costs 5 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a squad of foot soldiers. Costs 5 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "foot";
		size = "squad";
		cost = 5;
		cooldown = OPFOR_CD_FOOT_SQUAD;
	};
};

class support_opfor_foot_unit : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Foot Soldiers - Platoon";
	taskname = "Foot Soldiers - Platoon";
	taskdesc = "Create a platoon of foot soldiers (50 troops). Costs 10 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a platoon of foot soldiers (50 troops). Costs 10 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "foot";
		size = "platoon";
		cost = 10;
		cooldown = OPFOR_CD_FOOT_UNIT;
	};
};

class support_opfor_foot_battalion : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Foot Soldiers - Company";
	taskname = "Foot Soldiers - Company";
	taskdesc = "Create a company of foot soldiers (100 troops). Costs 15 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a company of foot soldiers (100 troops). Costs 15 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "foot";
		size = "company";
		cost = 15;
		cooldown = OPFOR_CD_FOOT_BATTALION;
	};
};

class support_opfor_armor_single : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Armor - Single";
	taskname = "Armor - Single";
	taskdesc = "Create a single armored vehicle. Costs 25 sandbags";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a single armored vehicle. Costs 25 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "armor";
		size = "single";
		cost = 25;
		cooldown = OPFOR_CD_ARMOR_SINGLE;
	};
};

class support_opfor_armor_duo : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Armor - Duo";
	taskname = "Armor - Duo";
	taskdesc = "Create two armored vehicles. Costs 50 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create two armored vehicles. Costs 50 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "armor";
		size = "duo";
		cost = 50;
		cooldown = OPFOR_CD_ARMOR_DUO;
	};
};

class support_opfor_armor_column : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Armor - Column";
	taskname = "Armor - Column";
	taskdesc = "Create a column of armored vehicles. Costs 75 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a column of armored vehicles. Costs 75 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "armor";
		size = "column";
		cost = 75;
		cooldown = OPFOR_CD_ARMOR_COLUMN;
	};
};

class support_opfor_rotary_single : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Rotary - Single";
	taskname = "Rotary - Single";
	taskdesc = "Create a single rotary aircraft. Costs 25 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a single rotary aircraft. Costs 25 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "rotary";
		size = "single";
		cost = 25;
		cooldown = OPFOR_CD_ROTARY_SINGLE;
	};
};

class support_opfor_rotary_section : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Rotary - Section";
	taskname = "Rotary - Section";
	taskdesc = "Create a section of rotary aircraft. Costs 50 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a section of rotary aircraft. Costs 50 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "rotary";
		size = "section";
		cost = 50;
		cooldown = OPFOR_CD_ROTARY_SECTION;
	};
};

class support_opfor_rotary_flight : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Rotary - Flight";
	taskname = "Rotary - Flight";
	taskdesc = "Create a flight of rotary aircraft. Costs 75 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a flight of rotary aircraft. Costs 75 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "rotary";
		size = "flight";
		cost = 75;
		cooldown = OPFOR_CD_ROTARY_FLIGHT;
	};
};

class support_opfor_fixed_single : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Fixed Wing - Single";
	taskname = "Fixed Wing - Single";
	taskdesc = "Create a single fixed wing aircraft. Costs 50 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a single fixed wing aircraft. Costs 50 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "fixed";
		size = "single";
		cost = 50;
		cooldown = OPFOR_CD_FIXED_SINGLE;
	};
};

class support_opfor_fixed_element : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Fixed Wing - Element";
	taskname = "Fixed Wing - Element";
	taskdesc = "Create an element of fixed wing aircraft. Costs 75 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create an element of fixed wing aircraft. Costs 75 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "fixed";
		size = "element";
		cost = 75;
		cooldown = OPFOR_CD_FIXED_ELEMENT;
	};
};

class support_opfor_fixed_squadron : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "Fixed Wing - Squadron";
	taskname = "Fixed Wing - Squadron";
	taskdesc = "Create a squadron of fixed wing aircraft. Costs 100 sandbags.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Create a squadron of fixed wing aircraft. Costs 100 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "fixed";
		size = "squadron";
		cost = 100;
		cooldown = OPFOR_CD_FIXED_SQUADRON;
	};
};

class support_opfor_strella_support : support_opfor_task
{
	taskcategory = "SUP";
	tasktitle = "AA Support - Strella";
	taskname = "AA Support - Strella";
	taskdesc = "Request anti-aircraft support with Strella launcher. Costs 25 sandbags. Cooldown: 10 minutes.";
	tasktype = "support";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	requestgroups[] = {"DacCong"};
	rankpoints = 0;
	taskprogress = 0;

	requesterDesc = "Request anti-aircraft support with Strella launcher (10 min cooldown). Costs 25 sandbags.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_opfor_create";
		unitType = "strella";
		size = "single";
		cost = 25;
		cooldown = OPFOR_CD_STRELLA_SUPPORT;
	};
};
