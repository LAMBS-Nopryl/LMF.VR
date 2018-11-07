// JIP TELEPORT FOR JIPING PLAYERS ////////////////////////////////////////////////////////////////
/*
	- File that adds an ace action to the player for JIP-teleport. Ace condition requires respawn marker
	  to work.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {speed player > 1};

//EXIT IF TOO CLOSE FOR JIP TP OR IF UNIT IS ALONE OR IF ALL HIS GROUP MEMBERS ARE DEAD
if ((([] call CBA_fnc_players) - [player]) findIf {_x distance2D player < 200} != -1) exitWith {};
if !(count units group player > 1) exitWith {};
if !({alive _x} count units group player > 1) exitWith {};

//GIVE PLAYER JIP HINT
private _response = [
"Welcome to the mission!<br/><br/>
You can use the 'TELEPORT TO GROUP' action in your ACE3 self interaction menu to teleport to your group.<br/>
If you move too far away from the spawn area or after approx. 5 minutes the action will disappear.<br/><br/>
Have fun!","JIP TELEPORT AVAILABLE",true,false
] call BIS_fnc_guiMessage;

//ACE JIP ACTION
private _jipActionCode = {
	private _target = [] call lmf_player_fnc_jipChooseTarget;
	private _vicSpot = [_target] call lmf_player_fnc_jipEmptySeat;

	player allowDamage false;
	cutText  ["", "BLACK OUT", 1, true];
	if (_vicSpot) then {
		player moveInAny vehicle _target;
	} else {
		player setPosATL (_target getPos [3, getDir _target - 180]);
	};
	cutText  ["", "BLACK IN", 1, true];
	player allowDamage true;

};

//CREATE SELF INTERACTION
player setVariable ["_sPos" ,getPosASL player];
private _jipTeleAction = ["tpToGroup","TELEPORT TO GROUP","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa",_jipActionCode,{player distance2D (player getvariable ["_sPos",[0,0,0]]) < 200}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _jipTeleAction] call ace_interact_menu_fnc_addActionToObject;

//REMOVE ACTION AFTER 300 SECONDS
[{[player,1,["ACE_SelfActions","tpToGroup"]] call ace_interact_menu_fnc_removeActionFromObject;}, [], 300] call CBA_fnc_waitAndExecute;