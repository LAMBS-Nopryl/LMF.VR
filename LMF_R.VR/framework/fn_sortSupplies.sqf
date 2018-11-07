// SORTING FUNCTION FOR SUPPLIES //////////////////////////////////////////////////////////////////
/*
	- File that handles what happens to created ammo boxes.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _supp = _this select 0;

//EXIT IF NOT LOCAL OR PLAYER HASN'T DEFINED CUSTOM GEAR
if !(local _supp) exitWith {};
if !(var_playerGear) exitWith {};

//WHICH SUPPLIES ARE AFFECTED?
private _type = typeof _supp;
private _allSupplies = [var_supSmall,var_supLarge,var_supSpecial,var_supExplosives];
if (_allSupplies findIf {_type == _x} == -1) exitWith {};

//CALL THE FUNCTION
[_supp] call lmf_player_fnc_initPlayerSupp;