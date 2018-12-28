// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file is a player gear loadout file.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull]];
if !(local _unit) exitWith {};

#include "..\..\..\settings\cfg_Player.sqf"


// APPLY NEW ROLE SPECIFIC LOADOUT ////////////////////////////////////////////////////////////////
_unit setUnitLoadout [
	[
		[_MMG,_MMG_Attach1,_MMG_Attach2,_MMG_Optic,[],[],_MMG_Bipod],
		[],
		[_Pistol,_Pistol_Attach1,_Pistol_Attach2,"",[],[],""],
		[(selectRandom _Uniform),[]],
		[(selectRandom _Vest),[[_MMG_Ammo,2,999],[_Pistol_Ammo,3,99],[_Grenade_Smoke,2,1]]],
		[(selectRandom _Backpack_AR_MMG),[[_MMG_Ammo,4,999]]],(selectRandom _Headgear),(selectRandom _Goggles),
		[],
		["","","ItemRadioAcreFlagged","","ItemWatch",""]
	],true
];

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

//RANK
_unit setRank "PRIVATE";

//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_or2" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;