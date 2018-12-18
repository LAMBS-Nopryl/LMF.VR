// APPLY SETTINGS TO DEFINED GROUND VICS //////////////////////////////////////////////////////////
/*
	- This file handles what happens on creation of player defined ground vehicles.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_vic",objNull,[objNull]]];
if (isNull _vic) exitWith {};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _vic;
clearMagazineCargoGlobal _vic;
clearItemCargoGlobal _vic;
clearBackpackCargoGlobal _vic;

//ADD NEW ITEMS
if (_Carbine_Ammo != "") then {_vic addMagazineCargoGlobal [_Carbine_Ammo, 5 + (random 10)];};
if (_Rifle_Ammo != "") then {_vic addMagazineCargoGlobal [_Rifle_Ammo, 5 + (random 10)];};
if (_Rifle_GL_Ammo != "") then {_vic addMagazineCargoGlobal [_Rifle_GL_Ammo, 5 + (random 10)];};
if (_LMG_Ammo != "") then {_vic addMagazineCargoGlobal [_LMG_Ammo, 2 + (random 4)];};
if (_MMG_Ammo != "") then {_vic addMagazineCargoGlobal [_MMG_Ammo, 2 + (random 4)];};
if (_Grenade != "") then {_vic addMagazineCargoGlobal [_Grenade, 1 + (random 2)];};
if (_Grenade_Smoke != "") then {_vic addMagazineCargoGlobal [_Grenade_Smoke, 1 + (random 2)];};

if (_LAT != "") then {_vic addWeaponCargoGlobal [_LAT, 2];};

_vic addItemCargoGlobal ["Toolkit",1];

if ((_Backpack_Light#0) != "") then {_vic addBackpackCargoGlobal [(selectRandom _Backpack_Light),1];};