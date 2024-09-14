//included by "ui_tr_base.hpp"

// RIGHT HAND SIDE -- INHERITED BELOW
class vn_tr_disp_showNewPlayerGuide_rhs : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = -1;
	onLoad = "";

	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;

	class controls
	{
		class mainInfoBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(0);
			y = UIH(0);
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_mainInfo.paa";
			tooltip = "";
		};


		#define RHS_IMAGE_Y_FROM_NUMB(N) \
			UIH((4 + (6 * N)))

		#define RHS_CAPTION_Y_FROM_NUMB(N) \
			UIH((4 - 0.75 + (6 * N)))


		// ARSENAL //////////////////////////////////////////////////////////////////////

		class rhs_img_arsenal: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(13);
			y = RHS_IMAGE_Y_FROM_NUMB(0);
			w = UIW(5);
			h = UIH(5);
			text = "custom\taskroster\help\img_newplayer_arsenal.paa";
			tooltip = "This is an Arsenal, kit up here.";
		};

		class rhs_helptext_arsenal: vn_mf_RscStructuredText
		{
			idc = -1;
			x = UIW(2);
			y = RHS_IMAGE_Y_FROM_NUMB(0);
			w = UIW(11.25);
			h = UIH(6);

			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			text = "This is an arsenal, marked with pink dots on the map around base. Use these to create, save, edit and load your loadouts. Multiple loadouts can be made for different roles and playstyles, be as creative as you like.";
			size = UIH(0.69);
			tooltip = "";
			class Attributes
			{
				align = "left";
				valign = "top";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};

		class rhs_img_arsenal_caption: vn_mf_RscText
		{
			idc = -1;
			x = UIW(12.75);
			y = RHS_CAPTION_Y_FROM_NUMB(0);
			w = UIW(5);
			h = UIH(1);
			font = USEDFONT_B;
			sizeEx = TXT_S;
			colorText[] = {0, 0, 0, 1};
			text = "Arsenal";
		};

		// TELEPORTER ///////////////////////////////////////////////////////////////////

		class rhs_img_teleporter: rhs_img_arsenal
		{
			y = RHS_IMAGE_Y_FROM_NUMB(1);
			text = "custom\taskroster\help\img_newplayer_map.paa";
			tooltip = "A Teleporter Map Board.";
		};

		class rhs_img_teleporter_caption: rhs_img_arsenal_caption
		{
			y = RHS_CAPTION_Y_FROM_NUMB(1);
			text = "Teleporter";
		};
        
        class rhs_helptext_teleporter: rhs_helptext_arsenal
        {
			y = RHS_IMAGE_Y_FROM_NUMB(1);
            text = "This is a Map Board, use these to quickly teleport to numerous locations on base. Use the 6 key to interact with it.";
        };

     	// HELO PADS ////////////////////////////////////////////////////////////////////

		class rhs_img_helopads: rhs_img_arsenal
		{
			y = RHS_IMAGE_Y_FROM_NUMB(2);
			text = "custom\taskroster\help\img_newplayer_pads.paa";
			tooltip = "Pick up location.";
		};

		class rhs_img_helopads_caption: rhs_img_arsenal_caption
		{
			y = RHS_CAPTION_Y_FROM_NUMB(2);
			text = "Helo Pickup";
		};
	    
	    class rhs_helptext_helopads: rhs_helptext_arsenal
        {
			y = RHS_IMAGE_Y_FROM_NUMB(2);
            text = "These are the helo pick-up pads, near Green Hornets. Switch to the Air Channel with the period key and ask a Green Hornet pilot to get you into the fight!";
        };
	};
};

