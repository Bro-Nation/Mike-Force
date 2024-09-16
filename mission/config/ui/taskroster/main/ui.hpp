//included by "ui_tr_base.hpp"

class vn_tr_disp_taskRoster_main_rhs : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = -1;
	onLoad = "";

	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;

	class controls
	{
		class rhs_img_sgd_banner: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(1.75);
			y = UIH(2.25);
			w = UIW(8);
			h = UIH(4.5);

			text = "\vn\missions_f_vietnam\data\img\mikeforce\mission.jpg";
		};

		class rhs_img_bn_welcome: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(9.75);
			y = UIH(2.25);
			w = UIW(8);
			h = UIH(4.5);

			text = "custom\billboards\BN_Welcome_20240621.paa";
		};

		#define HEIGHT_NEW_ROW_BY_NUMB(N)\
			y = UIH((7.25 + (N * 2.25)));

		class lhs_server_rules: vn_mf_RscStructuredText
		{
			idc = -1;
			style = "0x10";
			x = UIW(2);
			HEIGHT_NEW_ROW_BY_NUMB(0)
			w = UIW(16);
			h = UIH(2.25);

			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			size = TXT_M;
			text = "<t font='tt2020base_vn_bold'>Server Rules</t>: <a href='https://discord.com/channels/494435095168548866/884580184223797308'>Click here</a> to see game server rules on Discord.";
			class Attributes
			{
				align = "left";
				color = "#000000";
				colorLink = "#0a7012"; // dark green
				font = USEDFONT;
				size = 0.9;
				shadow = 0;
			};
		};

		class lhs_ban_policy_text: lhs_server_rules
		{
			HEIGHT_NEW_ROW_BY_NUMB(1)
			text = "<t font='tt2020base_vn_bold'>Ban Policy</t>: <a href='https://discord.com/channels/494435095168548866/972772268478459914'>Click here</a> to see Ban Policy in Discord.";
		};
		class lhs_playerreports_text: lhs_server_rules
		{
			HEIGHT_NEW_ROW_BY_NUMB(2)
			text = "<t font='tt2020base_vn_bold'>Player Reports</t>: <a href='https://discord.com/channels/494435095168548866/1079496263713702018'>Click here</a> to report bad behaviour in Discord.";
		};
		class lhs_bugreports_text: lhs_server_rules
		{
			HEIGHT_NEW_ROW_BY_NUMB(3)
			text = "<t font='tt2020base_vn_bold'>Bug Reports</t>: <a href='https://discord.com/channels/494435095168548866/1079495163958792212'>Click here</a> to report game bugs in Discord.";
		};
		class lhs_applywlu_text: lhs_server_rules
		{
			HEIGHT_NEW_ROW_BY_NUMB(4)
			text = "<t font='tt2020base_vn_bold'>Unit Applications</t>: <a href='https://discord.com/channels/494435095168548866/1245947819790041138'>Click here</a> to apply to whitelisted units in Discord.";
		};
		class lhs_training_text: lhs_server_rules
		{
			HEIGHT_NEW_ROW_BY_NUMB(5)
			text = "<t font='tt2020base_vn_bold'>Training</t>: <a href='https://discord.com/channels/494435095168548866/1246522786063712316'>Click here</a> to join some optional training sessions.";
		};
		class lhs_patreon_text: lhs_server_rules
		{
			HEIGHT_NEW_ROW_BY_NUMB(6)
			text = "<t font='tt2020base_vn_bold'>Patreon</t>: <a href='https://discord.com/channels/494435095168548866/783785538167373875'>Click here</a> to support the server on Patreon.";
		};
	};
};

class vn_tr_disp_taskRoster_Main
{
	name = "vn_tr_disp_taskRoster_Main";
	//If already opened -> Recalling it -> Reloading the Dialog (e.g. like updating the view, without "closing" it)
	onLoad = "[""onLoad"",_this,""vn_tr_disp_taskRoster_Main"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay');";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_taskRoster_Main"",''] call	(uinamespace getvariable 'BIS_fnc_initDisplay');";
	idd = VN_IDD_TR_TASKROSTER;
	movingEnable = 1;
	enableSimulation = 1;
	
