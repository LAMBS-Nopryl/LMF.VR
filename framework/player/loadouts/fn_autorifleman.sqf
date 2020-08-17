// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file is a player gear loadout file.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull]];
if !(local _unit) exitWith {};

#include "..\..\..\settings\cfg_Player.sqf"


// APPLY NEW ROLE SPECIFIC LOADOUT ////////////////////////////////////////////////////////////////
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon _LMG;
_unit addPrimaryWeaponItem _LMG_Attach1;
_unit addPrimaryWeaponItem _LMG_Attach2;
_unit addPrimaryWeaponItem _LMG_Optic;
_unit addPrimaryWeaponItem _LMG_Bipod;

_unit forceAddUniform selectRandom _Uniform;

_unit addVest selectRandom _Vest;
_unit addItemToVest _LMG_Ammo;
for "_i" from 1 to 2 do {_unit addItemToVest _Grenade;};
_unit addItemToVest _Grenade_Smoke;

_unit addBackpack selectRandom _Backpack_AR_MMG;
for "_i" from 1 to 2 do {_unit addItemToBackpack _LMG_Ammo;};
for "_i" from 1 to 2 do {_unit addItemToBackpack _LMG_Ammo_T;};

_unit addHeadgear selectRandom _Headgear;
_unit addGoggles selectRandom _Goggles;

_unit linkItem "ItemWatch";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadioAcreFlagged";

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
if (var_playerMaps == 0) then {
	_unit linkItem "ItemMap";
	_unit addItem "ACE_Flashlight_XL50";
};

//MEDICAL
for "_i" from 1 to 2 do {_unit addItem "ACE_morphine"};
for "_i" from 1 to 2 do {_unit addItem "ACE_tourniquet"};
for "_i" from 1 to 2 do {_unit addItem "ACE_splint"};
for "_i" from 1 to 4 do {_unit addItem "ACE_packingBandage"};

//NVG
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//PISTOL
if (var_pistolAll) then {
	_unit addWeapon _Pistol;
	_unit addHandgunItem _Pistol_Attach1;
	_unit addHandgunItem _Pistol_Attach2;		
	for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
};

//DISABLE SHIFT CLICK ON MAP
onMapSingleClick "_shift";

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",false];

//RANK
_unit setRank "PRIVATE";

//ROLE
//lmf_currentRole = "Automatic Rifleman";
_unit setVariable ["lmf_currentRole", "Automatic Rifleman", true];

//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_or2" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;