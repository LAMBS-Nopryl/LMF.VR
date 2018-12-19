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
		[],
		[],
		[_Pistol,_Pistol_Attach1,_Pistol_Attach2,"",[],[],""],
		[(selectRandom _Plane_Uniform),[["ACE_Flashlight_XL50",1]]],
		[(selectRandom _Plane_Vest),[[_Pistol_Ammo,3,999],[_FlareGun_Ammo,4,99]]],
		[(selectRandom _Backpack_Pilot),[[_ACRE_ITR,1],[[_FlareGun,"","","",[],[],""],1]]],(selectRandom _Plane_Headgear),(selectRandom _Goggles),
		[],
		["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]
	],true
];

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//REST
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};

//NVG
if (var_playerNVG != 2) then {_unit linkItem _NVG_Pilot};

//RANK
_unit setRank "CAPTAIN";

//INSIGNIA
private _chooseInsignia = {
	private _exists = isClass (configFile >> "CfgUnitInsignia" >> _this);
	(["",_this] select _exists)
};
player_insignia = "lambs_of2" call _chooseInsignia;
[_unit,player_insignia] call bis_fnc_setUnitInsignia;