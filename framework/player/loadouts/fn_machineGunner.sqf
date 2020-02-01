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

_unit addWeapon _MMG;
_unit addPrimaryWeaponItem _MMG_Attach1;
_unit addPrimaryWeaponItem _MMG_Attach2;
_unit addPrimaryWeaponItem _MMG_Optic;
_unit addPrimaryWeaponItem _MMG_Bipod;

_unit forceAddUniform selectRandom _Uniform;

_unit addVest selectRandom _Vest;
_unit addItemToVest _MMG_Ammo;
for "_i" from 1 to 2 do {_unit addItemToVest _Pistol_Ammo;};
for "_i" from 1 to 2 do {_unit addItemToVest _Grenade;};
_unit addItemToVest _Grenade_Smoke;

_unit addBackpack selectRandom _Backpack_AR_MMG;
for "_i" from 1 to 2 do {_unit addItemToBackpack _MMG_Ammo;};
_unit addItemToBackpack _Pistol_Ammo;

_unit addHeadgear selectRandom _Headgear;
_unit addGoggles selectRandom _Goggles;

_unit addWeapon _Pistol;
_unit addHandgunItem _Pistol_Attach1;
_unit addHandgunItem _Pistol_Attach2;

_unit linkItem "ItemWatch";
_unit linkItem "ItemRadioAcreFlagged";

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
if (var_playerMaps == 0) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit addItem "ACE_Flashlight_XL50";
};

//REST
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};

//NVG
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//DISABLE SHIFT CLICK ON MAP
onMapSingleClick "_shift";

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",false];

//RANK
_unit setRank "PRIVATE";

//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_or2" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;