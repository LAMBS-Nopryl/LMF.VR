// REMOTE SAFETY /////////////////////////////////////////////////////////////////////////////////////
/*
	- Function remotely enable or disable player safety. Probably good to have to post game.
	- Important to call this on server to not experience race conditions with lmf_warmup.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit",["_state", false]];

#include "cfg_admin.sqf"

//EXIT IF STILL WARMUP
if (lmf_warmup) exitWith {"Warmup has not even ended yet!!!" remoteExec ["systemChat",_unit]};

//REMOTE EXEC DISABLE OR ENABLE PLAYER SAFETY
if (_state) then {
	if !(lmf_isSafe) then {
		[true] remoteExec ["lmf_admin_fnc_playerSafety",0];
		lmf_isSafe = true;
		"Safety On" remoteExec ["systemChat",_unit];
	};
} else {
	if (lmf_isSafe) then {
		[false] remoteExec ["lmf_admin_fnc_playerSafety",0];
		lmf_isSafe = false;
		"Safety Off" remoteExec ["systemChat",_unit];
	};
};