// RESPAWN WAVE FUNCTION //////////////////////////////////////////////////////////////////////////
/*
	- Function to add a respawn wave (5 seconds).
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//MAKE PEOPLE RESPAWN
[] spawn {
	_result = ["Are you sure?", "CONFIRM: RESPAWN ALL DEAD PLAYERS", "RESPAWN", true] call BIS_fnc_guiMessage;
	if (_result) then {
		[5] remoteExec ["setPlayerRespawnTime", 0];
	};
};