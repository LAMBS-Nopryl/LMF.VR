// KILLED EVENT HANDLER FUNCTION //////////////////////////////////////////////////////////////////
/*
	- This function called in the killed EH applied to all defined AI handles what happens on the
	  AIs death.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];
if !(local _unit) exitWith {};
removeAllPrimaryWeaponItems _unit;
_unit unlinkItem "NVGoggles_OPFOR";
_unit removeWeapon "Binocular";