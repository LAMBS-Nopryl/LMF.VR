// PLAYER PERSONAL ARSENAL ////////////////////////////////////////////////////////////////////////
/*
	- Made by Alex2k, revised by Drgn V4karian.
	- This file handles the ace self-interaction personal arsenal that allows players to customize
	  their headgear and goggles.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(var_warmup) exitWith {};
["Preload"] call BIS_fnc_arsenal;

#include "..\..\..\settings\cfg_Player.sqf"

waitUntil {sleep 1; !isNil "lmf_warmup"};
waitUntil {sleep 1; time > 7};
if !(lmf_warmup) exitWith {};


// ADD GEAR BASED ON ROLES ////////////////////////////////////////////////////////////////////////
private _role = typeOf player;
private _specialRoles = [_Crew,_HeloPilot,_HeloCrew,_Pilot,_CrewLeader,_CrewSgt];
if (_specialRoles findIf {_x == _role} == -1) then {
	[player, _Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
	[player, _Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
} else {
	if (_role == _Crew || {_role == _CrewLeader || {_role == _CrewSgt}}) then {
		[player, _Crew_Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
		[player, _Crew_Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
	};

	if (_role == _HeloPilot || {_role == _HeloCrew}) then {
		[player, _Heli_Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
		[player, _Heli_Headgear_C, false, false] call BIS_fnc_addVirtualItemCargo;
		[player, _Heli_Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
	};

	if (_role == _Pilot) then {
		[player, _Plane_Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
		[player, _Plane_Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
	};
};


// REMOVE ABILITY TO RANDOMIZE/SAVE/LOAD/EXPORT/IMPORT LOADOUTS ///////////////////////////////////
[ missionNamespace, "arsenalOpened", {
    disableSerialization;
    private _display = _this select 0;
    {
		( _display displayCtrl _x ) ctrlSetTextColor [ 1, 0, 0, 0.3 ];
        ( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
		( _display displayCtrl _x ) ctrlEnable false;
    } forEach [
		44150, //Random loadout
		44146, //Save loadout
		44147, //Load loadout
		44148, //Export loadout
		44149, //Import loadout??
		44151, //Hide interface
		954, //CONTAINER: Misc. Items
		930, //RIFLE
		931, //LAUNCHER
		932, //HANDGUN
		933, //UNIFORM
		934, //VEST
		935, //BACKPACK
		938, //NVG
		939, //BINOCULARS
		940, //MAP
		941, //TERMINAL
		942, //COMMUNICATION
		943, //NAVIGATION
		944, //WATCH
		900, //RIFLE ON CHARACTER
		901, //LAUNCHER ON CHARACTER
		902, //HANDGUN ON CHARACTER
		903, //UNIFORM ON CHARACTER
		904, //VEST ON CHARACTER
		905, //BACKPACK ON CHARACTER
		908, //NVG ON CHARACTER
		909 //BINOCULARS ON CHARACTER
	];
	_display displayAddEventHandler ["KeyDown", "true"];
} ] call BIS_fnc_addScriptedEventHandler;


// ON ARSENAL OPENED //////////////////////////////////////////////////////////////////////////////
[missionNamespace, "arsenalOpened", {
		//LIGHT IN FRONT OF PLAYER
		lmf_arsenalLight1 = "#lightpoint" createVehicleLocal position player;
		lmf_arsenalLight1 setLightBrightness 1;
		lmf_arsenalLight1 setLightAmbient [0.0, 0.0, 0.0];
		lmf_arsenalLight1 setLightColor [1.0, 1.0, 1.0];
		lmf_arsenalLight1 lightAttachObject [player, [0,3,5]];

		//LIGHT BEHIND PLAYER
		lmf_arsenalLight2 = "#lightpoint" createVehicleLocal position player;
		lmf_arsenalLight2 setLightBrightness 1;
		lmf_arsenalLight2 setLightAmbient [0.0, 0.0, 0.0];
		lmf_arsenalLight2 setLightColor [1.0, 1.0, 1.0];
		lmf_arsenalLight2 lightAttachObject [player, [0,-3,5]];
}] call BIS_fnc_addScriptedEventHandler;


// ON ARSENAL CLOSED //////////////////////////////////////////////////////////////////////////////
[missionNamespace, "arsenalClosed", {
	[player,player_insignia] call bis_fnc_setUnitInsignia;
	deleteVehicle lmf_arsenalLight1;
	deleteVehicle lmf_arsenalLight2;
}] call BIS_fnc_addScriptedEventHandler;


// ADD ACTIONS ////////////////////////////////////////////////////////////////////////////////////
//_text = format ["<t shadow='2' color='#FFBA26'>Personal Arsenal</t>"];
private _personalArsenal = ["personalArsenal","Personal Arsenal","A3\ui_f_orange\Data\CfgOrange\Missions\orange_escape_ca.paa",{["Open",[false,player, player]] spawn bis_fnc_arsenal; player action ["SwitchWeapon", player, player, 100];},{lmf_warmup}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _personalArsenal] call ace_interact_menu_fnc_addActionToObject;