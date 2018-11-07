// INIT AI AIR VICS ///////////////////////////////////////////////////////////////////////////////
/*
	- File that handles what happens to all defined AI air vehicles on creation.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_air",objNull,[objNull]]];
if (isNull _air) exitWith {};

#include "..\..\settings\cfg_AI.sqf"


// CHECK WHO GETS WHAT GEAR ///////////////////////////////////////////////////////////////////////
private _type = typeOf _air;


// APPLY GENERAL SETTINGS /////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _air;
clearMagazineCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;

//REMOVE AMMO
{_air removeMagazines _x;} count _ammoBlacklist;


// APPLY VEHICLE SPECIFIC SETTINGS ////////////////////////////////////////////////////////////////
if (_heli_Transport findIf {_type == _x} != -1) then {
	if !(_heli_Transport_Camo isEqualTo [""]) then {
		_heli_Transport_Camo = selectRandom _heli_Transport_Camo;
		[_air,[_heli_Transport_Camo,1]] call BIS_fnc_initVehicle;
		_air setVehicleLock "LOCKEDPLAYER";
	};
};

if (_heli_Attack findIf {_type == _x} != -1) then {
	if !(_heli_Attack_Camo isEqualTo [""]) then {
		_heli_Attack_Camo = selectRandom _heli_Attack_Camo;
		[_air,[_heli_Attack_Camo,1]] call BIS_fnc_initVehicle;
	};
	_air setVehicleLock "LOCKEDPLAYER";
};