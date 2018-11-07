// AI SUPPRESSION FUNCTION ////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny (Heavily inspired by Big_Wilk).
 	- Revised by Drgn V4karian with great help from Diwako.
	- This function called by the Suppression EH function handles the task of suppressing
	  assigned to AR and MMG type AI.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull],["_target",objNull],["_timesFired",10],["_resetMagazine",false],["_mode","FullAuto"]];
if (isNull _unit) exitWith {
	if (var_debug) then {
		systemChat "No Suppressing Unit!";
	};
};
if (isNull _target) exitWith {
	if (var_debug) then {
		systemChat "No Targets to Suppress!";
	};
};
if !(local _unit) exitWith {};

private _time = _timesFired + time;

//POSITIONS (give _unit positions to watch and make suppression less deadly)
private _positions = [];
_positions pushback ((getPosATL _target) vectorAdd [0,0,random 0.5]);
_positions pushback ((_target getpos [random 6,random 360]) vectorAdd [0,0,random 0.5]);
_positions pushback ((_target getpos [random 6,random 360]) vectorAdd [0,0,random 0.5]);

//DEBUG
if (var_debug) then {
	{
		private _veh = "Sign_Arrow_Large_Blue_F" createVehicle _x;
		_veh enableSimulation false;
	} count _positions;
};

//GET UNIT READY
_unit doWatch (selectRandom _positions);
(group _unit) setFormDir (_unit getDir (_positions select 0));
_unit doTarget _target;
_unit setVariable ["var_isSuppressing", true];
doStop _unit;
_unit disableAI "PATH";
sleep 0.1;


// MAKE IT HAPPEN /////////////////////////////////////////////////////////////////////////////////
while {time < _time && {alive _unit}} do {
	if (_resetMagazine) then {_unit setAmmo [primaryWeapon _unit, 100]};
	_unit doWatch (selectRandom _positions);
	_unit forceWeaponFire [(primaryWeapon _unit), _mode];
	sleep 0.1;
};


// RESET THE UNIT IF STILL ALIVE //////////////////////////////////////////////////////////////////
if !(alive _unit) exitWith {};

_unit setVariable ["var_isSuppressing",false];
_unit doFollow leader group _unit;
_unit enableAI "PATH";
if (var_debug) then {systemchat format ["%1 is ready (%2s)",name _unit,_timesFired]};