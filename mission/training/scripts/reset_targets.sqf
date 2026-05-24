/*-------
Makes targets pop up at the user's command. Targets go down after being hit,
and return back with user action. Because swivel targets have a different
script assigned to them that works differently from all other targets, 
they are handled separately in the script. If you don't plan
to use swivel targets at all, feel free to delete the corresponding part
of the code.
-------*/

params [["_dist",1100,[1]],["_center",player,[objNull]]];					//in params
private _targets = nearestObjects [position _center, ["TargetBase"], _dist];	//take all nearby practice targets
if (count _targets < 1) exitWith {
	systemChat "No compatible targets were found.";						//exit if no targets have been found
};
{_x animate ["Terc",0];} forEach _targets;							//get all targets to upright pos

//systemChat "Killhouse has been reset."; // shows trigger message (remove // behind systemChat to see the text ingame)
// setup popup targets with: this execVM "training\scripts\setup_popup_target.sqf";
// setup reset/cleanup console with: this execVM "training\scripts\setup_target_control_console.sqf";