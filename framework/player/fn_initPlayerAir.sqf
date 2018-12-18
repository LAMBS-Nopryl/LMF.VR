// APPLY SETTINGS TO DEFINED AIR VICS /////////////////////////////////////////////////////////////
/*
	- This file handles what happens on creation of player defined air vehicles.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_air",objNull,[objNull]]];
if (isNull _air) exitWith {};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _air;
clearMagazineCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;

//ADD NEW ITEMS
if (_SMG_Ammo != "") then {_air addMagazineCargoGlobal [_SMG_Ammo, 5 + (random 10)];};
if (_Grenade_Smoke != "") then {_air addMagazineCargoGlobal [_Grenade_Smoke, 2 + (random 2)];};

_air addItemCargoGlobal ["Toolkit",1];

if ((_Backpack_Light#0) != "") then {_air addBackpackCargoGlobal [(selectRandom _Backpack_Light),1];};