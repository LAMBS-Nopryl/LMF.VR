// END MISSION ////////////////////////////////////////////////////////////////////////////////////
/*
	- Function to end mission.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit",["_state",true]];

#include "cfg_admin.sqf"

//END MISSION DEPENDING ON STATE
if (_state) then {
	"EveryoneWon" call BIS_fnc_endMissionServer;
} else {
	"EveryoneLost" call BIS_fnc_endMissionServer;
};