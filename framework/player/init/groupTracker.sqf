// GROUP MARKERS ALTERNATE /////////////////////////////////////////////////////////////////////////
/*
	- Creates group markers following around the player groups. When clicked while map is open,
	  it will list current members of the group.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//GENERAL GROUP ICON SETTINGS
if !(hasInterface) exitWith {};
setGroupIconsVisible [true,false];
setGroupIconsSelectable true;
var_iconColor = [0,0,0,1];
if (toUpper var_markerSide isEqualTo "COLORWEST") then {var_iconColor = [0,0.3,0.6,1]};
if (toUpper var_markerSide isEqualTo "COLOREAST") then {var_iconColor = [0.5,0,0,1]};
if (toUpper var_markerSide isEqualTo "COLORGUER") then {var_iconColor = [0,0.5,0,1]};


// FUNCTION CREATE THE GROUP ICON /////////////////////////////////////////////////////////////////
private _lmf_fnc_createIcon = {
	params [["_grp",grpNull],["_type","b_inf"],["_txt",""]];

	clearGroupIcons _grp;
	_grp addGroupIcon [_type,[0,0]];
	_grp setgroupIconParams [var_iconColor,_txt,1,true];
};


// WHICH GROUPS GET TRACKED ///////////////////////////////////////////////////////////////////////
//FOX PLATOON
if !(isNil "Grp_FOX_6") then {[Grp_FOX_6,"b_hq","FOX6"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FOX_1") then {[Grp_FOX_1,"b_inf","FOX1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FOX_2") then {[Grp_FOX_2,"b_inf","FOX2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FOX_3") then {[Grp_FOX_3,"b_inf","FOX3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FOX_4") then {[Grp_FOX_4,"b_inf","FOX4"] call _lmf_fnc_createIcon};

//WOLF PLATOON
if !(isNil "Grp_WOLF_6") then {[Grp_WOLF_6,"b_hq","WOLF6"] call _lmf_fnc_createIcon};
if !(isNil "Grp_WOLF_1") then {[Grp_WOLF_1,"b_inf","WOLF1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_WOLF_2") then {[Grp_WOLF_2,"b_inf","WOLF2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_WOLF_3") then {[Grp_WOLF_3,"b_inf","WOLF3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_WOLF_4") then {[Grp_WOLF_4,"b_inf","WOLF4"] call _lmf_fnc_createIcon};

//ARMOR
if !(isNil "Grp_DGR1") then {[Grp_DGR1,"b_motor_inf","DAGGER1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_DGR2") then {[Grp_DGR2,"b_motor_inf","DAGGER2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_DGR3") then {[Grp_DGR3,"b_motor_inf","DAGGER3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_DGR4") then {[Grp_DGR4,"b_motor_inf","DAGGER4"] call _lmf_fnc_createIcon};

if !(isNil "Grp_SWD1") then {[Grp_SWD1,"b_mech_inf","SWORD1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_SWD2") then {[Grp_SWD2,"b_mech_inf","SWORD2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_SWD3") then {[Grp_SWD3,"b_mech_inf","SWORD3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_SWD4") then {[Grp_SWD4,"b_mech_inf","SWORD4"] call _lmf_fnc_createIcon};

if !(isNil "Grp_HMR1") then {[Grp_HMR1,"b_armor","HAMMER1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_HMR2") then {[Grp_HMR2,"b_armor","HAMMER2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_HMR3") then {[Grp_HMR3,"b_armor","HAMMER3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_HMR4") then {[Grp_HMR4,"b_armor","HAMMER4"] call _lmf_fnc_createIcon};

//AIR
if !(isNil "Grp_FLC1") then {[Grp_FLC1,"b_air","FALCON1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FLC2") then {[Grp_FLC2,"b_air","FALCON2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FLC3") then {[Grp_FLC3,"b_air","FALCON3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_FLC4") then {[Grp_FLC4,"b_air","FALCON4"] call _lmf_fnc_createIcon};

if !(isNil "Grp_CDR1") then {[Grp_CDR1,"b_air","CONDOR1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_CDR2") then {[Grp_CDR2,"b_air","CONDOR2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_CDR3") then {[Grp_CDR3,"b_air","CONDOR3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_CDR4") then {[Grp_CDR4,"b_air","CONDOR4"] call _lmf_fnc_createIcon};

if !(isNil "Grp_HWK1") then {[Grp_HWK1,"b_air","HAWK1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_HWK2") then {[Grp_HWK2,"b_air","HAWK2"] call _lmf_fnc_createIcon};
if !(isNil "Grp_HWK3") then {[Grp_HWK3,"b_air","HAWK3"] call _lmf_fnc_createIcon};
if !(isNil "Grp_HWK4") then {[Grp_HWK4,"b_air","HAWK4"] call _lmf_fnc_createIcon};

if !(isNil "Grp_EGL1") then {[Grp_EGL1,"b_plane","EAGLE1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_EGL2") then {[Grp_EGL2,"b_plane","EAGLE1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_EGL3") then {[Grp_EGL3,"b_plane","EAGLE1"] call _lmf_fnc_createIcon};
if !(isNil "Grp_EGL4") then {[Grp_EGL4,"b_plane","EAGLE1"] call _lmf_fnc_createIcon};


//EVEN HANDLERS ///////////////////////////////////////////////////////////////////////////////////
//WAIT UNTIL TIME IS BIGGER THAN 1 (to avoid intro glitches)
waitUntil {time > 1};

//MOUSE HOVER OVER ICON EH
private _hoverEH = addMissionEventHandler ["GroupIconOverEnter",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	_group setGroupIconParams [var_iconColor,groupID _group,1.3,true];
}];

//MOUSE HOVER LEAVE ICON EH
private _hoverLeaveEH = addMissionEventHandler ["GroupIconOverLeave",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	_group setGroupIconParams [var_iconColor,groupID _group,1,true];

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
		} forEach units _group;

		private _nameList = _nameArray joinString "<br/>";
		private _textToDisplay = format [
			"<t shadow='2' color='#FFBA26' size='0.75'align='center'>%1</t><br/><t shadow='2' color='#D7DBD5' size='0.5'align='center'>%2</t>",
			groupID _group,_nameList
		];

		//CREATE LAYER AND SPAWN TEXT
		private _layerID = ["lmf_layer2"] call BIS_fnc_rscLayer;
		[_textToDisplay,(getMousePosition#0) - 0.65,(getMousePosition#1) - 0.1,10,0,0,_layerID] spawn BIS_fnc_dynamicText;

		//MAKE SURE TEXT FADES WHEN EXITING MAP
		[{!visibleMap},{"lmf_layer2" cutFadeOut 0},[]] call CBA_fnc_waitUntilAndExecute;
	};
}];