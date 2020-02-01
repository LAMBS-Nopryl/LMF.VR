// END WARMUP /////////////////////////////////////////////////////////////////////////////////////
/*
	- Function to end warmup phase.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//END WARMUP IF IT HAS NOT BEEN ENDED ALREADY
[] spawn {
	if (lmf_warmup) then {
		_result = ["Are you sure?", "CONFIRM: START MISSION NOW", "START MISSION", true] call BIS_fnc_guiMessage;
		if (_result) then {
			lmf_warmup = false;
			publicvariable "lmf_warmup";
		};
	};
};