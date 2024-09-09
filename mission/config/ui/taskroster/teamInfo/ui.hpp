//included by "ui_tr_base.hpp"

// RIGHT HAND SIDE -- INHERITED BELOW

class vn_tr_disp_showTeamInfo_rhs : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = -1;
	onLoad = "";

	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;

	class controls
	{
		class rhs_changeteam_title: vn_mf_RscText
		{
			idc = -1;
			x = UIW(2.5);
			y = UIH(1);
			w = UIW(9);
			h = UIH(2);
			sizeEx = TXT_L;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			text = "Change Team";
			tooltip = "";
			font = USEDFONT_B;
		};

		class lhs_changeteam_description: vn_mf_RscStructuredText
		{
			idc = -1;
			style = "0x10";

			x = UIW(2.5);
			y = UIH(3);
			w = UIW(16);
			h = UIH(6);

			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_XS;
			text = "To change your team, click on one of the entries in the list below, then press the CHANGE TEAM button.<br/><br/>'Public' teams are open to all players; 'Locked' teams are whitelisted teams you cannot join; 'Unlocked' teams are whitelisted teams you can join.";
			tooltip = "";
			class Attributes
			{
				align = "left";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 0.8;
				shadow = 0;
			};
		};

		class rhs_changeteam_select_listNBox: vn_mf_RscListNBox
		{
			idc = VN_TR_SHOWTEAMINFO_RHS_CHANGETEAM_LISTBOX_IDC;

			x = UIW(2.5);
			y = UIH(10);
			w = UIW(15);
			h = UIH(10);

			// icon start
			// team name start
			// public or whitelisted text start
			// mapmarker icon start
			columns[] = {
				0,
				0.075,
				0.45,
				0.85,
				0.95
			};

			sizeEx = TXT_S;
			rowHeight = UIH(1);

			colorBackground[] = {0,0,0,0};
			colorText[] = {0,0,0,1};
			colorShadow[] = {0,0,0,0};

			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.5};

			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {1,1,1,1};
			colorPictureDisabled[] = {1,1,1,1};

			tooltipPerColumn = true;
			padding = 0.008;
		};

		class rhs_confirm_btn: vn_mf_RscButton
		{
			idc = VN_TR_SHOWTEAMINFO_RHS_CHANGETEAM_BUTTON_IDC;

			x = UIW(11.5);
			y = UIH(21);
			w = UIW(6);
			h = UIH(1.5);

			text = "CHANGE TEAM";
			font = USEDFONT;
			sizeEx = TXT_L;
			onButtonClick = "call vn_mf_fnc_tr_teamInfo_changeteam_select;";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.1};
		};
	};
};

