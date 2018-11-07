// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file handles the players custom loadout component.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasinterface) exitWith {};
params [["_unit", objNull]];
if !(local _unit) exitWith {};

private _role = roleDescription _unit;
if (count _this > 1) then {_role = _this select 1;};
if (_role == "") then {_role = "Rifleman";};


#include "..\..\settings\cfg_Player.sqf"


// REMOVE /////////////////////////////////////////////////////////////////////////////////////////
removeAllItems _unit;
removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeUniform _unit;
removeVest _unit;
removeGoggles _unit;

onMapSingleClick "_shift";

player_insignia = "";

private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};

// APPLY NEW ROLE SPECIFIC STUFF //////////////////////////////////////////////////////////////////
//PLT LEADER
if (_role find "Platoon Leader" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_Leader; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 2 do {_unit addItem (_Pistol_Ammo select 0)};
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_Rifle select 0);
	_unit addWeapon (_Pistol select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Attach2;
	_unit setRank "LIEUTENANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_of1" call _chooseInsignia;
};

//PLT SGT
if (_role find "Platoon Sergeant" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_Leader; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 2 do {_unit addItem (_Pistol_Ammo select 0)};
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_Rifle select 0);
	_unit addWeapon (_Pistol select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Attach2;
	_unit setRank "SERGEANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or6" call _chooseInsignia;
};

//RTO
if (_role find "RTO" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_RTO; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Carbine_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Carbine_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addItemToBackpack _ACRE_MMR;
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_Carbine select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Optic;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or2" call _chooseInsignia;
};

//FAC
if (_role find "FAC" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_RTO; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Rifle_GL_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Smoke_Grn select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Smoke_Red select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Flare select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addItemToBackpack _ACRE_MMR;
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_Rifle_GL select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
	_unit setRank "CORPORAL";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or4" call _chooseInsignia;
};

//SQL
if (_role find "Squad Leader" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_Leader; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_GL_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Ammo_T select 0)};
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_GL_HE select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade_Smoke select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	for "_i" from 1 to 5 do {_unit addItemToBackpack (_Rifle_GL_Flare select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_Rifle_GL select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
	_unit setRank "SERGEANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or5" call _chooseInsignia;
};

//SQD 2IC
if (_role find "Squad 2iC" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_Light; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_GL_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Ammo_T select 0)};
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_GL_HE select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade_Smoke select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	for "_i" from 1 to 5 do {_unit addItemToBackpack (_Rifle_GL_Flare select 0)};
	_unit addWeapon (_Rifle_GL select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
	_unit setRank "CORPORAL";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or4" call _chooseInsignia;
};

