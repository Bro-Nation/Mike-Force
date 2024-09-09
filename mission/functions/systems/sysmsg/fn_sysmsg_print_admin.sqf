/*
    File: fn_sysmsg_print_admin.sqf
    Author: 'DJ' Dijksterhuis
    Public: No

    Description:
        Send some random pre-defined message to all players over system chat.

        These are all admin specific messages like server rules etc.

    Parameter(s): None

    Returns: nothing

    Example(s):
        call vn_mf_fnc_sysmsg_print_admin;
*/


private _admin_messages = [
    "Servers: We usually have a selection of custom Mike Force servers. Past missions: 1986 Cold War; WW2; Star Wars; Halo; Warhammer 40k. discord.gg/bro-nation",
    "Server Restarts: Every 6 hours: 00:00, 06:00, 12:00, 18:00 EST.",
    "Server Rule 1: Trolling will not be tolerated.",
    "Server Rule 2: Use communication channels appropriately.",
    "Server Rule 3: Missions are to be handled one AO at a time unless otherwise directed.",
    "Server Rule 4: All fire mission requests must be marked appropriately.",
    "Ban Policy: Appeal bans in the discord (ban-appeals channel): discord.gg/bro-nation",
    "Bug / Player / Server Reports: Handled over in the discord: discord.gg/bro-nation"
];

private _msg = format ["%1", selectRandom _admin_messages];
// don't care about client order -- send and forget with rECall
[_msg] remoteExecCall ["systemChat", -2];
