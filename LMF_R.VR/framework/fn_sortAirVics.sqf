// SORTING FUNCTION FOR AIR VEHICLES //////////////////////////////////////////////////////////////
/*
	- File that handles what happens to created air vehicles.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _air = _this select 0;

//EXIT IF NOT LOCAL
if !(local _air) exitWith {};

//WHICH VEHICLES CONTINUE?
#include "..\settings\cfg_AI.sqf"
private _type = typeOf _air;
private _AirVics = [_heli_Transport, _heli_Attack];

//AI DEFINED VEHICLES
if (
	(_AirVics select 0) findif {_type == _x} != -1 ||
	{(_AirVics select 1) findif {_type == _x} != -1}
) then {[_air] call lmf_ai_fnc_initAir;};

//PLAYER VEHICLES
if !(var_playerGear) exitWith {};
if (_type == var_air1 || {_type == var_air2 || {_type == var_air3 || {_type == var_air4}}}) then {
	[_air] call lmf_player_fnc_initPlayerAir;
};