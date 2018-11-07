// ARES ZEUS FUNCTIONS  ///////////////////////////////////////////////////////////////////////////
/*
	- If Ares-Achilles is on this file will create several zeus modules in the spawn sections to
	  spawn AI performing various tasks.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//GARRISON
["Spawn", "LMF Spawn AI Garrison", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Garrison",
		[
			["Group Type or Number", "OPTION", "TEAM"],
			["Garrison Radius", "RADIUS", "100"],
			["Fill Evenly", ["YES", "NO"], 1]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option","_radius", "_distribution"];

	private _optionSelect = parseNumber _option;
	if (_optionSelect != 0) then {
		_option = _optionSelect;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _radius, _distribution] remoteExec ["lmf_ai_fnc_garrison"];
}] call Ares_fnc_RegisterCustomModule;

//HUNTER
["Spawn", "LMF Spawn AI Hunter", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Hunter",
		[
			["Group Type or Number", "OPTION", "TEAM"],
			["Hunter Radius", "RADIUS", "500"],
			["Spawn Tickets", "NUMBER", "1"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option","_radius","_tickets"];

	private _optionSelect = parseNumber _option;
	if (_optionSelect != 0) then {
		_option = _optionSelect;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _radius, parseNumber _tickets] remoteExec ["lmf_ai_fnc_infantryHunter"];
}] call Ares_fnc_RegisterCustomModule;

//INFANTRY QRF
["Spawn", "LMF Spawn AI Infantry QRF", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Infantry QRF",
		[
			["Group Type or Number", "OPTION", "TEAM"],
			["Spawn Tickets", "Number", "1"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option","_tickets"];

	private _optionSelect = parseNumber _option;
	if (_optionSelect != 0) then {
		_option = _optionSelect;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _tickets] remoteExec ["lmf_ai_fnc_infantryQRF"];
}] call Ares_fnc_RegisterCustomModule;

//PATROL
["Spawn", "LMF Spawn AI Patrol", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Patrol",
		[
			["Group Type or Number", "OPTION", "TEAM"],
			["Patrol Radius", "RADIUS", "100"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option","_radius"];

	private _optionSelect = parseNumber _option;
	if (_optionSelect != 0) then {
		_option = _optionSelect;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _radius] remoteExec ["lmf_ai_fnc_patrol"];
}] call Ares_fnc_RegisterCustomModule;

//VEHICLE QRF
["Spawn", "LMF Spawn AI Vehicle QRF", {
	//SPAWNPOS
	private _pos = _this select 0;
	private _options = ["CAR","CARARMED","TURCK","APC","TANK","HELITRANSPORT","HELIATTACK"];

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Vehicle QRF",
		[
			["Vehicle Type", _options, 2],
			["Spawn Tickets", "TICKETS", "1"],
			["Respawn Timer", "TIMER", "300"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option","_tickets","_timer"];

	//CALL FUNCTION
	[_pos, _options select _option, parseNumber _tickets, parseNumber _timer] remoteExec ["lmf_ai_fnc_vehicleQRF"];
}] call Ares_fnc_RegisterCustomModule;