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
_grp setGroupIDGlobal [format ["Infantry Garrison: %1 (%2)",_grpType, groupId _grp]];
_grp setFormation "DIAMOND";
_grp enableIRLasers false;
_grp enableGunLights "ForceOff";

// GARRISON ///////////////////////////////////////////////////////////////////////////////////////
[_spawnPos, nil, units _grp, _garrisonRadius, _distribution, true, true] call ace_ai_fnc_garrison;

//CHECK IF UNIT IS IN HOUSE (function by Killzone Kid, slight tweak by Alex2k)
KK_fnc_inHouse = {
	lineIntersectsSurfaces [
		getPosWorld _this, 
		getPosWorld _this vectorAdd [0, 0, 50], 
		_this, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if (isNil "_house") exitWith {false};
	if (_house isKindOf "House") exitWith {true};
	false
};
{
	if (!(_x call KK_fnc_inHouse) && {getPosATL _x select 2 > 3} ) then {_x setUnitPos "DOWN";};	
} forEach (units _grp);

// UNGARRISON SINGLE UNIT WHEN HIT
lmf_ungarrisonHit = {
	params ["_unit","_instigator"];
	if (alive _unit) then {
		_unit setUnitPos "AUTO";
		[[_unit]] call ace_ai_fnc_unGarrison;
	};
};

// ADD EVENTHANDLER
{
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
		[_unit,_instigator] call lmf_ungarrisonHit;
		_unit removeEventHandler ["Hit", _thisEventHandler];
	}];
} forEach (units _grp);

// UNGARRISON SINGLE UNIT BASED ON NEARBY ENEMY FIRE, ITS OWN FIRE, OR NEARBY FRIENDLY FIRE
lmf_ungarrisonFiredNear = {
	params ["_unit", "_firer"];
	if (alive _unit) then {
		_unit setUnitPos "AUTO";
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
		if (5 > random 100) then {_unit enableGunLights "AUTO"};
	};
};

// ADD EVENTHANDLER
{
	_x addEventHandler ["FiredNear", {
	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
	[_unit,_firer] call lmf_ungarrisonFiredNear;
	_unit removeEventHandler ["FiredNear", _thisEventHandler];
	}];
} forEach (units _grp);