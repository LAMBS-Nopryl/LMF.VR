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

_unit addWeapon _SMG;
_unit addPrimaryWeaponItem _SMG_Attach1;
_unit addPrimaryWeaponItem _SMG_Attach2;
_unit addPrimaryWeaponItem _SMG_Optic;
_unit addPrimaryWeaponItem _SMG_Bipod;

_unit forceAddUniform selectRandom _Heli_Uniform;

_unit addVest selectRandom _Heli_Vest;
for "_i" from 1 to 5 do {_unit addItemToVest _SMG_Ammo;};
for "_i" from 1 to 4 do {_unit addItemToVest _FlareGun_Ammo;};

_unit addBackpack selectRandom _Backpack_Pilot;
_unit addItemToBackpack _ACRE_ITR;
_unit addItemToBackpack _FlareGun;

_unit addHeadgear selectRandom _Heli_Headgear;
_unit addGoggles selectRandom _Heli_Goggles;

_unit linkItem "ItemWatch";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadioAcreFlagged";

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
_unit linkItem "ItemMap";
_unit addItem "ACE_Flashlight_XL50";

//MEDICAL
for "_i" from 1 to 2 do {_unit addItem "ACE_morphine"};
for "_i" from 1 to 2 do {_unit addItem "ACE_tourniquet"};
for "_i" from 1 to 2 do {_unit addItem "ACE_splint"};
for "_i" from 1 to 4 do {_unit addItem "ACE_packingBandage"};

//NVG
if (var_playerNVG != 2) then {_unit linkItem _NVG_Pilot};

//PISTOL
if (var_pistolAll) then {
	_unit addWeapon _Pistol;
	_unit addHandgunItem _Pistol_Attach1;
	_unit addHandgunItem _Pistol_Attach2;
	for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
};

//ENABLE SHIFT CLICK ON MAP
onMapSingleClick "";

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",true];

//RANK
_unit setRank "LIEUTENANT";

//ROLE
//lmf_currentRole = "Helicopter Pilot";
_unit setVariable ["lmf_currentRole", "Helicopter Pilot", true];

//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_of1" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;