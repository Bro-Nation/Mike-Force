// limits and vanilla/custom trait values

/*

// this is used in A LOT of places as a look up. Choose the name wisely.
class TeamName
{
    // long display name in the UI
    name = "Mike Force [Infantry]";

    // Picture shown in the UI
    icon = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_MikeForce_HL.paa";

    // short display name in the UI
    shortname = "Mike Force";

    // default unit players load in with
    unit = "vn_b_men_army_01";

    // color shown as on map
    color = "ColorBlue";

    // RGBA values for color... not sure where this is used.
    colorRGBA[] = {0, 0, 1, 1};

    // description text shown in the UI
    description = "Sweep and clear areas; assault objectives and defend friendly positions.";

    // how many players can take these roles at a duty officer
    class rolelimits
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 10;
        vn_artillery = 0;
    };

    // default traits that get assigned to the player when switching to this team
    // for information on base game traits, see here:
    // https://community.bistudio.com/wiki/setUnitTrait
    class defaultTraits
    {
        // A lower value means the unit is harder to spot by AI
        camouflageCoef = 0.8;

        // A lower value means the unit is harder to hear by AI
        audibleCoef = 0.6;

        // Equipment weight multiplier affecting fatigue and stamina
        // The higher the value for the loadCoef the less stamina a unit has.
        // Negative values will dramatically increase the stamina actually to
        // a point where it extends the stamina bar.
        loadCoef = 1;

        // Ability to partially repair vehicles with toolkit
        // Can also use the paradigm building system
        engineer = false;

        // Ability to defuse mines with toolkit
        explosiveSpecialist = false;

        // Ability to treat self and others with medikit
        // Can also withstand without any firstaid kits
        medic = false;

        // Ability to hack enemy and frendly drones
        // not used in Mike Force, but required for scripting purposes
        UAVHacker = false;

        // can use the SOG PF artillery/air support module.
        // We've diabled this in bro nation as it causes gameplay issues.
        // do not enable for anyone
        vn_artillery = false;

        // whether tracker teams should be sent out to harass these players
        harassable = true;

        // can use the scout feature to find sites in base Mike Force
        // for bro-nation, can use the scout function to find the intel at
        // HQ/Factory sites
        // site scouting is ignored for bro-nation, as the feature is over
        // powered.
        scout = true;

        // can use the scout feature to find multiple sites in base Mike Force
        // ignored for bro-nation, the scout feature is over powered.
        scoutMultiple = true;

        // players can building objects via paradigm build system in 3 hits
        // instead of 5.
        // players can destroy objects via paradigm build system in 3 hits
        // instead of 5.
        increasedBuildRate = false;
    };

    //Function Calls on team Join.
    // not used.
    onJoin = "";
    onLeave = "";
};
*/


#define SIDE_WEST "west"
#define SIDE_EAST "east"
#define IS_WLU 1
#define NOT_WLU 0


