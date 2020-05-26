// KILLED EVENT HANDLER FUNCTION //////////////////////////////////////////////////////////////////
/*
	- This function called in the killed EH applied to all defined AI handles what happens on the
	  AIs death.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];
if !(local _unit) exitWith {};

_hmd = hmd _unit;
_binocular = binocular _unit;

_unit unlinkItem _hmd;
_unit removeWeapon _binocular;

removeAllPrimaryWeaponItems _unit;