//RIFLEMAN
if (_role find "Rifleman" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	_unit addItem (_LAT_Ammo select 0);
	for "_i" from 1 to 5 do {_unit addItemToVest (_Rifle_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addWeapon (_Rifle select 0);
	_unit addWeapon (_LAT select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "";
};

//GL
if (_role find "Grenadier" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Rifle_GL_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Rifle_GL_Ammo_T select 0)};
	for "_i" from 1 to 8 do {_unit addItemToVest (_Rifle_GL_HE select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addWeapon (_Rifle_GL select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Optic;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "";
};

//AR
if (_role find "Autorifleman" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_AR_MMG; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 3 do {_unit addItemToVest (_LMG_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	_unit addItemToBackpack (_LMG_Ammo select 0);
	for "_i" from 1 to 2 do {_unit addItemToBackpack (_LMG_Ammo_T select 0)};
	_unit addWeapon (_LMG select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _LMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _LMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _LMG_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or2" call _chooseInsignia;
};

//MEDIC
if (_role find "Medic" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_Medic; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Carbine_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Carbine_Ammo_T select 0)};
	for "_i" from 1 to 6 do {_unit addItemToVest (_Grenade_Smoke select 0)};
	_unit addItemToBackpack "ACE_personalAidKit";
	for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_Tourniquet";};
	for "_i" from 1 to 30 do {_unit addItemToBackpack "ACE_fieldDressing";};
	for "_i" from 1 to 30 do {_unit addItemToBackpack "ACE_packingBandage";};
	_unit addWeapon (_Carbine select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Optic;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach2;
	_unit setRank "CORPORAL";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_medic" call _chooseInsignia;
};

//MG
if (_role find "Machine Gunner" >= 0 && {_role find "Assistant" == -1}) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_AR_MMG; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 2 do {_unit addItem (_Pistol_Ammo select 0)};
	for "_i" from 1 to 3 do {_unit addItemToVest (_MMG_Ammo select 0)};
	for "_i" from 1 to 3 do {_unit addItemToBackpack (_MMG_Ammo select 0)};
	_unit addWeapon (_MMG select 0);
	_unit addWeapon (_Pistol select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _MMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _MMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _MMG_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or2" call _chooseInsignia;
};

//MGA
if (_role find "Assistant Machine Gunner" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_AR_MMG; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Carbine_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Carbine_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	for "_i" from 1 to 3 do {_unit addItemToBackpack (_MMG_Ammo select 0)};
	_unit addWeapon (_Carbine select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Optic;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "";
};

//MAT
if (_role find "AT Gunner" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_MAT; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Carbine_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Carbine_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToBackpack (_MAT_Ammo select 0)};
	_unit addWeapon (_Carbine select 0);
	_unit addWeapon (_MAT select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Optic;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach2;
	_unit addSecondaryWeaponitem selectRandom _MAT_Optic;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or2" call _chooseInsignia;
};

//MATA
if (_role find "AT Assistant" >= 0) then {
	_unit forceAddUniform selectRandom _Uniform;
	_unit addVest selectRandom _Vest;
	_unit addBackpack selectRandom _Backpack_MAT; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Headgear;
	_unit addGoggles selectRandom _Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_Carbine_Ammo select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Carbine_Ammo_T select 0)};
	for "_i" from 1 to 2 do {_unit addItemToVest (_Grenade select 0)};
	for "_i" from 1 to 2 do {_unit addItemToBackpack (_MAT_Ammo select 0)};
	_unit addWeapon (_Carbine select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Optic;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach1;
	_unit addPrimaryWeaponitem selectRandom _Carbine_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "";
};

//VIC PLAT LEAD
if (_role find "Vehicle Platoon Commander" >= 0) then {
	_unit forceAddUniform selectRandom _Crew_Uniform;
	_unit addVest selectRandom _Crew_Vest;
	_unit addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Crew_Headgear;
	_unit addGoggles selectRandom _Crew_Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_SMG select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "LIEUTENANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_of1" call _chooseInsignia;
};

//VIC PLAT SGT
if (_role find "Vehicle Platoon 2iC" >= 0) then {
	_unit forceAddUniform selectRandom _Crew_Uniform;
	_unit addVest selectRandom _Crew_Vest;
	_unit addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Crew_Headgear;
	_unit addGoggles selectRandom _Crew_Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_SMG select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "SERGEANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or6" call _chooseInsignia;
};

//VIC CMD
if (_role find "Vehicle Commander" >= 0 && {_role find "Platoon" == -1}) then {
	_unit forceAddUniform selectRandom _Crew_Uniform;
	_unit addVest selectRandom _Crew_Vest;
	_unit addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Crew_Headgear;
	_unit addGoggles selectRandom _Crew_Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	_unit addWeapon (_SMG select 0);
	_unit addWeapon (_Binocular select 0);
	if (var_playerMaps == 0 || {var_playerMaps == 1}) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "SERGEANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or5" call _chooseInsignia;
};

//VIC GUNNER
if (_role find "Vehicle Gunner" >= 0) then {
	_unit forceAddUniform selectRandom _Crew_Uniform;
	_unit addVest selectRandom _Crew_Vest;
	_unit addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Crew_Headgear;
	_unit addGoggles selectRandom _Crew_Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addWeapon (_SMG select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or2" call _chooseInsignia;
};

//VIC DRIVER
if (_role find "Vehicle Driver" >= 0) then {
	_unit forceAddUniform selectRandom _Crew_Uniform;
	_unit addVest selectRandom _Crew_Vest;
	_unit addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Crew_Headgear;
	_unit addGoggles selectRandom _Crew_Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addWeapon (_SMG select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "PRIVATE";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "";
};

//HELI
if (_role find "Helicopter Pilot" >= 0 || {_role find "Helicopter Co-Pilot" >= 0}) then {
	_unit forceAddUniform selectRandom _Heli_Uniform;
	_unit addVest selectRandom _Heli_Vest;
	_unit addBackpack selectRandom _Backpack_Pilot; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Heli_Headgear;
	_unit addGoggles selectRandom _Heli_Goggles;
	_unit addItem "ACE_Flashlight_XL50";
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	for "_i" from 1 to 2 do {_unit addItemToBackpack (_FlareGun_Ammo select 0)};
	_unit addWeapon (_SMG select 0);
	_unit addItemToBackpack (_FlareGun select 0);
	if (var_playerNVG == 0 || {var_playerNVG == 1}) then {_unit addWeapon (_NVG_Pilot select 0)};
	_unit linkItem "ItemMap";
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "LIEUTENANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_of1" call _chooseInsignia;
	onMapSingleClick "";
};

//HELI CREW
if (_role find "Helicopter Crew" >= 0) then {
	_unit forceAddUniform selectRandom _Heli_Uniform;
	_unit addVest selectRandom _Heli_Vest;
	_unit addBackpack selectRandom _Backpack_Pilot; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Heli_Headgear;
	_unit addGoggles selectRandom _Heli_Goggles;
	for "_i" from 1 to 4 do {_unit addItemToVest (_SMG_Ammo select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	for "_i" from 1 to 2 do {_unit addItemToBackpack (_FlareGun_Ammo select 0)};
	_unit addWeapon (_SMG select 0);
	_unit addItemToBackpack (_FlareGun select 0);
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	removeAllPrimaryWeaponItems _unit;
	_unit addPrimaryWeaponitem selectRandom _SMG_Optic;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach1;
	_unit addPrimaryWeaponitem selectRandom _SMG_Attach2;
	_unit setRank "SERGEANT";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_or5" call _chooseInsignia;
};

//PLANE
if (_role find "Fighter Pilot" >= 0) then {
	_unit forceAddUniform selectRandom _Plane_Uniform;
	_unit addVest selectRandom _Plane_Vest;
	_unit addBackpack selectRandom _Backpack_Pilot; clearAllItemsFromBackpack _unit;
	_unit addHeadgear selectRandom _Plane_Headgear;
	_unit addGoggles selectRandom _Plane_Goggles;
	_unit addItem "ACE_Flashlight_XL50";
	for "_i" from 1 to 2 do {_unit addItem (_Pistol_Ammo select 0)};
	_unit addItemToBackpack _ACRE_ITR;
	for "_i" from 1 to 2 do {_unit addItemToBackpack (_FlareGun_Ammo select 0)};
	_unit addWeapon (_Pistol select 0);
	_unit addItemToBackpack (_FlareGun select 0);
	if (var_playerNVG == 0 || {var_playerNVG == 1}) then {_unit addWeapon (_NVG_Pilot select 0)};
	_unit linkItem "ItemMap";
	_unit setRank "CAPTAIN";
	[_unit,""] call bis_fnc_setUnitInsignia;
	player_insignia = "lambs_of1" call _chooseInsignia;
	onMapSingleClick "";
};


/// ADD MISC //////////////////////////////////////////////////////////////////////////////////////
//BACKPACKS
if (var_backpacksAll) then {
	if (isNull (unitBackpack _unit)) then {
		_unit addBackpack selectRandom _Backpack_Light; clearAllItemsFromBackpack _unit;
	};
};

//NVG
if (var_playerNVG == 0) then {_unit addWeapon (_NVG select 0)};

//RADIOS
if (var_personalRadio) then {_unit addItemToUniform _ACRE_PRR;};

// PISTOLS
if (var_pistolAll) then {
	if (handgunWeapon _unit == "") then {
		for "_i" from 1 to 2 do {_unit addItem (_Pistol_Ammo select 0)};
		_unit addWeapon (_Pistol select 0);
	};
};

//REST
for "_i" from 1 to 4 do {_unit addItem "ACE_fieldDressing";};
for "_i" from 1 to 1 do {_unit addItem "ACE_morphine";};
for "_i" from 1 to 1 do {_unit addItem "ACE_tourniquet";};
_unit linkItem "ItemWatch";
[_unit,player_insignia] call bis_fnc_setUnitInsignia;