// ZEN ZEUS FUNCTIONS  ///////////////////////////////////////////////////////////////////////////
/*
	- If Zen is on this file will create several zeus modules in the "LMF" section.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//DEFINE AVAILABLE OPTIONS FOR MODULES
LMF_groupTypes = ["TEAM", "SQUAD", "SENTRY","ATTEAM","AATEAM", "MGTEAM","CUSTOM AMOUNT"];

//RE-APPLY LOADOUT
["LMF", "Re-apply Loadout", {
	//GET PASSED PARAMS
	params ["", "_obj"];

	//EXIT IF NO UNIT
	if (isNull _obj) exitWith {["ERROR: No Unit"] call zen_common_fnc_showMessage};

	//IF THERE IS A DUDE GIVE LOADOUT
	[_obj] remoteExec ["lmf_player_fnc_initPlayerGear"];

}] call zen_custom_modules_fnc_register;

//RESPAWN SINGLE Player
["LMF", "Respawn Single Player",{
	private _players = [] call ace_spectator_fnc_players;
	if (count _players == 0) exitWith {["ERROR: No Dead Players"] call zen_common_fnc_showMessage};
	private _names = _players apply {name _x};
	["Respawn Single Player",[
		//PARAMS
		["COMBO", "Player", [_players, _names]]
	],{
		//PARSE PARAMS
		params ["_dialog"];
		_dialog params [["_plr",objNull,[objNull]]];
		if (isNull _plr) exitWith {["ERROR: Unable To Find Player"] call zen_common_fnc_showMessage};

		//RESPAWN DUDE AND SHOW MESSAGE
		[5] remoteExec ["setPlayerRespawnTime",_plr];
		["Respawned %1",name _plr] call zen_common_fnc_showMessage;
  	},{},[]] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI GARRISON
["LMF", "AI: Infantry Garrison",{
	["Garrison",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]],
		["EDIT","Garrison Radius",["100"]],
		["CHECKBOX","Fill Evenly",false]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount","_radius","_distrib"];

		_pos = ASLToATL _pos;
		_radius = parseNumber _radius;
		_distrib = [0,1] select !_distrib;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type,_radius,_distrib] remoteExec ["lmf_ai_fnc_garrison"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI PATROL
["LMF", "AI: Infantry Patrol",{
	["Patrol",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]],
		["EDIT","Patrol Radius",["100"]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount","_radius"];

		_pos = ASLToATL _pos;
		_radius = parseNumber _radius;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type,_radius] remoteExec ["lmf_ai_fnc_patrol"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI QRF
["LMF", "AI: Infantry QRF",{
	["QRF",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount"];

		_pos = ASLToATL _pos;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type] remoteExec ["lmf_ai_fnc_infantryQRF"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI HUNTER
["LMF", "AI: Infantry Hunter",{
	["Hunter",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]],
		["EDIT","Hunting Radius",["500"]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount","_radius"];

		_pos = ASLToATL _pos;
		_radius = parseNumber _radius;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type,_radius] remoteExec ["lmf_ai_fnc_infantryHunter"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//VEHICLE QRF
["LMF", "AI: Vehicle QRF",{
	private _options = ["CAR","CARARMED","TRUCK","APC","TANK","HELITRANSPORT","HELIATTACK"];
	["Vehicle QRF",[
		//PARAMS
		["COMBO","Vehicle Type",[_options,_options,2]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type"];

		_pos = ASLToATL _pos;

		// CALL FUNCTION
		[_pos,_type] remoteExec ["lmf_ai_fnc_vehicleQRF"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//PARA QRF
["LMF", "AI: Para QRF",{
	//PARAMS
	private _pos = ASLToATL (_this#0);

	//CALL FUNCTION
	[_pos] remoteExec ["lmf_ai_fnc_paraQRF"];
}] call zen_custom_modules_fnc_register;

//STATIC WEAPON QRF
["LMF", "AI: Static Weapon QRF",{
	private _HWO = ["MORTAR","HMG","HAT"];
	["Static Weapon QRF",[
		//PARAMS
		["COMBO","Group Type",[_HWO,_HWO,0]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type"];

		_pos = ASLToATL _pos;

		// CALL FUNCTION
		[_pos,_type] remoteExec ["lmf_ai_fnc_staticQRF"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;