// AI INFANTRY GARRISON  //////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny.
	- Revised by Drgn V4karian.
	- Spawns a group of infantry that garrisons buildings.

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
_grp setFormation "DIAMOND";

// GARRISON ///////////////////////////////////////////////////////////////////////////////////////
[_spawnPos, nil, units _grp, _garrisonRadius, _distribution, true, true] call ace_ai_fnc_garrison;

//UNGARRISON SINGLE UNIT WHEN HIT
{
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
		if (alive _unit) then {
			[[_unit]] call ace_ai_fnc_unGarrison;
			//if (_unit knowsAbout _instigator > 1 && {(_unit distance _instigator) < (25 + (random 75))}) then {_unit doMove (getPosATL _instigator);};
		};
		_unit removeEventHandler ["Hit", _thisEventHandler];
	}];
} forEach (units _grp);

//UNGARRISON SINGLE UNIT BASED ON NEARBY ENEMY FIRE, ITS OWN FIRE, OR NEARBY FRIENDLY FIRE
{
	_x addEventHandler ["FiredNear", {
	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

	if (alive _unit) then {
		//NEARBY ENEMY FIRE
		if (side _firer != var_enemySide) then {
			if (50 > random 100) then {
				[[_unit]] call ace_ai_fnc_unGarrison;
				if (_unit knowsAbout _firer > 1) then {_unit doMove (getPosATL _firer);};
			};
		};
		//OWN FIRE
		if (_firer == _unit) then {
			if (50 > random 100) then {
				[[_unit]] call ace_ai_fnc_unGarrison;
			};
		};
		//NEARBY FRIENDLY FIRE
		if (_firer != _unit && {side _firer == var_enemySide}) then {
			if (20 > random 100) then {
				[[_unit]] call ace_ai_fnc_unGarrison;
				_unit doMove (getPosATL _firer);
			};
		};
	};
	_unit removeEventHandler ["FiredNear", _thisEventHandler];
	}];
} forEach (units _grp);