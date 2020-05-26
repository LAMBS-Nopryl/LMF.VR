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

_unit forceAddUniform selectRandom _Crew_Uniform;

_unit addVest selectRandom _Crew_Vest;
for "_i" from 1 to 5 do {_unit addItemToVest _SMG_Ammo;};

_unit addBackpack selectRandom _Backpack_Crew;
_unit addItemToBackpack _ACRE_ITR;

_unit addHeadgear selectRandom _Crew_Headgear;
_unit addGoggles selectRandom _Crew_Goggles;

_unit addWeapon _Binocular;

_unit linkItem "ItemWatch";
_unit linkItem "ItemRadioAcreFlagged";

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
if (var_playerMaps != 2) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
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
_unit setUnitTrait ["engineer",true];

//RANK
_unit setRank "SERGEANT";

//ROLE
if (_unit == leader (group _unit)) then {
	lmf_currentRole = "Vehicle Commander";
} else {
	lmf_currentRole = "Vehicle Platoon Sergeant";
};


//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_or5" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;