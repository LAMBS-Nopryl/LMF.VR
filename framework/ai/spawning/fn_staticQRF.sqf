// AI MORTAR QRF //////////////////////////////////////////////////////////////////////////////////
/*
	-
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_tickets", 1]];
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
	_grp setGroupIDGlobal [format ["Static Weapon QRF: %1 (%2)",_grpType, groupId _grp]];

	private _wp = _grp addWaypoint [_spawnPos,0];
	_wp setWaypointType "GUARD";
	_grp setFormation "STAG COLUMN";
	_grp enableIRLasers false;
	_grp enableGunLights "ForceOff";

	{_x disableAI "FSM"} count units _grp;
	{_x disableAI "AUTOCOMBAT"} count units _grp;
	_grp setVariable ["lambs_danger_disableGroupAI", true];
	{_x setVariable ["lambs_danger_disableAI",true]} count units _grp;

	if (_grpType == "HMG") then {0 = [_grp,"HMG"] spawn lmf_ai_fnc_taskStatic};
	if (_grpType == "MORTAR") then {0 = [_grp,"MORTAR"] spawn lmf_ai_fnc_taskStatic};
	if (_grpType == "HAT") then {0 = [_grp,"HAT"] spawn lmf_ai_fnc_taskStatic};

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL EVERYONE DEAD OR GROUND PROXIMITY HAS BEEN BROKEN
		waitUntil {sleep 5; {alive _x} count units _grp < 1 || {[_spawnPos,_range] call _proximityChecker isEqualTo "groundClose"}};
	};

	//SUBTRACT TICKET
	_initTickets = _initTickets - 1;
};