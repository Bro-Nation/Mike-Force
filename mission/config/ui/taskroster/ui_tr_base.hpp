//included by "ui_main.hpp"

//ctrl defines for TaskRoster

//Cordels in the center of the folder. Must be loaded as last item!
class vn_tr_cordels: vn_mf_RscPicture
{
	idc = -1;
	x = VN_TR_CORDLES_X;
	y = VN_TR_CORDLES_Y;
	w = VN_TR_CORDLES_W;
	h = VN_TR_CORDLES_H;

	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,1};
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_folder_cordels.paa";
	tooltip = "";
	onLoad = "(_this#0) ctrlenable false;";
};
//Clean Sheet, already adjusted to Standard Folder Size and correct position
class vn_sheet_clean_R_base: vn_mf_RscPicture
{
	idc = -1;
	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;

	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,1};
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_sheet_clean.paa";
	tooltip = "";
};

class vn_sheet_overview_base: vn_mf_RscPicture
{
	idc = -1;
	x = VN_TR_SHEET_L_X;
	y = VN_TR_SHEET_L_Y;
	w = VN_TR_SHEET_L_W;
	h = VN_TR_SHEET_L_H;

	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,1};
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_overview.paa";
	tooltip = "";
};

class vn_sheet_overview_accepted_base: vn_sheet_overview_base
{
	idc = -1;
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_sheet_clean.paa";
	tooltip = "";
};

class vn_tr_blanksheet_base: vn_sheet_clean_R_base
{
	idc = -1;
	onLoad = "";
};


#include "playerInfo\ui.hpp"
#include "teamInfo\ui.hpp"
#include "tasksInfo\ui.hpp"
#include "requestSupport\ui.hpp"
#include "newPlayerGuide\ui.hpp"

#include "main\ui.hpp"
