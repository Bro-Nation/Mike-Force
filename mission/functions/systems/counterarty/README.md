# FSB Counter-Battery

Enemy counter-artillery that answers player mortars and howitzers firing from inside a Fire Support Base (FSB).

## Behaviour

1. A player-crewed static mortar/howitzer fires inside an active FSB zone (`no_harass_bh_*` marker).
2. A session is created for that FSB and the gun position is recorded.
3. If no battery is alive and the respawn cooldown has expired, one enemy battery (D-44 + Type 63 mortar) spawns 2000-5000 m from the active AO center (marker `activeZoneCircle`), at least 2000 m from the FSB and 500 m from functional recon towers.
4. Every interval the battery fires at the latest recorded gun position. Spread starts at 1000 m and tightens by 100 m per volley to a 150 m minimum. Players within 300 m of the FSB get a chat warning.
5. Battery destroyed: volleys stop and that FSB waits the respawn cooldown before a new battery.
6. FSB removed (marker gone): battery, crew, session, counters and cooldown are deleted.
7. No player fire from the FSB for the timeout: the session ends and the battery is removed.

Each FSB has its own session and battery. Enemy guns are detectable by sound ranging.

## Timing

| Setting | Live | Test |
|---------|------|------|
| Volley interval | 180 s | 25 s |
| Respawn after destroy | 420 s | 45 s |
| Quiet timeout | 600 s | 120 s |
| Rounds per volley | 6 | 3 |

Enable test timing with `vn_mf_counterarty_test_mode = true; [] call vn_mf_fnc_counterarty_init;` on the server (debug console). Other values are set in `fn_counterarty_init.sqf`.

## Files

- `server/fn_counterarty_init.sqf` - config + tick job (called from `para_server_init.sqf`)
- `server/fn_counterarty_tick.sqf` - every 5 s: FSB removed, battery destroyed, timeout, due volleys
- `server/fn_counterarty_on_player_fire.sqf` - entry point, called from the soundranging Fired handler
- `server/fn_counterarty_start_session.sqf`, `spawn_battery`, `fire_volley`, `on_battery_destroyed`, `on_fsb_removed`, `end_session`
- `shared/fn_counterarty_get_fsb_for_pos.sqf`, `shared/fn_counterarty_get_session.sqf`

Sessions live in `vn_mf_counterarty_sessions` (HashMap: FSB id -> session HashMap with `battery`, `guns`, `spawn_ready`, `spread`, `next_volley`, `last_targets`, `last_fire_time`, `volleys_fired`, `active`).

## Limitations

- Only static weapons are detected as firing guns (the existing Fired handler is attached to `StaticWeapon`s).
- Not tested in game; artillery commands (`doArtilleryFire`, `inRangeOfArtillery`, `getArtilleryAmmo`) were not checked against the Bohemia wiki (inaccessible).
