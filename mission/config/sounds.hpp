class CfgSounds
{
	sounds[] = {};
	class vn_build_1
	{
		sound[]		= { "@vn\sounds_f_vietnam\sfx\vn_build_1.ogg",1.0,1.0,30 };
		titles[]	= { "vn_build_1" };
	};
	class vn_build_2
	{
		sound[]		= { "@vn\sounds_f_vietnam\sfx\vn_build_2.ogg",1.0,1.0,30 };
		titles[]	= { "vn_build_2"};
	};
	class vn_build_3
	{
		sound[]		= { "@vn\sounds_f_vietnam\sfx\vn_build_3.ogg",1.0,1.0,30 };
		titles[]	= { "vn_build_3" };
	};
	class Siren
	{
		sound[] = { "custom\sounds\Siren.ogg", 1, 1, 100 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "*MP Siren Blares*" };			// subtitles
	};
	class DacWhistle
	{
		sound[] = { "custom\sounds\whistle.ogg", 1, 1, 100 };	// file, volume, pitch, maxDistance
		titles[] = { 0, "*Dac Cong Whistle Blows*" };			// subtitles
	}
};
