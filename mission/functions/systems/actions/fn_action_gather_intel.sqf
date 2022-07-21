[
	player,		// Object the action is attached to
	"Gather Enemy Intel",		// Title of the action
	"custom\holdactions\holdAction_documents_ca.paa",	// Idle icon shown on screen
	"custom\holdactions\holdAction_documents_ca.paa",	// Progress icon shown on screen
	"(typeOf cursorTarget in ['Land_Map_unfolded_F','Land_Map_unfolded_Malden_F'] && player distance cursorTarget < 5)",	// Condition for the action to be shown
	"player distance cursorTarget < 10",						// Condition for the action to progress
	{},	// Code executed when action starts
	{},	// Code executed on every progress tick
	{
		deleteVehicle cursorTarget;
	},// Code executed on completion
	{},	// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration [s]
	100,													// Priority
	false,											// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
