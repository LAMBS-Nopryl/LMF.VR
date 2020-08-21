// END MISSION ////////////////////////////////////////////////////////////////////////////////////
/*
	- Function to end mission.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit",["_state",true]];

#include "cfg_admin.sqf"

lmf_hintVictory = {
	["LMFvictory",["MISSION COMPLETED"]] call BIS_fnc_showNotification;
}; 
lmf_hintDefeat = {
	["LMFdefeat",["MISSION FAILED"]] call BIS_fnc_showNotification;
}; 

//END MISSION DEPENDING ON STATE
[_unit,_state] spawn {
params ["_unit",["_state",true]];
	if (_state) then {
		_result = ["Are you sure?", "CONFIRM: MISSION COMPLETED", "END MISSION", true] call BIS_fnc_guiMessage;
		if (_result) then {
			remoteExec ["lmf_hintVictory"];
			sleep 10;
			["EveryoneWon"] remoteExec ["BIS_fnc_endMissionServer", 2];
		};
	} else {
		_result = ["Are you sure?", "CONFIRM: MISSION FAILED", "END MISSION", true] call BIS_fnc_guiMessage;
		if (_result) then {
			remoteExec ["lmf_hintDefeat"];
			sleep 10;
			["EveryoneLost"] remoteExec ["BIS_fnc_endMissionServer", 2];
		};
	};
};