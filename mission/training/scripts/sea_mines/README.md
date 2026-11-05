# Independent training sea mine spawner

Copy this sea_mines folder into the mission's training/scripts folder.

In Eden:

1. Place empty markers over water named training_sea_mines_0, training_sea_mines_1, and so on. Marker size and direction are ignored.
2. Place a separate information stand or other control object.
3. Put this in its init field:

```sqf
this execVM "training\scripts\sea_mines\setup_training_sea_mines_console.sqf";
```

Instructors within 5 metres get two actions: SPAWN OR REPLACE SEA MINES and CLEAR TRAINING SEA MINES.

Spawn/replace deletes the previous mine-only set, then creates one UnderwaterMine at each marker's exact map position, with no random spread. Add one marker for every mine you want. Mines sit 2 metres below sea level, raised if necessary to keep 0.5 metres above the seabed. Land markers and water shallower than 1.5 metres are skipped and logged in the server RPT. Marker height is ignored.

The scripts track only their own mines. They do not spawn, delete, or modify water supplies or mines from other systems. Mines do not automatically respawn. The depth is editable using _depthBelowSurface near the top of spawn_or_replace_training_sea_mines.sqf.

Uses the same BIS_fnc_call remote execution pattern as the existing water supply console. The mission must permit that remote execution. Action visibility follows the instructor team restriction; this is not a server-side authorization boundary.

Prepared for this Mike Force mission; requires an in-game multiplayer check for action visibility, underwater placement, detonation, replace, and clear behavior.
