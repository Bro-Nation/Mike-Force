//included by "ui_tr_base.hpp"

class vn_tr_missionInfoPolaroid_base : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = -1;
	x = VN_TR_MISSIONSHEET_X;
	y = VN_TR_MISSIONSHEET_Y;
	w = VN_TR_MISSIONSHEET_W;
	h = VN_TR_MISSIONSHEET_H;

	class controls
	{
		class vn_tr_missionInfo_previewPic: vn_mf_RscPicture
		{
			idc = VN_TR_ACTIVETASKS_RHS_PIC_IDC;
			x = UIW(11.7);
			y = UIH(17);
			w = UIW(7.4);
			h = UIH(6.95);

			onLoad = "(_this#0) ctrlenable false;";

			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa";
			tooltip = "";
		};
		class vn_tr_missionInfo_miniMap: vn_mf_RscMapControl
		{
			idc = VN_TR_ACTIVETASKS_RHS_MAP_IDC;
			// x = UIW(18);
			// y = UIH(17.65);
			x = UIX_CR(1.5);
			y = UIY_CU(-5.25);
			w = UIW(9.9);
			h = UIH(6.9);

			onLoad = "(_this#0) ctrlenable false;";
			type = 101;
			style = "0x10+ 0x20";
			colorBackground[] = {0.969,0.957,0.949,1};
			colorText[] = {0,0,0,1};
			font = "TahomaB";
			sizeEx = 0.04;
			text = "#(argb,8,8,3)color(1,1,1,1)";
		};
		class overlay_paperPolaroid: vn_mf_RscPicture
		{
			idc = VN_TR_ACTIVETASKS_RHS_IMG_IDC;
			x = 0;
			y = 0;
			w = VN_TR_MISSIONSHEET_POLA_W;
			h = VN_TR_MISSIONSHEET_POLA_H;

			colorText[] = {0.95,0.95,0.95,1};
			colorBackground[] = {1,1,1,1};

			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_1.paa";		//TYPE 1
			//text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_2.paa";	//TYPE 2
			//text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_3.paa";	//TYPE 3
			tooltip = "";
		};

		class mission_name: vn_mf_RscText
		{
			idc = VN_TR_ACTIVETASKS_RHS_NAME_IDC;
			x = UIW(2.25);
			y = UIH(3.5);
			w = UIW(15);
			h = UIH(1.8);
			style = "0x10 + 0x0200";

			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			shadow = 0;
			text = "Mission Name";
			font = USEDFONT_B;
			sizeEx = TXT_CST(0.9);
			tooltip = "";
		};
		class mission_desc: vn_mf_RscText
		{
			idc = VN_TR_ACTIVETASKS_RHS_DESC_IDC;
			x = UIW(2.25);
			y = UIH(5.45);
			w = UIW(15);
			h = UIH(3.6);
			style = "0x10 + 0x0200";

			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			shadow = 0;
			text = "Mission Description";
			font = USEDFONT;
			sizeEx = TXT_CST(0.75);
			tooltip = "";
		};
		class mission_tasks: vn_mf_RscStructuredText
		{
			idc = VN_TR_ACTIVETASKS_RHS_TASKS_IDC;
			x = UIW(2.25);
			y = UIH(9.25);
			w = UIW(15);
			h = UIH(1);
			style = "0x10 + 0x0200";

			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			shadow = 0;
			text = "";
			font = USEDFONT;
			tooltip = "";

			size = TXT_M;
		};
		class mission_tasks_list: vn_mf_RscListBox
		{
			idc = VN_TR_ACTIVETASKS_RHS_TASKS_LIST_IDC;
			onLBSelChanged = "_this call vn_mf_fnc_tr_tasksInfo_listbox_select";
			x = UIW(2.25);
			y = UIH(10.25);
			w = UIW(15);
			h = UIH(5.05);
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {0.5,0.5,0.5,0.4}; // Selected item fill color
			colorSelectBackground2[] = {0.5,0.5,0.5,0.4};
			colorText[] = {0,0,0,1};
			colorPicture[] = {0,0,0,1};
		};
		class CoordsText: vn_mf_RscText
		{
			idc = VN_TR_ACTIVETASKS_RHS_COORDS_IDC;
			x = UIW(2.25);
			y = UIH(15.25);
			w = UIW(8.5);
			h = UIH(1.1);

			style = "0x10 + 0x0200";

			colorText[] = {0.1,0.1,0.1,1.0};
			colorBackground[] = {0.0,0.0,0.0,0.0};
			shadow = 0;
			font = "EtelkaMonospacePro";
			sizeEx = TXT_L;
			text = "0m";
			tooltip = "Distance to Mission";
		};
	};
};

