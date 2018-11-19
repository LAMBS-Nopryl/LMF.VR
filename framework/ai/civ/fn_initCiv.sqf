// INIT AI CIV ////////////////////////////////////////////////////////////////////////////////////
/*
	- Initializes civilians to handle being shot at.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];
if (!var_civPanic || {isNull _unit}) exitWith {};
// civ is already paniced, no need for new EHs
if (_unit getVariable ["lmf_ai_civ_paniced",false]) exitWith {};

private _id = _unit addEventHandler["FiredNear",{
	_this call lmf_ai_civ_fnc_firedNear;
}];
_unit setVariable ["lmf_ai_civ_fired_near_EH", _id];

//LOKAL EH (To remove and reapply all EHs if locality changes.)
private _id = _unit addEventHandler ["Local", {
	params ["_unit"];
	_unit removeEventHandler ["FiredNear", _unit getVariable ["lmf_ai_civ_fired_near_EH", -1]];
	_unit removeEventHandler ["Local", _unit getVariable ["lmf_ai_civ_local_EH" ,-1]];
	//REAPPLY EHS
	["lmf_ai_civ_listener", [_unit], _unit] call CBA_fnc_targetEvent;
}];
_unit setvariable ["lmf_ai_civ_local_EH", _id];