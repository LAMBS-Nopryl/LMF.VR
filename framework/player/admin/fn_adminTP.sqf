// ADMIN TP //////////////////////////////////////////////////////////////////////////////////
/*
	- Function to teleport alive players that are not in vehicles to a 10m radius around the caller.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

if (!hasInterface || {!alive player || {vehicle player isKindOf "Air" || {_unit == player}}}) exitWith {};

player allowDamage false;
player setVelocity [0,0,0];
player action ["Eject",vehicle player];
player setPosATL (_unit getPos [random 10, random 360]);
player switchMove "";
player allowDamage true;