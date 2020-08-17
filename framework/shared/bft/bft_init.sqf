// BLUE FORCE TRACKER SYSTEM //////////////////////////////////////////////////////////////////////
/*
	- Creates group markers that follow the groups leader.
	- When clicked while map is open, it will list current members of the group.
	- Lets group leaders set callsigns mid-mission if needed.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//GENERAL GROUP ICON SETTINGS
if !(hasInterface) exitWith {};
waitUntil {sleep 1; time > 5};
setGroupIconsVisible [true,false];
setGroupIconsSelectable true;

// ADD ACTIONS ////////////////////////////////////////////////////////////////////////////////////
//MAIN CATEGORY
private _parentBFT = ["parentBFT","Blue Force Tracker","\a3\Modules_F_Curator\Data\portraitAnimalsSheep_ca.paa",{true;},{player == leader (group player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _parentBFT] call ace_interact_menu_fnc_addActionToObject;

//SUB CATEGORIES
private _parentGround = ["parentGround","Ground","a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeUnits_ca.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT"], _parentGround] call ace_interact_menu_fnc_addActionToObject;
private _parentAir = ["parentAir","Air","\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT"], _parentAir] call ace_interact_menu_fnc_addActionToObject;

//MARKER UPDATE SYSTEM
_insertChildrenGround = {
    params ["_target", "_player", "_params"];
	private _callsign = _params select 0;

	private _infantry = ["infantry","Infantry","\A3\ui_f\data\map\markers\nato\b_inf.paa",{[(group player),"b_inf",((_this select 2) select 0)] call lmf_fnc_setCallsign; ["lmf_bft_updateIcon", [(group player),"b_inf"]] call CBA_fnc_globalEventJIP; },{true},{},[_callsign]] call ace_interact_menu_fnc_createAction;

	private _armor = ["armor","Armor","\A3\ui_f\data\map\markers\nato\b_armor.paa",{[(group player),"b_armor",((_this select 2) select 0)] call lmf_fnc_setCallsign; ["lmf_bft_updateIcon", [(group player),"b_armor"]] call CBA_fnc_globalEventJIP; },{true},{},[_callsign]] call ace_interact_menu_fnc_createAction;

	private _mortar = ["mortar","Mortar","\A3\ui_f\data\map\markers\nato\b_mortar.paa",{[(group player),"b_mortar",((_this select 2) select 0)] call lmf_fnc_setCallsign; ["lmf_bft_updateIcon", [(group player),"b_mortar"]] call CBA_fnc_globalEventJIP; },{true},{},[_callsign]] call ace_interact_menu_fnc_createAction;

	private _medical = ["medical","Medical","\A3\ui_f\data\map\markers\nato\b_med.paa",{[(group player),"b_med",((_this select 2) select 0)] call lmf_fnc_setCallsign; ["lmf_bft_updateIcon", [(group player),"b_med"]] call CBA_fnc_globalEventJIP; },{true},{},[_callsign]] call ace_interact_menu_fnc_createAction;

    // Add children to this action
	private _actionsIDs = [_infantry,_armor,_mortar,_medical];
	private _return = [];
    {
        _return pushBack [_x, [], _player]; // New action, it's children, and the action's target
    } forEach _actionsIDs;

    _return
};

_insertChildrenAir = {
    params ["_target", "_player", "_params"];
	private _callsign = _params select 0;

	private _heli = ["heli","Helicopter","\A3\ui_f\data\map\markers\nato\b_air.paa",{[(group player),"b_air",((_this select 2) select 0)] call lmf_fnc_setCallsign; ["lmf_bft_updateIcon", [(group player),"b_air"]] call CBA_fnc_globalEventJIP; },{true},{},[_callsign]] call ace_interact_menu_fnc_createAction;

	private _plane = ["plane","Plane","\A3\ui_f\data\map\markers\nato\b_plane.paa",{[(group player),"b_plane",((_this select 2) select 0)] call lmf_fnc_setCallsign; ["lmf_bft_updateIcon", [(group player),"b_plane"]] call CBA_fnc_globalEventJIP; },{true},{},[_callsign]] call ace_interact_menu_fnc_createAction;

    // Add children to this action
	private _actionsIDs = [_heli,_plane];
	private _return = [];
    {
        _return pushBack [_x, [], _player]; // New action, it's children, and the action's target
    } forEach _actionsIDs;

    _return
};

//INFANTRY GROUPS
//1ST PLATOON
private _parent1st = ["parent1st","1PLT","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parent1st] call ace_interact_menu_fnc_addActionToObject;
private _1hq = ["1HQ","1/HQ","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["1/HQ"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent1st"], _1hq] call ace_interact_menu_fnc_addActionToObject;
private _1a = ["1A","1A","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["1A"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent1st"], _1a] call ace_interact_menu_fnc_addActionToObject;
private _1b = ["1B","1B","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["1B"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent1st"], _1b] call ace_interact_menu_fnc_addActionToObject;
private _1C = ["1C","1C","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["1C"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent1st"], _1C] call ace_interact_menu_fnc_addActionToObject;
private _1D = ["1D","1D","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["1D"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent1st"], _1D] call ace_interact_menu_fnc_addActionToObject;

//2ND PLATOON
private _parent2nd = ["parent2nd","2PLT","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parent2nd] call ace_interact_menu_fnc_addActionToObject;
private _2hq = ["2HQ","2/HQ","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["2/HQ"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent2nd"], _2hq] call ace_interact_menu_fnc_addActionToObject;
private _2a = ["2A","2A","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["2A"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent2nd"], _2a] call ace_interact_menu_fnc_addActionToObject;
private _2b = ["2B","2B","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["2B"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent2nd"], _2b] call ace_interact_menu_fnc_addActionToObject;
private _2c = ["2C","2C","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["2C"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent2nd"], _2c] call ace_interact_menu_fnc_addActionToObject;
private _2d = ["2D","2D","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["2D"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent2nd"], _2d] call ace_interact_menu_fnc_addActionToObject;

//3RD PLATOON
private _parent3rd = ["parent3rd","3PLT","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parent3rd] call ace_interact_menu_fnc_addActionToObject;
private _3hq = ["3HQ","3/HQ","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["3/HQ"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent3rd"], _3hq] call ace_interact_menu_fnc_addActionToObject;
private _3a = ["3A","3A","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["3A"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent3rd"], _3a] call ace_interact_menu_fnc_addActionToObject;
private _3b = ["3B","3B","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["3B"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent3rd"], _3b] call ace_interact_menu_fnc_addActionToObject;
private _3c = ["3C","3C","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["3C"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent3rd"], _3c] call ace_interact_menu_fnc_addActionToObject;
private _3d = ["3D","3D","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenGround,["3D"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parent3rd"], _3d] call ace_interact_menu_fnc_addActionToObject;
/*
//MIKE
private _parentM = ["parentM","MIKE","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parentM] call ace_interact_menu_fnc_addActionToObject;
private _m1 = ["m1","M1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["M1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentM"], _m1] call ace_interact_menu_fnc_addActionToObject;
private _m2 = ["m2","M2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["M2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentM"], _m2] call ace_interact_menu_fnc_addActionToObject;
private _m3 = ["m3","M3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["M3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentM"], _m3] call ace_interact_menu_fnc_addActionToObject;
private _m4 = ["m4","M4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["M4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentM"], _m4] call ace_interact_menu_fnc_addActionToObject;

//ROMEO
private _parentR = ["parentR","ROMEO","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parentR] call ace_interact_menu_fnc_addActionToObject;
private _r1 = ["r1","R1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["R1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentR"], _r1] call ace_interact_menu_fnc_addActionToObject;
private _r2 = ["r2","R2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["R2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentR"], _r2] call ace_interact_menu_fnc_addActionToObject;
private _r3 = ["r3","R3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["R3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentR"], _r3] call ace_interact_menu_fnc_addActionToObject;
private _r4 = ["r4","R4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["R4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentR"], _r4] call ace_interact_menu_fnc_addActionToObject;

//SIERRA
private _parentS = ["parentS","SIERRA","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parentS] call ace_interact_menu_fnc_addActionToObject;
private _s1 = ["s1","S1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["S1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentS"], _s1] call ace_interact_menu_fnc_addActionToObject;
private _s2 = ["s2","S2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["S2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentS"], _s2] call ace_interact_menu_fnc_addActionToObject;
private _s3 = ["s3","S3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["S3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentS"], _s3] call ace_interact_menu_fnc_addActionToObject;
private _s4 = ["s4","S4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["S4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentS"], _s4] call ace_interact_menu_fnc_addActionToObject;

//WHISKEY
private _parentW = ["parentW","WHISKEY","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround"], _parentW] call ace_interact_menu_fnc_addActionToObject;
private _w1 = ["w1","W1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["W1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentW"], _w1] call ace_interact_menu_fnc_addActionToObject;
private _w2 = ["w2","W2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["W2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentW"], _w2] call ace_interact_menu_fnc_addActionToObject;
private _w3 = ["w3","W3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["W3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentW"], _w3] call ace_interact_menu_fnc_addActionToObject;
private _w4 = ["w4","W4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildren,["W4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentGround","parentW"], _w4] call ace_interact_menu_fnc_addActionToObject;
*/
//AIR GROUPS
/*
//CONDOR FLIGHT
private _parentCondor = ["parentCondor","CONDOR Flight","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentCondor] call ace_interact_menu_fnc_addActionToObject;
private _condor1 = ["condor1","CONDOR1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["CDR1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor1] call ace_interact_menu_fnc_addActionToObject;
private _condor2 = ["condor2","CONDOR2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["CDR2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor2] call ace_interact_menu_fnc_addActionToObject;
private _condor3 = ["condor3","CONDOR3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["CDR3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor3] call ace_interact_menu_fnc_addActionToObject;
private _condor4 = ["condor4","CONDOR4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["CDR4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentCondor"], _condor4] call ace_interact_menu_fnc_addActionToObject;
*/

