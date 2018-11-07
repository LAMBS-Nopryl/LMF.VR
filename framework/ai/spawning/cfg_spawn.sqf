// DEFINITIONS FOR SPAWN FUNCTIONS  ////////////////////////////////////////////////////////////////
/*
	- File ment for defining groups, also includes some functions related to the spawning process
	  such as picking the group and checking if players are far enough away.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
#include "..\..\..\settings\cfg_AI.sqf"


// MEN FOR SCALAR SPAWNING ////////////////////////////////////////////////////////////////////////
_soldier = [
	_Rifleman,
	_Rifleman,
	_Rifleman,
	_Rifleman,
	_Rifleman,
	_Grenadier,
	_MMG_Gunner,
	_Marksman,
	_Rifleman_AT,
	_Autorifleman,
	_Squad_Leader
];


// GROUPS //////////////////////////////////////////////////////////////////////////////////////////
_squad = [
    [_Squad_Leader,_MAT_Gunner,_Grenadier,_Rifleman,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_MMG_Gunner,_Rifleman_AT,_Grenadier,_Rifleman,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_Autorifleman,_Rifleman_AT,_Grenadier,_Rifleman,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Rifleman_AT,_Rifleman,_Rifleman,_Rifleman,_Marksman]
	];

_team =	[
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_Rifleman],
	[_Squad_Leader,_Rifleman,_Marksman,_Marksman],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Rifleman],
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_Rifleman_AT],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Rifleman]
];

_sentry =	[
	[_Rifleman,_Rifleman_AT],
	[_Rifleman,_Grenadier],
	[_Rifleman,_Rifleman]
];

_atTeam =	[
	[_Squad_Leader,_Rifleman,_MAT_Gunner,_MAT_Gunner],
	[_Squad_Leader,_Rifleman,_Grenadier,_MAT_Gunner],
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_MAT_Gunner]
];

_aaTeam =	[
	[_Squad_Leader,_Autorifleman,_Grenadier,_AA_Gunner],
	[_Squad_Leader,_Autorifleman,_Rifleman_AT,_AA_Gunner],
	[_Squad_Leader,_Autorifleman,_Rifleman,_AA_Gunner]
];

_mgTeam =	[
	[_Squad_Leader,_Rifleman,_MMG_Gunner,_MMG_Gunner],
	[_Squad_Leader,_MMG_Gunner,_Rifleman,_Rifleman],
	[_Squad_Leader,_MMG_Gunner,_Grenadier,_Rifleman]
];

_vehicleCrew = [_Crew,_Crew,_Crew];
_heliCrew = [_Pilot,_Pilot];


// FUNCTIONS ///////////////////////////////////////////////////////////////////////////////////////
//PASS SELECTION OF TYPE OF GROUP
private _typeMaker = {
	params ["_type"];
	private _selection = [];
	if (_type isEqualType 0) then {
		for "_i" from 1 to (floor (_type)) do {
			_selection pushback (selectRandom _soldier);
		};
	}
	else {
		toUpper _type;
		_selection = selectRandom _team;

		if (_type == "SQUAD") then {_selection = selectRandom _squad};
		if (_type == "SENTRY") then {_selection = selectRandom _sentry};
		if (_type == "ATTEAM") then {_selection = selectRandom _atteam};;
		if (_type == "AATEAM") then {_selection = selectRandom _aateam};
		if (_type == "MGTEAM") then {_selection = selectRandom _mgteam};
	};
	_selection
};

//CHECK IF PLAYERS FAR ENOUGH AWAY
private _proximityChecker = {
	params ["_pos",["_range",500]];
	private _targetsToCheck = (switchableUnits + playableUnits - entities "HeadlessClient_F");
	private _close = false;
	{
		private _dist = vehicle _x distance _pos;
		if (isPlayer _x && {_dist < _range}) then {_close = true};
	} forEach _targetsToCheck;
	_close
};