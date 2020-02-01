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

_unit forceAddUniform selectRandom _Plane_Uniform;

_unit addVest selectRandom _Plane_Vest;
for "_i" from 1 to 3 do {_unit addItemToVest _Pistol_Ammo;};
for "_i" from 1 to 4 do {_unit addItemToVest _FlareGun_Ammo;};

_unit addBackpack selectRandom _Backpack_Pilot;
_unit addItemToBackpack _ACRE_ITR;
_unit addItemToBackpack _FlareGun;

_unit addWeapon _Pistol;
_unit addHandgunItem _Pistol_Attach1;
_unit addHandgunItem _Pistol_Attach2;

_unit addHeadgear selectRandom _Plane_Headgear;
_unit addGoggles selectRandom _Plane_Goggles;

_unit linkItem "ItemWatch";
_unit linkItem "ItemRadioAcreFlagged";

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit addItem "ACE_Flashlight_XL50";

//REST
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};

//NVG
if (var_playerNVG != 2) then {_unit linkItem _NVG_Pilot};

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",true];

//RANK
_unit setRank "CAPTAIN";

//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_of2" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;