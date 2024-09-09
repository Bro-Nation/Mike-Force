//included by "ui_tr_base.hpp"

class vn_tr_supportRequest_miniMapAA: vn_mf_RscMapControl
{
	idc = VN_TR_SUPREQ_MAP_IDC;
	x = UIX_CR(2.5);
	y = UIY(6.5);
	w = UIW(16);
	h = UIH(14.5);

	onMouseButtonClick = "call vn_mf_fnc_tr_getMapPosClick;";
	onLoad = "";
	tooltip = "";
};
// RIGHT HAND SIDE -- INHERITED BELOW
class vn_tr_disp_requestSupportMap_RHS : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = -1;
	onLoad = "";

	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;

	class controls
	{
		class rhs_background: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(0);
			y = UIH(0);
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_mainInfo.paa";
			// text = "";
			tooltip = "";
		};
		class rhs_title: vn_mf_RscText
		{
			idc = -1;
			x = UIW(2);
			y = UIH(2);
			w = UIW(15);
			h = UIH(1);

			style = "0x10 + 0x0200";
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "3. Mark Position";
			font = USEDFONT_B;
			sizeEx = TXT_M;
		};
		class rhs_helptext: vn_mf_RscText
		{
			idc = -1;
			x = UIW(2);
			y = UIH(3);
			w = UIW(16.5);
			h = UIH(3);

			style = "0x10 + 0x0200";
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "Place a marker by clicking on the map with your left mouse button. Right click and drag your mouse to move the map around; use your scroll wheel to zoom in and out.";
			font = USEDFONT;
			sizeEx = TXT_S;
		};
		class rhs_confirm_btn: vn_mf_RscButton
		{
			idc = VN_TR_SUPREQ_ACCEPT_IDC;

			x = UIW(12);
			y = UIH(21);
			w = UIW(6);
			h = UIH(1.5);

			text = "CONFIRM";
			font = USEDFONT;
			sizeEx = TXT_L;
			onButtonClick = "call vn_mf_fnc_tr_supportTask_selectPosition_accept; call vn_mf_fnc_tr_supportTask_create;";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.1};
		};
		class rhs_cancel_btn: vn_mf_RscButton
		{
			idc = VN_TR_SUPREQ_ABORT_IDC;

			x = UIW(2);
			y = UIH(21);
			w = UIW(6);
			h = UIH(1.5);

			text = "CLEAR MAP";
			font = USEDFONT;
			sizeEx = TXT_L;
			onButtonClick = "[] spawn vn_mf_fnc_tr_supportTask_map_hide;";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.1};
		};
	};
};


class vn_tr_disp_showRequestSupport
{
	name = "vn_tr_disp_showRequestSupport";
	//If already opened -> Recalling it -> Reloading the Dialog (e.g. like updating the view, without "closing" it)
	onLoad = "[""onLoad"",_this,""vn_tr_disp_showRequestSupport"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay'); call vn_mf_fnc_tr_supportTask_show;";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_showRequestSupport"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay'); call vn_mf_fnc_tr_supportTask_map_hide;";
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
		
		//MUST be in the background, otherwise it could "pop up", when clicking on it, covering up the cordles (silly Arma, y u do dis? :sad:)
		///////////////////Right:
		//Teamselection
		class vn_tr_map_rhs: vn_tr_disp_requestSupportMap_RHS
		{
			idc = VN_TR_SUPREQ_RHS_IDC;
		};
	};
	
	
	class Controls
	{
		
		///////////////////Left:

		// @dijksterhuis: This does absolutely nothing in the UI, but without it
		// the following text elements don't appear on the page. I have no idea why.
		class lhs_request_support_dummy_does_nothing: vn_mf_RscStructuredText
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

		class lhs_request_support_title_text: vn_mf_RscText
		{
			idc = -1;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(10.5);
			w = UIW(15);
			h = UIH(2);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			sizeEx = TXT_L;
			font = USEDFONT_B;
			
			text = "Create Support Tasks";
		};

		// Text for the team's description field.
		class lhs_request_support_description_stext: vn_mf_RscStructuredText
		{
			idc = -1;
			style = "0x10";

			x = UIX_CL(17.5);
			y = UIY_CU(9);
			w = UIW(16.5);
			h = UIH(3);

			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_XS;
			text = "'Support requests' can be used to ask for help from other teams. Whether that is for ammo resupply or a helicopter pickup in the field.";
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
		class lhs_task_description: vn_mf_RscStructuredText_c
		{
			idc = VN_TR_SUPREQ_DESC_TXT_IDC;
			style = 0x10;
			x = UIX_CL(17.5);
			y = UIY_CU(6.5);
			w = UIW(16.5);
			h = UIH(2);

			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_CST(0.6);
			text = "No task selected yet.";
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
		class lhs_task_select_subtitle: vn_mf_RscText
		{
			idc = -1;
			x = UIX_CL(17.5);
			y = UIY_CU(4);
			w = UIW(8);
			h = UIH(1);

			style = "0x10 + 0x0200";
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "1. Select Task";
			font = USEDFONT_B;
			sizeEx = TXT_M;
		};
		class lhs_task_select_listNBox: vn_mf_RscListNBox
		{
			idc = VN_TR_SUPREQ_TASK_IDC;

			x = UIX_CL(18);
			y = UIY_CU(3);
			w = UIW(9.5);
			h = UIH(10);

			//columns[] = {	0,			1,					};
			//columns[] = {	(Symbol:),	(Text: Description)	};
			columns[] = {0,0.05};

			sizeEx = TXT_S;
			rowHeight = UIH(0.8);

			colorBackground[] = {0,0,1,0.5};
			colorText[] = {0,0,0,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.5};
			colorShadow[] = {0,0,0,0};

			colorPicture[] = {0.0,0.5,0.1,1};
			colorPictureSelected[] = {0.0,0.5,0.1,1};
			colorPictureDisabled[] = {0,0,0,1};

			onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTask; false";
			onLBDblClick = "";
		};
		class lhs_team_select_subtitle: lhs_task_select_subtitle
		{
			idc = -1;

			x = UIX_CL(8.5);
			text = "2. Select Team";
		};
		// inherits from the task select listbox above
		class lhs_team_select_listNBox: lhs_task_select_listNBox
		{
			idc = VN_TR_SUPREQ_TEAM_IDC;

			x = UIX_CL(8.5);
			w = UIW(7);

			columns[] = {0,0.075};

			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {1,1,1,1};
			colorPictureDisabled[] = {1,1,1,1};

			onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTeam; false";
			onLBDblClick = "";
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