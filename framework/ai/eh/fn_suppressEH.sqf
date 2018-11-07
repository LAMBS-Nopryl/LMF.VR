// SUPPRESSION EVENT HANDLER FUNCTION /////////////////////////////////////////////////////////////
/*
	- This function called in the Suppression EH applied to AR and MMG type AI handles if/what
	  information gets passed to the actual suppression function.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

//EXIT IF NOT READY
if !(local _unit) exitWith {};
if (_unit getVariable ["var_isSuppressing",false]) exitWith {};

//EXIT IF WRONG RANGE
private _target = (_unit findNearestenemy _unit);
private _dist = _unit distance _target;
if (_dist < 50 || {_dist  > 800}) exitWith {};

//DEFINE PARAMS TO PASS
private _timesFired = round (3 + random 6);
private _modes = (getArray (configFile >> "CfgWeapons" >> currentWeapon _unit >> "modes"));
private _mode = "FullAuto";
if (_modes findif {"FullAuto" == _x} == -1) then {_mode = "close"};
private _resetMagazine = false;

//SPAWN THE SUPPRESSION FUNCTION
[_unit,_target,_timesFired,_resetMagazine,_mode] spawn lmf_ai_fnc_taskSuppress;