class MikeForce
{
    name = "Mike Force [Infantry]";
    icon = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_MikeForce_HL.paa";
    shortname = "Mike Force";
    unit = "vn_b_men_army_01";
    color = "ColorBlue";
    colorRGBA[] = {0, 0, 1, 1};
    description = "Sweep and clear areas; assault objectives and defend friendly positions.";
    side = SIDE_WEST;
    wlu = NOT_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 10;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = false;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = true;
        increasedBuildRate = false;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class SpikeTeam
{
    name = "Spike Team [Special Forces]";
    icon = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_SpikeTeam_HL.paa";
    shortname = "Spike Team";
    unit = "vn_b_men_army_01";
    color = "ColorUNKNOWN";
    colorRGBA[] = {0.7,0.6,0,1};
    description = "Reconnaissance; ambushing and assaulting objectives.";
    side = SIDE_WEST;
    wlu = NOT_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 0;
        explosiveSpecialist = 20;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0.3;
        loadCoef = 0.5;
        engineer = false;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = false;
        scout = true;
        scout_multiple = true;
        increasedBuildRate = false;
        canAttachChemlights = true;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class ACAV
{
    name = "Armored Cavalry [Ground Support]";
    icon = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_ACAV_HL.paa";
    shortname = "ACAV";
    unit = "vn_b_men_army_01";
    color = "ColorOrange";
    colorRGBA[] = {0.85, 0.4, 0, 1};
    description = "Combat engineering, artillery fire support and armour support.";
    side = SIDE_WEST;
    wlu = NOT_WLU;

    class rolelimits 
    {
        medic = 20;
        engineer = 40;
        explosiveSpecialist = 10;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = false;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class GreenHornets
{
    name = "Green Hornets [Air Support]";
    icon = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_Hornets_HL.paa";
    shortname = "Green Hornets";
    unit = "vn_b_men_army_01";
    color = "ColorIndependent";
    colorRGBA[] = {0, 1, 0, 1};
    description = "Helicopter based troop transport, resupply and reconnaissance.";
    side = SIDE_WEST;
    wlu = NOT_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 0;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = false;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = false;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class 3rdMEU
{
    name = "31st MEU [31st MEU]";
    icon = "custom\taskroster\31st_logo_meu_HL.paa";
    shortname = "31st MEU";
    unit = "vn_b_men_army_01";
    color = "ColorBlue";
    colorRGBA[] = {0, 0.3, 0.6, 1};
    description = "Forged in the crucible of history and honed through decades of service, the 31st MEU stands as a symbol of unwavering dedication and prowess in the world of military operations.";
    side = SIDE_WEST;
    wlu = IS_WLU;

    class rolelimits 
    {
        medic = 10;
        engineer = 40;
        explosiveSpecialist = 10;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = true;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class MilitaryPolice
{
    name = "Military Police [716th MP]";
    icon = "custom\taskroster\militarypolice_HL.paa";
    shortname = "Military Police";
    unit = "vn_b_men_army_01";
    color = "ColorBlue";
    colorRGBA[] = {0, 0, 1, 1};
    description = "We are a tribute unit for the 716th Military Police Battalion (Saigon Warriors) that focus on Military Police action in combat and in a garrison role.";
    side = SIDE_WEST;
    wlu = IS_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 20;
        explosiveSpecialist = 20;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = false;
        explosiveSpecialist = false;
        medic = true;
        UAVHacker = false;
        vn_artillery = true;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class QuarterHorse
{
    name = "Black Horse [11th ACR]";
    icon = "custom\taskroster\blackhorse_HL.paa";
    shortname = "Black Horse";
    unit = "vn_b_men_army_01";
    color = "ColorOrange";
    colorRGBA[] = {0.85, 0.4, 0, 1};
    description = "11th ACR is a multi-component combat brigade with a special emphasis on combat engineering, armored warfare, and firesupport.";
    side = SIDE_WEST;
    wlu = IS_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class Frogmen
{
    name = "Frogmen [UDT]";
    icon = "custom\taskroster\frogmen_HL.paa";
    shortname = "Frogmen";
    unit = "vn_b_men_army_01";
    color = "ColorOrange";
    colorRGBA[] = {0.85, 0.4, 0, 1};
    description = "UDT is a USN based spike team. Before there were SEALs, there was UDT.";
    side = SIDE_WEST;
    wlu = IS_WLU;

    class rolelimits 
    {
        medic = 20;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0.3;
        loadCoef = 0.5;
        engineer = true;
        explosiveSpecialist = true;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = true;
        scout_multiple = true;
        increasedBuildRate = true;
        canAttachChemlights = true;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class Muskets
{
    name = "Muskets [176th Gunships]";
    icon = "custom\taskroster\muskets_HL.paa";
    shortname = "Muskets";
    unit = "vn_b_men_army_01";
    color = "ColorIndependent";
    colorRGBA[] = {0, 1, 0, 1};
    description = "The 176th Assault Helicopter Company, 3rd Gunship Platoon, also known as the 'Muskets' is a Close Air Support (CAS) unit that provides air support using a variety of attack helicopters.";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 20;
        engineer = 20;
        explosiveSpecialist = 0;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = false;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class SatansAngels
{
    name = "Satans Angels [433rd TFS]";
    icon = "custom\taskroster\satansangels_HL.paa";
    shortname = "Satans Angels";
    unit = "vn_b_men_army_01";
    color = "ColorIndependent";
    colorRGBA[] = {0, 1, 0, 1};
    description = "An advanced air superiority squadron providing close air support and air superiority.";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 20;
        engineer = 20;
        explosiveSpecialist = 20;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = false;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class 633rdCSG
{
    name = "Crossbow [633rd CSG]";
    icon = "custom\taskroster\633rdcombatsupportgroup_HL.paa";
    shortname = "Crossbow";
    unit = "vn_b_men_army_01";
    color = "ColorBlue";
    colorRGBA[] = {0, 1, 0, 1};
    description = "Support functions with a focus on aviation support and logistics. We do what others don't want to do or are deemed dangerous.";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 30;
        engineer = 60;
        explosiveSpecialist = 30;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class 7thCAV
{
    name = "Garryowen [7th CAV]";
    icon = "custom\taskroster\7thcav_HL.paa";
    shortname = "Garryowen";
    unit = "vn_b_men_army_01";
    color = "ColorOrange";
    colorRGBA[] = {0.85, 0.4, 0, 1};
    description = "The 7th Cavalry Regiment is an air cavalry based unit that focuses on rapid and mobile assaults.";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 30;
        engineer = 60;
        explosiveSpecialist = 30;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = true;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class TigerForce
{
    name = "Tiger Force [Recon]";
    icon = "custom\taskroster\tigerforce_HL.paa";
    shortname = "Tiger Force";
    unit = "vn_b_men_army_01";
    color = "ColorUNKNOWN";
    colorRGBA[] = {0.7,0.6,0,1};
    description = "Tiger Force is a Long Range Reconnaissance Patrol comprised of 45 Paratroopers from the 1st Battalion 327th Infantry Regiment of the 101st Airborne.";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 15;
        engineer = 20;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0.3;
        loadCoef = 0.5;
        engineer = true;
        explosiveSpecialist = true;
        medic = true;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = true;
        scout_multiple = true;
        increasedBuildRate = true;
        canAttachChemlights = true;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class SASR
{
    name = "ANZAC";
    icon = "custom\taskroster\BN_ANZAC_HL.paa";
    shortname = "ANZAC";
    unit = "vn_b_men_army_01";
    color = "ColorUNKNOWN";
    colorRGBA[] = {0.7,0.6,0,1};
    description = "Bro-Nation ANZAC - 1st Australian Task Force is a ground infantry unit. The unit consist of two elements, the ANZAC Mike Force (inspired by 1RAR) and the ANZAC Spike Team (inspired by SASR and NZSAS).";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 20;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0.3;
        loadCoef = 0.5;
        engineer = true;
        explosiveSpecialist = true;
        medic = true;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = true;
        scout_multiple = true;
        increasedBuildRate = true;
        canAttachChemlights = true;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class ARVN
{
    name = "Army of the Republic of Vietnam";
    icon = "custom\taskroster\ARVN_HL.paa";
    shortname = "ARVNR";
    unit = "vn_b_men_army_01";
    color = "ColorUNKNOWN";
    colorRGBA[] = {0.7,0.6,0,1};
    description = "A light infantry unit with different elements: recon team; armored corps and traditional infantry.";
    side = SIDE_WEST;
    wlu = IS_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };

    class defaultTraits
    {
        camouflageCoef = 0.8;
        audibleCoef = 0.6;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = true;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = true;
        scout = true;
        scout_multiple = true;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class MACV
{
    name = "MACV [Command]";
    icon = "custom\taskroster\macv_HL.paa";
    shortname = "MACV";
    unit = "vn_b_men_army_01";
    color = "ColorYellow";
    colorRGBA[] = {0.85, 0.85, 0, 1};
    description = "Military Assistance Command, Vietnam.";
    side = SIDE_WEST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = true;
        medic = true;
        UAVHacker = true;
        vn_artillery = false;
        harassable = false;
        scout = true;
        increasedBuildRate = true;
        canAttachChemlights = true;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class DacCong
{
    name = "Dac Cong [Commandos]";
    icon = "custom\taskroster\daccong_team.paa";
    shortname = "Dac Cong";
    unit = "vn_b_men_army_01";
    color = "ColorOPFOR";
    colorRGBA[] = {1, 0, 0, 1};
    side = SIDE_EAST;
    wlu = IS_WLU;
    
    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0;
        loadCoef = 1;
        engineer = true;
        explosiveSpecialist = true;
        medic = true;
        UAVHacker = false;
        vn_artillery = false;
        harassable = false;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = true;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};

class PressCorp
{
    name = "Press Corp [DASPO]";
    icon = "custom\taskroster\presscorp_HL.paa";
    shortname = "Press Corp";
    unit = "C_journalist_F";
    color = "ColorCIV";
    colorRGBA[] = {0.4, 0, 0.5, 1};
    description = "The Department of the Army Special Photographic Office was a unit of the United States Department of the Army from 1962 to 1974.";
    side = SIDE_WEST;
    wlu = IS_WLU;

    class rolelimits 
    {
        medic = 40;
        engineer = 40;
        explosiveSpecialist = 40;
        vn_artillery = 0;
    };
    
    class defaultTraits
    {
        camouflageCoef = 1;
        audibleCoef = 0;
        loadCoef = 1;
        engineer = false;
        explosiveSpecialist = false;
        medic = false;
        UAVHacker = false;
        vn_artillery = false;
        harassable = false;
        scout = false;
        increasedBuildRate = true;
        canAttachChemlights = false;
    };

    //Function Calls on team Join
    onJoin = "";
    onLeave = "";
};
