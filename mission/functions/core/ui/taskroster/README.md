# task roster ui scripts

Various scripts used by the task roster to load display pages etc.

The scripts for each display are contained in each of the directories here.

The `fn_tr_init.sqf`, `fn_tr_overview_team_update.sqf` and `fn_enable_task_roster.sqf`
are not called within the task roster itself, and so are left here in this folder
(they are 'global' scripts).

If you add new helper scripts that are used by multiple display pages (e.g. 
`teamInfo` and `playerInfo`) then please put the scripts in the "top level" task
roster directory (i.e. in this folder where the README file is). This highlights that
the functions are called in multiple locations and people should pay attention when
editing them ;)