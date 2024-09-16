/*
    File: fn_sysmsg_print_others.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Send some random pre-defined helper message to all players over system chat.

        NOTE: I've disabled a bunch of these as I'm a bit suspicious that the large
        array passed to `selectRandom` might be slowing down the command when
        there's a lot of jobs executing on the server.

    Parameter(s): None

    Returns: nothing

    Example(s):
        Call vn_mf_fnc_sysmsg_print_others;
*/


private _other_messages = [
    "Events: We regularly host events and custom missions on multiple servers. See the events tab on discord: discord.gg/bro-nation",
    // --- wlus
    // "UDT: Before there were SEALs, there was UDT.",
    // "UDT: Pioneers in underwater demolition, closed-circuit diving, combat swimming, and midget submarine (dry and wet submersible) operations.",
    // "Tiger Force: The complete destruction of the enemy.",
    // "Tiger Force: Long Range Reconnaissance Patrol comprised of 45 Paratroopers from the 1st Battalion 327th Infantry Regiment of the 101st Airborne.",
    // "Marines: Footmobile, airborne and mechanized infantry, brown water surface warfare and spec ops.",
    // "Marines: Tribute to the US 1st Marine Division, being deployed under the same name in South Vietnam during the Vietnam war.",
    // "Military Police: Tribute unit for the 716th Military Police Battalion focusing on action in combat and in a garrison role.",
    // "Military Police: Like to help others? Want to save the day? Sign up today to the most active RP Unit on Bro Nations today!",
    // "NZ-SAS: New Zealand and Australian themed Small Unit Tactics (SUT) Offshoot of the SAS.",
    // "NZ-SAS: 1,200 patrols; 492 enemey confirmed killed; 11 prisoners captured. All for one KIA and one MIA.",
    // "Satan's Angels: Advanced air superiority squadron providing Close Air Support (CAS) and Air Superiority.",
    // "Muskets: Close Air Support (CAS) using a variety of attack helicopters, plus troop transportation, sling loading and logistics, aerial recon and wreck recovery.",
    // "ARVN Rangers: Light infantry unit, now grown into a bigger capable fighting force with different elements.",
    // "ARVN Rangers: The Vietnamese Rangers, commonly known as the ARVN Rangers, were the light infantry of the Army of the Republic of Vietnam.",
    // "Black Horse: We are the Blackhorse Troopers, the finest in the land, we fight for right and use our might to free our fellow man.",
    // "Black Horse: 11th Armored Cavalry Regiment is a multi-component combat brigade with a special emphasis on combat engineering, armored warfare, and firesupport.",
    // "633rd CSG: A tribute unit to the USAF unit of the same name stationed at Pleiku Airbase.",
    // "633rd CSG: Support functions with a focus on aviation support and logistics.",
    // "633rd CSG: We do what others don't want to do or are deemed dangerous.",
    // "7th Cav: Air cavalry based unit that focuses on rapid and mobile assaults, using Heuy's, Chinhooks, and Cayuse's with the occasional use of mechanized infantry.",
    // "7th Cav: We are the jack of all trades and Master of one, that being Air Assault.",
    // "7th Cav: We get called in to be the Spearhead of an assault or the Reinforcements for one.",
    // --- bn specific
    "Dac Cong: Been captured? Try to escape the tunnels and get rescued. Respawning is for cowards!",
    // "Dac Cong: Been captured? Escape and grab a shovel... You're going to need it.",
    "Dac Cong: Been captured? Only give them your name, rank and player UID.",
    "Dac Cong: OPFOR's jungle warefare experts. Grab a battle buddy and watch each other's back!",
    // "Dac Cong: 'Go home GI. You no welcome here. You invader. Stinky GI.'",
    "Dac Cong: Gia Lam and Dac Cong HQ are off limits, except when curators announce a special mission for Gia Lam, and only Gia Lam.",
    // "Dac Cong: Prepare for an emotionally difficult experience when Dac Cong are unleashed. WU-TANG!",
    "Dac Cong: Capture Dac Cong players to take them out of the game longer. Ask MP / WLU bros to interrogate them at the MP base!",
    "Fire Missions: Example of good map marking text for a CAS fire mission: CAS - WHISKEY - NAPALM - EAST/WEST.",
    "Fire Missions: Example of good map marking text for an Arty fire mission: ART - ECHO - WP - WTL.",
    "Fire Missions: Ultimate responsibility for go/no-go lies with the operator performing the fire mission.",
    "CAS: Whitelisted to specific WLUs (Whitelisted Units). No exceptions.",
    "CAS: Why CAS whitelisting? Because people were toxic in the past. Now the toys are locked away.",
    "CAS: Whitelisted to prevent toxic behaviour.",
    "CAS: With great power comes great responsibility... Which is why all CAS is whitelisted.",
    // "Charlie Brown: Anyone with *popular support* can step up and lead an AO (unless they have already done so in the last 24 hours).",
    // "Charlie Brown: Remember that everything should be a request, not an order, and we're all here to have fun.",
    // "Charlie Brown: It's only after you've stepped outside your comfort zone that you begin to change, grow, and transform.",
    // "Training: Bros with 06 and above in their name are Senior Instructor qualified. They can teach you about Mines and JTAC calls.",
    // "Training: Bros with 05 and above in their name are Instructor qualified. They can teach you about Patrolling, Combat Comms, Engineering and Parachuting.",
    "Training: Voluntary public training sessions are regularly hosted on discord: discord.gg/bro-nation",
    "Training: No training is required to play on the server(s), but some whitelisted units may require you complete trainings before you can join their ranks.",
    "WLUs: Whitelisted Units are groups of like-minded Bros that regularly play Arma together.",
    "WLUs: Join the discord if you want to apply to a Whitelisted Unit: discord.gg/bro-nation",
    "PID: Sorry goes a long way, especially if you just friendly fired a fellow bro!",
    "PID: Positively identify (PID) your targets. Check your map *before* you shoot!",
    // "Map: There is (usually) a legend somewhere on map explaining all the markings around the main base.",
    "Map: Please mark any mines you place on map in side channel. It's just the right thing to do.",
    "Map: Deleting important map markings without permission can be considered toxic/trolling behaviour.",
    // --- gamemode hints
    "Duty Officer: Get specialist roles like Engineer, Explosives or Medic by walking up to a duty officer and pressing the 6 key.",
    "Duty Officer: Switch between teams by walking up to a duty officer, pressing Alt + H and selecting from the top row of images.",
    "Key Binds: Change Mike Force specific key binds by pressing Esc and opening the GAMEMODE KEYBINDS menu (top left).",
    "Key Binds: Change your 'Throw Grenade' Keybind to double tap G (2xG) to avoid accidentally killing fellow Bros!",
    "Building: Press the N key to bring up the build menu. You will need the ACAV role from a Duty Officer.",
    "Building: (Step 1) Get shovel and sandbags (Step 2) place structure from build menu (N key) (Step 3) hit structure with shovel several times (Step 4) add sandbags with 6 key (Step 5) bask in combat engineer glory.",
    "Building: Supply your buildings with sandbags or supply crates. Use the 6 wheel menu to add the resources when looking at the structure.",
    "Building: Grab a machete and clear out some foliage so you can see Charlie coming.",
    // "Support Request: In the Alt + H menu you can create missions for Green Hornets to deliver critical supplies.",
    // "Support Request: In the Alt + H menu you can create missions for Spike Team to destroy an objective.",
    "Comms: Be clear, concise and confident.",
    "Comms: You can mute specific players. Open your Map and go to the 'Players' tab. Click the speaker icon next to their name to mute/unmute.",
    // "Comms: Side channel is text only, but everyone can see it. Perfect for fire mission requests.",
    // "Comms: Use the '.' key to switch between comms channels. Not everything needs to be said over Ground channel.",
    // "Comms: Use the '/' key to send a text message on a comms channel (press 'Enter' to send your text message).",
    "Comms: Direct channel for bros in your immediate vicinity. Vehicle channel when in a vehicle. Side channel for everyone (text only).",
    // "Comms: Mute/Unmute some channels by pressing Alt + H and clicking the icons in the top left of the window.",
    "Comms: Create isolated comms groups using the Dynamic Group menu ('U' key). Invite other Bros to join and communicate over the Group channel.",
    "Intel: Avoid calling Fire Missions or using Willie Pete on HQ/Factory sites until you've got the intel.",
    "Intel: The HQ/Factory sites have an intel document which can reveal other site locations.",
    "Intel: Scout for the exact location of HQ/Factory intel documents using the 6 wheel menu.",
    "Sites: To 'spike' supplies, shelters and statics at sites you'll need satchel/breaching charges.",
    "Sites: At Camp sites you need to destroy all supply crates and tent like shelters.",
    "Sites: At Arty sites you need to destroy all mortars and/or artillery installations.",
    "Sites: At AA sites you need to destroy the ZPU(s).",
    // "Sites: At Radar sites you need to destroy all the SA2 / Radar installations.",
    "Sites: At HQ sites you need to destroy all the supply crates.",
    "Sites: At Factory sites you need to destroy the large shipping container.",
    "Radio Tap: Radio sets at certain sites can be wire-tapped to reveal up to three other sites (need wiretap kit).",
    "Radio Tap: Wiretapping radio sets at sites can now reveal all AO sites. But the locations are less accurate than the intel.",
    "Camps: Watch out for traps at campsites ...",
    "Camps: Mine Detectors have a 15m detection radius while Trap Kits only have a 5m detection radius. Morale of the story: use Mine Detectors!",
    "Camps: Always remember to turn on your Mine Detector before you step off!"
    // --- misc
    // "Be a bro.",
    // "Be a bro, be like John the GI.",
    // "It is only a game.",
    // "When in doubt, apologize and move on with your life.",
    // "Never step off without your Mine Detector.",
    // "ACAV, best Cav.",
    // "Spike team, best team."
];

private _msg = format ["%1", selectRandom _other_messages];
// don't care about client order -- send and forget with rECall
[_msg] remoteExecCall ["systemChat", -2];

nil;