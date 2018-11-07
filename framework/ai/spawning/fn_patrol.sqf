// AI INFANTRY PATROL  ////////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny.
	- Revised by Drgn V4karian.
	- File to spawn a group of infantry that peforms a patrol task. Once it gets into combat,
	  it will move in to attack threats.

	- USAGE:
		1) Spawn Position.
		2) Group Type [OPTIONAL] ("squad", "team", "sentry","atTeam","aaTeam" or number of soldiers) (default: "TEAM")
		3) Patrol Radius. [OPTIONAL] (default: 200)

	- EXAMPLE: 0 = [this,"TEAM",200] spawn lmf_ai_fnc_patrol;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_patrolRadius", 200]];
_spawnPos = _spawnPos call CBA_fnc_getPos;
private _patrolTarget = _spawnPos;


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _type = [_grptype] call _typeMaker;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;


// GIVE THEM ORDERS ///////////////////////////////////////////////////////////////////////////////
[_grp, _patrolTarget, _patrolRadius, 4, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [10,20,30]] call CBA_fnc_taskPatrol;

waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1}};

if ({alive _x} count units _grp < 1) exitWith {};
0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
sleep 5;
0 = [_grp] spawn lmf_ai_fnc_taskAssault;