class vn_tr_disp_showTasksInfo
{
	name = "vn_tr_disp_showTasksInfo";
	//If already opened -> Recalling it -> Reloading the Dialog (e.g. like updating the view, without "closing" it)
	onLoad = "[""onLoad"",_this,""vn_tr_disp_showTasksInfo"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay'); call vn_mf_fnc_tr_tasksInfo_fill;";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_showTasksInfo"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay');";
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
		
		// RIGHT HAND SIDE OF TASK ROSTER
		// Inherited from class above
		class vn_tr_taskDetails: vn_tr_missionInfoPolaroid_base
		{
			idc = VN_TR_ACTIVETASKS_RHS_GROUP_IDC;
		};
	};
	
	class Controls
	{
		
		// LEFT HAND SIDE OF TASK ROSTER

		// @dijksterhuis: This does absolutely nothing in the UI, but without it
		// the following text elements don't appear on the page. I have no idea why.
		class lhs_tasks_dummy_does_nothing: vn_mf_RscStructuredText
		{
			idc = -1;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(9.5);
			w = UIW(0);
			h = UIH(0);

			colorText[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_XS;
			text = "";
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

		class lhs_tasks_title: vn_mf_RscText
		{
			idc = -1;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(10.5);
			w = UIW(15);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = TXT_L;
			font = USEDFONT_B;
			
			text = "Active Task List";
		};

		class lhs_tasks_description: vn_mf_RscStructuredText
		{
			idc = -1;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(9);
			w = UIW(16);
			h = UIH(12);

			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_XS;
			text = "The map is divided into zones that must be taken over. Players need to work together to complete several primary tasks -- destroying sites; building a FOB and defending the zone.<br/><br/>Players can create additional support requests, like an ammo resupply or a pilot rescue 'brightlight' mission.<br/><br/>Click on a parent task below then select one of the subtasks on the right to change your active task.";
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

		class lhs_tasks_list: vn_mf_RscListNBox
		{
			idc = VN_TR_ACTIVETASKS_LHS_LBOX_IDC;
			
			x = UIX_CL(17.5);
			y = UIY_CU(-1);
			w = UIW(16);
			h = UIH(7);

			// TODO: These need to be percentages from 0 -> 1 (ending with 1)
			columns[] = {
				0.0,
				0.05,
				0.25,
				0.3,
				1
			};
			
			colorBackground[] = {0,0,0,1};
			colorBorder[] = {0,0,0,1};
			
			colorText[] = {0,0,0,1};		// Text and frame color
			colorSelect[] = {0,0,0,1};		// Text selection color
			colorSelect2[] = {0,0,0,1};		// Text selection color (oscillates between this and colorSelect)
			colorDisabled[] = {1,1,1,0.5};	// Disabled text color
			colorShadow[] = {0,0,0,0.5};	// Text shadow color (used only when shadow is 1)
			
			colorPicture[] = {0.2,0.2,0.2,1};
			colorPictureSelected[] = {0.9,0.9,0.9,1};
			colorPictureDisabled[] = {0,0,0,1};

			onLBSelChanged = "_this call vn_mf_fnc_tr_tasksInfo_show";
			onLBDblClick = "";
		};

		class lhs_tasks_back_btn: vn_mf_RscButton
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