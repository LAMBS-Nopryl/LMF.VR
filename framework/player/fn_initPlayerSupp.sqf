// APPLY SETTINGS TO DEFINED SUPPLY CRATES ////////////////////////////////////////////////////////
/*
	- This file handles what happens on creation of player defined supply crates.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_supp",objNull,[objNull]]];
if (isNull _supp) exitWith {};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _supp;
clearMagazineCargoGlobal _supp;
clearItemCargoGlobal _supp;
clearBackpackCargoGlobal _supp;

//ADD NEW ITEMS
if (typeOf _supp == var_supSmall) exitWith {
	if (_Carbine_Ammo != "") then {_supp addMagazineCargoGlobal [_Carbine_Ammo, 15];};
	if (_Rifle_Ammo != "") then {_supp addMagazineCargoGlobal [_Rifle_Ammo, 15];};
	if (_Rifle_GL_Ammo != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_Ammo, 15];};
	if (_LMG_Ammo != "") then {_supp addMagazineCargoGlobal [_LMG_Ammo, 4];};
	if (_MMG_Ammo != "") then {_supp addMagazineCargoGlobal [_MMG_Ammo, 4];};
	if (_MAT_Ammo != "") then {_supp addMagazineCargoGlobal [_MAT_Ammo, 4];};
	if (_Rifle_GL_HE != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_HE, 4];};
	if (_Grenade != "") then {_supp addMagazineCargoGlobal [_Grenade, 4];};
	if (_Grenade_Smoke != "") then {_supp addMagazineCargoGlobal [_Grenade_Smoke, 4];};
	if (_Grenade_Smoke_Grn != "") then {_supp addMagazineCargoGlobal [_Grenade_Smoke_Grn, 4];};
};

if (typeOf _supp == var_supLarge) exitWith {
	if (_Carbine_Ammo != "") then {_supp addMagazineCargoGlobal [_Carbine_Ammo, 40];};
	if (_Rifle_Ammo != "") then {_supp addMagazineCargoGlobal [_Rifle_Ammo, 40];};
	if (_Rifle_GL_Ammo != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_Ammo, 40];};
	if (_LMG_Ammo != "") then {_supp addMagazineCargoGlobal [_LMG_Ammo, 10];};
	if (_MMG_Ammo != "") then {_supp addMagazineCargoGlobal [_MMG_Ammo, 10];};
	if (_MAT_Ammo != "") then {_supp addMagazineCargoGlobal [_MAT_Ammo, 10];};
	if (_Rifle_GL_HE != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_HE, 20];};
	if (_Rifle_GL_Flare != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_Flare, 30];};
	if (_Rifle_GL_Smoke_Grn != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_Smoke_Grn, 10];};
	if (_Rifle_GL_Smoke_Red != "") then {_supp addMagazineCargoGlobal [_Rifle_GL_Smoke_Red, 10];};
	if (_Grenade != "") then {_supp addMagazineCargoGlobal [_Grenade, 10];};
	if (_Grenade_Smoke != "") then {_supp addMagazineCargoGlobal [_Grenade_Smoke, 10];};
	if (_Grenade_Smoke_Grn != "") then {_supp addMagazineCargoGlobal [_Grenade_Smoke_Grn, 10];};


	if (_LAT != "") then {_supp addWeaponCargoGlobal [_LAT, 6];};

	_supp addItemCargoGlobal ["ACE_Wirecutter",5];
};

if (typeOf _supp == var_supSpecial) exitWith {
	_supp addMagazineCargoGlobal ["TrainingMine_Mag", 10];
	_supp addMagazineCargoGlobal ["Chemlight_blue", 20];
	_supp addMagazineCargoGlobal ["Chemlight_green", 20];
	_supp addMagazineCargoGlobal ["Chemlight_red", 20];
	_supp addMagazineCargoGlobal ["ACE_Chemlight_HiRed", 20];
	_supp addMagazineCargoGlobal ["ACE_Chemlight_HiWhite", 20];
	_supp addMagazineCargoGlobal ["ACE_Chemlight_HiYellow", 20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_Green", 20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_Red", 20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_White", 20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_Yellow", 20];
	_supp addMagazineCargoGlobal ["ACE_M84", 10];

	_supp addItemCargoGlobal ["ACE_RangeTable_82mm",2];
	_supp addItemCargoGlobal ["ACE_RangeCard",5];
	_supp addItemCargoGlobal ["ACE_CableTie",20];
	_supp addItemCargoGlobal ["ACE_wirecutter",5];
	_supp addItemCargoGlobal ["ACE_DefusalKit",5];
	_supp addItemCargoGlobal ["ACE_EntrenchingTool",5];
	_supp addItemCargoGlobal ["ACE_Fortify",5];
	_supp addItemCargoGlobal ["ACE_HuntIR_monitor",5];
	_supp addItemCargoGlobal ["ACE_IR_Strobe_Item",20];
	_supp addItemCargoGlobal ["ACE_Clacker",5];
	_supp addItemCargoGlobal ["ACE_Flashlight_XL50",20];
	_supp addItemCargoGlobal ["ACE_MapTools",5];

	_supp addItemCargoGlobal ["ACRE_PRC117F",5];
	_supp addItemCargoGlobal ["ACRE_PRC148",10];
	_supp addItemCargoGlobal ["ACRE_PRC152",10];
	_supp addItemCargoGlobal ["ACRE_PRC343",20];

	_supp addItemCargoGlobal ["acc_pointer_IR",20];
	_supp addItemCargoGlobal ["acc_flashlight",20];
	_supp addItemCargoGlobal ["ACE_VectorDay",5];
	_supp addItemCargoGlobal ["ItemGPS",5];

	if ((_Backpack_Light#0) != "") then {_supp addBackpackCargoGlobal [(selectRandom _Backpack_Light), 5];};
};

if (typeOf _supp == var_supExplosives) exitWith {
	_supp addItemCargoGlobal ["DemoCharge_Remote_Mag", 8];
	_supp addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
	_supp addItemCargoGlobal ["ACE_M26_Clacker",2];

	if ((_Backpack_Light#0) != "") then {_supp addBackpackCargoGlobal [(selectRandom _Backpack_Light), 2];};
};