// AI INFANTRY GARRISON  //////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny.
	- Revised by Drgn V4karian.
	- File to spawn a group of infantry that garrisons. The group will ungarrison/regarrison
	  depending on their combat status and their distance to the closest enemy.

	- USAGE:
		1) Spawn Position.
		2) Group Type [OPTIONAL] ("squad", "team", "sentry","atTeam","aaTeam", "mgTeam" or number of soldiers.) (default: "TEAM")
		3) Garrison Radius. [OPTIONAL] (number) (default: 100)
		4) Distribution [OPTIONAL] (0 = fill evenly, 1 = building by building) (default: 1)

	- EXAMPLE: 0 = [this,"TEAM",100,1] spawn lmf_ai_fnc_garrison;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_garrisonRadius", 100],["_distribution", 1]];
_spawnPos = _spawnPos call CBA_fnc_getPos;


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _type = [_grptype] call _typeMaker;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;


// GARRISON THEM //////////////////////////////////////////////////////////////////////////////////
//APPLY GARRISON AND SELECT RANDOM STANCE
[_spawnPos, nil, units _grp, _garrisonRadius, _distribution, selectRandom [true,false], true] call ace_ai_fnc_garrison;
{_x setUnitPos selectRandom ["UP","UP","MIDDLE"];} count units _grp;

//WAIT UNTIL THEY ARE IN COMBAT AND THEN CHANGE THEIR STANCE
waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1}};
if ({alive _x} count units _grp < 1) exitWith {};

{_x setUnitPos "UP";} count units _grp;

sleep 5 + random 10;

{
	if (typeOf _x == _Autorifleman || {typeOf _x == _MMG_Gunner}) then {
		_x setUnitPos "UP";
	} else {
	_x setUnitPos "AUTO";
	};
} count units _grp;

//MAKE THEM UNGARRISON AND REGARRISON DEPENDING ON PLAYER DISTANCE
while {count units _grp > 1} do {
	waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1}};
	if ({alive _x} count units _grp < 1) exitWith {};
	private _nearEnemy = (leader _grp) findNearestEnemy (leader _grp);
	private _range = 25 + random 25;

	sleep 30;

	if (!isNull _nearEnemy && {_nearEnemy distance (leader _grp) < _range}) then {
		{_x disableAI "AUTOCOMBAT";} count units _grp;
		_grp setBehaviour "AWARE";
		[units _grp] call ace_ai_fnc_unGarrison;
		sleep 5;
		if ({alive _x} count units _grp > 1) then {
			[_spawnPos, nil, units _grp, _garrisonRadius, _distribution, selectRandom [true,false], false] call ace_ai_fnc_garrison;
			sleep 55;
			{_x enableAI "AUTOCOMBAT";} count units _grp;
			_grp setBehaviour "AWARE";
		};
	};
};