	class ControlsBackground
	{
		// Prevent the ListNBox from using any control with the idc -1 as its left and right control
		class LNBCatcher: vn_mf_RscText
		{
			idc = -1;
		};
		class folderBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = VN_TR_FOLDER_X;
			y = VN_TR_FOLDER_Y;
			w = VN_TR_FOLDER_W;
			h = VN_TR_FOLDER_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			// empty lhs background sheet
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_folder_background_sheetL.paa";
		};
		// empty rhs background sheet
		class vn_sheet_clean_R: vn_sheet_clean_R_base
		{
			idc = -1;
		};
		// MUST be last entry, so it's above all other Sheets!
		class vn_tr_blanksheet: vn_tr_blanksheet_base
		{
			idc = VN_TR_BLANKSHEET_RHS_IDC;
		};
	};
	
	class Controls
	{
		class rhs: vn_tr_disp_taskRoster_main_rhs {};

		class lhs_welcome_text_header: vn_mf_RscText
		{
			idc = -1;
			style = "0x10";
			x = UIX_CL(17.5);
			y = UIY_CU(10.5);
			w = UIW(16);
			h = UIH(2);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = TXT_L;
			font = USEDFONT_B;
			
			text = "Bro-Nation Mike Force";
		};
		class lhs_welcome_text_blurb: vn_mf_RscStructuredText
		{
			idc = -1;
			style = "0x10";
			x = UIX_CL(17.5);
			y = UIY_CU(8.5);
			w = UIW(16);
			h = UIH(14);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			size = TXT_M;
			
			text = "Mike Force is a co-operative PvE gamemode by <t font='tt2020base_vn_bold'><a href='https://www.savage-game.com'>Savage Game Design</a></t>. This is a modified version of Mike Force brought to you by <t font='tt2020base_vn_bold'><a href='https://discord.gg/bro-nation'>Bro-Nation</a></t>.<br/><br/>This menu can be toggled to open/close at any time by pressing the H key.<br/><br/>We recommend new players read our 'Server Guide' by clicking on the button below!<br/><br/>Please join the <t font='tt2020base_vn_bold'><a href='https://discord.gg/bro-nation'>Bro-Nation Discord</a></t> for additional help, or click on the links on the opposite page.";
			class Attributes
			{
				align = "left";
				color = "#000000";
				colorLink = "#0a7012"; // dark green
				font = USEDFONT;
				size = 0.9;
				shadow = 0;
			};
		};

		// left hand buttons /////////////////////////////////

		class lhs_newbie_info_btn: vn_mf_RscButton
		{
			idc = VN_TR_NEWBIEHELP_BTN_IDC;
			style = "0x10";
			x = UIX_CL(17);
			y = UIY_CU(-5);
			w = UIW(8);
			h = UIH(1.5);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.1};

			text = "Server Guide";
			onButtonClick = "createDialog 'vn_tr_disp_showNewPlayerGuide';";
		};
		class lhs_player_stats_and_roles_btn: lhs_newbie_info_btn
		{
			idc = VN_TR_MEDALSTEXT_BTN_IDC;
			y = UIY_CU(-7);
			onButtonClick = "createDialog 'vn_tr_disp_showPlayerInfo';";
			text = "Stats & Roles";
		};
		class lhs_player_team_btn: lhs_newbie_info_btn
		{
			idc = VN_TR_CURRTEAMTEXT_BTN_IDC;
			y = UIY_CU(-9);
			onButtonClick = "createDialog 'vn_tr_disp_showTeamInfo';";
			text = "Select Team";
		};

		// right hand buttons /////////////////////////////////

		class lhs_changelog_btn: lhs_newbie_info_btn
		{
			idc = VN_TR_CURRTASKSTEXT_BTN_IDC;
			x = UIX_CL(8.5);
			y = UIY_CU(-5);
			onButtonClick = "createDialog 'para_ChangelogScreen';";
			text = "S.G.D. Changelog";
		};
		class lhs_player_active_tasks_btn: lhs_changelog_btn
		{
			idc = VN_TR_CURRTASKSTEXT_BTN_IDC;
			y = UIY_CU(-7);
			onButtonClick = "createDialog 'vn_tr_disp_showTasksInfo';";
			text = "Active Tasks";
		};
		class lhs_player_request_support_tasks_btn: lhs_player_active_tasks_btn
		{
			idc = VN_TR_TASK_REQ_IDC;
			y = UIY_CU(-9);
			onButtonClick = "createDialog 'vn_tr_disp_showRequestSupport';";
			text = "Create Tasks";
		};

		// ALWAYS AT THE BOTTOM/LAST OF THE CONTROLS!
		// 2x binders in the centre of the screen to make it look like a notebook
		class folder_cordels: vn_tr_cordels{};
	};
};