//EAGLE FLIGHT
private _parentEagle = ["parentEagle","EAGLE Flight","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentEagle] call ace_interact_menu_fnc_addActionToObject;
private _eagle1 = ["eagle1","EAGLE1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["EGL1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle1] call ace_interact_menu_fnc_addActionToObject;
private _eagle2 = ["eagle2","EAGLE2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["EGL2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle2] call ace_interact_menu_fnc_addActionToObject;
private _eagle3 = ["eagle3","EAGLE3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["EGL3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle3] call ace_interact_menu_fnc_addActionToObject;
private _eagle4 = ["eagle4","EAGLE4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["EGL4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentEagle"], _eagle4] call ace_interact_menu_fnc_addActionToObject;

//FALCON FLIGHT
private _parentFalcon = ["parentFalcon","FALCON Flight","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentFalcon] call ace_interact_menu_fnc_addActionToObject;
private _falcon1 = ["falcon1","FALCON1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["FLC1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon1] call ace_interact_menu_fnc_addActionToObject;
private _falcon2 = ["falcon2","FALCON2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["FLC2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon2] call ace_interact_menu_fnc_addActionToObject;
private _falcon3 = ["falcon3","FALCON3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["FLC3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon3] call ace_interact_menu_fnc_addActionToObject;
private _falcon4 = ["falcon4","FALCON4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["FLC4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentFalcon"], _falcon4] call ace_interact_menu_fnc_addActionToObject;

//HAWK FLIGHT
private _parentHawk = ["parentHawk","HAWK Flight","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir"], _parentHawk] call ace_interact_menu_fnc_addActionToObject;
private _hawk1 = ["hawk1","HAWK1","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["HWK1"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk1] call ace_interact_menu_fnc_addActionToObject;
private _hawk2 = ["hawk2","HAWK2","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["HWK2"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk2] call ace_interact_menu_fnc_addActionToObject;
private _hawk3 = ["hawk3","HAWK3","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["HWK3"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk3] call ace_interact_menu_fnc_addActionToObject;
private _hawk4 = ["hawk4","HAWK4","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{},{true},_insertChildrenAir,["HWK4"]] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","parentBFT","parentAir","parentHawk"], _hawk4] call ace_interact_menu_fnc_addActionToObject;

//EVENT HANDLERS //////////////////////////////////////////////////////////////////////////////////
//WAIT UNTIL TIME IS BIGGER THAN 1 (to avoid intro glitches)
waitUntil {sleep 1; time > 1};

//MOUSE HOVER OVER ICON EH
private _hoverEH = addMissionEventHandler ["GroupIconOverEnter",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	private _iconParams = getGroupIconParams _group;
	_group setGroupIconParams [_iconParams select 0,_iconParams select 1,1,true];
}];

//MOUSE HOVER LEAVE ICON EH
private _hoverLeaveEH = addMissionEventHandler ["GroupIconOverLeave",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	private _iconParams = getGroupIconParams _group;
	_group setGroupIconParams [_iconParams select 0,_iconParams select 1,0.75,true];

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
			"<t shadow='2' font='PuristaBold' color='#FFBA26' size='0.75'align='center'>%1</t><br/><t shadow='2' color='#FFFFFF' size='0.5'align='center'>%2</t><br/><t shadow='2' color='#D7DBD5' size='0.5'align='center'>%3</t>",
			_iconParams select 1,_leaderName,_nameList
		];

		//CREATE LAYER AND SPAWN TEXT
		private _layerID = ["lmf_layer2"] call BIS_fnc_rscLayer;
		[_textToDisplay,(getMousePosition#0) - 0.65,(getMousePosition#1) - 0.1,10,0,0,_layerID] spawn BIS_fnc_dynamicText;

		//MAKE SURE TEXT FADES WHEN EXITING MAP
		[{!visibleMap},{"lmf_layer2" cutFadeOut 0},[]] call CBA_fnc_waitUntilAndExecute;
	};
}];