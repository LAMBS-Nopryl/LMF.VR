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

//GET UNIT READY
_distanceToTarget = _unit distance2D _target;
_skillOld = skill _unit;
_skillNew = ((_distanceToTarget/100) * _skillOld);
if (_skillNew < _skillOld) then {_skillNew = _skillOld};
_unit setSkill _skillnew;
_unit doWatch _target;
(group _unit) setFormDir (_unit getDir _target);
_unit doTarget _target;
_unit setVariable ["var_isSuppressing", true];
doStop _unit;
_unit disableAI "PATH";
sleep 0.1;


// MAKE IT HAPPEN /////////////////////////////////////////////////////////////////////////////////
while {time < _time && {alive _unit}} do {
	if (_resetMagazine) then {_unit setAmmo [primaryWeapon _unit, 100]};
	_unit doWatch _target;
	_unit forceWeaponFire [(primaryWeapon _unit), _mode];
	sleep 0.1;
};


// RESET THE UNIT IF STILL ALIVE //////////////////////////////////////////////////////////////////
if !(alive _unit) exitWith {};

_unit setSkill _skillOld;
_unit doFollow leader group _unit;
_unit enableAI "PATH";
_unit setVariable ["var_isSuppressing",false];
if (var_debug) then {systemchat format ["%1 is ready (%2s)",name _unit,_timesFired]};