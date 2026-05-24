// Training-only teams. Included by mission/config/gamemode.hpp only on the mftraining map.

class Instructors
{
    name = "Instructors [Training Cadre]";
    icon = "training\taskroster\instructors_HL.paa";
    shortname = "Instructors";
    unit = "vn_b_men_army_01";
    color = "ColorYellow";
    colorRGBA[] = {0.95, 0.85, 0.2, 1};
    description = "MF_Training cadre and instructor support team.";
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
        loadCoef = -1;
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

    onJoin = "";
    onLeave = "";
};