class vn_tr_disp_showTeamInfo
{
	name = "vn_tr_disp_showTeamInfo";
	//If already opened -> Recalling it -> Reloading the Dialog (e.g. like updating the view, without "closing" it)
	onLoad = "[""onLoad"",_this,""vn_tr_disp_showTeamInfo"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay'); call vn_mf_fnc_tr_teamInfo_show;";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_showTeamInfo"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay');";
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
		
	class ControlsBackground
	{
		class folderBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = VN_TR_FOLDER_X;
			y = VN_TR_FOLDER_Y;
			w = VN_TR_FOLDER_W;
			h = VN_TR_FOLDER_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_folder_background_sheetL.paa";
		};
		//MUST be in the background, otherwise it could "pop up", when clicking on it, covering up the cordles
		class vn_sheet_clean_R: vn_sheet_clean_R_base
		{
			idc = -1;
		};
	};
	
	
	class Controls
	{
		// Teamselection
		// @dijksterhuis: I do not know why this has to be in the main
		// Controls class. Putting it in the ControlsBackground class
		// breaks the UI but showPlayerInfo does that fine ?!?!?
		class rhs: vn_tr_disp_showTeamInfo_rhs
		{
			idc = VN_TR_SHOWTEAMINFO_RHS_IDC;
		};

		class lhs_main_text_header: vn_mf_RscText
		{
			idc = -1;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(10.5);
			w = UIW(6);
			h = UIH(2);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			sizeEx = TXT_L;
			font = USEDFONT_B;
			
			text = "Your Team";
		};

		// Current Team: %1
		class lhs_text_top: vn_mf_RscStructuredText
		{
			idc = VN_TR_SHOWTEAMINFO_LHS_TEAMNAME_IDC;
			x = UIX_CL(12);
			y = UIY_CU(10.35);
			w = UIW(7);
			h = UIH(1.5);
			
		
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			text = "";
			sizeEx = TXT_S;
			tooltip = "";
			class Attributes
			{
				align = "right";
				valign = "middle";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};

		class lhs_team_logo_img: vn_mf_RscPicture
		{
			idc = VN_TR_SHOWTEAMINFO_LHS_LOGO_IDC;
			x = UIX_CL(4.5);
			y = UIY_CU(11);
			w = UIW(2);
			h = UIH(2);
			
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			text = "";
			tooltip = "";
		};
		

		// Text for the team's description field.
		class lhs_team_description_stext: vn_mf_RscStructuredText
		{
			idc = VN_TR_SHOWTEAMINFO_LHS_DESC_IDC;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(8.5);
			w = UIW(15);
			h = UIH(6);

			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_XS;
			text = "adasd";
			tooltip = "";
			class Attributes
			{
				align = "left";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 0.8;
				shadow = 0;
			};
		};

		class lhs_PlayersRoleListHeader: vn_mf_RscControlsGroupNoScrollbarH
		{
			idc = -1;
			x = UIX_CL(17.5);
			y = UIY_CU(4.5);
			w = UIW(15);
			h = UIH(0.75);
			class controls
			{
				class PlayerName: vn_mf_RscStructuredText
				{
					text = "Players";
					x = 0;
					y = 0;
					w = UIW(16);
					h = UIH(0.75);
					size = TXT_S;
					class Attributes
					{
						align = "left";
						color = "#000000";
						colorLink = "#D09B43";
						font = USEDFONT_B;
						size = 1;
						shadow = 0;
					};
				};
				class RoleImgs: PlayerName
				{
					text = "Roles";
					x = UIW(11);
					w = UIW(3);
				};
			};
		};
		class lhs_PlayersRoleList: lhs_PlayersRoleListHeader
		{
			idc = VN_TR_SHOWTEAMINFO_LHS_PLAYERS_IDC;
			y = UIY_CU(3.75);
			h = UIH(5);
			colorBackground[] = {0, 0, 0, 1};
			class controls {};
		};

		class lhs_RoleLimitsHeader: vn_mf_RscControlsGroupNoScrollbarH
		{
			idc = -1;
			x = UIX_CL(17.5);
			y = UIY_CU(-3);

			w = UIW(15);
			h = UIH(0.75);
			class controls
			{
				class Role: vn_mf_RscStructuredText
				{
					text = "Team Role Allowance";
					x = 0;
					y = 0;
					w = UIW(6);
					h = UIH(0.75);
					size = TXT_S;
					class Attributes
					{
						align = "left";
						color = "#000000";
						colorLink = "#D09B43";
						font = USEDFONT_B;
						size = 1;
						shadow = 0;
					};
				};
				class PlayerCount: Role
				{
					text = "Players";
					x = UIW(8.5);
					w = UIW(4);
				};
				class PlayerCountLimit: Role
				{
					text = "Limit";
					x = UIW(12.5);
					w = UIW(3);
				};
			};
		};
		class lhs_RoleLimits: lhs_RoleLimitsHeader
		{
			idc = VN_TR_SHOWTEAMINFO_LHS_ROLELIMITS_IDC;
			y = UIY_CU(-3.75);
			h = UIH(5);
			colorBackground[] = {0, 0, 0, 1};
			class controls {};
		};

		class lhs_back_btn: vn_mf_RscButton
		{
			idc = -1;

			x = UIX_CL(17);
			y = UIY_CU(-9);
			w = UIW(7);
			h = UIH(1.5);
			
			text = "BACK";
			font = USEDFONT;
			sizeEx = TXT_L;
			onButtonClick = "(ctrlParent param[0]) closeDisplay 2";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.1};
		};
		
		//ALWAYS AT THE BOTTOM/LAST OF THE CONTROLS!
		class folder_cordels: vn_tr_cordels
		{};
	};
};