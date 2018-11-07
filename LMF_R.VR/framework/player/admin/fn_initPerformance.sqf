// PERFORMANCE CHECK INIT /////////////////////////////////////////////////////////////////////////
/*
	- Function that throws out non-admins and passes valid admin to the performance check
	  function.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//CALL PERFORMANCE CHECK GLOBALLY
[_unit] remoteExec ["lmf_admin_fnc_performanceCheck",0];