/*
	File: fn_tasks_helpers_counterattack_defend_area_condition_check.sqf
	Author: @dijksterhuis
	Public: No

	Description:
		Check whether the players have failed the main task of holding the area.

		Failure occurs when there are no players in the red circle who are
			- alive
			- west/independent side
			- not in a helo or plance
			- not incapacitated

		Otherwise, if 30 or 40 minutes have passed (depending on whether flag
		was built) the task has been successful.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns:
		String of the current task status -- SUCCESS, FAILED or ACTIVE

	Example(s):
		[_tds] call vn_mf_fnc_tasks_helpers_counterattack_defend_area_condition_check;
*/
params ["_tds"];

private _attackPos = _tds getVariable "attackPos";
private _areaSize = _tds getVariable "attackAreaSize";
private _areaDescriptor = [_attackPos, _areaSize select 0, _areaSize select 1, 0, false];
private _enemyZoneHeldTime = _tds getVariable "enemyZoneHeldTime";
private _lastCheck = _tds getVariable "lastCheck";

//Side check - downed players don't count. Nor do players in aircraft. Ground vehicles are fair game.
private _alivePlayersInZone = allPlayers inAreaArray _areaDescriptor
	select {
		alive _x
		&& {
			(side _x == west || side _x == independent)
		&& {
			!(vehicle _x isKindOf "Air")
		&& {
			!(_x getVariable ["vn_revive_incapacitated", false])
		}
		}
		};
	};

//Enemy hold the zone if no living players.
private _enemyHoldZone = count _alivePlayersInZone == 0;

if (_enemyHoldZone) then {
	//Adding the interval between checks will be close enough to work.
	//We will lose or gain a few seconds but will even out in the long run.
	//Interval is approx 5 +/- 2 seconds from my testing.
	_tds setVariable ["enemyZoneHeldTime", _enemyZoneHeldTime + (serverTime - _lastCheck)];
	_tds setVariable ["lastCheck", serverTime];
} else {
	_tds setVariable ["enemyZoneHeldTime", 0];
	_tds setVariable ["lastCheck", serverTime];
};

private _startTime = _tds getVariable "startTime";
private _endTime = _startTime + (_tds getVariable "holdDuration");

//Zone has been held long enough, or they've killed enough attackers for the
// AI objective to complete.

private _allAttackObjectivesAreNull = (
	count ((_tds getVariable "attackObjectives") select {isNull _x})
		isEqualTo (count (_tds getVariable "attackObjectives"))
);

if (serverTime > _endTime || _allAttackObjectivesAreNull) exitWith {
	_tds setVariable ["enemyZoneHeldTime", 0];
	_tds setVariable ["lastCheck", 0];
	"SUCCESS";
};

//Enemy hold the zone for X seconds, we've failed
if (_enemyHoldZone && {_enemyZoneHeldTime > (_tds getVariable ["failureDuration", 5 * 60])}) exitWith {
	_tds setVariable ["enemyZoneHeldTime", 0];
	_tds setVariable ["lastCheck", 0];
	"FAILED";
};

// still going and been at least 10 minutes since we last pinged players about remaining duration
if (
	_endTime > serverTime
	&& {serverTime - (10 * 60) > (_tds getVariable ["attackLastNotification", _startTime])}
) then {
	_tds setVariable ["attackLastNotification", serverTime];
	[_endTime - serverTime] call vn_mf_fnc_tasks_helpers_counterattack_notify_attack_time;
};

"ACTIVE";