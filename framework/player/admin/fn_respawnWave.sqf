// RESPAWN WAVE FUNCTION //////////////////////////////////////////////////////////////////////////
/*
	- Function to add a respawn wave (5 seconds).
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//MAKE PEOPLE RESPAWN
[] spawn {
	[5] remoteExec ["setPlayerRespawnTime", 0];
	sleep 6;
	[var_respawnTime] remoteExec ["setPlayerRespawnTime", 0];
};