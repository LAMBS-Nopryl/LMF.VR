// CFG FOR ADMINS /////////////////////////////////////////////////////////////////////////////////
/*
	- This file handles who is an admin and gets to execute admin functions. It is included in all
	  admin related functions.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _admin = false;
private _uid = getPlayerUID _unit;
private _adminList =  [
"76561197962792796", // nkenny
"76561197972953971", // MoonDawg
"76561197972498138", // Liquid Tracer
"76561197968829665", // Alex2k
"76561198202783595", // Aizen
"76561197997590271", // G4rrus
"_SP_PLAYER_"
];

//CHECK IF ADMIN
if (admin owner _unit > 0 || {_adminList findIf {_x == _uid} != -1}) then {_admin = true};

//IF NOT
if !(_admin) exitWith {"Only for certified members!!!" remoteExec ["systemChat",_unit]};