// AI INFANTRY HUNTER /////////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny.
	- Revised by Drgn V4karian.
	- File to spawn a group of infantry that functions as hunter AI. Once in range of _radius they
	  will start to move in on the closest target aggressively.
	- It is important to note that the player proximity check for spawning will only occur if spawn tickets
	  are set to a higher number than 1.

	- USAGE:
		1) Spawn Position.
		2) Group Type [OPTIONAL] ("squad", "team", "sentry","atTeam","aaTeam", "mgTeam" or number of soldiers.) (default: "TEAM")
		3) Hunting Radius [OPTIONAL] (default: 500)
		4) Spawn Tickets [OPTIONAL] (default: 1)

	- EXAMPLE: 0 = [this,"TEAM",500,1] spawn lmf_ai_fnc_infantryHunter;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_radius", 500],["_tickets", 1]];
_spawnPos = _spawnPos call CBA_fnc_getPos;
private _range = 500;


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _initTickets = _tickets;

while {_initTickets > 0} do {

	//CHECK AIR PROXIMITY
	if ([_spawnPos,_range] call _proximityChecker isEqualTo "airClose") then {
		//IF TOO CLOSE, WAIT UNTIL IT'S FINE, OR UNTIL GROUND PROXIMITY BREAKS
		waitUntil {sleep 5; [_spawnPos,_range] call _proximityChecker isEqualTo "airDistance" || {[_spawnPos,_range] call _proximityChecker isEqualTo "groundClose"}};
	};
	//EXIT IF GROUND PROXIMITY LIMIT HAS BEEN BROKEN
	if ([_spawnPos,_range] call _proximityChecker isEqualTo "groundClose") exitWith {};

	//SPAWN GROUP + SETTINGS
	private _type = [_grptype] call _typeMaker;
	private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;

	_grp setVariable ["lambs_danger_dangerAI","disabled"];
	{_x setVariable ["lambs_danger_disableAI",true]} count units _grp;
	{_x disableAI "AUTOCOMBAT"} count units _grp;
	_grp enableAttack false;
	_grp allowFleeing 0;

	0 = [_grp,_radius] spawn lmf_ai_fnc_taskHunt;

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL EVERYONE DEAD OR GROUND PROXIMITY HAS BEEN BROKEN
		waitUntil {sleep 5; {alive _x} count units _grp < 1 || {[_spawnPos,_range] call _proximityChecker isEqualTo "groundClose"}};
	};

	//SUBTRACT TICKET
	_initTickets = _initTickets - 1;
};