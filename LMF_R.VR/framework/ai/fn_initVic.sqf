// INIT AI VIC ////////////////////////////////////////////////////////////////////////////////////
/*
	- File that handles what happens to all defined AI ground vehicles on creation.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_vic",objNull,[objNull]]];
if (isNull _vic) exitWith {};

#include "..\..\settings\cfg_AI.sqf"


// CHECK WHO GETS WHAT GEAR ///////////////////////////////////////////////////////////////////////
private _type = typeOf _vic;


// APPLY GENERAL SETTINGS /////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _vic;
clearMagazineCargoGlobal _vic;
clearItemCargoGlobal _vic;
clearBackpackCargoGlobal _vic;

//REMOVE AMMO
{_vic removeMagazines _x;} count _ammoBlacklist;


// APPLY VEHICLE SPECIFIC SETTINGS ////////////////////////////////////////////////////////////////
if (_car findIf {_type == _x} != -1) then {
	if !(_car_Camo isEqualTo [""]) then {
		_car_Camo = selectRandom _car_Camo;
		[_vic,[_car_Camo,1]] call BIS_fnc_initVehicle;
	};
};

if (_carArmed findIf {_type == _x} != -1) then {
	if !(_carArmed_Camo isEqualTo [""]) then {
		_carArmed_Camo = selectRandom _carArmed_Camo;
		[_vic,[_carArmed_Camo,1]] call BIS_fnc_initVehicle;
	};
	if (60 > random 100) then {_vic allowCrewInImmobile true;};
};

if (_truck findIf {_type == _x} != -1) then {
	if !(_truck_Camo isEqualTo [""]) then {
		_truck_Camo = selectRandom _truck_Camo;
		[_vic,[_truck_Camo,1]] call BIS_fnc_initVehicle;
	};
};

if (_apc findIf {_type == _x} != -1) then {
	if !(_apc_Camo isEqualTo [""]) then {
		_apc_Camo = selectRandom _apc_Camo;
		[_vic,[_apc_Camo,1]] call BIS_fnc_initVehicle;
	};
	_vic setVehicleLock "LOCKEDPLAYER";
	if (70 > random 100) then {_vic allowCrewInImmobile true;};
};

if (_tank findIf {_type == _x} != -1) then {
	if !(_tank_Camo isEqualTo [""]) then {
		_tank_Camo = selectRandom _tank_Camo;
		[_vic,[_tank_Camo,1]] call BIS_fnc_initVehicle;
	};
	_vic setVehicleLock "LOCKEDPLAYER";
	if (80 > random 100) then {_vic allowCrewInImmobile true;};
};