class vn_tr_disp_showNewPlayerGuide
{
	name = "vn_tr_disp_showNewPlayerGuide";
	onLoad = "[""onLoad"",_this,""vn_tr_disp_showNewPlayerGuide"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay');";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_showNewPlayerGuide"",''] call (uinamespace getvariable 'BIS_fnc_initDisplay');";
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
		class rhs: vn_tr_disp_showNewPlayerGuide_rhs
		{
			idc = -1;
		};
	};

	class Controls
	{
		class title: vn_mf_RscText
		{
			idc = -1;
			x = UIX_CL(17.5);
			y = UIY_CU(10.5);
			w = UIW(16);
			h = UIH(2);

			style = "0x10 + 0x0200";
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "New Player Guide";
			font = USEDFONT_B;
			sizeEx = TXT_L;
		};

		#define LHS_IMAGE_Y_FROM_NUMB(N) \
			UIY_CU((8.25 - (6 * N)))

		#define LHS_CAPTION_Y_FROM_NUMB(N) \
			UIY_CU((8.25 + 0.75 - (6 * N)))

     	// ZONES ////////////////////////////////////////////////////////////////////////

		class rhs_img_zones: vn_mf_RscPicture
		{
			idc = -1;

			x = UIX_CL(17.5);
			y = LHS_IMAGE_Y_FROM_NUMB(0);
			w = UIW(5);
			h = UIH(5);

			text = "custom\taskroster\help\img_newplayer_zone.paa";
			tooltip = "Zones to be taken.";
		};

		class rhs_img_zones_caption: vn_mf_RscText
		{
			idc = -1;

			x = UIX_CL(17.75);
			y = LHS_CAPTION_Y_FROM_NUMB(0);

			font = USEDFONT_B;
			sizeEx = TXT_S;
			colorText[] = {0, 0, 0, 1};
			text = "Combat Zones";
		};

		class rhs_helptext_zones: vn_mf_RscStructuredText
		{
			idc = -1;

			x = UIX_CL(12.5);
			y = LHS_IMAGE_Y_FROM_NUMB(0);
			w = UIW(11.5);
			h = UIH(5);

			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			text = "Zones are where the action happens. Active zones are marked by task markers. Green zones are completed. Do not enter blue zones. Destroy all sites in active red zones. Defend yellow zones from counterattack. ";
			size = UIH(0.69);
			tooltip = "";
			class Attributes
			{
				align = "left";
				valign = "top";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};

     	// MAP LEGEND ///////////////////////////////////////////////////////////////////

		class rhs_img_legend: rhs_img_zones
		{
			y = LHS_IMAGE_Y_FROM_NUMB(1);

			text = "custom\taskroster\help\img_newplayer_legend.paa";
			tooltip = "Map Legend.";
		};

		class rhs_img_legend_caption: rhs_img_zones_caption
		{
			y = LHS_CAPTION_Y_FROM_NUMB(1);
			w = UIW(5);
			text = "Map Legend";
		};

        class rhs_helptext_zones_legend: rhs_helptext_zones
        {
			y = LHS_IMAGE_Y_FROM_NUMB(1);
            text = "This is a map legend and can usually be found somewhere on the map. Use this to help navigate yourself around the base and the rest of the map.";
        };

		// CAS IS WHITELISTED PLEASE STOP ASKING ////////////////////////////////////////

		class rhs_img_cas: rhs_img_zones
		{
			y = LHS_IMAGE_Y_FROM_NUMB(2);

			text = "custom\taskroster\help\img_newplayer_cas.paa";
			tooltip = "CAS is whitelisted.";
		};

		class rhs_img_cas_caption: rhs_img_zones_caption
		{
			y = LHS_CAPTION_Y_FROM_NUMB(2);
			text = "CAS and Arty";
		};
     
        class rhs_helptext_cas: rhs_helptext_zones
        {
			y = LHS_IMAGE_Y_FROM_NUMB(2);
            text = "CAS and heavy artilley are whitelisted, this is to prevent misuse and abuse of these powerful assets to improve all players experience. Enquire in Discord for how to join.";
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

		/////////////////////////////////////////////////////////////////////////////////
		// ALWAYS AT THE BOTTOM/LAST OF THE CONTROLS!
		class folder_cordels: vn_tr_cordels {};
	};
};