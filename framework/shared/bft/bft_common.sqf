// BFT COMMON FUNCTIONS AND VARIABLES /////////////////////////////////////////////////////////////
/*
	- Various needed for the BFT system.
*/

//Checks if callsign is available
lmf_fnc_callsignAvailable = {
	params [["_grp",grpNull],["_txt",""]];

	_groupUsingCallsign = [];
	_groupUsingCallsign = allGroups select {_x getVariable "lmf_bft_callsign" == _txt && {{alive _x} count units _x > 0} && _x != _grp};
	if (_groupUsingCallsign isEqualTo []) then {true} else {false};
};

//Sets callsign and applies icon
lmf_fnc_setCallsign = {
    params [["_grp",grpNull],["_type","b_inf"],["_txt",""]];

    if !([_grp, _txt] call lmf_fnc_callsignAvailable) exitWith {systemChat format ["Callsign %1 already in use", _txt];};

	_grp setVariable ["lmf_bft_callsign", _txt, true];

    ["lmf_bft_createIcon", [_grp,_type,_txt]] call CBA_fnc_globalEventJIP;

    if (time > 10) then {systemChat format ["Callsign set to %1", _txt];};
};