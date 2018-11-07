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

waitUntil {time > 10};
waitUntil {!isNil "lmf_warmup"};
if !(lmf_warmup) exitWith {};


// ADD GEAR BASED ON ROLES ////////////////////////////////////////////////////////////////////////
private _role = roleDescription player;
private _veh = _role find "Vehicle" >= 0;
private _heli = _role find "Heli" >= 0;
private _fighter = _role find "Fighter" >= 0;


if (!_heli && {!_veh && {!_fighter}}) then {
	[player, _Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
	[player, _Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
} else {
	if (_veh) then {
		[player, _Crew_Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
		[player, _Crew_Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
	};

	if (_heli) then {
		[player, _Heli_Headgear, false, false] call BIS_fnc_addVirtualItemCargo;
		[player, _Heli_Goggles, false, false] call BIS_fnc_addVirtualItemCargo;
	};

	if (_fighter) then {
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
    } forEach [44150,44146,44147,44148,44149,44151,954,930,931,932,933,934,935,938,939,940,941,942,943,944,900,901,902,903,904,905,908,909];

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


// ADD ACTION /////////////////////////////////////////////////////////////////////////////////////
private _personalArsenal = ["personalArsenal","Personal Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",{["Open",[false,player, player]] spawn bis_fnc_arsenal; player action ["SwitchWeapon", player, player, 100];},{lmf_warmup}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","ACE_Equipment"], _personalArsenal] call ace_interact_menu_fnc_addActionToObject;