class vn_whitelisted_arsenal_loadouts
{
	class vn_mikeforce
	{
		displayname = "$STR_VN_DLC_DEFAULT_DN";
		/*
			Test Line Please Ignore
			Format: {"item_classname", 							{ EAST RANK, WEST RANK, INDEPENDENT RANK, CIVILIAN RANK}}
			Ranks:
				"NONE" =-1
				"PRIVATE" = 0
				"CORPORAL" = 1
				"SERGEANT" = 2
				"LIEUTENANT" = 3
				"CAPTAIN" = 4
				"MAJOR" = 5
				"COLONEL" = 6

			All you need to do is change the sides rank number.
			Players will have access to all the items that are assigned to a rank equal to or below theirs.
			When side restriction is unlocked players will have access to items based on the lowest
			rank it is available at. 

			E.G {1, 2, 6,-1}- The item would be avaliable to ALL SIDES at rank 1.

			Example:
				Weapon:
					vn_dp28
				Ranks:
					EAST: LIEUTENANT
					WEST: NONE
					INDEP: NONE
					CIVILIAN: COLONEL

				Entry:	
					{ "vn_dp28", 							{ 3,-1,-1, 6}}
		*/
		weapons[] =								
{ 														
//Rifles														
//BluFor														
	{	"vn_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	M40 Sniper Rifle firing 7.62x51mm match-grade ammunition
	{	"vn_m40a1_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	M40 Sniper Rifle firing 7.62x51mm match-grade ammunition
	{	"vn_m40a1_sniper_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M40 Sniper Rifle firing 7.62x51mm match-grade ammunition
	{	"vn_m40a1_nvg"	,{	-1	,	0	,	0	,	-1	}}	,	//	M40 Sniper Rifle firing 7.62x51mm match-grade ammunition
	{	"vn_m40a1_nvg_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M40 Sniper Rifle firing 7.62x51mm match-grade ammunition
	{	"vn_m40a1_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M40 Sniper Rifle, camo polymer body, firing 7.62x51mm match-grade ammunition
	{	"vn_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	M14 selective-fire rifle firing 7.62mm ammunition in 20-round mags
	{	"vn_m14_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M14 selective-fire rifle firing 7.62mm ammunition in 20-round mags
	{	"vn_m14_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M14 selective-fire rifle firing 7.62mm ammunition in 20-round mags
	{	"vn_m14_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M14 selective-fire rifle firing 7.62mm ammunition in 20-round mags, with camo tape
	{	"vn_m21"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM21 sniper rifle firing 7.62mm ammunition in 20-round mags. Fitted with a 3x to 9x Adjustable Ranging Telescope
	{	"vn_m21_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM21 sniper rifle firing 7.62mm ammunition in 20-round mags. Fitted with a 3x to 9x Adjustable Ranging Telescope
	{	"vn_m21_nvg"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM21 sniper rifle firing 7.62mm ammunition in 20-round mags. Fitted with a 3x to 9x Adjustable Ranging Telescope
	{	"vn_m21_nvg_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM21 sniper rifle firing 7.62mm ammunition in 20-round mags. Fitted with a 3x to 9x Adjustable Ranging Telescope
	{	"vn_m1_garand"	,{	-1	,	0	,	0	,	-1	}}	,	//	M1 Garand 7.62x63mm Rifle
	{	"vn_m1_garand_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	M1 Garand 7.62x63mm Rifle
	{	"vn_m1_garand_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M1 Garand 7.62x63mm Rifle
	{	"vn_m1_garand_gl"	,{	-1	,	0	,	1	,	-1	}}	,	//	M1 Garand 7.62x63mm Rifle, fitted with an M8 22mm rifle grenade
	{	"vn_m14a1"	,{	-1	,	0	,	-1	,	-1	}}	,	//	M14A1 7.62mm automatic rifle
	{	"vn_m14a1_bipod"	,{	-1	,	0	,	-1	,	-1	}}	,	//	M14A1 7.62mm automatic rifle
	{	"vn_m14a1_sniper"	,{	-1	,	0	,	-1	,	-1	}}	,	//	M14A1 7.62mm automatic rifle
	{	"vn_m14a1_nvg"	,{	-1	,	0	,	-1	,	-1	}}	,	//	M14A1 7.62mm automatic rifle
	{	"vn_m14a1_camo"	,{	-1	,	0	,	-1	,	-1	}}	,	//	M14A1 7.62mm automatic rifle, fitted with a bipod and camo paint
	{	"vn_m14a1_shorty"	,{	-1	,	0	,	4	,	-1	}}	,	//	M14A1 cut short for use by SOG recon
	{	"vn_m14a1_shorty_fs"	,{	-1	,	0	,	5	,	-1	}}	,	//	M14A1 cut short for use by SOG recon, with added front sight
	{	"vn_m1903"	,{	0	,	0	,	0	,	0	}}	,	//	M1903 5-shot, clip-fed, 7.62x65 rifle
	{	"vn_m1903_sniper"	,{	0	,	0	,	0	,	0	}}	,	//	M1903 5-shot, clip-fed, 7.62x65 rifle
	{	"vn_m1903_bayo"	,{	0	,	0	,	0	,	0	}}	,	//	M1903 5-shot, clip-fed, 7.62x65 rifle
	{	"vn_m1903_gl"	,{	0	,	0	,	2	,	2	}}	,	//	M1903 5-shot, clip-fed, 7.62x65 rifle fitted with an M8 22mm rifle grenade
	{	"vn_m36"	,{	0	,	0	,	0	,	0	}}	,	//	M36 5-shot, clip-fed, 7.5x54mm rifle
	{	"vn_m36_bayo"	,{	0	,	0	,	0	,	0	}}	,	//	M36 5-shot, clip-fed, 7.5x54mm rifle
	{	"vn_m36_camo"	,{	0	,	0	,	0	,	0	}}	,	//	M36 5-shot, clip-fed, 7.5x54mm rifle
	{	"vn_l1a1_01"	,{	-1	,	0	,	1	,	-1	}}	,	//	Australian L1A1 7.62mm Rifle
	{	"vn_l1a1_01_mrk"	,{	-1	,	0	,	1	,	-1	}}	,	//	Australian L1A1 7.62mm Rifle
	{	"vn_l1a1_01_bayo"	,{	-1	,	0	,	1	,	-1	}}	,	//	Australian L1A1 7.62mm Rifle
	{	"vn_l1a1_01_camo"	,{	-1	,	0	,	1	,	-1	}}	,	//	Australian L1A1 7.62mm Rifle, fitted with camo tape
	{	"vn_l1a1_01_gl"	,{	-1	,	0	,	2	,	-1	}}	,	//	Australian L1A1 7.62mm Rifle, fitted with a 22mm rifle grenade adapter
	{	"vn_l1a1_02"	,{	-1	,	0	,	1	,	-1	}}	,	//	New Zealand L1A1 7.62mm Rifle
	{	"vn_l1a1_02_mrk"	,{	-1	,	0	,	1	,	-1	}}	,	//	New Zealand L1A1 7.62mm Rifle
	{	"vn_l1a1_02_bayo"	,{	-1	,	0	,	1	,	-1	}}	,	//	New Zealand L1A1 7.62mm Rifle
	{	"vn_l1a1_02_camo"	,{	-1	,	0	,	2	,	-1	}}	,	//	New Zealand L1A1 7.62mm Rifle, fitted with camo tape
	{	"vn_l1a1_02_gl"	,{	-1	,	0	,	3	,	-1	}}	,	//	New Zealand L1A1 7.62mm Rifle, fitted with a 22mm rifle grenade adapter
	{	"vn_l1a1_03"	,{	-1	,	0	,	4	,	-1	}}	,	//	SAS L1A1 7.62mm Rifle, fitted with foregrip
	{	"vn_l1a1_03_camo"	,{	-1	,	0	,	5	,	-1	}}	,	//	SAS L1A1 7.62mm Rifle, fitted with foregrip and camo paint
	{	"vn_l1a1_xm148"	,{	-1	,	0	,	4	,	-1	}}	,	//	L1A1 7.62mm Rifle, fitted with an XM148 40mm grenade launcher
	{	"vn_l1a1_xm148_camo"	,{	-1	,	0	,	5	,	-1	}}	,	//	L1A1 7.62mm Rifle, fitted with an XM148 40mm grenade launcher and camo paint
//OpFor														
	{	"vn_sks"	,{	0	,	-1	,	0	,	-1	}}	,	//	SKS semi-automatic rifle with folding bayonet. Chambered in 10-round clips of 7.62x39mm
	{	"vn_sks_sniper"	,{	0	,	-1	,	0	,	-1	}}	,	//	SKS semi-automatic rifle with folding bayonet. Chambered in 10-round clips of 7.62x39mm
	{	"vn_sks_bayo"	,{	0	,	-1	,	0	,	-1	}}	,	//	SKS semi-automatic rifle with folding bayonet. Chambered in 10-round clips of 7.62x39mm
	{	"vn_sks_gl"	,{	0	,	-1	,	0	,	-1	}}	,	//	SKS semi-automatic rifle with folding bayonet. Chambered in 10-round clips of 7.62x39mm. Fitted with 22mm rifle grenade
	{	"vn_m1891"	,{	0	,	-1	,	0	,	-1	}}	,	//	M1891 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_m1891_bayo"	,{	0	,	-1	,	0	,	-1	}}	,	//	M1891 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_m38"	,{	0	,	-1	,	0	,	-1	}}	,	//	M38 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_m38_bayo"	,{	0	,	-1	,	0	,	-1	}}	,	//	M38 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_m9130"	,{	0	,	-1	,	0	,	-1	}}	,	//	M91/30 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_m9130_sniper"	,{	0	,	-1	,	0	,	-1	}}	,	//	M91/30 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_m9130_bayo"	,{	0	,	-1	,	0	,	-1	}}	,	//	M91/30 5-shot, clip-fed, 7.62x54mmR rifle
	{	"vn_vz54"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VZ54 7.62mm Rifle
	{	"vn_vz54_sniper"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VZ54 7.62mm Rifle
	{	"vn_vz54_sniper_camo"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VZ54 7.62mm Rifle
	{	"vn_svd"	,{	0	,	-1	,	-1	,	-1	}}	,	//	SVD 7.62x54mm semi-automatic marksman rifle
	{	"vn_svd_sniper"	,{	0	,	-1	,	-1	,	-1	}}	,	//	SVD 7.62x54mm semi-automatic marksman rifle
	{	"vn_svd_sniper_camo"	,{	0	,	-1	,	-1	,	-1	}}	,	//	SVD 7.62x54mm semi-automatic marksman rifle
	{	"vn_k98k"	,{	0	,	-1	,	0	,	0	}}	,	//	K98K 5-shot, clip-fed, 7.92x57mm rifle
	{	"vn_k98k_bayo"	,{	0	,	-1	,	0	,	0	}}	,	//	K98K 5-shot, clip-fed, 7.92x57mm rifle
	{	"vn_k98k_mrk"	,{	0	,	-1	,	0	,	0	}}	,	//	K98K 5-shot, clip-fed, 7.92x57mm rifle
	{	"vn_k98k_mrk_camo"	,{	0	,	-1	,	0	,	0	}}	,	//	K98K 5-shot, clip-fed, 7.92x57mm rifle
//Assault Rifles														
//BluFor														
	{	"vn_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle. 20-round mag
	{	"vn_m16_muzzle"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle. 20-round mag
	{	"vn_m16_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_mrk"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_mrk_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_sniper_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_nvg"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_nvg_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG camo version
	{	"vn_m16_xm148"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle with XM148 single-shot 40mm grenade-launcher attached under the barrel, and camo tape
	{	"vn_m16_m203"	,{	-1	,	0	,	4	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG version fitted with M203 40mm Grenade Launcher
	{	"vn_m16_m203_camo"	,{	-1	,	0	,	6	,	-1	}}	,	//	M16A1 5.56mm Assault Rifle, SF/SOG version fitted with M203 40mm Grenade Launcher and camo
	{	"vn_m16_usaf"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16 5.56mm Assault Rifle. USAF version. 20-round mag
	{	"vn_m16_usaf_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16 5.56mm Assault Rifle. USAF version. 20-round mag
	{	"vn_m16_usaf_mrk"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16 5.56mm Assault Rifle. USAF version. 20-round mag
	{	"vn_m16_usaf_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16 5.56mm Assault Rifle. USAF version. 20-round mag
	{	"vn_m16_usaf_nvg"	,{	-1	,	0	,	0	,	-1	}}	,	//	M16 5.56mm Assault Rifle. USAF version. 20-round mag
	{	"vn_gau5a"	,{	-1	,	0	,	2	,	-1	}}	,	//	GAU-5A/A 5.56mm USAF carbine
	{	"vn_gau5a_mrk"	,{	-1	,	0	,	2	,	-1	}}	,	//	GAU-5A/A 5.56mm USAF carbine
	{	"vn_m63a"	,{	-1	,	0	,	0	,	-1	}}	,	//	M63A 5.56mm Automatic Rifle. 30-round mag
	{	"vn_xm16e1"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM16E1 5.56mm Assault Rifle. Early version. 20-round mag
	{	"vn_xm16e1_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM16E1 5.56mm Assault Rifle. Early version. 20-round mag
	{	"vn_xm16e1_mrk"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM16E1 5.56mm Assault Rifle. Early version. 20-round mag
	{	"vn_xm16e1_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM16E1 5.56mm Assault Rifle. Early version. 20-round mag
	{	"vn_xm16e1_xm148"	,{	-1	,	0	,	5	,	-1	}}	,	//	XM16E1 5.56mm Assault Rifle, fitted with XM148 40mm grenade launcher
	{	"vn_xm16e1_nvg"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM16E1 5.56mm Assault Rifle. Early version. 20-round mag
	{	"vn_xm177_stock"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG version fitted with an M16 stock
	{	"vn_xm177_stock_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG version fitted with an M16 stock and camo paint
	{	"vn_xm177_short"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, short SF/SOG version with 10 inch barrel
	{	"vn_xm177"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG light version
	{	"vn_xm177_muzzle"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG light version
	{	"vn_xm177_mrk"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG light version
	{	"vn_xm177_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG light version
	{	"vn_xm177_nvg"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG light version
	{	"vn_xm177_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG version with camo tape
	{	"vn_xm177_fg"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG version fitted with a fore-grip
	{	"vn_xm177_xm148"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG version fitted with XM148 40mm grenade launcher
	{	"vn_xm177_xm148_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	XM177E2 5.56mm carbine, SF/SOG version fitted with XM148 40mm grenade launcher and camo paint
	{	"vn_xm177e1"	,{	-1	,	0	,	1	,	-1	}}	,	//	XM177E1 5.56mm carbine, early SF/SOG light version
	{	"vn_xm177e1_mrk"	,{	-1	,	0	,	1	,	-1	}}	,	//	XM177E1 5.56mm carbine, early SF/SOG light version
	{	"vn_xm177e1_sniper"	,{	-1	,	0	,	1	,	-1	}}	,	//	XM177E1 5.56mm carbine, early SF/SOG light version
	{	"vn_xm177e1_nvg"	,{	-1	,	0	,	1	,	-1	}}	,	//	XM177E1 5.56mm carbine, early SF/SOG light version
	{	"vn_xm177e1_camo"	,{	-1	,	0	,	2	,	-1	}}	,	//	XM177E1 5.56mm carbine, early SF/SOG light version with camo tape
	{	"vn_xm177_m203"	,{	-1	,	0	,	5	,	-1	}}	,	//	XM177E2 5.56mm Assault Rifle, SF/SOG version fitted with M203 40mm Grenade Launcher
	{	"vn_xm177_m203_camo"	,{	-1	,	0	,	6	,	-1	}}	,	//	XM177E2 5.56mm Assault Rifle, SF/SOG camo version fitted with M203 40mm Grenade Launcher
//OpFor														
	{	"vn_type56"	,{	0	,	-1	,	0	,	-1	}}	,	//	Type 56 7.62mm Assault Rifle. Chinese copy of AK-47 with folding cruciform bayonet
	{	"vn_kbkg"	,{	0	,	-1	,	-1	,	4	}}	,	//	KBKG 7.62x39mm Assault Rifle
	{	"vn_kbkg_gl"	,{	0	,	-1	,	-1	,	6	}}	,	//	KBKG 7.62x39mm, lightweight, easy-to-use selective-fire rifle, fitted with a 22mm rifle grenade
	{	"vn_ak_01"	,{	0	,	-1	,	4	,	2	}}	,	//	AK 7.62x39mm Assault Rifle
//Carbine														
//BluFor														
	{	"vn_m2carbine"	,{	-1	,	0	,	0	,	-1	}}	,	//	M2 Carbine, 7.62x33mm, lightweight, easy-to-use selective-fire rifle
	{	"vn_m2carbine_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M2 Carbine, 7.62x33mm, lightweight, easy-to-use selective-fire rifle
	{	"vn_m2carbine_sniper"	,{	-1	,	0	,	0	,	-1	}}	,	//	M2 Carbine, 7.62x33mm, lightweight, easy-to-use selective-fire rifle
	{	"vn_m2carbine_gl"	,{	-1	,	0	,	0	,	-1	}}	,	//	M2 Carbine, 7.62x33mm, lightweight, easy-to-use selective-fire rifle, fitted with an M8 22mm rifle grenade
	{	"vn_m3carbine"	,{	-1	,	0	,	0	,	-1	}}	,	//	M3 carbine 7.62x33mm rifle, fitted with a heavy infra-red night-vision scope
	{	"vn_m1carbine_shorty"	,{	-1	,	0	,	6	,	-1	}}	,	//	M1 Carbine cut short with added scope and rechambered in 9x19mm to take HP magazines, for use by SOG recon
	{	"vn_m1carbine"	,{	0	,	0	,	0	,	-1	}}	,	//	M1 Carbine, 7.62x33mm, lightweight, easy-to-use semi-automatic rifle
	{	"vn_m1carbine_bayo"	,{	0	,	0	,	0	,	-1	}}	,	//	M1 Carbine, 7.62x33mm, lightweight, easy-to-use semi-automatic rifle
	{	"vn_m1carbine_sniper"	,{	0	,	0	,	0	,	-1	}}	,	//	M1 Carbine, 7.62x33mm, lightweight, easy-to-use semi-automatic rifle
	{	"vn_m1carbine_gl"	,{	0	,	0	,	0	,	-1	}}	,	//	M1 Carbine, 7.62x33mm, lightweight, easy-to-use semi-automatic rifle, fitted with an M8 22mm rifle grenade
	{	"vn_m4956"	,{	0	,	0	,	0	,	-1	}}	,	//	M49/56 French semi-automatic 7.5x54mm rifle
	{	"vn_m4956_sniper"	,{	0	,	0	,	0	,	-1	}}	,	//	M49/56 French semi-automatic 7.5x54mm rifle
	{	"vn_m4956_bayo"	,{	0	,	0	,	0	,	-1	}}	,	//	M49/56 French semi-automatic 7.5x54mm rifle
	{	"vn_m4956_gl"	,{	0	,	0	,	0	,	-1	}}	,	//	M49/56 French semi-automatic 7.5x54mm rifle fitted with a 22mm rifle grenade
//Machine Guns														
//BluFor														
	{	"vn_m60_shorty"	,{	-1	,	0	,	0	,	-1	}}	,	//	M60 7.62mm Light Machine Gun with 100-round box and short barrel
	{	"vn_m60_shorty_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M60 7.62mm Light Machine Gun with 100-round box, short barrel and camo spray
	{	"vn_m60"	,{	-1	,	0	,	0	,	-1	}}	,	//	M60 7.62mm Light Machine Gun with 100-round box and bipod
	{	"vn_m63a_cdo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M63A 5.56mm Commando. 150-round drum
	{	"vn_m63a_cdo_bipod"	,{	-1	,	0	,	0	,	-1	}}	,	//	M63A 5.56mm Commando. 150-round drum
	{	"vn_m63a_lmg"	,{	-1	,	0	,	0	,	-1	}}	,	//	M63A 5.56mm LMG. 100-round box
	{	"vn_m63a_lmg_bipod"	,{	-1	,	0	,	0	,	-1	}}	,	//	M63A 5.56mm LMG. 100-round box
	{	"vn_m1918"	,{	-1	,	0	,	2	,	-1	}}	,	//	M1918A2 7.62x63mm Light Machine Gun fed by 20 round magazines
	{	"vn_m1918_bipod"	,{	-1	,	0	,	2	,	-1	}}	,	//	M1918A2 7.62x63mm Light Machine Gun fed by 20 round magazines
	{	"vn_l2a1_01"	,{	-1	,	0	,	3	,	-1	}}	,	//	L2A1 7.62mm LMG, fitted with a bipod
	{	"vn_l4"	,{	-1	,	0	,	-1	,	-1	}}	,	//	L4 7.62x51mm selective-fire LMG
//OpFor														
	{	"vn_rpd_shorty"	,{	0	,	-1	,	0	,	-1	}}	,	//	RPD 7.62mm LMG, with sawn-off barrel, sight, and bipod, carried by El Cid of MACV SOG
	{	"vn_rpd_shorty_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	RPD 7.62mm LMG, with sawn-off barrel and bipod
	{	"vn_rpd"	,{	0	,	-1	,	0	,	-1	}}	,	//	RPD 7.62x39mm Light Machine Gun fed by drums containing 100-round belts
	{	"vn_dp28"	,{	0	,	-1	,	0	,	-1	}}	,	//	DP-27 7.62mm Light Machine Gun with 47 round mag and bipod
	{	"vn_pk"	,{	0	,	-1	,	0	,	-1	}}	,	//	PK 7.62mm Light Machine Gun with 100-round box and bipod
	{	"vn_mg42"	,{	0	,	-1	,	-1	,	4	}}	,	//	MG42 7.92x57mm Light Machine Gun fed by 50-round drums or boxes containing 250-round belts
//Submachine Guns														
//BluFor														
	{	"vn_m3a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	M3A1 Grease Gun
	{	"vn_m3sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M3A1 Grease Gun
	{	"vn_m45"	,{	-1	,	0	,	0	,	-1	}}	,	//	M/45 9mm Submachinegun. Swedish SMG with folding stock
	{	"vn_m45_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	M/45 9mm Submachinegun. Swedish SMG with folding stock
	{	"vn_m45_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	M/45 9mm Submachinegun. Swedish SMG with camo paint and folding stock
	{	"vn_m45_fold"	,{	-1	,	0	,	0	,	-1	}}	,	//	M/45 9mm Submachinegun. Swedish SMG with folded stock
	{	"vn_mat49"	,{	-1	,	0	,	0	,	-1	}}	,	//	MAT-49
	{	"vn_mat49_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	MAT-49
	{	"vn_mc10"	,{	-1	,	0	,	0	,	-1	}}	,	//	The MC-10 is a compact, blowback operated machine pistol developed in 1964 chambered in 9mm (or .45ACP)
	{	"vn_mc10_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	The MC-10 is a compact, blowback operated machine pistol developed in 1964 chambered in 9mm (or .45ACP)
	{	"vn_sten"	,{	-1	,	0	,	0	,	0	}}	,	//	Sten Mk.II
	{	"vn_sten_sd"	,{	-1	,	0	,	0	,	0	}}	,	//	Sten Mk.II
	{	"vn_m1928_tommy"	,{	-1	,	0	,	0	,	-1	}}	,	//	The M1928 Tommy Gun is a blowback operated, selective fire U.S. submachinegun chambered in .45 ACP, capable of using a 50 round drum
	{	"vn_m1928a1_tommy"	,{	-1	,	0	,	0	,	-1	}}	,	//	The M1928A1 Tommy Gun is a blowback operated, selective fire U.S. submachinegun chambered in .45 ACP, capable of using a 50 round drum
	{	"vn_m1a1_tommy"	,{	-1	,	0	,	0	,	-1	}}	,	//	The M1A1 Tommy Gun is a blowback operated, selective fire U.S. submachinegun chambered in .45 ACP
	{	"vn_m1a1_tommy_so"	,{	-1	,	0	,	0	,	-1	}}	,	//	The M1A1 Tommy Gun (shorty) is a blowback operated, selective fire U.S. submachinegun chambered in .45 ACP with the butt removed
	{	"vn_mpu"	,{	-1	,	0	,	0	,	-1	}}	,	//	The MPU is a compact, open bolt, blowback operated submachinegun developed in 1954 chambered in 9mm
	{	"vn_mpu_sd"	,{	-1	,	0	,	0	,	-1	}}	,	//	The MPU is a compact, open bolt, blowback operated submachinegun developed in 1954 chambered in 9mm
	{	"vn_f1_smg"	,{	-1	,	0	,	2	,	-1	}}	,	//	F1 9mm SMG
	{	"vn_f1_smg_bayo"	,{	-1	,	0	,	2	,	-1	}}	,	//	F1 9mm SMG
	{	"vn_l2a3"	,{	-1	,	0	,	2	,	-1	}}	,	//	L2A3 9mm Submachinegun.
	{	"vn_l2a3_f"	,{	-1	,	0	,	3	,	-1	}}	,	//	L2A3 9mm Submachinegun. SMG with folded stock
	{	"vn_l34a1"	,{	-1	,	0	,	4	,	-1	}}	,	//	L34A1 9mm Submachinegun with folding stock and integral suppressor.
	{	"vn_l34a1_f"	,{	-1	,	0	,	5	,	-1	}}	,	//	L34A1 9mm Submachinegun with folded stock and integral suppressor.
	{	"vn_l34a1_xm148"	,{	-1	,	0	,	6	,	-1	}}	,	//	L34A1 9mm Submachinegun with folding stock and integral suppressor, with XM148 single-shot 40mm grenade-launcher attached under the barrel.
//OpFor														
	{	"vn_k50m"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vietnamese K-50M 7.62mm submachinegun with 35 or 71-round magazine
	{	"vn_mat49_f"	,{	0	,	-1	,	0	,	-1	}}	,	//	MAT-49 SMG with folded stock
	{	"vn_mat49_vc"	,{	0	,	-1	,	0	,	-1	}}	,	//	MAT-49 SMG, Viet Cong conversion
	{	"vn_mp40"	,{	0	,	-1	,	0	,	-1	}}	,	//	The MP40 is a submachinegun chambered for 9Ã—19mm Parabellum cartridge
	{	"vn_pps43"	,{	0	,	-1	,	0	,	-1	}}	,	//	Polish PPS-43 7.62mm automatic submachinegun with 35-round magazine
	{	"vn_pps52"	,{	0	,	-1	,	0	,	-1	}}	,	//	Polish PPS-52 7.62mm automatic submachinegun with 35-round magazine
	{	"vn_ppsh41"	,{	0	,	-1	,	0	,	-1	}}	,	//	Soviet PPSh-41 7.62mm submachinegun with 35 or 71-round magazine
	{	"vn_vz61"	,{	0	,	-1	,	0	,	-1	}}	,	//	The VZ.61 Skorpion is a select-fire blowback operated Czech machine pistol chambered in .32 ACP
	{	"vn_type64_smg"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Type 64 7.65mm Submachinegun. Chinese SMG with folding stock and integral suppressor.
	{	"vn_type64_f_smg"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Type 64 7.65mm Submachinegun. Chinese SMG with folded stock and integral suppressor.
//Shotguns														
//BluFor														
	{	"vn_m1897"	,{	-1	,	0	,	0	,	-1	}}	,	//	Model 1897 12 gauge Trench gun, 6-round mag, capable of slam-firing
	{	"vn_m1897_bayo"	,{	-1	,	0	,	0	,	-1	}}	,	//	Model 1897 12 gauge Trench gun, 6-round mag, capable of slam-firing
//OpFor														
	{	"vn_izh54"	,{	0	,	-1	,	0	,	-1	}}	,	//	ISh-54 double-barrelled Shotgun
	{	"vn_izh54_shorty"	,{	0	,	-1	,	0	,	-1	}}	,	//	ISh-54 double-barrelled Shotgun (Sawn-off)
//Sidearm														
//BluFor														
	{	"vn_welrod"	,{	-1	,	0	,	0	,	-1	}}	,	//	Welrod single-shot, suppressed pistol, caliber 7.65x17mm, 8-round mag
	{	"vn_vz61_p"	,{	-1	,	0	,	0	,	-1	}}	,	//	The VZ.61 Skorpion is a select-fire blowback operated Czech machine pistol chambered in .32 ACP, and worn as a sidearm
	{	"vn_fkb1_pm"	,{	0	,	0	,	0	,	-1	}}	,	//	PM semi-automatic pistol, 9mm caliber, 8-round mag with FKB-1 Flashlight
	{	"vn_fkb1_pm_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	PM semi-automatic pistol, 9mm caliber, 8-round mag with FKB-1 Flashlight
	{	"vn_mx991_m1911"	,{	0	,	0	,	0	,	-1	}}	,	//	M1911 .45 caliber semi-automatic pistol, 7-round magazine, with angle-head MX-991 Flashlight
	{	"vn_mx991_m1911_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	M1911 .45 caliber semi-automatic pistol, 7-round magazine, with angle-head MX-991 Flashlight
	{	"vn_pm"	,{	0	,	0	,	0	,	-1	}}	,	//	PM semi-automatic pistol, 9mm caliber, 8-round mag
	{	"vn_pm_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	PM semi-automatic pistol, 9mm caliber, 8-round mag
	{	"vn_tt33"	,{	0	,	0	,	0	,	-1	}}	,	//	TT-33 semi-automatic pistol, chambered in 7.62x25mm. 8-round magazine
	{	"vn_hd"	,{	0	,	0	,	0	,	-1	}}	,	//	HD suppressed pistol, .22LR caliber, 10-round mag
	{	"vn_hp"	,{	0	,	0	,	0	,	-1	}}	,	//	HP 9mm semi-automatic pistol, 13 round mag
	{	"vn_hp_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	HP 9mm semi-automatic pistol, 13 round mag
	{	"vn_m1911"	,{	0	,	0	,	0	,	-1	}}	,	//	M1911 .45 caliber semi-automatic pistol, 7-round magazine
	{	"vn_m1911_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	M1911 .45 caliber semi-automatic pistol, 7-round magazine
	{	"vn_mk22"	,{	0	,	0	,	0	,	-1	}}	,	//	Mk22 Mod 0
	{	"vn_mk22_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	Mk22 Mod 0
	{	"vn_m10"	,{	0	,	0	,	0	,	-1	}}	,	//	Model 10 .38 revolver, 6-round reload
	{	"vn_m10_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	Model 10 .38 revolver, 6-round reload
	{	"vn_m1895"	,{	0	,	0	,	0	,	-1	}}	,	//	M1895 seven-shot, gas-seal revolver chambered for 7.62x38mmR. The unique gas seal enables use with a suppressor
	{	"vn_m1895_sd"	,{	0	,	0	,	0	,	-1	}}	,	//	M1895 seven-shot, gas-seal revolver chambered for 7.62x38mmR. The unique gas seal enables use with a suppressor
	{	"vn_p38s"	,{	0	,	0	,	0	,	-1	}}	,	//	.38 Revolver revolver, 6-round reload
	{	"vn_ppk"	,{	0	,	0	,	2	,	0	}}	,	//	PPK 9mm semi-automatic pistol
	{	"vn_ppk_sd"	,{	0	,	0	,	2	,	0	}}	,	//	PPK 9mm semi-automatic pistol
	{	"vn_p38"	,{	0	,	0	,	1	,	1	}}	,	//	P38 9mm semi-automatic pistol
	{	"vn_p38_sd"	,{	0	,	0	,	1	,	1	}}	,	//	P38 9mm semi-automatic pistol
	{	"vn_mk1_udg"	,{	-1	,	0	,	0	,	-1	}}	,	//	The Mk1 Underwater Defence Gun (UDG) is a compact, double action only pepper-box weapon developed in the 1960s with a removable cylinder of six 4.25in darts
//OpFor														
	{	"vn_m712"	,{	0	,	-1	,	0	,	-1	}}	,	//	M712 selective-fire pistol, chambered in 7.62x25mm. 20-round magazine
	{	"vn_izh54_p"	,{	0	,	-1	,	0	,	-1	}}	,	//	ISh-54 double-barrelled Shotgun (Sidearm)
	{	"vn_type64"	,{	0	,	-1	,	-1	,	6	}}	,	//	Suppressed Type 64 7.65x17mm semi-automatic pistol
//Launchers														
//BluFor														
	{	"vn_m72"	,{	-1	,	0	,	0	,	-1	}}	,	//	M72 LAW single-use HEAT rocket
	{	"vn_m79"	,{	0	,	0	,	0	,	-1	}}	,	//	M79 Grenade Launcher. Fires 40mm HE grenades, smoke and flares
	{	"vn_m79_p"	,{	-1	,	0	,	0	,	-1	}}	,	//	M79 Grenade Launcher. Sawn-off for close quarters by SOG as a sidearm. Fires 40mm HE grenades, smoke and flares
	{	"vn_m20a1b1_01"	,{	-1	,	0	,	3	,	-1	}}	,	//	
	{	"vn_rocket_m128_launcher"	,{	-1	,	0	,	0	,	-1	}}	,	//	Flare Launcher
//OpFor														
	{	"vn_rpg2"	,{	0	,	-1	,	0	,	-1	}}	,	//	B40 HEAT rocket
	{	"vn_rpg7"	,{	0	,	-1	,	0	,	-1	}}	,	//	B41 HEAT rocket
	{	"vn_sa7"	,{	0	,	-1	,	0	,	-1	}}	,	//	9K32 Strela-2 Anti-Aircraft Missile
	{	"vn_sa7b"	,{	0	,	-1	,	0	,	-1	}}	,	//	9K32 Strela-2M Anti-Aircraft Missile
//Other														
//BluFor														
	{	"vn_mx991"	,{	0	,	0	,	0	,	-1	}}	,	//	US Angle-head MX-991 Flashlight, powered by BA-30 1.5v batteries
	{	"vn_mx991_red"	,{	0	,	0	,	0	,	-1	}}	,	//	Angle-head MX-991 Flashlight with red lens, powered by BA-30 1.5v batteries
	{	"vn_m127"	,{	0	,	0	,	0	,	-1	}}	,	//	M127 single-use flare, white
	{	"vn_camera_01"	,{	-1	,	0	,	1	,	-1	}}	,	//	SOG 35mm camera carried on clandestine missions by MACV SOG
	{	"vn_fkb1"	,{	0	,	0	,	0	,	-1	}}	,	//	Soviet FKB-1 Flashlight, powered by 2xR20 batteries
	{	"vn_fkb1_red"	,{	0	,	0	,	0	,	-1	}}	,	//	Soviet FKB-1 Flashlight with red lens, powered by 2xR20 batteries
//Melee Weapons:														
//Blufor														
	{	"vn_m_axe_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_axe_fire"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_bayo_carbine"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_bayo_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_bayo_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_bayo_m1897"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_bayo_m4956"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_bolo_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_fighting_knife_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_hammer"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_m51_etool_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_machete_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_machete_02"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_mk2_knife_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_shovel_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_typeivaxe_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_m_wrench_01"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_melee_m43_etool_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_melee_m1903"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_b_melee_m36"	,{	0	,	0	,	0	,	0	}}	,	//	
//OpFor														
	{	"vn_b_melee_k98k"	,{	0	,	-1	,	-1	,	0	}}	,	//	
	{	"vn_m_vc_knife_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	
//Nickel Steel														
/*	{	"vnx_m77e"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m77e_shorty"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_fm2429"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_fm2429_aa"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_gjet"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_hd_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_l1a1_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_l1a1_04_camo"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_l1a1_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_l1a1_05_camo"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m12_smg"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m12_smg_fold"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m45_sf"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m45_sf_sd"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m50_smg"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m50_smg_fold"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_type56_xm148"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m_ladle"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m_spoon_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m_spoon_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m77e_fl_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m77e_buck_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m77e_so_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_fm2429_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_fm2429_t_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_gjet_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_hd_02_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m12_smg_32_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m12_smg_32_t_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m12_smg_20_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m12_smg_20_t_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m50_smg_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vnx_m50_smg_t_mag"	,{	0	,	0	,	0	,	0	}}	,	//	
*/														
//Binoculars														
//BluFor														
	{	"vn_m19_binocs_grey"	,{	0	,	0	,	0	,	0	}}	,	//	Binocular M19 Grey (7x50)
	{	"vn_m19_binocs_grn"	,{	0	,	0	,	0	,	0	}}	,	//	Binocular M19 Green (7x50)
	{	"vn_mk21_binocs"	,{	0	,	0	,	0	,	0	}}	,	//	Binocular Mk21 (7x50)
	{	"vn_anpvs2_binoc"	,{	-1	,	0	,	0	,	0	}}	,	//	Starlight ANPVS2 (NV)
//Blufor														
//Bayonet/Camo														
	{	"vn_b_camo_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Camo wrap [M14]
	{	"vn_b_camo_m14a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Camo wrap [M14A1]
	{	"vn_b_camo_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Camo wrap [M40]
	{	"vn_b_carbine"	,{	0	,	0	,	0	,	-1	}}	,	//	Bayonet M4 [M1/ M2]
	{	"vn_b_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bayonet M6 [M14]
	{	"vn_b_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bayonet M7 [M16]
	{	"vn_b_m1897"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bayonet M1917 [M1897]
	{	"vn_b_m1_garand"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bayonet M5 [M1 Garand]
	{	"vn_b_camo_m1_garand"	,{	-1	,	0	,	2	,	-1	}}	,	//	Camo wrap [M1 Garand]
	{	"vn_bipod_m1918"	,{	-1	,	0	,	4	,	-1	}}	,	//	Bipod [M1918]
	{	"vn_bipod_m16"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bipod [M16]
	{	"vn_bipod_m14"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bipod [M14]
	{	"vn_b_l1a1"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bayonet L1A1 [L1A1/ F1]
	{	"vn_b_m1903"	,{	0	,	0	,	1	,	1	}}	,	//	Bayonet [M1903]
	{	"vn_b_m36"	,{	0	,	0	,	1	,	1	}}	,	//	Bayonet Spike [M36]
	{	"vn_b_camo_m1903"	,{	0	,	0	,	2	,	2	}}	,	//	Camo wrap [M1903]
	{	"vn_b_camo_m36"	,{	0	,	0	,	2	,	2	}}	,	//	Camo wrap [M36]
	{	"vn_bipod_m63a"	,{	-1	,	0	,	3	,	-1	}}	,	//	Bipod [M63A]
 	{	"vn_b_m4956"	,{	0	,	0	,	0	,	-1	}}	,	//	Bayonet Model 58 [M49/56]
//Suppressor														
	{	"vn_s_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M14/M40]
	{	"vn_s_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M16]
	{	"vn_s_m1895"	,{	0	,	0	,	0	,	-1	}}	,	//	Suppressor [M1895]
	{	"vn_s_m1911"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M1911]
	{	"vn_s_m3a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M3]
	{	"vn_s_m45"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M/45]
	{	"vn_s_m45_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M/45 Camo]
	{	"vn_s_mat49"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [MAT-49]
	{	"vn_s_mc10"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [MC-10]
	{	"vn_s_mk22"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [Mk22]
	{	"vn_s_pm"	,{	0	,	0	,	0	,	-1	}}	,	//	Suppressor [PM]
	{	"vn_s_sten"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [Sten Mk.II]
	{	"vn_s_ppk"	,{	0	,	0	,	2	,	2	}}	,	//	Suppressor 9mm [PPK/ P38]
	{	"vn_s_hp"	,{	-1	,	0	,	3	,	-1	}}	,	//	Suppressor 9mm [HP]
	{	"vn_s_mpu"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [MPU]
//Optics														
	{	"vn_o_4x_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M16 4x)
	{	"vn_o_9x_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M14 3-9x)
	{	"vn_o_9x_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M16 3-9x)
	{	"vn_o_9x_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M40 3-9x)
	{	"vn_o_9x_m40a1_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M40 3-9x camo)
	{	"vn_o_anpvs2_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scope (AN-PVS2 Starlight) [M14]
	{	"vn_o_anpvs2_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scope (AN-PVS2 Starlight) [XM177/M16]
	{	"vn_o_anpvs2_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scope (AN-PVS2 Starlight) [M40]
	{	"vn_o_3x_m84"	,{	0	,	0	,	0	,	-1	}}	,	//	Scope (M1/2 Carbine 2.2x)
	{	"vn_o_1x_sp_m16"	,{	-1	,	0	,	6	,	-1	}}	,	//	Optic (M16 SP)
	{	"vn_o_3x_l1a1"	,{	-1	,	0	,	2	,	-1	}}	,	//	Optic (L1A1 3x)
	{	"vn_o_8x_m1903"	,{	0	,	0	,	1	,	1	}}	,	//	Optic [M1903 8x]
	{	"vn_o_m14_front"	,{	-1	,	0	,	4	,	-1	}}	,	//	Optic (M14 Front Sight)
	{	"vn_o_4x_m4956"	,{	0	,	0	,	0	,	-1	}}	,	//	Scope (M49/56 3.5x)
//OpFor														
//Bayonet/Camo														
	{	"vn_b_sks"	,{	0	,	-1	,	0	,	-1	}}	,	//	Bayonet Spike [M38]
	{	"vn_b_type56"	,{	0	,	-1	,	0	,	-1	}}	,	//	Bayonet Spike [Type56]
 	{	"vn_b_camo_vz54"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Camo wrap [VZ54]
	{	"vn_b_camo_svd"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Camo wrap [SVD]
	{	"vn_b_camo_k98k"	,{	0	,	-1	,	2	,	2	}}	,	//	Camo wrap [K98K]
	{	"vn_b_k98k"	,{	0	,	-1	,	1	,	1	}}	,	//	Bayonet [K98K]
	{	"vn_b_m38"	,{	0	,	-1	,	0	,	-1	}}	,	//	Bayonet Spike [M38/ M91/30/ M1892]
	{	"vn_b_camo_m9130"	,{	0	,	-1	,	0	,	-1	}}	,	//	Camo wrap [M9130]
//Optic														
	{	"vn_o_3x_m9130"	,{	0	,	-1	,	0	,	-1	}}	,	//	Optic (M91/30 3.5x)
	{	"vn_o_3x_sks"	,{	0	,	-1	,	0	,	-1	}}	,	//	Optic (SKS 3.5x)
	{	"vn_o_3x_vz54"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Optic (VZ54 2.5x)
	{	"vn_o_4x_svd"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Optic [SVD 4x]
	{	"vn_o_1_5x_k98k"	,{	0	,	-1	,	1	,	1	}}	,	//	Optic [K98K 1.5x]
};														
magazines[] =														
{ 														
//Rifle Grenades														
	{	"vn_22mm_cs_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	22mm CS Riot gas rifle grenade used in SKS, M1 Carbine and M49/56
	{	"vn_22mm_he_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	22mm FRAG rifle grenade used in M49/56 rifle
	{	"vn_22mm_lume_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	22mm Illumination rifle grenade used in SKS, M1 Carbine and M49/56
	{	"vn_22mm_m17_frag_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M17 22mm FRAG rifle grenade used in M1 Carbine
	{	"vn_22mm_m19_wp_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M19 22mm White Phosphorus rifle grenade used in SKS, M1 Carbine and M49/56
	{	"vn_22mm_m1a2_frag_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M1A2 22mm FRAG rifle grenade used in M1 Carbine
	{	"vn_22mm_m22_smoke_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M22 22mm Smoke rifle grenade used in SKS, M1 Carbine and M49/56
	{	"vn_22mm_m60_frag_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M60 22mm FRAG rifle grenade used in SKS rifle
	{	"vn_22mm_m60_heat_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M60 22mm HEAT rifle grenade used in SKS rifle
	{	"vn_22mm_m9_heat_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	M9 22mm HEAT rifle grenade used in M1 Carbine and M49/56
	{	"vn_22mm_m61_frag_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M61 22mm FRAG rifle grenade used in L1A1
	{	"vn_22mm_n94_heat_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	N94 22mm HEAT rifle grenade used in L1A1
//OpFor														
	{	"vn_20mm_f1n60_frag_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	F1N60 20mm FRAG rifle grenade used in KBKG rifle
	{	"vn_20mm_kgn_frag_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	KGN 20mm FRAG rifle grenade used in KBKG rifle
	{	"vn_20mm_pgn60_heat_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	PGN60 20mm HEAT rifle grenade used in KBKG rifle
	{	"vn_20mm_dgn_wp_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	DGN 20mm White Phosphorus rifle grenade used in KBKG, M1 Carbine and M49/56
//40mm Ammo														
	{	"vn_40mm_m381_he_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M381 40mm HE Grenade used in M79, XM148 and M203 Grenade Launchers. 3m arming distance
	{	"vn_40mm_m397_ab_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M397 40mm Airburst Grenade used in M79, XM148 and M203 Grenade Launchers
	{	"vn_40mm_m406_he_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M406 40mm HE Grenade used in M79, XM148 and M203 Grenade Launchers. 14m arming distance
	{	"vn_40mm_m433_hedp_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M433 40mm HEDP Grenade used in M79, XM148 and M203 Grenade Launchers. Range 15m, penetrates 2in RHA steel armour
	{	"vn_40mm_m576_buck_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M576 40mm Buckshot round used in M79, XM148 and M203 Grenade Launchers
	{	"vn_40mm_m583_flare_w_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M583 40mm Flare (White) used in M79, XM148 and M203 Grenade Launchers
	{	"vn_40mm_m651_cs_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M651 40mm CS Gas grenade used in M203, XM148 and M79 grenade launchers
	{	"vn_40mm_m661_flare_g_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M661 40mm Flare (Green) used in M79, XM148 and M203 Grenade Launchers
	{	"vn_40mm_m662_flare_r_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M662 40mm Flare (Red) used in M79, XM148 and M203 Grenade Launchers
	{	"vn_40mm_m680_smoke_w_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M680 40mm Smoke grenade (White) used in M203, XM148 and M79 grenade launchers
	{	"vn_40mm_m682_smoke_r_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M682 40mm Smoke grenade (Red) used in M203, XM148 and M79 grenade launchers
	{	"vn_40mm_m695_flare_y_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M695 40mm Flare (Yellow) used in M79, XM148 and M203 Grenade Launchers
	{	"vn_40mm_m715_smoke_g_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M715 40mm Smoke grenade (Green) used in M203, XM148 and M79 grenade launchers
	{	"vn_40mm_m716_smoke_y_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M716 40mm Smoke grenade (Yellow) used in M203, XM148 and M79 grenade launchers
	{	"vn_40mm_m717_smoke_p_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M717 40mm Smoke grenade (Purple) used in M203, XM148 and M79 grenade launchers
//Rifle Cartridge														
//Clips														
	{	"vn_m40a1_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	5Rnd. M40 Reload. Caliber: 7.62x51mm. Used in M40 Rifle
	{	"vn_m40a1_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	5Rnd. M40 Reload (Tracer). Caliber: 7.62x51mm. Used in M40 Rifle
	{	"vn_sks_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	10Rnd. SKS Clip. Caliber: 7.62x39mm. Used in SKS rifle
	{	"vn_sks_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	10Rnd. SKS Tracer Clip. Caliber: 7.62x39mm. Used in SKS rifle
	{	"vn_m1_garand_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	8Rnd. M1 Garand Clip. Caliber: 7.62x63mm. Used in M1 Garand
	{	"vn_m1_garand_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	8Rnd. M1 Garand Clip Caliber: 7.62x63mm. Used in M1 Garand(Tracer)
	{	"vn_m1903_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	5Rnd. M1903 Clip. Caliber: 7.62x65mm. Used in M1903 rifle
	{	"vn_m1903_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	5Rnd. M1903 Tracer Clip. Caliber: 7.62x65mm Used in M1903 rifle
	{	"vn_m36_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	5Rnd. M36 Clip. Caliber: 7.5x54mm. Used in M36 rifle
	{	"vn_m36_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	5Rnd. M36 Tracer Clip. Caliber: 7.5x54mm Used in M36 rifle
//OpFor														
	{	"vn_m38_mag"	,{	0	,	-1	,	0	,	3	}}	,	//	5Rnd. M38 Clip. Caliber: 7.62x54mmR. Used in M38, VZ54, M1891 and M91/30 rifles
	{	"vn_m38_t_mag"	,{	0	,	-1	,	0	,	3	}}	,	//	5Rnd. M38 Tracer Clip. Caliber: 7.62x54mmR. Used in M38, VZ54, M1891 and M91/30 rifles
	{	"vn_k98k_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	5Rnd. K98K Clip. Caliber: 7.92x57mm. Used in K98K
	{	"vn_k98k_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	5Rnd. K98K Tracer Clip. Caliber: 7.92x57mm Used in K98K
//Mags														
	{	"vn_m14_10_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	10Rnd. M14 Magazine. Caliber: 7.62x51mm. Used in M14 and XM21 Rifles
	{	"vn_m14_10_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	10Rnd. M14 Tracer Magazine. Caliber: 7.62x51mm. Used in M14 and XM21 Rifles
	{	"vn_m14_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M14 Magazine. Caliber: 7.62x51mm. Used in M14 and XM21 Rifles
	{	"vn_m14_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M14 Tracer Magazine. Caliber: 7.62x51mm. Used in M14 and XM21 Rifles
	{	"vn_m16_20_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M16 Magazine. Caliber: 5.56x45mm. Used in M16 and XM177, 2 rounds removed to protect the spring
	{	"vn_m16_20_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M16 Tracer Magazine. Caliber: 5.56x45mm. Used in M16 and XM177, 2 rounds removed to protect the spring
	{	"vn_m16_30_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. M16 Magazine. Caliber: 5.56x45mm. Used in M16 and XM177, 2 rounds removed to protect the spring
	{	"vn_m16_30_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. M16 Tracer Magazine. Caliber: 5.56x45mm. Used in M16 and XM177, 2 rounds removed to protect the spring
	{	"vn_m16_40_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Dual 20Rnd. M16 Magazines. Caliber: 5.56x45mm. Used in M16 and XM177, 2 rounds removed to protect the spring
	{	"vn_m16_40_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Dual 20Rnd. M16 Tracer Magazines. Caliber: 5.56x45mm. Used in M16 and XM177, 2 rounds removed
	{	"vn_m4956_10_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	10Rnd. M49/56 Carbine Magazine. Caliber: 7.5x54mm. Used in M49/56
	{	"vn_m4956_10_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	10Rnd. M49/56 Carbine Magazine. Caliber: 7.5x54mm. Used in M49/56. (Tracer)
	{	"vn_hp_sd_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	13Rnd. HP magazine. Caliber: 9mm Used in M1 Carbine (Shorty)
	{	"vn_carbine_15_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	15Rnd. M1/M2 Carbine. Caliber: 7.62x33mm. Used in M1 and M2 Carbines
	{	"vn_carbine_30_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	30Rnd. M1/M2 Carbine Magazine. Caliber: 7.62x33mm. Used in M1 and M2 Carbines
	{	"vn_carbine_15_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	15Rnd. M1/M2 Carbine Tracer Magazine. Caliber: 7.62x33mm. Used in M1 and M2 Carbines
	{	"vn_carbine_30_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	30Rnd. M1/M2 Carbine Tracer Magazine. Caliber: 7.62x33mm. Used in M1 and M2 Carbines
	{	"vn_l1a1_10_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	10Rnd. L1A1/L2A1/L4 Mag. Calibre: 5.56x45mm. Used in L1A1/L2A1/L4
	{	"vn_l1a1_10_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	10Rnd. L1A1/L2A1/L4 Mag. Calibre: 5.56x45mm. Used in L1A1/L2A1/L4 (Tracer)
	{	"vn_l1a1_20_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. L1A1/L2A1/L4 Mag. Calibre: 7.62x51mm. Used in L1A1/L2A1/L4
	{	"vn_l1a1_20_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. L1A1/L2A1/L4 Mag (Tracer). Calibre: 7.62x51mm. Used in L1A1/L2A1/L4
	{	"vn_l1a1_30_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. L2A1/L1A1/L4 Mag. Calibre: 7.62x51mm. Used in L2A1/L1A1/L4
	{	"vn_l1a1_30_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. L2A1/L1A1/L4 Tracer Mag. Calibre: 7.62x51mm. Used in L2A1/L1A1/L4
	{	"vn_l1a1_30_02_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. L2A1/L1A1/L4 Mag Straight. Calibre: 7.62x51mm. Used in L2A1/L1A1/L4
	{	"vn_l1a1_30_02_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. L2A1/L1A1/L4 Straight Tracer Mag. Calibre: 7.62x51mm. Used in L2A1/L1A1/L4
	{	"vn_m1a1_20_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M1A1 magazine. Caliber: 11.43x23mm. Used in M1A1 and M1928 Tommy gun
	{	"vn_m1a1_20_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M1A1 magazine. Caliber: 11.43x23mm. Used in M1A1 and M1928 Tommy gun (Tracer)
	{	"vn_m1a1_30_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. M1A1 magazine. Caliber: 11.43x23mm. Used in M1A1 and M1928 Tommy gun
	{	"vn_m1a1_30_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. M1A1 magazine. Caliber: 11.43x23mm. Used in M1A1 and M1928 Tommy gun (Tracer)
//OpFor														
	{	"vn_type56_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	30Rnd. Type 56/AK Magazine. Caliber: 7.62x39mm. Used in Type 56/AK, AK and KBKG assault rifle
	{	"vn_type56_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	30Rnd. Type 56/AK Tracer Magazine. Caliber: 7.62x39mm. Used in Type 56/AK, AK and KBKG assault rifle
	{	"vn_svd_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	10Rnd. SVD Mag. Caliber: 7.62x54mm. Used in SVD sniper rifle
	{	"vn_svd_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	10Rnd. SVD Tracer Magazine. Caliber: 7.62x54mm Used in SVD sniper rifle
	{	"vn_kbkg_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	10Rnd. KBKG Mag. Caliber: 7.62x39mm. Used in KBKG, Type 56 and AK rifles
	{	"vn_kbkg_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	10Rnd. KBKG Tracer Magazine. Caliber: 7.62x39mm Used in KBKG, Type 56 and AK rifles
//MG Belts/Mags														
	{	"vn_m1918_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M1918 Magazine. Calibre: 7.62x63mm. Used in M1918 automatic rifle
	{	"vn_m1918_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	20Rnd. M1918 Tracer Magazine. Calibre: 7.62x63mm. Used in M1918 automatic rifle
	{	"vn_m60_100_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	100Rnd. M60 Belt. Caliber: 7.62x51mm. Used in M60/ Shorty Machine Guns
	{	"vn_m63a_30_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. STANAG Magazine. Caliber: 5.56x45mm. Used in M63A assault rifle
	{	"vn_m63a_30_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. STANAG Tracer Magazine. Caliber: 5.56x45mm. Used in M63A assault rifle
	{	"vn_m63a_150_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	150Rnd. M63A Drum. Caliber: 5.56x45mm. Used in M63A Commando
	{	"vn_m63a_150_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	150Rnd. M63A Drum. Caliber: 5.56x45mm. Used in M63A Commando (Tracer)
	{	"vn_m63a_100_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	100Rnd. M63A Box. Caliber: 5.56x45mm. Used in M63A LMG
	{	"vn_m63a_100_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	100Rnd. M63A Box. Caliber: 5.56x45mm. Used in M63A LMG (Tracer)
//OpFor														
	{	"vn_rpd_100_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	100Rnd. RPD Belt. Caliber: 7.62x39mm. Used in RPD Light machine gun
	{	"vn_rpd_125_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	125Rnd. RPD Belt. Caliber: 7.62x39mm. 1:1 tracer, used by US Special Forces in captured RPD machine guns
	{	"vn_pk_100_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	100Rnd. PK Belt. Caliber: 7.62x54mmR. Used in PK machine gun
	{	"vn_dp28_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	47Rnd. DP-27 Mag. Caliber: 7.62x54mmR. Used in DP-27 machine gun
	{	"vn_mg42_50_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	50Rnd. MG42 Drum. Calibre: 7.92x57mm. Used in MG42 machine gun
	{	"vn_mg42_50_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	50Rnd. MG42 Tracer Drum. Calibre: 7.92x57mm. Used in MG42 machine gun
//Pistol Mags														
	{	"vn_hd_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	10Rnd. HD magazine. Caliber .22 LR. Used in HD pistol
	{	"vn_hp_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	13Rnd. HP magazine. Caliber: 9mm Used in HP pistol
	{	"vn_m1911_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	7Rnd. M1911 magazine. Caliber: .45in. Used in M1911 pistol
	{	"vn_m712_mag"	,{	0	,	0	,	0	,	4	}}	,	//	20Rnd. M712 Magazine. Caliber: 7.62x25mm. Used in M712 pistol
	{	"vn_mk22_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	14Rnd. Mk22 Magazine. Caliber: 9x19mm. Used in Mk22 Mod 0 pistol
	{	"vn_pm_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	8Rnd. PM magazine. Caliber: 9x18mm. Used in PM pistol
	{	"vn_tt33_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	8Rnd. TT-33 Magazine. Caliber: 7.62x25mm. Used in TT-33 pistol
	{	"vn_welrod_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	8Rnd. Welrod magazine. Caliber 7.65x17mm. Used in Welrod pistol
	{	"vn_vz61_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	20Rnd. VZ.61 SMG magazine. Caliber: 7.65x17mm. Used in VZ.61 Skorpion SMG
	{	"vn_vz61_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	20Rnd. VZ.61 SMG magazine. Caliber: 7.65x17mm. Used in VZ.61 Skorpion SMG (Tracer)
	{	"vn_ppk_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	7Rnd. PPK Mag. Caliber: 9x17mm. Used in PPK pistol
	{	"vn_p38_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	8Rnd. P38 Mag. Caliber: 9x19mm. Used in P38 pistol
//OpFor														
	{	"vn_type64_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	9Rnd. Type 64 Mag. Caliber: 7.65x17mm. Used in Type 64 pistol
//SMG Mags														
	{	"vn_m3a1_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. M3A1 Magazine. Caliber: 11.43x23mm .45 cal. Used in M3A1 Submachinegun
	{	"vn_m3a1_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	30Rnd. M3A1 Tracer Magazine. Caliber: 11.43x23mm .45 cal. Used in M3A1 Submachinegun
	{	"vn_m45_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	36Rnd. M/45 Magazine. Caliber: 9x19mm. Used in M/45 Submachinegun
	{	"vn_m45_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	36Rnd. M/45 Tracer Magazine. Caliber: 9x19mm. Used in M/45 Submachinegun
	{	"vn_mat49_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	32Rnd. MAT-49 Magazine. Caliber: 9x19mm Used in MAT-49 Submachinegun
	{	"vn_mat49_t_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	32Rnd. MAT-49 Tracer Magazine. Caliber: 9x19mm Used in MAT-49 Submachinegun
	{	"vn_mc10_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	32Rnd. MC-10 SMG Magazine. Caliber: 9x19mm. Used in MC-10 SMG
	{	"vn_mc10_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	32Rnd. MC-10 SMG Magazine. Caliber: 9x19mm. Used in MC-10 SMG. (Tracer)
	{	"vn_sten_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	32Rnd. Sten Mk.II Magazine. Caliber: 9x19mm Used in Sten Mk.II Submachinegun
	{	"vn_sten_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	32Rnd. Sten Mk.II Tracer Magazine. Caliber: 9x19mm Used in Sten Mk.II Submachinegun
	{	"vn_f1_smg_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	34Rnd. F1/L2A3/L34A1 Mag. Calibre: 9x19mm. Used in F1, L2A3, L34A1 SMG
	{	"vn_f1_smg_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	34Rnd. F1/L2A3/L34A1 Tracer Mag. Calibre: 9x19mm. Used in F1, L2A3, L34A1 SMG
	{	"vn_m1928_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	50Rnd. M1928 magazine. Caliber: 11.43x23mm. Used in M1928 Tommy gun
	{	"vn_m1928_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	50Rnd. M1928 magazine. Caliber: 11.43x23mm. Used in M1928 Tommy gun (Tracer)
	{	"vn_mpu_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	32Rnd. MPU SMG magazine. Caliber: 9x19mm. Used in MPU SMG
	{	"vn_mpu_t_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	32Rnd. MPU SMG Magazine. Caliber: 9x19mm. Used in MPU SMG (Tracer)
//OpFor														
	{	"vn_mat49_vc_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	32Rnd. MAT-49 Magazine (VC). Caliber: 7.62x25mm Used in VC converted MAT-49 Submachinegun
	{	"vn_mat49_vc_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	32Rnd. MAT-49 Tracer Magazine (VC). Caliber: 7.62x25mm Used in VC converted MAT-49 Submachinegun
	{	"vn_type64_smg_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	30Rnd. Type 64 SMG Magazine. Caliber: 7.65x25mm Used in Type 64 SMG
	{	"vn_type64_smg_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	30Rnd. Type 64 SMG Tracer Magazine. Caliber: 7.65x25mm Used in Type 64 SMG
	{	"vn_mp40_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	32Rnd. MP40 Mag
	{	"vn_mp40_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	32Rnd. MP40 Mag (Tracer)
	{	"vn_pps_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	35Rnd. PPS Magazine. Caliber: 7.62x25mm. Used in PPS-43 and PPS-52 SMGs
	{	"vn_pps_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	35Rnd. PPS Tracer Magazine. Caliber: 7.62x25mm. Used in PPS-43 and PPS-52 SMGs
	{	"vn_ppsh41_35_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	35Rnd. PPSh-41 Magazine. Caliber: 7.62x25mm Used in PPSh-41 and K-50M Submachineguns
	{	"vn_ppsh41_35_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	35Rnd. PPSh-41 Tracer Magazine. Caliber: 7.62x25mm Used in PPSh-41 and K-50M Submachineguns
	{	"vn_ppsh41_71_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	71Rnd. PPSh-41 Magazine. Caliber: 7.62x25mm Used in PPSh-41 and K-50M Submachineguns
	{	"vn_ppsh41_71_t_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	71Rnd. PPSh-41 Tracer Magazine. Caliber: 7.62x25mm Used in PPSh-41 and K-50M Submachineguns
//Revolver Ammo														
	{	"vn_m10_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	6Rnd. .38 revolver. Caliber: .38 revolver. Used in M10 and .38 revolvers
	{	"vn_m1895_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	7Rnd. M1895 reload. Caliber 7.62x38mm. Used in Model 1895 revolver
	{	"vn_mk1_udg_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	6Rnd. Mk1 UDG magazine. Caliber: 4.25in Mk59 dart. Used in Mk1 Underwater Defence Gun
//Shotgun Ammo														
	{	"vn_m1897_buck_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	6Rnd. M1897 Reload. Caliber: 12 gauge buckshot. Used in Model 1897 shotgun
	{	"vn_m1897_fl_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	6Rnd. M1897 Reload. Caliber: 12 gauge flechette. Used in Model 1897 shotgun
//OpFor														
	{	"vn_izh54_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	2Rnd. ISh-54 Reload. Caliber: 12 gauge buckshot. Used in ISh-54 shotgun
	{	"vn_izh54_so_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	2Rnd. ISh-54 Sawn-off. Caliber: 12 gauge buckshot. Used in ISh-54 shotgun
//Grenades														
	{	"vn_v40_grenade_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade V40 (Frag)
	{	"vn_m61_grenade_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade M61 (Frag)
	{	"vn_m67_grenade_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade M67 (Frag)
	{	"vn_m14_grenade_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade M14 (Incendiary)
	{	"vn_m14_early_grenade_mag"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Grenade M14-A (Incendiary)
	{	"vn_m34_grenade_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade M34 (WP)
	{	"vn_m7_grenade_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade M7A3 (CS Gas)
	{	"vn_m18_green_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade Smoke (Green)
	{	"vn_m18_purple_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade Smoke (Purple)
	{	"vn_m18_red_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade Smoke (Red)
	{	"vn_m18_white_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade Smoke (White)
	{	"vn_m18_yellow_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Grenade Smoke (Yellow)
	{	"Chemlight_blue"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"Chemlight_green"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"Chemlight_yellow"	,{	-1	,	0	,	0	,	-1	}}	,	//	
//OpFor														
	{	"vn_t67_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade Type67 (Frag)
	{	"vn_chicom_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade Chicom (Frag)
	{	"vn_rg42_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade RG-42 (Frag)
	{	"vn_rgd33_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade RGD-33 (Frag)
	{	"vn_rgd5_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade RGD-5 (Frag)
	{	"vn_rkg3_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade RKG-3 (HEAT)
	{	"vn_molotov_grenade_mag"	,{	0	,	-1	,	0	,	0	}}	,	//	Grenade (Molotov Cocktail)
	{	"vn_rdg2_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade RDG-2 Smoke (White)
	{	"vn_f1_grenade_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Grenade F-1 (Frag)
	{	"Chemlight_red"	,{	0	,	-1	,	0	,	-1	}}	,	//	
//Rockets/Missiles														
	{	"vn_m72_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M72 66mm HEAT Rocket. Used in M72 single-shot, disposable rocket launcher
	{	"vn_m20a1b1_heat_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M28A2 HEAT Rocket. Used in M20A1B1 Super Bazooka
	{	"vn_m20a1b1_wp_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M30 WP Rocket. Used in M20A1B1 Super Bazooka
//OpFor														
	{	"vn_rpg2_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	PG-2 82mm HEAT Rocket. Used in B40 hand-held, anti-tank grenade-launcher
	{	"vn_rpg7_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	PG-7V 85mm HEAT Rocket. Used in B41 hand-held, anti-tank grenade-launcher
	{	"vn_sa7_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Strela-2 72mm Anti-Aircraft Missile. Used in 9K32 hand-held, anti-aircraft missile system
	{	"vn_sa7b_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Strela-2M 72mm Anti-Aircraft Missile. Used in 9K32 hand-held, anti-aircraft missile system
	{	"vn_rpg2_fuze_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	PG-2 82mm Fuze Rocket. Used in B40 hand-held, anti-tank grenade-launcher
//Explosives														
	{	"vn_mine_m112_remote_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M112 Breaching charge
	{	"vn_mine_m14_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M14 Toe-popper
	{	"vn_mine_m15_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M15 Anti-Tank
	{	"vn_mine_m16_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M16 Bounding
	{	"vn_mine_m18_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18 Claymore (Remote)
	{	"vn_mine_m18_range_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18 Claymore (Proximity)
	{	"vn_mine_m18_x3_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18 Claymore x3 (Remote)
	{	"vn_mine_m18_x3_range_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18 Claymore x3 (Proximity)
	{	"vn_mine_satchel_remote_02_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	Satchel charge
	{	"vn_mine_tripwire_m16_02_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M16 2m tripwire
	{	"vn_mine_tripwire_m16_04_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M16 4m tripwire
	{	"vn_mine_tripwire_m49_02_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M49A1 2m tripwire (Flare)
	{	"vn_mine_tripwire_m49_04_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M49A1 4m tripwire (Flare)
	{	"vn_mine_bangalore_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine Bangalore (Remote)
	{	"vn_mine_limpet_01_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine Limpet US (Remote)
	{	"vn_mine_m18_fuze10_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18 Claymore (10s Fuze)
	{	"vn_mine_m18_wp_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18/WP Claymore (Remote)
	{	"vn_mine_m18_wp_range_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18/WP Claymore (Proximity)
	{	"vn_mine_m18_wp_fuze10_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mine M18/WP Claymore (10s Fuze)
//OpFor														
	{	"vn_mine_ammobox_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Ammobox (booby-trapped)
	{	"vn_mine_punji_01_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap punji (Large)
	{	"vn_mine_punji_02_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap punji (Small)
	{	"vn_mine_punji_03_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap punji (Whip)
	{	"vn_mine_tm57_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine TM-57 Anti-Tank
	{	"vn_mine_tripwire_arty_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap IED 4m tripwire
	{	"vn_mine_tripwire_f1_02_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	Trap F-1 2m tripwire
	{	"vn_mine_tripwire_f1_04_mag"	,{	0	,	0	,	0	,	-1	}}	,	//	Trap F-1 4m tripwire
	{	"vn_mine_bike_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Bicycle (Remote)
	{	"vn_mine_bike_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Bicycle (Proximity)
	{	"vn_mine_cartridge_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Cartridge (Proximity)
	{	"vn_mine_dh10_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine DH10 (Remote)
	{	"vn_mine_dh10_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine DH10 (Proximity)
	{	"vn_mine_jerrycan_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Jerry Can (Remote)
	{	"vn_mine_jerrycan_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Jerry Can (Proximity)
	{	"vn_mine_lighter_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Lighter (Proximity)
	{	"vn_mine_mortar_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Mortar (Proximity)
	{	"vn_mine_chicom_no8_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine No 8 (Proximity)
	{	"vn_mine_pot_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Pot (Remote)
	{	"vn_mine_pot_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Pot (Proximity)
	{	"vn_mine_gboard_range_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap RGD5 4m (AP)
	{	"vn_mine_punji_04_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap punji (Doorway)
	{	"vn_mine_punji_05_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Trap punji (Side Whip Tripwire)
	{	"vn_satchelcharge_02_throw_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Satchel charge (Thrown)
	{	"vn_mine_limpet_02_mag"	,{	0	,	-1	,	0	,	-1	}}	,	//	Mine Limpet Russian (Remote)
//Other														
	{	"vn_m127_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M127 Flare Launcher
	{	"vn_m128_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M128 Flare Launcher (Green)
	{	"vn_m129_mag"	,{	-1	,	0	,	0	,	-1	}}	,	//	M129 Flare Launcher (Red)
	{	"vn_prop_fort_mag"	,{	0	,	0	,	0	,	0	}}	,	//	Sandbag
	{	"MineDetector"	,{	0	,	0	,	0	,	-1	}}	,	//	Mine Detector ARMA 3 Modern
	{	"vn_b_item_trapkit"	,{	0	,	0	,	0	,	-1	}}	,	//	Trapkit
	{	"vn_b_item_lighter_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Lighter
	{	"vn_b_item_cigs_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Cigs
//Vehicle Ammo														
	{	"vn_v_m18r_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_v_m61_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_v_m7_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_v_rdg2_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_v_rgd5_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_type56_v_12_he_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_type56_v_12_heat_mag"	,{	-1	,	-1	,	0	,	-1	}}	,	//	
//Food and Drink														
	{	"vn_prop_drink_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_07_01"	,{	0	,	-1	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_07_02"	,{	0	,	-1	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_07_03"	,{	0	,	-1	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_08_01"	,{	0	,	-1	,	0	,	0	}}	,	//	
	{	"vn_prop_drink_09_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_01_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_01_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_01_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_07"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_box_02_08"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_07"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_08"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_09"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_10"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_11"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_12"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_13"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_14"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_15"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_01_16"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_07"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_02_08"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_03_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_03_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_03_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_can_03_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_07"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_08"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_09"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_fresh_10"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_07"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_lrrp_01_08"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_07"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_08"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_09"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_10"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_11"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_12"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_13"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_14"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_15"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_16"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_17"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_01_18"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_02_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_02_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_02_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_02_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_02_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_meal_02_06"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_pir_01_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_pir_01_02"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_pir_01_03"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_pir_01_04"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_pir_01_05"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_sack_01"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_food_sack_02"	,{	0	,	0	,	0	,	0	}}	,	//	
//Medication														
	{	"vn_prop_med_antibiotics"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_med_antimalaria"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_med_antivenom"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"vn_prop_med_dysentery"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_med_painkillers"	,{	0	,	0	,	0	,	0	}}	,	//	
	{	"vn_prop_med_wormpowder"	,{	0	,	0	,	0	,	0	}}	,	//	
};														
items[] =														
{ 														
//Blufor														
//Bayonet/Camo														
	{	"vn_b_camo_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Camo wrap [M14]
	{	"vn_b_camo_m14a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Camo wrap [M14A1]
	{	"vn_b_camo_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Camo wrap [M40]
	{	"vn_b_carbine"	,{	0	,	0	,	0	,	-1	}}	,	//	Bayonet M4 [M1/ M2]
	{	"vn_b_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bayonet M6 [M14]
	{	"vn_b_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bayonet M7 [M16]
	{	"vn_b_m1897"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bayonet M1917 [M1897]
	{	"vn_b_m1_garand"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bayonet M5 [M1 Garand]
	{	"vn_b_camo_m1_garand"	,{	-1	,	0	,	2	,	-1	}}	,	//	Camo wrap [M1 Garand]
	{	"vn_bipod_m1918"	,{	-1	,	0	,	4	,	-1	}}	,	//	Bipod [M1918]
	{	"vn_bipod_m16"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bipod [M16]
	{	"vn_bipod_m14"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bipod [M14]
	{	"vn_b_l1a1"	,{	-1	,	0	,	1	,	-1	}}	,	//	Bayonet L1A1 [L1A1/ F1]
	{	"vn_b_m1903"	,{	0	,	0	,	1	,	1	}}	,	//	Bayonet [M1903]
	{	"vn_b_m36"	,{	0	,	0	,	1	,	1	}}	,	//	Bayonet Spike [M36]
	{	"vn_b_camo_m1903"	,{	0	,	0	,	2	,	2	}}	,	//	Camo wrap [M1903]
	{	"vn_b_camo_m36"	,{	0	,	0	,	2	,	2	}}	,	//	Camo wrap [M36]
	{	"vn_bipod_m63a"	,{	-1	,	0	,	3	,	-1	}}	,	//	Bipod [M63A]
 	{	"vn_b_m4956"	,{	0	,	0	,	0	,	-1	}}	,	//	Bayonet Model 58 [M49/56]
//Suppressor														
	{	"vn_s_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M14/M40]
	{	"vn_s_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M16]
	{	"vn_s_m1895"	,{	0	,	0	,	0	,	-1	}}	,	//	Suppressor [M1895]
	{	"vn_s_m1911"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M1911]
	{	"vn_s_m3a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M3]
	{	"vn_s_m45"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M/45]
	{	"vn_s_m45_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [M/45 Camo]
	{	"vn_s_mat49"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [MAT-49]
	{	"vn_s_mc10"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [MC-10]
	{	"vn_s_mk22"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [Mk22]
	{	"vn_s_pm"	,{	0	,	0	,	0	,	-1	}}	,	//	Suppressor [PM]
	{	"vn_s_sten"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [Sten Mk.II]
	{	"vn_s_ppk"	,{	0	,	0	,	2	,	2	}}	,	//	Suppressor 9mm [PPK/ P38]
	{	"vn_s_hp"	,{	-1	,	0	,	3	,	-1	}}	,	//	Suppressor 9mm [HP]
	{	"vn_s_mpu"	,{	-1	,	0	,	0	,	-1	}}	,	//	Suppressor [MPU]
//Optics														
	{	"vn_o_4x_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M16 4x)
	{	"vn_o_9x_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M14 3-9x)
	{	"vn_o_9x_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M16 3-9x)
	{	"vn_o_9x_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M40 3-9x)
	{	"vn_o_9x_m40a1_camo"	,{	-1	,	0	,	0	,	-1	}}	,	//	Optic (M40 3-9x camo)
	{	"vn_o_anpvs2_m14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scope (AN-PVS2 Starlight) [M14]
	{	"vn_o_anpvs2_m16"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scope (AN-PVS2 Starlight) [XM177/M16]
	{	"vn_o_anpvs2_m40a1"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scope (AN-PVS2 Starlight) [M40]
	{	"vn_o_3x_m84"	,{	0	,	0	,	0	,	-1	}}	,	//	Scope (M1/2 Carbine 2.2x)
	{	"vn_o_1x_sp_m16"	,{	-1	,	0	,	6	,	-1	}}	,	//	Optic (M16 SP)
	{	"vn_o_3x_l1a1"	,{	-1	,	0	,	2	,	-1	}}	,	//	Optic (L1A1 3x)
	{	"vn_o_8x_m1903"	,{	0	,	0	,	1	,	1	}}	,	//	Optic [M1903 8x]
	{	"vn_o_m14_front"	,{	-1	,	0	,	4	,	-1	}}	,	//	Optic (M14 Front Sight)
	{	"vn_o_4x_m4956"	,{	0	,	0	,	0	,	-1	}}	,	//	Scope (M49/56 3.5x)
//OpFor														
//Bayonet/Camo														
	{	"vn_b_sks"	,{	0	,	-1	,	0	,	-1	}}	,	//	Bayonet Spike [M38]
	{	"vn_b_type56"	,{	0	,	-1	,	0	,	-1	}}	,	//	Bayonet Spike [Type56]
 	{	"vn_b_camo_vz54"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Camo wrap [VZ54]
	{	"vn_b_camo_svd"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Camo wrap [SVD]
	{	"vn_b_camo_k98k"	,{	0	,	-1	,	2	,	2	}}	,	//	Camo wrap [K98K]
	{	"vn_b_k98k"	,{	0	,	-1	,	1	,	1	}}	,	//	Bayonet [K98K]
	{	"vn_b_m38"	,{	0	,	-1	,	0	,	-1	}}	,	//	Bayonet Spike [M38/ M91/30/ M1892]
	{	"vn_b_camo_m9130"	,{	0	,	-1	,	0	,	-1	}}	,	//	Camo wrap [M9130]
//Optic														
	{	"vn_o_3x_m9130"	,{	0	,	-1	,	0	,	-1	}}	,	//	Optic (M91/30 3.5x)
	{	"vn_o_3x_sks"	,{	0	,	-1	,	0	,	-1	}}	,	//	Optic (SKS 3.5x)
	{	"vn_o_3x_vz54"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Optic (VZ54 2.5x)
	{	"vn_o_4x_svd"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Optic [SVD 4x]
	{	"vn_o_1_5x_k98k"	,{	0	,	-1	,	1	,	1	}}	,	//	Optic [K98K 1.5x]
//Basics														
	{	"vn_b_item_lighter_01"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"FirstAidKit"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"ItemCompass"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"ItemMap"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"ItemRadio"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"ItemWatch"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"Medikit"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"Toolkit"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	
	{	"vn_o_item_firstaidkit"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_o_item_map"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_o_item_radio_m252"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_compass"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_compass_sog"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_firstaidkit"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_map"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_medikit_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_radio_urc10"	,{	-1	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_toolkit"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_watch"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"vn_b_item_wiretap"	,{	0	,	0	,	0	,	-1	}}	,	//	
	{	"MineDetector"	,{	0	,	0	,	0	,	-1	}}	,	//	ARMA3 Modern
//	{	"ACRE_PRC343"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	ACRE leftover?
//	{	"ACRE_PRC77"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	ACRE leftover?
//	{	"ItemRadioAcreFlagged"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	ACRE leftover?
	{	"vn_b_prop_camera_01"	,{	-1	,	-1	,	-1	,	0	}}	,	//	
//OpFor														
	{	"vn_o_item_firstaidkit"	,{	0	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_o_item_map"	,{	0	,	-1	,	0	,	-1	}}	,	//	
	{	"vn_o_item_radio_m252"	,{	0	,	-1	,	0	,	-1	}}	,	//	
//Facewear														
	{	"G_Aviator"	,{	0	,	0	,	0	,	-1	}}	,	//	ARMA3 Modern
	{	"G_Bandanna_aviator"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMA3 Modern
	{	"G_Bandanna_blk"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMA3 Modern
	{	"G_Bandanna_oli"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMA3 Modern
	{	"G_Spectacles_Tinted"	,{	0	,	0	,	0	,	-1	}}	,	//	ARMA3 Modern
	{	"vn_b_acc_goggles_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	M44 Goggles
	{	"vn_b_acc_m17_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	M17 Respirator
	{	"vn_b_acc_m17_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	M17 Respirator (Hood)
	{	"vn_b_acc_ms22001_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mask MS-22001
	{	"vn_b_acc_ms22001_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Mask MS-22001 (Loose)
	{	"vn_b_aviator"	,{	0	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_b_acc_rag_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scrim Scarf 01
	{	"vn_b_acc_rag_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scrim Scarf 02
	{	"vn_b_acc_towel_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Towel 01
	{	"vn_b_acc_towel_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Towel 02
	{	"vn_b_bandana_a"	,{	-1	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_b_scarf_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Scarf (Olive US)
	{	"vn_b_scarf_01_03"	,{	0	,	0	,	0	,	-1	}}	,	//	Scarf (Black US)
	{	"vn_b_spectacles"	,{	0	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_b_spectacles_tinted"	,{	0	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_b_squares"	,{	0	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_b_squares_tinted"	,{	0	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_g_glasses_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Sunglasses
	{	"vn_g_spectacles_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Soectacles (Round)
	{	"vn_g_spectacles_02"	,{	0	,	0	,	0	,	-1	}}	,	//	Spectacles (GI)
	{	"vn_b_acc_seal_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	SEAL (Diver)
//OpFor														
	{	"vn_o_acc_goggles_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Crew Goggles
	{	"vn_o_acc_goggles_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	PO-1M Goggles
	{	"vn_o_acc_goggles_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	PO-1M Goggles (KM32 Mask)
	{	"vn_o_acc_km32_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	KM32 Mask
	{	"vn_o_scarf_01_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Scarf (Red)
	{	"vn_o_scarf_01_02"	,{	0	,	0	,	0	,	-1	}}	,	//	Scarf (Green)
	{	"vn_o_scarf_01_03"	,{	0	,	0	,	0	,	-1	}}	,	//	Scarf (Blue)
	{	"vn_o_scarf_01_04"	,{	0	,	0	,	0	,	-1	}}	,	//	Scarf (Black)
	{	"vn_o_bandana_b"	,{	-1	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_o_bandana_g"	,{	-1	,	0	,	0	,	-1	}}	,	//	Unknown
	{	"vn_o_poncho_01_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Poncho (Camo)
//Headgear														
	{	"vn_b_beret_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (Dark Green)
	{	"vn_b_beret_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (Black)
	{	"vn_b_beret_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (Maroon)
	{	"vn_b_beret_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (Khaki Green)
	{	"vn_b_beret_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ERDL brown)
	{	"vn_b_beret_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (Tiger)
	{	"vn_b_beret_01_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (RAC)
	{	"vn_b_beret_01_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ERDL) ADDED
	{	"vn_b_beret_01_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret 1 (MEDT)
	{	"vn_b_beret_01_10"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret 2 (MEDT)
	{	"vn_b_beret_01_11"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret 3 (MEDT)
	{	"vn_b_beret_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (US TF-116)
	{	"vn_b_beret_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (RAC Headset)
	{	"vn_i_beret_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ARVN Armor)
	{	"vn_i_beret_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ARVN Tan)
	{	"vn_i_beret_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ARVN Black)
	{	"vn_i_beret_03_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ARVN Airborne)
	{	"vn_i_beret_03_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Beret (ARVN Ranger)
	{	"vn_b_bandana_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Bandana (Green)
	{	"vn_b_bandana_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bandana (Tiger)
	{	"vn_b_bandana_03"	,{	0	,	0	,	0	,	-1	}}	,	//	Bandana (Black)
	{	"vn_b_bandana_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bandana (Spray)
	{	"vn_b_bandana_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bandana (Tiger green)
	{	"vn_b_bandana_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bandana (ERDL brown)
	{	"vn_b_bandana_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bandana (Leopard)
	{	"vn_b_bandana_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Bandana (ERDL) ADDED
	{	"vn_b_boonie_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Green)
	{	"vn_b_boonie_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Tiger)
	{	"vn_b_boonie_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Black)
	{	"vn_b_boonie_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Spray)
	{	"vn_b_boonie_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Tiger green)
	{	"vn_b_boonie_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (ERDL brown)
	{	"vn_b_boonie_01_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Leopard)
	{	"vn_b_boonie_01_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (ERDL)
	{	"vn_b_boonie_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Green)
	{	"vn_b_boonie_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Tiger)
	{	"vn_b_boonie_02_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Black)
	{	"vn_b_boonie_02_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Spray)
	{	"vn_b_boonie_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Tiger green)
	{	"vn_b_boonie_02_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ERDL brown)
	{	"vn_b_boonie_02_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Leopard)
	{	"vn_b_boonie_02_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ERDL)
	{	"vn_b_boonie_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Green)
	{	"vn_b_boonie_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Tiger)
	{	"vn_b_boonie_03_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Black)
	{	"vn_b_boonie_03_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Spray)
	{	"vn_b_boonie_03_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Tiger green)
	{	"vn_b_boonie_03_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (ERDL brown)
	{	"vn_b_boonie_03_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Leopard)
	{	"vn_b_boonie_03_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (ERDL)
	{	"vn_b_boonie_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Green)
	{	"vn_b_boonie_04_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Tiger)
	{	"vn_b_boonie_04_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Black)
	{	"vn_b_boonie_04_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Spray)
	{	"vn_b_boonie_04_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Tiger green)
	{	"vn_b_boonie_04_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (ERDL brown)
	{	"vn_b_boonie_04_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Leopard)
	{	"vn_b_boonie_04_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (ERDL)
	{	"vn_b_boonie_05_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Green)
	{	"vn_b_boonie_05_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Tiger)
	{	"vn_b_boonie_05_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Black)
	{	"vn_b_boonie_05_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Spray)
	{	"vn_b_boonie_05_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Tiger green)
	{	"vn_b_boonie_05_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (ERDL brown)
	{	"vn_b_boonie_05_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Leopard)
	{	"vn_b_boonie_05_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (ERDL)
	{	"vn_b_boonie_06_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ANZAC)
	{	"vn_b_boonie_07_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ANZAC Oval)
	{	"vn_b_boonie_08_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ANZAC Folded)
	{	"vn_b_boonie_06_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ANZAC Stripe)
	{	"vn_b_boonie_07_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ANZAC Oval Stripe)
	{	"vn_b_boonie_08_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (ANZAC Folded Stripe)
	{	"vn_b_boonie_09_01"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Green) BLACKLIST
	{	"vn_b_boonie_09_02"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Tiger) BLACKLIST
	{	"vn_b_boonie_09_03"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Black) BLACKLIST
	{	"vn_b_boonie_09_04"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Spray) BLACKLIST
	{	"vn_b_boonie_09_05"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Tiger green) BLACKLIST
	{	"vn_b_boonie_09_06"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ ERDL brown) BLACKLIST
	{	"vn_b_boonie_09_07"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Duckhunter) BLACKLIST
	{	"vn_b_boonie_09_08"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ ERDL) BLACKLIST
	{	"vn_b_boonie_09_09"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Boonie (Rebel/ Grey)
	{	"vn_b_boonie_01_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/sides (Grey)
	{	"vn_b_boonie_02_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie (Grey)
	{	"vn_b_boonie_03_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/front (Grey)
	{	"vn_b_boonie_04_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/left (Grey)
	{	"vn_b_boonie_05_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Boonie F/right (Grey)
	{	"vn_b_headband_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Headband (Green)
	{	"vn_b_headband_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Headband (Tiger)
	{	"vn_b_headband_03"	,{	0	,	0	,	0	,	-1	}}	,	//	Headband (Black)
	{	"vn_b_headband_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Headband (Spray)
	{	"vn_b_headband_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Headband (ERDL brown)
	{	"vn_b_headband_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Headband (ERDL) ADDED
	{	"vn_c_headband_01"	,{	0	,	0	,	0	,	-1	}}	,	//	Headband (Red)
	{	"vn_c_headband_02"	,{	0	,	0	,	0	,	-1	}}	,	//	Headband (Green)
	{	"vn_c_headband_03"	,{	0	,	0	,	0	,	-1	}}	,	//	Headband (Blue)
	{	"vn_c_headband_04"	,{	0	,	0	,	0	,	-1	}}	,	//	Headband (Black/white)
//OpFor														
	{	"vn_o_boonie_nva_02_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Boonie Hat (NVA/ green)
	{	"vn_o_boonie_nva_02_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Boonie Hat (NVA/ black)
	{	"vn_o_boonie_vc_01_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Boonie Hat (Green)
	{	"vn_o_boonie_vc_01_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Boonie Hat (Black)
	{	"vn_o_boonie_vc_02_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Boonie Hat (VC/ green)
	{	"vn_o_boonie_vc_02_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Boonie Hat (VC/ black)
	{	"vn_o_cap_navy_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Cap (VPN Sailor)
	{	"vn_c_conehat_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Non La (Strap)
	{	"vn_c_conehat_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Non La
	{	"vn_o_pl_cap_02_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Cap (PL)
	{	"vn_o_pl_cap_01_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Cap (PL Tan)
	{	"vn_o_pl_cap_02_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Cap (PL Grey)
	{	"vn_o_cap_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Field cap (NVA)
	{	"vn_o_cap_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Field cap (VC)
//Helmet														
	{	"vn_i_helmet_m1_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Biet Dong Quan)
	{	"vn_i_helmet_m1_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Quan Canh)
	{	"vn_i_helmet_m1_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Net 1)
	{	"vn_i_helmet_m1_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Net 2)
	{	"vn_i_helmet_m1_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Tiger/ Net 1)
	{	"vn_i_helmet_m1_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Tiger/ Net 2)
	{	"vn_b_helmet_svh4_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (Air Cav)
	{	"vn_b_helmet_svh4_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (ARVN custom)
	{	"vn_b_helmet_svh4_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (USAF)
	{	"vn_b_helmet_svh4_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (Army)
	{	"vn_b_helmet_svh4_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (ARVN)
	{	"vn_b_helmet_svh4_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (Scream)
	{	"vn_b_helmet_svh4_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (Air Cav/ Visor)
	{	"vn_b_helmet_svh4_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (ARVN custom/ Visor)
	{	"vn_b_helmet_svh4_02_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (USAF/ Visor)
	{	"vn_b_helmet_svh4_02_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (Army/ Visor)
	{	"vn_b_helmet_svh4_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (ARVN/ Visor)
	{	"vn_b_helmet_svh4_02_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet SVH4 (Scream/ Visor)
	{	"vn_b_helmet_aph6_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (White)
	{	"vn_b_helmet_aph6_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USAF Wolfpack)
	{	"vn_b_helmet_aph6_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USN Sundowners)
	{	"vn_b_helmet_aph6_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USN VA196)
	{	"vn_b_helmet_aph6_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USMC VM121)
	{	"vn_b_helmet_aph6_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (White/ Visor)
	{	"vn_b_helmet_aph6_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USAF Wolfpack/ Visor)
	{	"vn_b_helmet_aph6_02_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USN Sundowners/ Visor)
	{	"vn_b_helmet_aph6_02_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USN VA196/ Visor)
	{	"vn_b_helmet_aph6_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet APH6 (USMC VM121/ Visor)
	{	"vn_b_helmet_t56_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet T56
	{	"vn_b_helmet_t56_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet T56 1
	{	"vn_b_helmet_t56_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet T56 2
	{	"vn_b_helmet_t56_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet T56 (Goggles)
	{	"vn_b_helmet_t56_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet T56 1 (Goggles)
	{	"vn_b_helmet_t56_02_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet T56 2 (Goggles)
	{	"vn_b_helmet_m1_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (Steel)
	{	"vn_b_helmet_m1_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (716 MP)
	{	"vn_b_helmet_m1_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 2 (Camo)
	{	"vn_b_helmet_m1_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 2 (Camo 2)
	{	"vn_b_helmet_m1_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 3 (Camo)
	{	"vn_b_helmet_m1_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 3 (Camo 2)
	{	"vn_b_helmet_m1_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 GL (Camo)
	{	"vn_b_helmet_m1_04_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 GL (Camo 2)
	{	"vn_b_helmet_m1_05_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 5 (Camo)
	{	"vn_b_helmet_m1_05_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 5 (Camo 2)
	{	"vn_b_helmet_m1_06_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 6 (Camo)
	{	"vn_b_helmet_m1_06_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 6 (Camo 2)
	{	"vn_b_helmet_m1_07_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 7 (Camo)
	{	"vn_b_helmet_m1_07_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 7 (Camo 2)
	{	"vn_b_helmet_m1_08_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 MG (Camo)
	{	"vn_b_helmet_m1_08_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 MG (Camo 2)
	{	"vn_b_helmet_m1_09_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 Crew (Camo)
	{	"vn_b_helmet_m1_09_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 Crew (Camo 2)
	{	"vn_b_helmet_m1_10_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 Net 1 (Camo)
	{	"vn_b_helmet_m1_11_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 Net 2 (Camo)
	{	"vn_b_helmet_m1_12_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (ROK/ Jungle)
	{	"vn_b_helmet_m1_12_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 (ROK/ Sand)
	{	"vn_b_helmet_m1_14_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 14 (Camo)
	{	"vn_b_helmet_m1_14_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 14 (Camo 2)
	{	"vn_b_helmet_m1_15_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 15 (Camo)
	{	"vn_b_helmet_m1_15_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 15 (Camo 2)
	{	"vn_b_helmet_m1_16_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 16 (Camo)
	{	"vn_b_helmet_m1_16_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 16 (Camo 2)
	{	"vn_b_helmet_m1_17_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 GL 17 (Camo)
	{	"vn_b_helmet_m1_17_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 GL 17 (Camo 2)
	{	"vn_b_helmet_m1_18_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 18 (Camo)
	{	"vn_b_helmet_m1_18_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 18 (Camo 2)
	{	"vn_b_helmet_m1_19_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 19 (Camo)
	{	"vn_b_helmet_m1_19_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 19 (Camo 2)
	{	"vn_b_helmet_m1_20_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 20 (Camo)
	{	"vn_b_helmet_m1_20_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Helmet M1 20 (Camo 2)
//OpFor														
	{	"vn_b_helmet_sog_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (SOG) Removed no Monties
	{	"vn_o_helmet_nva_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (NVA)
	{	"vn_o_helmet_nva_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (NVA/ strap)
	{	"vn_o_helmet_nva_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (NVA/ camo)
	{	"vn_o_helmet_nva_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (NVA/ assault)
	{	"vn_o_helmet_nva_05"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (NVA/ driver)
	{	"vn_o_helmet_nva_06"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VPN)
	{	"vn_o_helmet_nva_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (NVA/ net)
	{	"vn_o_helmet_nva_08"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VPN/ net)
	{	"vn_o_helmet_nva_09"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet SSh-40
	{	"vn_o_helmet_nva_10"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet M56
	{	"vn_o_helmet_vc_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VC)
	{	"vn_o_helmet_vc_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VC/ strap)
	{	"vn_o_helmet_vc_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VC/ camo)
	{	"vn_o_helmet_vc_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VC/ assault)
	{	"vn_o_helmet_vc_05"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Pith Helmet (VC/ net)
	{	"vn_o_helmet_shl61_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet SHL61 (Goggles)
	{	"vn_o_helmet_shl61_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet SHL61
	{	"vn_o_helmet_tsh3_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet TSH3 (Goggles)
	{	"vn_o_helmet_tsh3_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet TSH3
	{	"vn_o_helmet_zsh3_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet ZSH03
	{	"vn_o_helmet_zsh3_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	Helmet ZSH03 (Visor)
//Uniforms														
//US Air Uniforms														
	{	"vn_b_uniform_heli_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU US Army Aircrew
	{	"vn_b_uniform_k2b_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USAF Jet Crew
	{	"vn_b_uniform_k2b_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USMC Jet Crew
	{	"vn_b_uniform_k2b_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USMC Jet Crew (Tiger)
	{	"vn_b_uniform_k2b_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USMC Jet Crew (Khaki)
	{	"vn_b_uniform_k2b_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B US Army Heli Crew
	{	"vn_b_uniform_k2b_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USMC Heli Crew
	{	"vn_b_uniform_k2b_02_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USSF Heli Crew
	{	"vn_b_uniform_k2b_02_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USMC Heli Crew (Tiger)
	{	"vn_b_uniform_k2b_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B USMC Heli Crew (Khaki)
	{	"vn_b_uniform_k2b_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B RAAF Heli Crew
	{	"vn_b_uniform_k2b_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	K2B RAN Heli Crew
//US Infantry Uniforms														
	{	"vn_b_uniform_macv_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Olive/ field)
	{	"vn_b_uniform_macv_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Tiger)
	{	"vn_b_uniform_macv_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Black)
	{	"vn_b_uniform_macv_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Spray)
	{	"vn_b_uniform_macv_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Tiger green)
	{	"vn_b_uniform_macv_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (ERDL/brown)
	{	"vn_b_uniform_macv_01_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Olive)
	{	"vn_b_uniform_macv_01_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (Leopard)
	{	"vn_b_uniform_macv_01_15"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (ERDL)
	{	"vn_b_uniform_macv_01_16"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU RLA 1 (Lizard)
	{	"vn_b_uniform_macv_01_17"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ARVN 1 (BDQ)
	{	"vn_b_uniform_macv_01_18"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ROK 1 (Frog)
	{	"vn_b_uniform_macv_01_22"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 1 (ERDL/ MEDT) ADDED
	{	"vn_b_uniform_macv_01_23"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (ERDL/ MEDT) ADDED
	{	"vn_b_uniform_macv_01_24"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (ERDL/ MEDT) ADDED
	{	"vn_b_uniform_macv_01_25"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (ERDL/ MEDT) ADDED
	{	"vn_b_uniform_macv_01_26"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (ERDL/ MEDT) ADDED
	{	"vn_b_uniform_macv_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (Olive/ field)
	{	"vn_b_uniform_macv_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (Tiger)
	{	"vn_b_uniform_macv_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (Tiger green)
	{	"vn_b_uniform_macv_02_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (ERDL/brown)
	{	"vn_b_uniform_macv_02_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (Olive)
	{	"vn_b_uniform_macv_02_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (Leopard)
	{	"vn_b_uniform_macv_02_15"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 2 (ERDL) ADDED
	{	"vn_b_uniform_macv_02_16"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU RLA 2 (Lizard)
	{	"vn_b_uniform_macv_02_17"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ARVN 2 (BDQ)
	{	"vn_b_uniform_macv_02_18"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ROK 2 (Frog)
	{	"vn_b_uniform_macv_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (Olive/ field)
	{	"vn_b_uniform_macv_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (Tiger)
	{	"vn_b_uniform_macv_03_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (Tiger green)
	{	"vn_b_uniform_macv_03_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (ERDL/brown)
	{	"vn_b_uniform_macv_03_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (Olive)
	{	"vn_b_uniform_macv_03_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (Leopard)
	{	"vn_b_uniform_macv_03_15"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 3 (ERDL) ADDED
	{	"vn_b_uniform_macv_03_16"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU RLA 3 (Lizard)
	{	"vn_b_uniform_macv_03_17"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ARVN 3 (BDQ)
	{	"vn_b_uniform_macv_03_18"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ROK 3 (Frog)
	{	"vn_b_uniform_macv_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (Olive/ field)
	{	"vn_b_uniform_macv_04_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (Tiger)
	{	"vn_b_uniform_macv_04_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (Tiger green)
	{	"vn_b_uniform_macv_04_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (ERDL/brown)
	{	"vn_b_uniform_macv_04_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (Olive)
	{	"vn_b_uniform_macv_04_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (Leopard)
	{	"vn_b_uniform_macv_04_15"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (ERDL)
	{	"vn_b_uniform_macv_04_16"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU RLA 4 (Lizard)
	{	"vn_b_uniform_macv_04_17"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ARVN 4 (BDQ)
	{	"vn_b_uniform_macv_04_18"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ROK 4 (Frog)
	{	"vn_b_uniform_macv_04_20"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (Tiger/ base)
	{	"vn_b_uniform_macv_04_21"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 4 (ERDL/ base)
	{	"vn_b_uniform_macv_05_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (Olive/ field)
	{	"vn_b_uniform_macv_05_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (Tiger)
	{	"vn_b_uniform_macv_05_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (Tiger green)
	{	"vn_b_uniform_macv_05_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (ERDL/brown)
	{	"vn_b_uniform_macv_05_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (Olive)
	{	"vn_b_uniform_macv_05_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (Leopard)
	{	"vn_b_uniform_macv_05_15"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 5 (ERDL)
	{	"vn_b_uniform_macv_05_16"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU RLA 5 (Lizard)
	{	"vn_b_uniform_macv_05_17"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ARVN 5 (BDQ)
	{	"vn_b_uniform_macv_05_18"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ROK 5 (Frog)
	{	"vn_b_uniform_macv_06_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (Olive/ field)
	{	"vn_b_uniform_macv_06_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (Tiger)
	{	"vn_b_uniform_macv_06_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (Tiger green)
	{	"vn_b_uniform_macv_06_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (ERDL/brown)
	{	"vn_b_uniform_macv_06_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (Olive)
	{	"vn_b_uniform_macv_06_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (Leopard)
	{	"vn_b_uniform_macv_06_15"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU MACV 6 (ERDL) ADDED
	{	"vn_b_uniform_macv_06_16"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU RLA 6 (Lizard)
	{	"vn_b_uniform_macv_06_17"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ARVN 6 (BDQ)
	{	"vn_b_uniform_macv_06_18"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU ROK 6 (Frog)
	{	"vn_b_uniform_sog_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 1 (Olive)
	{	"vn_b_uniform_sog_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 1 (Tiger)
	{	"vn_b_uniform_sog_01_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 1 (Black)
	{	"vn_b_uniform_sog_01_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 1 (Spray)
	{	"vn_b_uniform_sog_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 1 (Tiger/ black)
	{	"vn_b_uniform_sog_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 1 (Spray/ black)
	{	"vn_b_uniform_sog_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 2 (Olive)
	{	"vn_b_uniform_sog_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 2 (Tiger)
	{	"vn_b_uniform_sog_02_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 2 (Black)
	{	"vn_b_uniform_sog_02_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 2 (Spray)
	{	"vn_b_uniform_sog_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 2 (Tiger/ black)
	{	"vn_b_uniform_sog_02_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SOG 2 (Spray/black)
//Seal														
	{	"vn_b_uniform_seal_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 1 (ERDL)
	{	"vn_b_uniform_seal_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 1 (Olive Dirty)
	{	"vn_b_uniform_seal_01_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 1 (Olive)
	{	"vn_b_uniform_seal_01_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 1 (Tiger Green)
	{	"vn_b_uniform_seal_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 1 (Tiger)
	{	"vn_b_uniform_seal_02_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 2 (ERDL)
	{	"vn_b_uniform_seal_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 2 (Olive Dirty)
	{	"vn_b_uniform_seal_02_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 2 (Olive)
	{	"vn_b_uniform_seal_02_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 2 (Tiger Green)
	{	"vn_b_uniform_seal_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 2 (Tiger)
	{	"vn_b_uniform_seal_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 3 (Blue)
	{	"vn_b_uniform_seal_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 4 (Blue)
	{	"vn_b_uniform_seal_05_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 5 (ERDL)
	{	"vn_b_uniform_seal_05_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 5 (Olive Dirty)
	{	"vn_b_uniform_seal_05_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 5 (Olive)
	{	"vn_b_uniform_seal_05_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 5 (Tiger Green)
	{	"vn_b_uniform_seal_05_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 5 (Tiger)
	{	"vn_b_uniform_seal_06_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 6 (ERDL)
	{	"vn_b_uniform_seal_06_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 6 (Olive Dirty)
	{	"vn_b_uniform_seal_06_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 6 (Olive)
	{	"vn_b_uniform_seal_06_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 6 (Tiger Green)
	{	"vn_b_uniform_seal_06_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform SEAL 6 (Tiger)
	{	"vn_b_uniform_seal_07_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 1 (Blue/ Khaki)
	{	"vn_b_uniform_seal_07_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 1 (Blue/ Tiger)
	{	"vn_b_uniform_seal_07_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 1 (Yellow/ Khaki)
	{	"vn_b_uniform_seal_07_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 1 (Yellow/ Tiger)
	{	"vn_b_uniform_seal_08_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 2 (Blue/ Khaki)
	{	"vn_b_uniform_seal_08_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 2 (Blue/ Tiger)
	{	"vn_b_uniform_seal_08_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 2 ( Yellow/ Khaki)
	{	"vn_b_uniform_seal_08_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 2 ( Yellow/ Tiger)
	{	"vn_b_uniform_seal_09_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Uniform UDT 3 (Beaver Wetsuit)
//Anzac														
	{	"vn_b_uniform_aus_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 1 (Olive)
	{	"vn_b_uniform_aus_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 2 (Olive)
	{	"vn_b_uniform_aus_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 3 (Olive)
	{	"vn_b_uniform_aus_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 4 (Olive)
	{	"vn_b_uniform_aus_05_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 5 (Olive)
	{	"vn_b_uniform_aus_06_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 6 (Olive)
	{	"vn_b_uniform_aus_07_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 7 (Olive)
	{	"vn_b_uniform_aus_08_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 8 (Olive)
	{	"vn_b_uniform_aus_09_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 9 (Olive)
	{	"vn_b_uniform_aus_10_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU AUS 10 (Olive)
	{	"vn_b_uniform_nz_01_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU NZ 1 (Olive)
	{	"vn_b_uniform_nz_02_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU NZ 2 (Olive)
	{	"vn_b_uniform_nz_03_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU NZ 3 (Olive)
	{	"vn_b_uniform_nz_04_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU NZ 4 (Olive)
	{	"vn_b_uniform_nz_05_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU NZ 5 (Olive)
	{	"vn_b_uniform_nz_06_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU NZ 6 (Olive)
	{	"vn_b_uniform_sas_01_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SAS 1 (ERDL)
	{	"vn_b_uniform_sas_02_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SAS 2 (ERDL)
	{	"vn_b_uniform_sas_03_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	BDU SAS 3 (ERDL)
//NVA Infantry Uniforms														
	{	"vn_o_uniform_nva_air_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PAVN Pilot Uniform
	{	"vn_o_uniform_nva_army_01_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 1
	{	"vn_o_uniform_nva_army_01_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 1 (Field)
	{	"vn_o_uniform_nva_army_01_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 1
	{	"vn_o_uniform_nva_army_01_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 1 (Field)
	{	"vn_o_uniform_nva_army_02_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 2
	{	"vn_o_uniform_nva_army_02_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 2 (Field)
	{	"vn_o_uniform_nva_army_02_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 2
	{	"vn_o_uniform_nva_army_02_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 2 (Field)
	{	"vn_o_uniform_nva_army_03_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 3
	{	"vn_o_uniform_nva_army_03_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 3 (Field)
	{	"vn_o_uniform_nva_army_03_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 3
	{	"vn_o_uniform_nva_army_03_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 3 (Field)
	{	"vn_o_uniform_nva_army_04_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 4
	{	"vn_o_uniform_nva_army_04_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 4 (Field)
	{	"vn_o_uniform_nva_army_04_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 4
	{	"vn_o_uniform_nva_army_04_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 4 (Field)
	{	"vn_o_uniform_nva_army_05_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 5
	{	"vn_o_uniform_nva_army_05_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 5 (Field)
	{	"vn_o_uniform_nva_army_06_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 6
	{	"vn_o_uniform_nva_army_06_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 6 (Field)
	{	"vn_o_uniform_nva_army_07_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 7
	{	"vn_o_uniform_nva_army_07_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 7 (Field)
	{	"vn_o_uniform_nva_army_08_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 8
	{	"vn_o_uniform_nva_army_08_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 8 (Field)
	{	"vn_o_uniform_nva_army_09_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 9
	{	"vn_o_uniform_nva_army_09_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 9 (Field)
	{	"vn_o_uniform_nva_army_09_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 9
	{	"vn_o_uniform_nva_army_09_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 9 (Field)
	{	"vn_o_uniform_nva_army_10_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 10
	{	"vn_o_uniform_nva_army_10_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 10 (Field)
	{	"vn_o_uniform_nva_army_11_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 11
	{	"vn_o_uniform_nva_army_11_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 11 (Field)
	{	"vn_o_uniform_nva_army_12_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 12
	{	"vn_o_uniform_nva_army_12_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA 65 Uniform 12 (Field)
	{	"vn_o_uniform_nva_army_12_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 12
	{	"vn_o_uniform_nva_army_12_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Uniform 12 (Field)
	{	"vn_o_uniform_nva_dc_13_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Dac Cong Uniform 1 (Tan)
	{	"vn_o_uniform_nva_dc_13_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Dac Cong Uniform 1 (Green)
	{	"vn_o_uniform_nva_dc_13_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Dac Cong Uniform 1 (Black)
	{	"vn_o_uniform_nva_dc_13_08"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Dac Cong Uniform 1 (Blue)
	{	"vn_o_uniform_nva_dc_14_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Dac Cong Uniform 2 (Black)
	{	"vn_o_uniform_nva_dc_14_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	NVA Dac Cong Uniform 2 (Blue)
	{	"vn_o_uniform_nva_navy_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VPN Marines Uniform 1
	{	"vn_o_uniform_nva_navy_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VPN Marines Uniform 2
	{	"vn_o_uniform_nva_navy_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VPN Navy Uniform 1
	{	"vn_o_uniform_nva_navy_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VPN Navy Uniform 2
//VC Uniforms														
	{	"vn_o_uniform_vc_01_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (Black)
	{	"vn_o_uniform_vc_01_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (Black/ white)
	{	"vn_o_uniform_vc_01_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (Grey/ tan)
	{	"vn_o_uniform_vc_01_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (Blue)
	{	"vn_o_uniform_vc_01_05"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (White/ black)
	{	"vn_o_uniform_vc_01_06"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (Blue/ white)
	{	"vn_o_uniform_vc_01_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1 (Blue/ grey)
	{	"vn_o_uniform_vc_02_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (Black)
	{	"vn_o_uniform_vc_02_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (Black/ white)
	{	"vn_o_uniform_vc_02_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (Grey/ tan)
	{	"vn_o_uniform_vc_02_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (Blue)
	{	"vn_o_uniform_vc_02_05"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (White/ black)
	{	"vn_o_uniform_vc_02_06"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (Blue/ white)
	{	"vn_o_uniform_vc_02_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2 (Blue/ grey)
	{	"vn_o_uniform_vc_03_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (Black)
	{	"vn_o_uniform_vc_03_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (Black/ white)
	{	"vn_o_uniform_vc_03_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (Grey/ tan)
	{	"vn_o_uniform_vc_03_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (Blue)
	{	"vn_o_uniform_vc_03_05"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (White/ black)
	{	"vn_o_uniform_vc_03_06"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (Blue/ white)
	{	"vn_o_uniform_vc_03_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3 (Blue/ grey)
	{	"vn_o_uniform_vc_04_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (Black)
	{	"vn_o_uniform_vc_04_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (Black/ white)
	{	"vn_o_uniform_vc_04_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (Grey/tan)
	{	"vn_o_uniform_vc_04_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (Blue)
	{	"vn_o_uniform_vc_04_05"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (White/black)
	{	"vn_o_uniform_vc_04_06"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (Blue/ white)
	{	"vn_o_uniform_vc_04_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4 (Blue/ grey)
	{	"vn_o_uniform_vc_05_01"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 5 (Black)
	{	"vn_o_uniform_vc_05_02"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 5 (White)
	{	"vn_o_uniform_vc_05_03"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 5 (Grey)
	{	"vn_o_uniform_vc_05_04"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 5 (Blue)
	{	"vn_o_uniform_vc_mf_01_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 1
	{	"vn_o_uniform_vc_mf_02_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 2
	{	"vn_o_uniform_vc_mf_03_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 3
	{	"vn_o_uniform_vc_mf_04_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 4
	{	"vn_o_uniform_vc_mf_09_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 9
	{	"vn_o_uniform_vc_mf_10_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 10
	{	"vn_o_uniform_vc_mf_11_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 11
	{	"vn_o_uniform_vc_mf_12_07"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 12
	{	"vn_o_uniform_vc_reg_11_08"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 11 (Blue)
	{	"vn_o_uniform_vc_reg_11_09"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 11 (Blue/ tan)
	{	"vn_o_uniform_vc_reg_11_10"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 11 (Tan/ black)
	{	"vn_o_uniform_vc_reg_12_08"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 12 (Blue)
	{	"vn_o_uniform_vc_reg_12_09"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 12 (Blue/ tan)
	{	"vn_o_uniform_vc_reg_12_10"	,{	0	,	-1	,	-1	,	-1	}}	,	//	VC Uniform 12 (Tan/ black)
	{	"vn_o_uniform_pl_army_01_11"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 1 (Dark)
	{	"vn_o_uniform_pl_army_01_12"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 1 (Dark/ Field)
	{	"vn_o_uniform_pl_army_01_13"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 1 (Light)
	{	"vn_o_uniform_pl_army_01_14"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 1 (Light/ Field)
	{	"vn_o_uniform_pl_army_02_11"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 2 (Dark)
	{	"vn_o_uniform_pl_army_02_12"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 2 (Dark/ Field)
	{	"vn_o_uniform_pl_army_02_13"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 2 (Light)
	{	"vn_o_uniform_pl_army_02_14"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 2 (Light/ Field)
	{	"vn_o_uniform_pl_army_03_11"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 3 (Dark)
	{	"vn_o_uniform_pl_army_03_12"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 3 (Dark/ Field)
	{	"vn_o_uniform_pl_army_03_13"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 3 (Light)
	{	"vn_o_uniform_pl_army_03_14"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 3 (Light/ Field)
	{	"vn_o_uniform_pl_army_04_11"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 4 (Dark)
	{	"vn_o_uniform_pl_army_04_12"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 4 (Dark/ Field)
	{	"vn_o_uniform_pl_army_04_13"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 4 (Light)
	{	"vn_o_uniform_pl_army_04_14"	,{	0	,	-1	,	-1	,	-1	}}	,	//	PL Uniform 4 (Light/ Field)
//Vests														
//US Vests														
	{	"vn_b_vest_aircrew_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Aircrew
	{	"vn_b_vest_aircrew_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USAF (Pilot)
	{	"vn_b_vest_aircrew_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Pilot)
	{	"vn_b_vest_aircrew_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USAF (Pilot/ holster)
	{	"vn_b_vest_aircrew_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Pilot/ holster)
	{	"vn_b_vest_aircrew_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USAF (Pilot/ camo)
	{	"vn_b_vest_aircrew_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USSF (Pilot/ camo/ holster)
	{	"vn_b_vest_sog_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SOG (One-Zero TL)
	{	"vn_b_vest_sog_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SOG (One-Two Medic)
	{	"vn_b_vest_sog_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SOG (Demolitions)
	{	"vn_b_vest_sog_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SOG (Scout)
	{	"vn_b_vest_sog_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SOG (MG)
	{	"vn_b_vest_sog_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SOG (One-One RTO)
	{	"vn_b_vest_usarmy_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Sentry)
	{	"vn_b_vest_usarmy_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Rifleman 01)
	{	"vn_b_vest_usarmy_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Rifleman 02)
	{	"vn_b_vest_usarmy_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Scout)
	{	"vn_b_vest_usarmy_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Grenadier)
	{	"vn_b_vest_usarmy_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (MG)
	{	"vn_b_vest_usarmy_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Medic)
	{	"vn_b_vest_usarmy_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Marksman)
	{	"vn_b_vest_usarmy_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Officer)
	{	"vn_b_vest_usarmy_10"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Crewman)
	{	"vn_b_vest_usarmy_11"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Crewman M1952A holster)
	{	"vn_b_vest_usarmy_12"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Crewman M1952A)
	{	"vn_b_vest_usarmy_13"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Crewman M69 holster)
	{	"vn_b_vest_usarmy_14"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - Army (Crewman M69)
	{	"vn_b_vest_seal_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (diver)
	{	"vn_b_vest_seal_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (TL)
	{	"vn_b_vest_seal_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (MG)
	{	"vn_b_vest_seal_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (Rifleman)
	{	"vn_b_vest_seal_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (Scout)
	{	"vn_b_vest_seal_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (Medic)
	{	"vn_b_vest_seal_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SEAL (Grenadier)
	{	"vn_b_vest_usmc_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Rifleman 01)
	{	"vn_b_vest_usmc_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Rifleman 02)
	{	"vn_b_vest_usmc_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (MG)
	{	"vn_b_vest_usmc_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Grenadier)
	{	"vn_b_vest_usmc_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Corpsman)
	{	"vn_b_vest_usmc_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Officer)
	{	"vn_b_vest_usmc_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Rifleman/ recon)
	{	"vn_b_vest_usmc_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (MG/ recon)
	{	"vn_b_vest_usmc_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - USMC (Grenadier/ recon)
//Anzac														
	{	"vn_b_vest_anzac_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Rifleman 01)
	{	"vn_b_vest_anzac_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Rifleman 02)
	{	"vn_b_vest_anzac_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Scout)
	{	"vn_b_vest_anzac_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Grenadier)
	{	"vn_b_vest_anzac_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (MG)
	{	"vn_b_vest_anzac_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Medic)
	{	"vn_b_vest_anzac_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Officer)
	{	"vn_b_vest_anzac_08"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Pilot M1952A)
	{	"vn_b_vest_anzac_09"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Crewman M1952A)
	{	"vn_b_vest_anzac_10"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - ANZAC (Crewman)
	{	"vn_b_vest_sas_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SAS (Scout)
	{	"vn_b_vest_sas_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SAS (Grenadier)
	{	"vn_b_vest_sas_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SAS (MG)
	{	"vn_b_vest_sas_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Vest - SAS (Patrol Commander)
//NVA Vests														
	{	"vn_o_vest_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - NVA (Assault)
	{	"vn_o_vest_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - NVA (Rifle)
	{	"vn_o_vest_03"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - NVA (MG)
	{	"vn_o_vest_04"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VPN
	{	"vn_o_vest_05"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VPN (Holster)
	{	"vn_o_vest_06"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - NVA (Medic)
	{	"vn_o_vest_07"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - NVA (Officer)
	{	"vn_o_vest_08"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - NVA (Sapper)
//VC Vests														
	{	"vn_o_vest_vc_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VC (Assault)
	{	"vn_o_vest_vc_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VC (Rifle)
	{	"vn_o_vest_vc_03"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VC (MG)
	{	"vn_o_vest_vc_04"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VC (Medic)
	{	"vn_o_vest_vc_05"	,{	0	,	-1	,	0	,	-1	}}	,	//	Vest - VC (Leader)
};														
backpacks[] =														
{ 														
//Blufor														
	{	"B_Parachute"	,{	0	,	0	,	0	,	-1	}}	,	//	ARMA3 Steerable
	{	"vn_b_pack_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (CISO)
	{	"vn_b_pack_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	CIDG (CISO)
	{	"vn_b_pack_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (CISO MG)
	{	"vn_b_pack_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	CIDG (CISO MG)
	{	"vn_b_pack_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (CISO RTO)
	{	"vn_b_pack_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	CIDG (CISO RTO)
	{	"vn_b_pack_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (CISO Scout)
	{	"vn_b_pack_04_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	CIDG (CISO Scout)
	{	"vn_b_pack_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (CISO Demo)
	{	"vn_b_pack_05_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	CIDG (CISO Demo)
	{	"vn_b_pack_lw_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Rifleman)
	{	"vn_b_pack_lw_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (MG)
	{	"vn_b_pack_lw_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Scout)
	{	"vn_b_pack_lw_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Engineer)
	{	"vn_b_pack_lw_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (MG Ammo)
	{	"vn_b_pack_lw_06"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (RTO 2)
	{	"vn_b_pack_lw_07"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Medic)
	{	"vn_b_pack_m5_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Medic M5)
	{	"vn_b_pack_prc77_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (RTO)
	{	"vn_b_pack_trp_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (Tropical MG)
	{	"vn_b_pack_trp_01_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Tropical MG)
	{	"vn_b_pack_trp_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (Tropical)
	{	"vn_b_pack_trp_02_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Tropical)
	{	"vn_b_pack_trp_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (Tropical Demo)
	{	"vn_b_pack_trp_03_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Tropical Demo)
	{	"vn_b_pack_trp_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	SOG (Tropical RTO)
	{	"vn_b_pack_trp_04_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	Army (Tropical RTO)
	{	"vn_b_pack_seal_01"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	SEAL (Diver) removed due to non protection under water
	{	"vn_b_pack_p08_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (P08 1)
	{	"vn_b_pack_p08_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (P08 2)
	{	"vn_b_pack_p08_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (P08 3)
	{	"vn_b_pack_p44_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (P44 1)
	{	"vn_b_pack_p44_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (P44 2)
	{	"vn_b_pack_p44_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (P44 3)
	{	"vn_b_pack_pfield_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (Field 1)
	{	"vn_b_pack_pfield_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	ANZAC (Field 2)
	{	"vn_b_pack_ba18_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Parachute (BA18)
	{	"vn_b_pack_ba22_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	Parachute (BA22)
	{	"vn_b_pack_t10_01"	,{	0	,	0	,	0	,	0	}}	,	//	Parachute (T10) OPEN TO ALL
	{	"vn_b_pack_m41_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	USMC (M41 1)
	{	"vn_b_pack_m41_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	USMC (M41 2)
	{	"vn_b_pack_m41_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	USMC (M41 3)
	{	"vn_b_pack_m41_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	USMC (M41 4)
	{	"vn_b_pack_m41_05"	,{	-1	,	0	,	0	,	-1	}}	,	//	USMC (M41 RTO)
	{	"vn_b_pack_arvn_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARVN 1
	{	"vn_b_pack_arvn_02"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARVN 2
	{	"vn_b_pack_arvn_03"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARVN 3
	{	"vn_b_pack_arvn_04"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARVN 4
//Blufor Static Backpacks														
	{	"vn_b_pack_static_ammo_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (Ammo Resupply)
	{	"vn_b_pack_static_base_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (Weapon Base)
	{	"vn_b_pack_static_tow" 	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (BGM-71 TOW) ADDED
	{	"vn_b_pack_static_m1919a4_high_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (M1919A4 high)
	{	"vn_b_pack_static_m1919a4_low_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (M1919A4 low)
	{	"vn_b_pack_static_m1919a6_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (M1919A6)
	{	"vn_b_pack_static_m29_01"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	ARMY (M29 Mortar 81mm) BLACKLIST
	{	"vn_b_pack_static_m2_01"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	ARMY (M2 Mortar 60mm) BLACKLIST
	{	"vn_b_pack_static_m2_high_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY(M2 high)
	{	"vn_b_pack_static_m2_low_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY(M2 low)
	{	"vn_b_pack_static_m60_high_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (M60 high)
	{	"vn_b_pack_static_m60_low_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (M60 low)
	{	"vn_b_pack_static_mk18"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY (MK18)
	{	"vn_b_pack_static_m2_scoped_high_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY(M2 Scoped high)
	{	"vn_b_pack_static_m2_scoped_low_01"	,{	-1	,	0	,	0	,	-1	}}	,	//	ARMY(M2 Scoped low)
//OpFor														
	{	"vn_c_pack_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Pack (Basket)
	{	"vn_c_pack_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	Pack (Ganh Hang Rong)
	{	"vn_o_pack_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA 1
	{	"vn_o_pack_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA 2
	{	"vn_o_pack_03"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (RPG)
	{	"vn_o_pack_04"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Assault)
	{	"vn_o_pack_05"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Sapper)
	{	"vn_o_pack_06"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Recon)
	{	"vn_o_pack_07"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Recon/RPG)
	{	"vn_o_pack_08"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Mortar Ammo)
	{	"vn_o_pack_t884_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA T884 Radio
	{	"vn_i_pack_parachute_01"	,{	-1	,	-1	,	-1	,	-1	}}	,	//	Parachute (Independant) BLACKLIST
	{	"vn_o_pack_parachute_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	Parachute (Opfor)
//Opfor Static Backpacks														
	{	"vn_o_pack_static_ammo_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Ammo Resupply) ??
	{	"vn_o_pack_static_base_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Weapon Base)
	{	"vn_o_pack_static_dp28_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (DP27)
	{	"vn_o_pack_static_dshkm_high_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (DShKM high)
	{	"vn_o_pack_static_dshkm_high_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (DShKM AA)
	{	"vn_o_pack_static_dshkm_low_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (DShKM Armour)
	{	"vn_o_pack_static_dshkm_low_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (DShKM low)
	{	"vn_o_pack_static_rpd_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (RPD)
	{	"vn_o_pack_static_type53_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Type 53 Mortar)
	{	"vn_o_pack_static_type63_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Type 63 Mortar)
	{	"vn_o_pack_static_at3_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (AT-3) ADDED
	{	"vn_o_pack_static_pk_high_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (PK high) ADDED
	{	"vn_o_pack_static_pk_low_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (PK low) ADDED
	{	"vn_o_pack_static_sgm_low_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (SGM low,shield)
	{	"vn_o_pack_static_sgm_low_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (SGM low)
	{	"vn_o_pack_static_sgm_high_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (SGM high)
	{	"vn_o_pack_static_mg42_low"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (MG42 high)
	{	"vn_o_pack_static_mg42_high"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (MG42 low)
	{	"vn_o_pack_static_m1910_low_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (M1910 low,shield)
	{	"vn_o_pack_static_m1910_low_02"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (M1910 low)
	{	"vn_o_pack_static_m1910_high_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (M1910 high)
	{	"vn_o_pack_static_type56rr_01"	,{	0	,	-1	,	0	,	-1	}}	,	//	NVA (Type 56 Recoilless)
};														

		vehicles[] =
		{
			{ "NonSteerable_Parachute_F", 			{ 0, 0, 0, 0}}, 
			{ "Steerable_Parachute_F", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_01_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_02_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_03", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_03_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_04", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_04_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_05", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_05_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_06", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_06_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_07", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_07_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_08", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_08_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_09", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_09_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_10", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ah1g_10_usmc", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ch34_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ch34_03_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ch34_04_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ch34_04_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ch34_04_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_ch34_04_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_at", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_bmb", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_cap", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_cas", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_cbu", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_ehcas", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_gbu", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_hbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_hcas", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_lbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_lrbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_mbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_mr", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_sead", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_navy_ucas", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_at", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_bmb", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_cap", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_cas", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_cbu", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_ehcas", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_gbu", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_hbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_hcas", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_lbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_lrbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_mbmb", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_mr", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_sead", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4b_usmc_ucas", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_at", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_bmb", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_cap", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_cas", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_cbu", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_chico", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_ehcas", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_gbu", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_hbmb", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_hcas", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_lbmb", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_lrbmb", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_mbmb", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_mr", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_sead", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_f4c_ucas", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_03", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_04", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_05", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_06", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_oh6a_07", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_01_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_02_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_03_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_04_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_05_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_06_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_06_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1c_07_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_01_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_air_uh1d_02_07", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_armor_m41_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_armor_m41_01_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m101_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m101_02", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m1919a4_high", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m1919a4_low", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m1919a6", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m2_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m2_low", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m45", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m60_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_m60_low", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_mortar_m2", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_mortar_m29", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_army_static_tow", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_boat_05_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_boat_05_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_boat_06_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_boat_06_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m101_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m101_02", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m1919a4_high", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m1919a4_low", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m1919a6", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m2_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m2_low", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m45", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m60_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_m60_low", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_mortar_m2", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_mortar_m29", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_sf_static_tow", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_01_mp", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_02_mp", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_mg_02", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_mg_02_mp", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_mg_03", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_mg_03_mp", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_mg_04", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m151_mg_04_mp", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_01_airport", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_01_sog", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_02_sog", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_ammo", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_ammo_airport", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_fuel", 				{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_fuel_airport", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_mg_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_mg_02", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_mg_03", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_repair", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_wheeled_m54_repair_airport", 	{ 0, 0, 0, 0}}, 
			{ "vn_c_bicycle_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_bicycle_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_01_00", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_01_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_01_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_01_03", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_01_04", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_02_00", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_02_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_02_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_02_03", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_02_04", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_07_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_07_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_08_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_boat_08_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_wheeled_m151_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_c_wheeled_m151_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_ch34_01_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_ch34_02_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_ch34_02_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_uh1c_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_uh1c_02_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_uh1c_07_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_uh1d_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_air_uh1d_02_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_armor_m41_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_i_armor_type63_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m101_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m101_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m1919a4_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m1919a4_low", 			{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m1919a6", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m2_high", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m2_low", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m45", 					{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m60_high", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_m60_low", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_mortar_m2", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_static_mortar_m29", 			{ 0, 0, 0, 0}}, 
			{ "vn_i_static_tow", 					{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m151_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m151_01_mp", 			{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m151_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m151_02_mp", 			{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m151_mg_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m151_mg_01_mp", 		{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m54_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m54_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m54_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m54_ammo", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m54_fuel", 				{ 0, 0, 0, 0}}, 
			{ "vn_i_wheeled_m54_repair", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_01_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_01_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_01_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_02_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_02_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_03_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_03_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_03_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_03_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_03_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_03_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_04_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_04_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_04_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_04_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_04_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_04_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_05_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_05_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_05_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_05_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_05_05", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_air_mi2_05_06", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_armor_m41_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_armor_m41_02_vcmf", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_armor_type63_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_armor_type63_01_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_01_nva65", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_01_nvam", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_01_vcmf", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_02_nva65", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_bicycle_02_vcmf", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_00", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_03", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_04", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_mg_00", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_mg_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_mg_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_mg_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_01_mg_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_00", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_03", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_04", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_mg_00", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_mg_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_mg_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_mg_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_02_mg_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_03_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_03_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_04_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_04_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_07_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_07_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_08_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_boat_08_02", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_d44", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_d44_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_dshkm_high_01",	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_dshkm_high_02", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_dshkm_low_01", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_dshkm_low_02", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_mortar_type53",	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_mortar_type63",	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_pk_high", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_pk_low", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_rpd_high", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_zpu4", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_at3", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_d44", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_d44_01", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_dshkm_high_01", { 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_dshkm_high_02", { 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_dshkm_low_01", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_dshkm_low_02", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_mortar_type53", { 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_mortar_type63", { 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_pk_high", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_pk_low", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_rpd_high", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_zpu4", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_at3", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_d44", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_d44_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_dshkm_high_01", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_dshkm_high_02", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_dshkm_low_01", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_dshkm_low_02", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_mortar_type53", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_mortar_type63", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_pk_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_pk_low", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_rpd_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_static_zpu4", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_d44", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_d44_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_dp28_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_dshkm_high_01", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_dshkm_high_02", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_dshkm_low_01", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_dshkm_low_02", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_mortar_type53", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_mortar_type63", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_pk_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_pk_low", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_vc_static_rpd_high", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_01_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_01_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_01_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_02_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_02_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_02_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_01_nva65", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_01_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_01_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_02", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_02_nva65", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_02_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_02_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_03", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_03_nva65", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_03_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_btr40_mg_03_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_01", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_01_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_01_nvam", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_01_vcmf", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_02", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_02_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_02_nvam", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_02_vcmf", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_03", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_03_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_03_nvam", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_03_vcmf", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_04", 				{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_04_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_04_nvam", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_04_vcmf", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_ammo", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_ammo_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_ammo_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_ammo_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_fuel", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_fuel_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_fuel_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_fuel_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_01", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_01_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_01_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_01_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_02", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_02_nva65", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_02_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_mg_02_vcmf", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_repair", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_repair_nva65", 	{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_repair_nvam", 		{ 0, 0, 0, 0}}, 
			{ "vn_o_wheeled_z157_repair_vcmf", 		{ 0, 0, 0, 0}}, 
			//1.1 Content
			{ "vn_b_wheeled_m151_mg_05", 			{ 0, 0, 0, 0}}, 
			{ "vn_c_car_01_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_car_02_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_car_03_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_c_car_04_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_car_04_mg_01", 					{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_navy_static_v11m", 			{ 0, 0, 0, 0}}, 
			{ "vn_o_nva_65_static_type56rr", 		{ 0, 0, 0, 0}}, 
			{ "vn_b_navy_static_l60mk3", 			{ 0, 0, 0, 0}}, 
			{ "vn_b_navy_static_l70mk2", 			{ 0, 0, 0, 0}},
			{ "B_Heli_Light_01_F", 					{ 0, 0, 0, 0}},

			//UNSUNG
			{"uns_xm706e1", 						{0, 0, 0, 0}},
			{"uns_xm706e2", 						{0, 0, 0, 0}},
			{"uns_M1_81mm_mortar", 					{0, 0, 0, 0}},
			{"uns_M1_81mm_mortar_arty", 			{0, 0, 0, 0}},
			{"uns_M2_60mm_mortar", 					{0, 0, 0, 0}},
			{"uns_M30_107mm_mortar", 				{0, 0, 0, 0}},
			{"Uns_M102_artillery", 					{0, 0, 0, 0}},
			{"Uns_M114_artillery", 					{0, 0, 0, 0}},
			{"UNS_floatraft_3", 					{0, 0, 0, 0}},
			{"uns_C130_H", 							{0, 0, 0, 0}},
			{"uns_KC130_H", 						{0, 0, 0, 0}},
			{"uns_c1a", 							{0, 0, 0, 0}},
			{"uns_c1a2", 							{0, 0, 0, 0}},
			{"uns_c1a2cargo", 						{0, 0, 0, 0}},
			{"uns_c1a3", 							{0, 0, 0, 0}},
			{"uns_c1a3cargo", 						{0, 0, 0, 0}},
			{"uns_c1a4", 							{0, 0, 0, 0}},
			{"uns_c1a4cargo", 						{0, 0, 0, 0}},
			{"uns_c1a5",							{0, 0, 0, 0}},
			{"uns_c1a5cargo", 						{0, 0, 0, 0}},
			{"uns_c1a6", 							{0, 0, 0, 0}},
			{"uns_c1a6cargo", 						{0, 0, 0, 0}},
			{"uns_c1a7", 							{0, 0, 0, 0}},
			{"uns_c1a7cargo", 						{0, 0, 0, 0}},
			{"uns_ch46d", 							{0, 0, 0, 0}},
			{"uns_ch47_m60_usmc", 					{0, 0, 0, 0}},
			{"uns_ch47_m60_army", 					{0, 0, 0, 0}},
			{"uns_ch47_m60_1AC", 					{0, 0, 0, 0}},
			{"uns_ch47a_medevac", 					{0, 0, 0, 0}},
			{"uns_ach47_m134", 						{0, 0, 0, 0}},
			{"uns_ch53a_med_usmc", 					{0, 0, 0, 0}},
			{"uns_ch53a_m60_usmc", 					{0, 0, 0, 0}},
			{"uns_rh53a_m2_usn", 					{0, 0, 0, 0}},
			{"uns_ch53d_m2_usmc", 					{0, 0, 0, 0}},
			{"uns_hh53b_m134_usaf", 				{0, 0, 0, 0}},
			{"uns_AC47", 							{0, 0, 0, 0}},
			{"uns_ac47_flare", 						{0, 0, 0, 0}},
			{"uns_f100b_CAP", 						{0, 0, 0, 0}},
			{"uns_f100b_CAS", 						{0, 0, 0, 0}},
			{"uns_f100b_AGM", 						{0, 0, 0, 0}},
			{"uns_f100b_MR", 						{0, 0, 0, 0}},
			{"uns_f100b_BMB", 						{0, 0, 0, 0}},
			{"uns_f100b_CBU", 						{0, 0, 0, 0}},
			{"uns_f100b_SEAD", 						{0, 0, 0, 0}},
			{"uns_h21c", 							{0, 0, 0, 0}},
			{"uns_h21c_mg", 						{0, 0, 0, 0}},
			{"UNS_Hawkeye", 						{0, 0, 0, 0}},
			{"uns_m274", 							{0, 0, 0, 0}},
			{"uns_m274_m60", 						{0, 0, 0, 0}},
			{"uns_m274_m40", 						{0, 0, 0, 0}},
			{"uns_m48a3", 							{0, 0, 0, 0}},
			{"uns_M67A", 							{0, 0, 0, 0}},
			{"uns_pbr", 							{0, 0, 0, 0}},
			{"uns_pbr_mk18", 						{0, 0, 0, 0}},
			{"uns_PBR_M10", 						{0, 0, 0, 0}},
			{"uns_m551", 							{0, 0, 0, 0}},
			{"uns_US_MK18_low", 					{0, 0, 0, 0}},
			{"uns_M40_106mm_US", 					{0, 0, 0, 0}},
			{"uns_f105D_CAP", 						{0, 0, 0, 0}},
			{"uns_f105D_CAS", 						{0, 0, 0, 0}},
			{"uns_f105D_HCAS", 						{0, 0, 0, 0}},
			{"uns_f105D_AGM", 						{0, 0, 0, 0}},
			{"uns_f105D_MR",						{0, 0, 0, 0}},
			{"uns_f105D_LRBMB", 					{0, 0, 0, 0}},
			{"uns_f105D_BMB", 						{0, 0, 0, 0}},
			{"uns_f105D_MBMB", 						{0, 0, 0, 0}},
			{"uns_f105D_HBMB", 						{0, 0, 0, 0}},
			{"uns_f105D_CBU", 						{0, 0, 0, 0}},
			{"uns_f105F_MR", 						{0, 0, 0, 0}},
			{"uns_f105F_AGM", 						{0, 0, 0, 0}},
			{"uns_f105F_BMB", 						{0, 0, 0, 0}},
			{"uns_f105F_CBU", 						{0, 0, 0, 0}},
			{"uns_f105F_SEAD", 						{0, 0, 0, 0}},
			{"uns_H13_medevac_USMC", 				{0, 0, 0, 0}},
			{"uns_H13_medevac_Army", 				{0, 0, 0, 0}},
			{"uns_H13_medevac_USN", 				{0, 0, 0, 0}},
			{"uns_H13_medevac_USAF", 				{0, 0, 0, 0}},
			{"uns_H13_medevac_CAV", 				{0, 0, 0, 0}},
			{"uns_H13_amphib_USMC", 				{0, 0, 0, 0}},
			{"uns_H13_amphib_Army", 				{0, 0, 0, 0}},
			{"uns_H13_amphib_USN", 					{0, 0, 0, 0}},
			{"uns_H13_amphib_USAF", 				{0, 0, 0, 0}},
			{"uns_H13_amphib_CAV", 					{0, 0, 0, 0}},
			{"uns_H13_transport_USMC", 				{0, 0, 0, 0}},
			{"uns_H13_transport_Army", 				{0, 0, 0, 0}},
			{"uns_H13_transport_USN", 				{0, 0, 0, 0}},
			{"uns_H13_transport_USAF", 				{0, 0, 0, 0}},
			{"uns_H13_transport_CAV", 				{0, 0, 0, 0}},
			{"uns_H13_gunship_USMC", 				{0, 0, 0, 0}},
			{"uns_H13_gunship_Army", 				{0, 0, 0, 0}},
			{"uns_H13_gunship_USN", 				{0, 0, 0, 0}},
			{"uns_H13_gunship_USAF", 				{0, 0, 0, 0}},
			{"uns_H13_gunship_CAV", 				{0, 0, 0, 0}},
			{"uns_A1J", 							{0, 0, 0, 0}},
			{"uns_A1J_navy", 						{0, 0, 0, 0}},
			{"uns_A1J_CAS", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_CAS", 					{0, 0, 0, 0}},
			{"uns_A1J_HCAS", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_HCAS", 					{0, 0, 0, 0}},
			{"uns_A1J_EHCAS", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_EHCAS", 					{0, 0, 0, 0}},
			{"uns_A1J_AGM", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_AGM", 					{0, 0, 0, 0}},
			{"uns_A1J_MR", 							{0, 0, 0, 0}},
			{"uns_A1J_navy_MR", 					{0, 0, 0, 0}},
			{"uns_A1J_LBMB", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_LBMB", 					{0, 0, 0, 0}},
			{"uns_A1J_BMB", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_BMB", 					{0, 0, 0, 0}},
			{"uns_A1J_HBMB", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_HBMB", 					{0, 0, 0, 0}},
			{"uns_A1J_CBU", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_CBU", 					{0, 0, 0, 0}},
			{"uns_A1J_CMU", 						{0, 0, 0, 0}},
			{"uns_A1J_navy_CMU", 					{0, 0, 0, 0}},
			{"uns_a3b", 							{0, 0, 0, 0}},
			{"uns_a3bcamo1", 						{0, 0, 0, 0}},
			{"uns_a3bvah1", 						{0, 0, 0, 0}},
			{"uns_a3bvah2", 						{0, 0, 0, 0}},
			{"uns_a3bvah4", 						{0, 0, 0, 0}},
			{"uns_a3bvah6", 						{0, 0, 0, 0}},
			{"uns_a3bvah11", 						{0, 0, 0, 0}},
			{"uns_a3avah1", 						{0, 0, 0, 0}},
			{"uns_a3avah2", 						{0, 0, 0, 0}},
			{"uns_a3avah4", 						{0, 0, 0, 0}},
			{"uns_a3avah6", 						{0, 0, 0, 0}},
			{"uns_a3avah11", 						{0, 0, 0, 0}},
			{"uns_a3a", 							{0, 0, 0, 0}},
			{"uns_ka3b", 							{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_CAP", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_CAS", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_HCAS", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_MR", 					{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_BMB", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_AGM", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_LRBMB", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_MBMB", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_HBMB", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_CBU", 				{0, 0, 0, 0}},
			{"uns_A4B_skyhawk_SEAD", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_CAP", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_CAP", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_CAS", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_CAS", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_HCAS", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_HCAS", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_AGM", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_AGM", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_MR", 					{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_MR", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_BMB", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_BMB", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_HBMB", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_HBMB", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_LRBMB", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_LRBMB", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_MBMB", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_MBMB", 			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_SEAD", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_SEAD",			{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_CBU", 				{0, 0, 0, 0}},
			{"uns_A4E_skyhawk_USMC_CBU", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_LBMB", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_LBMB", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_SEAD", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_CAS", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_CAS", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_AGM", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_AGM", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_MR", 					{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_MR", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_BMB", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_BMB", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_LRBMB", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_LRBMB", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_MBMB", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_MBMB", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_HBMB", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_HBMB", 			{0, 0, 0, 0}},
			{"uns_A6_Intruder_CBU", 				{0, 0, 0, 0}},
			{"uns_A6_Intruder_USMC_CBU", 			{0, 0, 0, 0}},
			{"uns_A7_CAP", 							{0, 0, 0, 0}},
			{"uns_A7_CAS", 							{0, 0, 0, 0}},
			{"uns_A7_AGM", 							{0, 0, 0, 0}},
			{"uns_A7_MR", 							{0, 0, 0, 0}},
			{"uns_A7_LRBMB", 						{0, 0, 0, 0}},
			{"uns_A7_LBMB", 						{0, 0, 0, 0}},
			{"uns_A7_BMB", 							{0, 0, 0, 0}},
			{"uns_A7_MBMB", 						{0, 0, 0, 0}},
			{"uns_A7_HBMB", 						{0, 0, 0, 0}},
			{"uns_A7_CBU", 							{0, 0, 0, 0}},
			{"uns_A7_SEAD", 						{0, 0, 0, 0}},
			{"uns_A7N_CAP", 						{0, 0, 0, 0}},
			{"uns_A7N_CAS", 						{0, 0, 0, 0}},
			{"uns_A7N_AGM", 						{0, 0, 0, 0}},
			{"uns_A7N_MR", 							{0, 0, 0, 0}},
			{"uns_A7N_BMB", 						{0, 0, 0, 0}},
			{"uns_A7N_LRBMB", 						{0, 0, 0, 0}},
			{"uns_A7N_LBMB", 						{0, 0, 0, 0}},
			{"uns_A7N_MBMB", 						{0, 0, 0, 0}},
			{"uns_A7N_HBMB", 						{0, 0, 0, 0}},
			{"uns_A7N_CBU", 						{0, 0, 0, 0}},
			{"uns_A7N_SEAD", 						{0, 0, 0, 0}},
			{"UNS_F111_CAS", 						{0, 0, 0, 0}},
			{"UNS_F111_D_CAS", 						{0, 0, 0, 0}},
			{"UNS_F111_HCAS", 						{0, 0, 0, 0}},
			{"UNS_F111_D_HCAS", 					{0, 0, 0, 0}},
			{"UNS_F111_AGM", 						{0, 0, 0, 0}},
			{"UNS_F111_D_AGM", 						{0, 0, 0, 0}},
			{"UNS_F111_MR", 						{0, 0, 0, 0}},
			{"UNS_F111_D_MR",						{0, 0, 0, 0}},
			{"UNS_F111_LBMB", 						{0, 0, 0, 0}},
			{"UNS_F111_D_LBMB", 					{0, 0, 0, 0}},
			{"UNS_F111_LRBMB", 						{0, 0, 0, 0}},
			{"UNS_F111_D_LRBMB", 					{0, 0, 0, 0}},
			{"UNS_F111_BMB", 						{0, 0, 0, 0}},
			{"UNS_F111_D_BMB", 						{0, 0, 0, 0}},
			{"UNS_F111_HBMB", 						{0, 0, 0, 0}},
			{"UNS_F111_D_HBMB", 					{0, 0, 0, 0}},
			{"UNS_F111_LGB", 						{0, 0, 0, 0}},
			{"UNS_F111_D_LGB", 						{0, 0, 0, 0}},
			{"UNS_F111_CBU", 						{0, 0, 0, 0}},
			{"UNS_F111_D_CBU", 						{0, 0, 0, 0}},
			{"uns_m107sp", 							{0, 0, 0, 0}},
			{"uns_m110sp", 							{0, 0, 0, 0}},
			{"uns_M113_XM182", 						{0, 0, 0, 0}},
			{"uns_M113_M60", 						{0, 0, 0, 0}},
			{"uns_M113_30cal", 						{0, 0, 0, 0}},
			{"uns_M113_M134", 						{0, 0, 0, 0}},
			{"uns_M113_M2", 						{0, 0, 0, 0}},
			{"uns_M113_M30", 						{0, 0, 0, 0}},
			{"uns_M113_M30_HQ", 					{0, 0, 0, 0}},
			{"uns_M132", 							{0, 0, 0, 0}},
			{"uns_M577_amb", 						{0, 0, 0, 0}},
			{"uns_M113_transport", 					{0, 0, 0, 0}},
			{"uns_M113_ENG",	 					{0, 0, 0, 0}},
			{"uns_m163", 							{0, 0, 0, 0}},
			{"uns_M113A1_M2", 						{0, 0, 0, 0}},
			{"uns_M113A1_XM182", 					{0, 0, 0, 0}},
			{"uns_M113A1_M60", 						{0, 0, 0, 0}},
			{"uns_M113A1_M134", 					{0, 0, 0, 0}},
			{"uns_M113A1_M40", 						{0, 0, 0, 0}},
			{"uns_ch47_m60_arvn", 					{0, 0, 0, 0}},
			{"uns_xm706", 							{0, 0, 0, 0}},
			{"uns_A1H", 							{0, 0, 0, 0}},
			{"uns_A1H_CAS", 						{0, 0, 0, 0}},
			{"uns_A1H_HCAS",	 					{0, 0, 0, 0}},
			{"uns_A1H_EHCAS", 						{0, 0, 0, 0}},
			{"uns_A1H_AGM", 						{0, 0, 0, 0}},
			{"uns_A1H_MR", 							{0, 0, 0, 0}},
			{"uns_A1H_LBMB", 						{0, 0, 0, 0}},
			{"uns_A1H_BMB", 						{0, 0, 0, 0}},
			{"uns_A1H_HBMB", 						{0, 0, 0, 0}},
			{"uns_A1H_CBU", 						{0, 0, 0, 0}},
			{"uns_A1H_C", 							{0, 0, 0, 0}},

			{"vn_o_boat_01_03_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_01_04_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_02_00_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_02_01_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_02_02_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_02_03_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_02_04_pl",					{0,-1,-1,-1}},
			{"vn_o_boat_01_mg_00_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_01_mg_01_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_01_mg_02_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_01_mg_03_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_01_mg_04_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_02_mg_00_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_02_mg_01_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_02_mg_02_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_02_mg_03_pl",				{2,-1,-1,-1}},
			{"vn_o_boat_02_mg_04_pl",				{2,-1,-1,-1}},
			// STAB
			{"vn_b_boat_09_01",						{-1,3,-1,-1}},
			{"vn_b_boat_10_01",						{-1,3,-1,-1}},
			{"vn_b_boat_11_01",						{-1,3,-1,-1}},
			// PBR MkII
			{"vn_b_boat_12_01",						{-1,2,-1,-1}},
			{"vn_b_boat_12_02",						{-1,2,-1,-1}},
			{"vn_b_boat_12_03",						{-1,2,-1,-1}},
			{"vn_b_boat_12_04",						{-1,2,-1,-1}},
			{"vn_b_boat_13_01",						{-1,3,-1,-1}},
			{"vn_b_boat_13_02",						{-1,3,-1,-1}},
			{"vn_b_boat_13_03",						{-1,3,-1,-1}},
			{"vn_b_boat_13_04",						{-1,3,-1,-1}},
			//UH1D - Dustoff
			{"vn_b_air_uh1d_04_09",					{-1,1,-1,-1}},
			//UH1D gunship
			{"vn_b_air_uh1d_03_06",					{-1,4,-1,-1}},
			//UH1C slick
			{"vn_b_air_uh1b_01_01",					{-1,1,-1,-1}},
			{"vn_b_air_uh1b_01_02",					{-1,1,-1,-1}},
			{"vn_b_air_uh1b_01_03",					{-1,1,-1,-1}},
			{"vn_b_air_uh1b_01_04",					{-1,1,-1,-1}},
			{"vn_b_air_uh1b_01_05",					{-1,1,-1,-1}},
			{"vn_b_air_uh1b_01_06",					{-1,1,-1,-1}},
			{"vn_b_air_uh1b_01_09",					{-1,1,-1,-1}},
			{"vn_b_air_uh1f_01_03",					{-1,1,-1,-1}},
			{"vn_b_air_uh1e_03_04",					{-1,1,-1,-1}},
			//UH1C - Gunship
			{"vn_b_air_uh1b_02_05",					{-1,3,-1,-1}},
			//UH1E gunship
			{"vn_b_air_uh1e_01_04",					{-1,3,-1,-1}},
			{"vn_b_air_uh1e_02_04",					{-1,4,-1,-1}},
			// MiG-19
			{"vn_o_air_mig19_gun",					{4,-1,-1,-1}},
			{"vn_o_air_mig19_cap",					{4,-1,-1,-1}},
			{"vn_o_air_mig19_cas",					{5,-1,-1,-1}},
			{"vn_o_air_mig19_at",					{5,-1,-1,-1}},
			{"vn_o_air_mig19_mr",					{5,-1,-1,-1}},
			{"vn_o_air_mig19_bmb",					{5,-1,-1,-1}},
			{"vn_o_air_mig19_hbmb",					{6,-1,-1,-1}},
			//f100
			{"vn_b_air_f100d_cap",					{-1,3,-1,-1}},
			{"vn_b_air_f100d_cas",					{-1,4,-1,-1}},
			{"vn_b_air_f100d_hcas",					{-1,5,-1,-1}},
			{"vn_b_air_f100d_ehcas",					{-1,5,-1,-1}},
			{"vn_b_air_f100d_at",					{-1,4,-1,-1}},
			{"vn_b_air_f100d_mr",					{-1,3,-1,-1}},
			{"vn_b_air_f100d_cbu",					{-1,5,-1,-1}},
			{"vn_b_air_f100d_bmb",					{-1,5,-1,-1}},
			{"vn_b_air_f100d_lbmb",					{-1,4,-1,-1}},
			{"vn_b_air_f100d_mbmb",					{-1,6,-1,-1}},
			{"vn_b_air_f100d_hbmb",					{-1,6,-1,-1}},
			{"vn_b_air_f100d_sead",					{-1,6,-1,-1}},
			{"B_Heli_Attack_01_dynamicLoadout_F", 	{0, 0, 0, 0}},
			{"B_Heli_Light_01_dynamicLoadout_F", 	{0, 0, 0, 0}},
			//---
			/// 1.3 vehicles -- 
			//uh-1
			{"vn_i_air_uh1d_01_02",					{-1,0,1,-1}},
			{"vn_i_air_uh1d_02_02",					{-1,0,1,-1}},
			// CH-47 Chinook
			{"vn_b_air_ch47_01_01",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_02_01",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_03_01",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_04_01",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_01_02",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_02_02",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_03_02",					{-1,0,-1,-1}},
			{"vn_b_air_ch47_04_02",					{-1,0,-1,-1}},
			{"vn_b_air_ach47_01_01",				{-1,0,-1,-1}},
			{"vn_b_air_ach47_02_01",				{-1,0,-1,-1}},
			{"vn_b_air_ach47_03_01",				{-1,0,-1,-1}},
			{"vn_b_air_ach47_04_01",				{-1,0,-1,-1}},
			{"vn_b_air_ach47_05_01",				{-1,0,-1,-1}},
			{"vn_i_air_ch47_01_01",					{-1,0,-1,-1}},
			{"vn_i_air_ch47_02_01",					{-1,0,-1,-1}},
			{"vn_i_air_ch47_03_01",					{-1,0,-1,-1}},
			{"vn_i_air_ch47_04_01",					{-1,0,-1,-1}},
			// MiG-21
			{"vn_o_air_mig21_gun",					{0,-1,-1,-1}},
			{"vn_o_air_mig21_cap",					{0,-1,-1,-1}},
			{"vn_o_air_mig21_cas",					{0,-1,-1,-1}},
			{"vn_o_air_mig21_at",					{0,-1,-1,-1}},
			{"vn_o_air_mig21_mr",					{0,-1,-1,-1}},
			{"vn_o_air_mig21_bmb",					{0,-1,-1,-1}},
			{"vn_o_air_mig21_hbmb",					{0,-1,-1,-1}},

			// M48A3
			{"vn_b_armor_m48_01_01",				{-1,0,-1,-1}},
			{"vn_b_armor_m48_01_02",				{-1,0,-1,-1}},
			{"vn_b_armor_m67_01_01",				{-1,0,-1,-1}},
			{"vn_b_armor_m67_01_02",				{-1,0,-1,-1}},
			{"vn_i_armor_m48_01_01",				{-1,0,0,-1}},
			{"vn_i_armor_m67_01_01",				{-1,0,0,-1}},
			// BTR-50PK
			{"vn_o_armor_btr50pk_01",				{3,-1,-1,-1}},
			{"vn_o_armor_btr50pk_02",				{4,-1,-1,-1}},
			{"vn_o_armor_btr50pk_03",				{5,-1,-1,-1}},
			{"vn_o_armor_btr50pk_01_nva65",			{3,-1,-1,-1}},
			{"vn_o_armor_btr50pk_02_nva65",			{4,-1,-1,-1}},
			{"vn_o_armor_btr50pk_03_nva65",			{5,-1,-1,-1}},
			{"vn_o_armor_btr50pk_01_nvam",			{3,-1,-1,-1}},
			{"vn_o_armor_btr50pk_02_nvam",			{4,-1,-1,-1}},
			{"vn_o_armor_btr50pk_03_nvam",			{5,-1,-1,-1}},
			// M113A1
			{"vn_b_armor_m125_01",					{-1,0,-1,-1}},
			{"vn_b_armor_m132_01",					{-1,0,-1,-1}},
			{"vn_b_armor_m577_01",					{-1,0,-1,-1}},
			{"vn_b_armor_m577_02",					{-1,0,-1,-1}},
			{"vn_b_armor_m125_01_aus_army",			{-1,0,-1,-1}},
			{"vn_b_armor_m577_01_aus_army",			{-1,0,-1,-1}},
			{"vn_b_armor_m577_02_aus_army",			{-1,0,-1,-1}},
			{"vn_b_armor_m125_01_rok_army",			{-1,0,-1,-1}},
			{"vn_b_armor_m577_01_rok_army",			{-1,0,-1,-1}},
			{"vn_b_armor_m577_02_rok_army",			{-1,0,-1,-1}},
			{"vn_i_armor_m125_01",					{-1,0,6,-1}},
			{"vn_i_armor_m132_01",					{-1,0,5,-1}},
			{"vn_i_armor_m577_01",					{-1,0,0,-1}},
			{"vn_i_armor_m577_02",					{-1,0,0,-1}},
			{"vn_i_armor_m113_01_fank_71",			{-1,-1,1,-1}},
			{"vn_i_armor_m113_acav_01_fank_71",		{-1,-1,2,-1}},
			{"vn_i_armor_m113_acav_02_fank_71",		{-1,-1,3,-1}},
			{"vn_i_armor_m113_acav_03_fank_71",		{-1,-1,4,-1}},
			{"vn_i_armor_m113_acav_06_fank_71",		{-1,-1,5,-1}},
			{"vn_o_armor_m125_01",					{0,-1,-1,-1}},
			{"vn_o_armor_m577_01",					{0,-1,-1,-1}},
			{"vn_o_armor_m577_02",					{0,-1,-1,-1}},
			{"vn_o_armor_m113_01_kr",				{0,-1,-1,-1}},
			{"vn_o_armor_m113_acav_01_kr",			{0,-1,-1,-1}},
			{"vn_o_armor_m113_acav_02_kr",			{0,-1,-1,-1}},
			{"vn_o_armor_m113_acav_03_kr",			{0,-1,-1,-1}},
			{"vn_o_armor_m113_acav_06_kr",			{0,-1,-1,-1}},

			// T-54
			{"vn_o_armor_t54b_01_nva65",			{0,-1,-1,-1}},
			{"vn_o_armor_t54b_01",					{0,-1,-1,-1}},
			{"vn_o_armor_t54b_01_vcmf",				{0,-1,-1,-1}},
			{"vn_o_armor_ot54_01_nva65",			{0,-1,-1,-1}},
			{"vn_o_armor_ot54_01",					{0,-1,-1,-1}},
			{"vn_o_armor_ot54_01_vcmf",				{0,-1,-1,-1}},
			// KR
			{"vn_o_boat_01_00_kr",					{0,0,0,0}},
			{"vn_o_boat_01_01_kr",					{0,0,0,0}},
			{"vn_o_boat_01_02_kr",					{0,0,0,0}},
			{"vn_o_boat_01_03_kr",					{0,0,0,0}},
			{"vn_o_boat_01_04_kr",					{0,0,0,0}},
			{"vn_o_boat_02_00_kr",					{0,0,0,0}},
			{"vn_o_boat_02_01_kr",					{0,0,0,0}},
			{"vn_o_boat_02_02_kr",					{0,0,0,0}},
			{"vn_o_boat_02_03_kr",					{0,0,0,0}},
			{"vn_o_boat_02_04_kr",					{0,0,0,0}},
			{"vn_o_boat_01_mg_00_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_01_mg_01_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_01_mg_02_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_01_mg_03_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_01_mg_04_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_02_mg_00_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_02_mg_01_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_02_mg_02_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_02_mg_03_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_02_mg_04_kr",				{0,-1,-1,-1}},
			{"vn_o_boat_07_01_kr",					{0,-1,-1,-1}},
			{"vn_o_boat_07_02_kr",					{0,-1,-1,-1}},
			{"vn_o_boat_08_01_kr",					{0,-1,-1,-1}},
			{"vn_o_boat_08_02_kr",					{0,-1,-1,-1}},
			// FANK
			{"vn_i_boat_01_00_fank_70",				{0,0,0,0}},
			{"vn_i_boat_01_01_fank_70",				{0,0,0,0}},
			{"vn_i_boat_01_02_fank_70",				{0,0,0,0}},
			{"vn_i_boat_01_03_fank_70",				{0,0,0,0}},
			{"vn_i_boat_01_04_fank_70",				{0,0,0,0}},
			{"vn_i_boat_02_00_fank_70",				{0,0,0,0}},
			{"vn_i_boat_02_01_fank_70",				{0,0,0,0}},
			{"vn_i_boat_02_02_fank_70",				{0,0,0,0}},
			{"vn_i_boat_02_03_fank_70",				{0,0,0,0}},
			{"vn_i_boat_02_04_fank_70",				{0,0,0,0}},
			{"vn_i_boat_01_mg_00_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_01_mg_01_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_01_mg_02_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_01_mg_03_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_01_mg_04_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_02_mg_00_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_02_mg_01_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_02_mg_02_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_02_mg_03_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_02_mg_04_fank_70",			{-1,-1,2,-1}},
			{"vn_i_boat_12_01_fank_71",				{-1,-1,2,-1}},
			{"vn_i_boat_12_02_fank_71",				{-1,-1,2,-1}},
			{"vn_i_boat_12_03_fank_71",				{-1,-1,2,-1}},
			{"vn_i_boat_12_04_fank_71",				{-1,-1,2,-1}},
			// ZGU-1
			{"vn_o_nva_static_zgu1_01",				{0,-1,-1,-1}},
			{"vn_o_nva_65_static_zgu1_01",			{0,-1,-1,-1}},
			{"vn_o_nva_navy_static_zgu1_01",		{0,-1,-1,-1}},
			{"vn_o_vc_static_zgu1_01",				{0,-1,-1,-1}},
			{"vn_o_pl_static_zgu1_01",				{0,-1,-1,-1}},
			//M1910
			{"vn_o_nva_static_m1910_low_01",		{0,-1,-1,-1}},
			{"vn_o_nva_static_m1910_low_02",		{0,-1,-1,-1}},
			{"vn_o_nva_static_m1910_high_01",		{0,-1,-1,-1}},
			{"vn_o_nva_65_static_m1910_low_01",		{0,-1,-1,-1}},
			{"vn_o_nva_65_static_m1910_low_02",		{0,-1,-1,-1}},
			{"vn_o_nva_65_static_m1910_high_01",	{0,-1,-1,-1}},
			{"vn_o_nva_navy_static_m1910_low_01",	{0,-1,-1,-1}},
			{"vn_o_nva_navy_static_m1910_low_02",	{0,-1,-1,-1}},
			{"vn_o_nva_navy_static_m1910_high_01",	{0,-1,-1,-1}},
			{"vn_o_vc_static_m1910_low_01",			{0,-1,-1,-1}},
			{"vn_o_vc_static_m1910_low_02",			{0,-1,-1,-1}},
			{"vn_o_vc_static_m1910_high_01",		{0,-1,-1,-1}},
			//M2
			{"vn_b_army_static_m2_scoped_high",		{-1,0,-1,-1}},
			{"vn_b_army_static_m2_scoped_low",		{-1,0,-1,-1}},
			{"vn_b_sf_static_m2_scoped_high",		{-1,0,-1,-1}},
			{"vn_b_sf_static_m2_scoped_low",		{-1,0,-1,-1}},
		};
	};
};
