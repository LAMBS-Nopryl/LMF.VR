// END MISSION ////////////////////////////////////////////////////////////////////////////////////
/*
	- Function to end mission.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit",["_state",true]];

#include "cfg_admin.sqf"

lmf_hintVictory = {
	hint parsetext format ["<br/><t align='center' font='PuristaBold' color='#A3FFA3' size='1.5'>MISSION COMPLETED</t><br/><t align='center' color='#FFFFFF' size='1.0'>%1</t><br/><t align='center' color='#D7DBD5' size='1.0'>by: %2</t><br /><br />",briefingName,var_author];
	sleep 8;
	hint "";
}; 
lmf_hintDefeat = {
	hint parsetext format ["<br/><t align='center' font='PuristaBold' color='#F2513C' size='1.5'>MISSION FAILED</t><br/><t align='center' color='#FFFFFF' size='1.0'>%1</t><br/><t align='center' color='#D7DBD5' size='1.0'>by: %2</t><br /><br />",briefingName,var_author];
	sleep 8;
	hint "";
}; 

//END MISSION DEPENDING ON STATE
[_unit,_state] spawn {
params ["_unit",["_state",true]];
	if (_state) then {
		_result = ["Are you sure?", "CONFIRM: MISSION COMPLETED", "END MISSION", true] call BIS_fnc_guiMessage;
		if (_result) then {
			remoteExec ["lmf_hintVictory"];
			sleep 8;
			["EveryoneWon"] remoteExec ["BIS_fnc_endMissionServer", 2];
		};
	} else {
		_result = ["Are you sure?", "CONFIRM: MISSION FAILED", "END MISSION", true] call BIS_fnc_guiMessage;
		if (_result) then {
			remoteExec ["lmf_hintDefeat"];
			sleep 8;
			["EveryoneLost"] remoteExec ["BIS_fnc_endMissionServer", 2];
		};
	};
};