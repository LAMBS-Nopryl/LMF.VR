// AI STATIC WEAPON QRF ///////////////////////////////////////////////////////////////////////////
/*
	- Handles Static Weapon behaviour
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_grp",["_type","HMG"]];
#include "..\..\..\settings\cfg_AI.sqf"

_grp enableIRLasers false;
_grp enableGunLights "ForceOff";

private _gunner = (units _grp) select 0;
private _assistant = (units _grp) select 1;

//ADD CORRECT BACKPACKS
removeBackpack _gunner;
removeBackpack _assistant;
if (_type == "HMG") then {
_gunner addBackpack selectRandom _Backpack_HMG_Gun;
_assistant addBackpack selectRandom _Backpack_HMG_Pod;
};
if (_type == "MORTAR") then {
	_gunner addBackpack selectRandom _Backpack_MORTAR_Gun;
	_assistant addBackpack selectRandom _Backpack_MORTAR_Pod;
};
if (_type == "HAT") then {
	_gunner addBackpack selectRandom _Backpack_HAT_Gun;
	_assistant addBackpack selectRandom _Backpack_HAT_Pod;
};

private _backPackWeapon = backpack _gunner;
private _backPackPod = backpack _assistant;


private _a2k_staticReset = {
	params ["_gunner","_assistant","_backPackWeapon","_backPackPod"];

	{_x setUnitPos "AUTO"} forEach [_gunner,_assistant];

	if (alive _gunner && {(vehicle _gunner) != _gunner}) then {
		deleteVehicle (vehicle _gunner);
		sleep 2;
		if (isNull unitBackpack _gunner) then {_gunner addBackpack _backPackWeapon;};
		if (alive _assistant && {isNull unitBackpack _assistant}) then {_assistant addBackpack _backPackPod;};
	};

	if ((vehicle _gunner) == _gunner) then {(group _gunner) setCombatMode "GREEN"; _gunner enableAI "CHECKVISIBLE";};
};

//ADD EH THAT MAKES SURE THE GUY GETS IN AND THE WEAPON IS ROTATED RIGHT
_gunner addEventHandler ["WeaponAssembled",{
	_this spawn {
		params ["_unit","_weapon"];
		_unit setCombatMode "BLUE";
		sleep 2;
		private _dir = _unit getDir (_unit findNearestEnemy _unit);
		_weapon setDir _dir;
		_weapon setVectorUp (surfaceNormal position _weapon);
		_unit moveInAny _weapon;
	};
}];

//MAIN LOOP
while {{alive _x} count (units _grp) > 1} do {

	//FIRE CONTROL
	_grp setCombatMode "GREEN";
	_gunner enableAI "CHECKVISIBLE";

	//WAIT UNTIL TARGET SPOTTED
	if (_type == "HAT") then {
		waitUntil {sleep 5; count ((leader _grp) targets [true, 1000]) > 0 && (((leader _grp) targets [true, 1000]) findIf {_x isKindOf "LandVehicle"}) == 0 || {{alive _x} count units _grp < 1}};
	};
	if (_type == "MORTAR") then {
		waitUntil {sleep 5; count ((leader _grp) targets [true, 1500]) > 0 || {{alive _x} count units _grp < 1}};
	};
	if (_type == "HMG") then {
		waitUntil {sleep 5; count ((leader _grp) targets [true, 800]) > 0 || {{alive _x} count units _grp < 1}};
	};

	//DEPLOY THE WEAPON
	if ( count ((leader _grp) targets [true, 100]) > 0 ) exitWith {_grp setCombatMode "YELLOW"; _gunner enableAI "CHECKVISIBLE"; 0 = [_grp] spawn lmf_ai_fnc_taskAssault;};
	if (_type == "MORTAR") then {_grp setCombatMode "BLUE"; _gunner disableAI "CHECKVISIBLE";};
	private _base = unitBackpack _assistant;
	_gunner playMoveNow "AinvPknlMstpSnonWnonDr_medic5";
	_assistant doMove (getPos _gunner);
	{_x setUnitPos "MIDDLE"} forEach (units _grp);	
	sleep 13;
	if (!alive _gunner) exitWith {};
	_gunner action ["Assemble", _base];
	waitUntil {sleep 1; isNull (unitBackpack _gunner) || {{alive _x} count units _grp < 1}};
	removeBackpack _assistant;

	//OPEN FIRE
	waitUntil {sleep 1; vehicle _gunner != _gunner || {{alive _x} count units _grp < 1}};
	sleep (1 + (random 3));

	//MORTAR
	if (_type == "MORTAR") then {
		_grp setCombatMode "BLUE";
		//INITIAL DELAY TO SIMULATE SETTING UP MORTAR, CALCULATING ETC.
		sleep (5 + (random 15));

		//BARRAGE MAIN LOOP
		while {{alive _x} count (units _grp) > 1 && {count (magazines (vehicle _gunner)) != 0}} do {
			_grp setCombatMode "BLUE";

			//GET TARGET POSITION
			private _enemyTargets = (leader _grp) targets [true, 1500];
			if (_enemyTargets isEqualTo []) exitWith {[_gunner,_assistant,_backPackWeapon,_backPackPod] spawn _a2k_staticReset;};
			_enemyTargets = _enemyTargets select {side _x != var_enemySide};
			private _enemyTargetsGround = _enemyTargets select {(getPos _x) select 2 < 25};
			if (_enemyTargetsGround isEqualTo []) exitWith {[_gunner,_assistant,_backPackWeapon,_backPackPod] spawn _a2k_staticReset;};
			_enemyTargetsGround sort true;
			private _targetPos = getPos (_enemyTargetsGround select 0);

			//HOLD FIRE IF FRIENDLY UNITS IN TARGET AREA
			private _unitsInRange = _targetPos nearEntities ["Man", 100];
			private _friendlyUnitsInRange = _unitsInRange select {side _x == var_enemySide && {alive _x} && {!(_x in (units _grp))}};
			if (count _friendlyUnitsInRange > 0) exitWith {[_gunner,_assistant,_backPackWeapon,_backPackPod] spawn _a2k_staticReset;};

			//CALCULATE DISTANCE AND ACCURACY
			private _distanceToTarget = ((leader _grp) distance2D _targetPos);
			private _accuracy = _distanceToTarget/4;
			if (_accuracy > 250) then {_accuracy = 250};
			if (_accuracy < 100) then {_accuracy = 100};

			if (vehicle _gunner != _gunner && {canFire (vehicle _gunner)} && {_targetPos inRangeOfArtillery [[(vehicle _gunner)], currentMagazine (vehicle _gunner)]}) then {
				//ADJUST ACCURACY
				_accuracy = _accuracy - 20;

				//START BARRAGE
				for "_i" from 0 to (3 + (random 5)) do {
					if (count _friendlyUnitsInRange > 0 || count (magazines (vehicle _gunner)) == 0) exitWith {};
					_grp setCombatMode "BLUE";

					//FORGET TARGETS TO PREVENT AUTONOMOUS SHOOTING
					private _forgetTheseTargets = (leader _grp) targets [true, 1500];
					{_grp forgetTarget _x} forEach _forgetTheseTargets;

					private _posC = [[[_targetPos, _accuracy]],[]] call BIS_fnc_randomPos;
					_grp setCombatMode "YELLOW";
					(gunner (vehicle _gunner)) doArtilleryFire [(ATLToASL _posC), currentMagazine (vehicle _gunner), 1];
					sleep (2 + (random 2));
				};
				if (count _friendlyUnitsInRange > 0 || count (magazines (vehicle _gunner)) == 0) exitWith {[_gunner,_assistant,_backPackWeapon,_backPackPod] spawn _a2k_staticReset;};
				_grp setCombatMode "BLUE";
				sleep (40 + (random 40));
			} else {[_gunner,_assistant,_backPackWeapon,_backPackPod] spawn _a2k_staticReset;};
		};
	} else {
		_grp setCombatMode "YELLOW";
	};


	//WAIT UNTIL NO KNOWN ENEMY OR OUT OF AMMO
	waitUntil {sleep 5; count ((leader _grp) targets [true, 1500]) == 0 || {count (magazines (vehicle _gunner)) == 0} || {(vehicle _gunner) == _gunner} || {{alive _x} count units _grp < 1}};
	[_gunner,_assistant,_backPackWeapon,_backPackPod] spawn _a2k_staticReset;
	sleep 30;
};