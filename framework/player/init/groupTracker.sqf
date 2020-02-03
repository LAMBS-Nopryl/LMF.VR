// GROUP MARKERS //////////////////////////////////////////////////////////////////////////////////
/*
	- Creates group markers that follow the groups leader.
	- When clicked while map is open, it will list current members of the group.
	- Lets group leaders set callsigns mid-mission if needed.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//GENERAL GROUP ICON SETTINGS
if !(hasInterface) exitWith {};
waitUntil {time > 1};
setGroupIconsVisible [true,false];
setGroupIconsSelectable true;
var_iconColor = [0,0,0,1];
if (toUpper var_markerSide isEqualTo "COLORWEST") then {var_iconColor = [0,0.3,0.6,1]};
if (toUpper var_markerSide isEqualTo "COLOREAST") then {var_iconColor = [0.5,0,0,1]};
if (toUpper var_markerSide isEqualTo "COLORGUER") then {var_iconColor = [0,0.5,0,1]};

// FUNCTIONS //////////////////////////////////////////////////////////////////////////////////////
lmf_fnc_callsignAvailable = {
	params [["_grp",grpNull],["_txt",""]];

	_groupUsingCallsign = [];
	_groupUsingCallsign = allGroups select {_x getVariable "lmf_bft_callsign" == _txt && {{alive _x} count units _x > 0}};
	if (_groupUsingCallsign isEqualTo []) then {true} else {false};
};

lmf_fnc_createIcon = {
	params [["_grp",grpNull],["_type","b_inf"],["_txt",""]];

	clearGroupIcons _grp;
	_grp addGroupIcon [_type,[0,0]];
	_grp setgroupIconParams [var_iconColor,_txt,1,true];

	_grp setVariable ["lmf_bft_hasIcon", true];
};

lmf_fnc_setCallsign = {
	params [["_grp",grpNull],["_type","b_inf"],["_txt",""]];

	if (_grp getVariable "lmf_bft_callsign" == _txt) exitWith {systemChat format ["Your callsign is already %1", _txt];};
	if !([_grp, _txt] call lmf_fnc_callsignAvailable) exitWith {systemChat format ["Callsign %1 already in use", _txt];};

	[_grp, _txt] call CBA_fnc_setCallsign;
	if (_grp getVariable ["lmf_bft_hasIcon",false]) then {[_grp,_type,_txt] call lmf_fnc_createIcon};

	_grp setVariable ["lmf_bft_callsignSet", true, true];
	_grp setVariable ["lmf_bft_callsign", _txt, true];

	if (time > 10) then {systemChat format ["Callsign set to %1", _txt];};
};

lmf_fnc_addIconToNewGroups = {
	{
		if !(_x getVariable ["lmf_bft_hasIcon",false] && _x getVariable "lmf_bft_callsignSet") then {
			[_x,"b_inf",toUpper (groupid _x)] call lmf_fnc_createIcon;
		};
	} forEach (allGroups select {side _x == side player});
};

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	[] call lmf_fnc_addIconToNewGroups;
}];

addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	[] call lmf_fnc_addIconToNewGroups;
}];

// WHICH GROUPS GET TRACKED BY DEFAULT ////////////////////////////////////////////////////////////
//FOX PLATOON
if !(isNil "Grp_FOX_6") then {[Grp_FOX_6,"b_inf","FOX6"] call lmf_fnc_setCallsign};
if !(isNil "Grp_FOX_1") then {[Grp_FOX_1,"b_inf","FOX1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_FOX_2") then {[Grp_FOX_2,"b_inf","FOX2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_FOX_3") then {[Grp_FOX_3,"b_inf","FOX3"] call lmf_fnc_setCallsign};

//WOLF PLATOON
if !(isNil "Grp_WOLF_6") then {[Grp_WOLF_6,"b_inf","WOLF6"] call lmf_fnc_setCallsign};
if !(isNil "Grp_WOLF_1") then {[Grp_WOLF_1,"b_inf","WOLF1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_WOLF_2") then {[Grp_WOLF_2,"b_inf","WOLF2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_WOLF_3") then {[Grp_WOLF_3,"b_inf","WOLF3"] call lmf_fnc_setCallsign};

//DOG PLATOON
if !(isNil "Grp_DOG_6") then {[Grp_DOG_6,"b_inf","DOG6"] call lmf_fnc_setCallsign};
if !(isNil "Grp_DOG_1") then {[Grp_DOG_1,"b_inf","DOG1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_DOG_2") then {[Grp_DOG_2,"b_inf","DOG2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_DOG_3") then {[Grp_DOG_3,"b_inf","DOG3"] call lmf_fnc_setCallsign};

//ARMOR
if !(isNil "Grp_DGR1") then {[Grp_DGR1,"b_motor_inf","DAGGER1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_DGR2") then {[Grp_DGR2,"b_motor_inf","DAGGER2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_DGR3") then {[Grp_DGR3,"b_motor_inf","DAGGER3"] call lmf_fnc_setCallsign};
if !(isNil "Grp_DGR4") then {[Grp_DGR4,"b_motor_inf","DAGGER4"] call lmf_fnc_setCallsign};

if !(isNil "Grp_SWD1") then {[Grp_SWD1,"b_mech_inf","SWORD1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_SWD2") then {[Grp_SWD2,"b_mech_inf","SWORD2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_SWD3") then {[Grp_SWD3,"b_mech_inf","SWORD3"] call lmf_fnc_setCallsign};
if !(isNil "Grp_SWD4") then {[Grp_SWD4,"b_mech_inf","SWORD4"] call lmf_fnc_setCallsign};

if !(isNil "Grp_HMR1") then {[Grp_HMR1,"b_armor","HAMMER1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_HMR2") then {[Grp_HMR2,"b_armor","HAMMER2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_HMR3") then {[Grp_HMR3,"b_armor","HAMMER3"] call lmf_fnc_setCallsign};
if !(isNil "Grp_HMR4") then {[Grp_HMR4,"b_armor","HAMMER4"] call lmf_fnc_setCallsign};

//AIR
if !(isNil "Grp_FLC1") then {[Grp_FLC1,"b_air","FALCON1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_FLC2") then {[Grp_FLC2,"b_air","FALCON2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_FLC3") then {[Grp_FLC3,"b_air","FALCON3"] call lmf_fnc_setCallsign};
if !(isNil "Grp_FLC4") then {[Grp_FLC4,"b_air","FALCON4"] call lmf_fnc_setCallsign};

if !(isNil "Grp_CDR1") then {[Grp_CDR1,"b_air","CONDOR1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_CDR2") then {[Grp_CDR2,"b_air","CONDOR2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_CDR3") then {[Grp_CDR3,"b_air","CONDOR3"] call lmf_fnc_setCallsign};
if !(isNil "Grp_CDR4") then {[Grp_CDR4,"b_air","CONDOR4"] call lmf_fnc_setCallsign};

if !(isNil "Grp_HWK1") then {[Grp_HWK1,"b_air","HAWK1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_HWK2") then {[Grp_HWK2,"b_air","HAWK2"] call lmf_fnc_setCallsign};
if !(isNil "Grp_HWK3") then {[Grp_HWK3,"b_air","HAWK3"] call lmf_fnc_setCallsign};
if !(isNil "Grp_HWK4") then {[Grp_HWK4,"b_air","HAWK4"] call lmf_fnc_setCallsign};

if !(isNil "Grp_EGL1") then {[Grp_EGL1,"b_plane","EAGLE1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_EGL2") then {[Grp_EGL2,"b_plane","EAGLE1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_EGL3") then {[Grp_EGL3,"b_plane","EAGLE1"] call lmf_fnc_setCallsign};
if !(isNil "Grp_EGL4") then {[Grp_EGL4,"b_plane","EAGLE1"] call lmf_fnc_setCallsign};

// ADD ACTIONS ////////////////////////////////////////////////////////////////////////////////////
//MAIN CATEGORY
private _parentBFT = ["parentBFT","Blue Force Tracker","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{player == leader (group player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _parentBFT] call ace_interact_menu_fnc_addActionToObject;

//SUB CATEGORIES
private _parentInfantry = ["parentInfantry","Infantry","\A3\ui_f\data\map\markers\nato\b_inf.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT"], _parentInfantry] call ace_interact_menu_fnc_addActionToObject;
private _parentArmor = ["parentArmor","Armor","\A3\ui_f\data\map\markers\nato\b_armor.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT"], _parentArmor] call ace_interact_menu_fnc_addActionToObject;
private _parentAir = ["parentAir","Air","\A3\ui_f\data\map\markers\nato\b_air.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT"], _parentAir] call ace_interact_menu_fnc_addActionToObject;

//INFANTRY GROUPS
//FOX PLATOON
private _parentFOX = ["parentFOX","FOX Platoon","\A3\ui_f\data\map\markers\nato\b_inf.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry"], _parentFOX] call ace_interact_menu_fnc_addActionToObject;
private _fox6 = ["fox6","FOX6","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","FOX6"] call lmf_fnc_setCallsign; },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentFOX"], _fox6] call ace_interact_menu_fnc_addActionToObject;
private _fox1 = ["fox1","FOX1","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","FOX1"] call lmf_fnc_setCallsign; },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentFOX"], _fox1] call ace_interact_menu_fnc_addActionToObject;
private _fox2 = ["fox2","FOX2","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","FOX2"] call lmf_fnc_setCallsign; },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentFOX"], _fox2] call ace_interact_menu_fnc_addActionToObject;
private _fox3 = ["fox3","FOX3","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","FOX3"] call lmf_fnc_setCallsign; },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentFOX"], _fox3] call ace_interact_menu_fnc_addActionToObject;
private _fox4 = ["fox4","FOX4","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","FOX4"] call lmf_fnc_setCallsign; },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentFOX"], _fox4] call ace_interact_menu_fnc_addActionToObject;

//WOLF PLATOON
private _parentWOLF = ["parentWOLF","WOLF Platoon","\A3\ui_f\data\map\markers\nato\b_inf.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry"], _parentWOLF] call ace_interact_menu_fnc_addActionToObject;
private _wolf6 = ["wolf6","WOLF6","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","WOLF6"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentWOLF"], _wolf6] call ace_interact_menu_fnc_addActionToObject;
private _wolf1 = ["wolf1","WOLF1","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","WOLF1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentWOLF"], _wolf1] call ace_interact_menu_fnc_addActionToObject;
private _wolf2 = ["wolf2","WOLF2","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","WOLF2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentWOLF"], _wolf2] call ace_interact_menu_fnc_addActionToObject;
private _wolf3 = ["wolf3","WOLF3","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","WOLF3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentWOLF"], _wolf3] call ace_interact_menu_fnc_addActionToObject;
private _wolf4 = ["wolf4","WOLF4","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","WOLF4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentWOLF"], _wolf4] call ace_interact_menu_fnc_addActionToObject;

//DOG PLATOON
private _parentDOG = ["parentDOG","DOG Platoon","\A3\ui_f\data\map\markers\nato\b_inf.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry"], _parentDOG] call ace_interact_menu_fnc_addActionToObject;
private _dog6 = ["dog6","DOG6","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","DOG6"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentDOG"], _dog6] call ace_interact_menu_fnc_addActionToObject;
private _dog1 = ["dog1","DOG1","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","DOG1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentDOG"], _dog1] call ace_interact_menu_fnc_addActionToObject;
private _dog2 = ["dog2","DOG2","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","DOG2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentDOG"], _dog2] call ace_interact_menu_fnc_addActionToObject;
private _dog3 = ["dog3","DOG3","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","DOG3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentDOG"], _dog3] call ace_interact_menu_fnc_addActionToObject;
private _dog4 = ["dog4","DOG4","\A3\ui_f\data\map\markers\nato\b_inf.paa",{ [(group player),"b_inf","DOG4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentInfantry","parentDOG"], _dog4] call ace_interact_menu_fnc_addActionToObject;

//ARMOUR GROUPS
//DAGGER PLATOON
private _parentDagger = ["parentDagger","DAGGER Platoon","\A3\ui_f\data\map\markers\nato\b_armor.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor"], _parentDagger] call ace_interact_menu_fnc_addActionToObject;
private _dagger1 = ["dagger1","DAGGER1","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","DAGGER1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentDagger"], _dagger1] call ace_interact_menu_fnc_addActionToObject;
private _dagger2 = ["dagger2","DAGGER2","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","DAGGER2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentDagger"], _dagger2] call ace_interact_menu_fnc_addActionToObject;
private _dagger3 = ["dagger3","DAGGER3","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","DAGGER3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentDagger"], _dagger3] call ace_interact_menu_fnc_addActionToObject;
private _dagger4 = ["dagger4","DAGGER4","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","DAGGER4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentDagger"], _dagger4] call ace_interact_menu_fnc_addActionToObject;

//SWORD PLATOON
private _parentSword = ["parentSword","SWORD Platoon","\A3\ui_f\data\map\markers\nato\b_armor.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor"], _parentSword] call ace_interact_menu_fnc_addActionToObject;
private _sword1 = ["sword1","SWORD1","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","SWORD1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentSword"], _sword1] call ace_interact_menu_fnc_addActionToObject;
private _sword2 = ["sword2","SWORD2","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","SWORD2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentSword"], _sword2] call ace_interact_menu_fnc_addActionToObject;
private _sword3 = ["sword3","SWORD3","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","SWORD3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentSword"], _sword3] call ace_interact_menu_fnc_addActionToObject;
private _sword4 = ["sword4","SWORD4","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","SWORD4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentSword"], _sword4] call ace_interact_menu_fnc_addActionToObject;

//HAMMER PLATOON
private _parentHammer = ["parentHammer","HAMMER Platoon","\A3\ui_f\data\map\markers\nato\b_armor.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor"], _parentHammer] call ace_interact_menu_fnc_addActionToObject;
private _hammer1 = ["hammer1","HAMMER1","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","HAMMER1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentHammer"], _hammer1] call ace_interact_menu_fnc_addActionToObject;
private _hammer2 = ["hammer2","HAMMER2","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","HAMMER2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentHammer"], _hammer2] call ace_interact_menu_fnc_addActionToObject;
private _hammer3 = ["hammer3","HAMMER3","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","HAMMER3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentHammer"], _hammer3] call ace_interact_menu_fnc_addActionToObject;
private _hammer4 = ["hammer4","HAMMER4","\A3\ui_f\data\map\markers\nato\b_armor.paa",{ [(group player),"b_armor","HAMMER4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentArmor","parentHammer"], _hammer4] call ace_interact_menu_fnc_addActionToObject;

//AIR GROUPS
//FALCON FLIGHT
private _parentFalcon = ["parentFalcon","FALCON Flight","\A3\ui_f\data\map\markers\nato\b_air.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentFalcon] call ace_interact_menu_fnc_addActionToObject;
private _falcon1 = ["falcon1","FALCON1","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","FALCON1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon1] call ace_interact_menu_fnc_addActionToObject;
private _falcon2 = ["falcon2","FALCON2","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","FALCON2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon2] call ace_interact_menu_fnc_addActionToObject;
private _falcon3 = ["falcon3","FALCON3","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","FALCON3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon3] call ace_interact_menu_fnc_addActionToObject;
private _falcon4 = ["falcon4","FALCON4","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","FALCON4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon4] call ace_interact_menu_fnc_addActionToObject;

//CONDOR FLIGHT
private _parentCondor = ["parentCondor","CONDOR Flight","\A3\ui_f\data\map\markers\nato\b_air.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentCondor] call ace_interact_menu_fnc_addActionToObject;
private _condor1 = ["condor1","CONDOR1","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","CONDOR1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor1] call ace_interact_menu_fnc_addActionToObject;
private _condor2 = ["condor2","CONDOR2","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","CONDOR2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor2] call ace_interact_menu_fnc_addActionToObject;
private _condor3 = ["condor3","CONDOR3","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","CONDOR3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor3] call ace_interact_menu_fnc_addActionToObject;
private _condor4 = ["condor4","CONDOR4","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","CONDOR4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor4] call ace_interact_menu_fnc_addActionToObject;

//HAWK FLIGHT
private _parentHawk = ["parentHawk","HAWK Flight","\A3\ui_f\data\map\markers\nato\b_air.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentHawk] call ace_interact_menu_fnc_addActionToObject;
private _hawk1 = ["hawk1","HAWK1","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","HAWK1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk1] call ace_interact_menu_fnc_addActionToObject;
private _hawk2 = ["hawk2","HAWK2","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","HAWK2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk2] call ace_interact_menu_fnc_addActionToObject;
private _hawk3 = ["hawk3","HAWK3","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","HAWK3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk3] call ace_interact_menu_fnc_addActionToObject;
private _hawk4 = ["hawk4","HAWK4","\A3\ui_f\data\map\markers\nato\b_air.paa",{ [(group player),"b_air","HAWK4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk4] call ace_interact_menu_fnc_addActionToObject;

//EAGLE FLIGHT
private _parentEagle = ["parentEagle","EAGLE Flight","\A3\ui_f\data\map\markers\nato\b_plane.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentEagle] call ace_interact_menu_fnc_addActionToObject;
private _eagle1 = ["eagle1","EAGLE1","\A3\ui_f\data\map\markers\nato\b_plane.paa",{ [(group player),"b_plane","EAGLE1"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle1] call ace_interact_menu_fnc_addActionToObject;
private _eagle2 = ["eagle2","EAGLE2","\A3\ui_f\data\map\markers\nato\b_plane.paa",{ [(group player),"b_plane","EAGLE2"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle2] call ace_interact_menu_fnc_addActionToObject;
private _eagle3 = ["eagle3","EAGLE3","\A3\ui_f\data\map\markers\nato\b_plane.paa",{ [(group player),"b_plane","EAGLE3"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle3] call ace_interact_menu_fnc_addActionToObject;
private _eagle4 = ["eagle4","EAGLE4","\A3\ui_f\data\map\markers\nato\b_plane.paa",{ [(group player),"b_plane","EAGLE4"] call lmf_fnc_setCallsign },{ player == leader (group player) }] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle4] call ace_interact_menu_fnc_addActionToObject;

//EVENT HANDLERS //////////////////////////////////////////////////////////////////////////////////
//WAIT UNTIL TIME IS BIGGER THAN 1 (to avoid intro glitches)
waitUntil {time > 1};

//MOUSE HOVER OVER ICON EH
private _hoverEH = addMissionEventHandler ["GroupIconOverEnter",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	private _iconParams = getGroupIconParams _group;
	_group setGroupIconParams [_iconParams select 0,_iconParams select 1,1.3,true];
}];

//MOUSE HOVER LEAVE ICON EH
private _hoverLeaveEH = addMissionEventHandler ["GroupIconOverLeave",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	private _iconParams = getGroupIconParams _group;
	_group setGroupIconParams [_iconParams select 0,_iconParams select 1,1,true];

	//FADE TEXT
	"lmf_layer2" cutFadeOut 0;
}];

//ON CLICKING ICON
private _clickIconEH = addMissionEventHandler ["GroupIconClick",{
	params ["_is3D","_group","_waypointId","_mouseButton"];

	//CHECK FOR LEFT CLICK
	if (_mouseButton isEqualTo 0) then {
		//GET ARRAY WITH UNIT NAMES FROM GROUP
		private _nameArray = [];
		{
			_nameArray pushBack name _x;
		} forEach (units _group) - [leader _group];

		private _leaderName = (name (leader _group) + " (Current leader)");
		private _iconParams = getGroupIconParams _group;
		private _nameList = _nameArray joinString "<br/>";
		private _textToDisplay = format [
			"<t shadow='2' color='#FFBA26' size='0.75'align='center'>%1</t><br/><t shadow='2' color='#FFFFFF' size='0.5'align='center'>%2</t><br/><t shadow='2' color='#D7DBD5' size='0.5'align='center'>%3</t>",
			_iconParams select 1,_leaderName,_nameList
		];

		//CREATE LAYER AND SPAWN TEXT
		private _layerID = ["lmf_layer2"] call BIS_fnc_rscLayer;
		[_textToDisplay,(getMousePosition#0) - 0.65,(getMousePosition#1) - 0.1,10,0,0,_layerID] spawn BIS_fnc_dynamicText;

		//MAKE SURE TEXT FADES WHEN EXITING MAP
		[{!visibleMap},{"lmf_layer2" cutFadeOut 0},[]] call CBA_fnc_waitUntilAndExecute;
	};
}];