// AI TASK ASSAULT FUNCTION ///////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny with some changes by Alex2k. Revised by Drgn V4karian with some help
	  from Diwako.
	- This function assigns the AI with a task to assault targets rather aggressively if in range.
	- Alternative version that loads if LAMBS Danger is running.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]],["_range",500,[0]]];
private _cycle = 30;
private _assaultRange = 50 + (random 100);
private _randDist = _assaultRange + (50 + (random 100));
_grp enableIRLasers false;
_grp enableGunLights "ForceOff";
_grp setSpeedMode "FULL";
_grp enableAttack false;

lmf_ai_infantryRush = {
	params ["_grp","_rushPos"];
		if (_grp getvariable ["lmf_ai_isRushing",false]) exitWith {};
		if ((_rushPos select 2) > 25) exitWith {};
		_grp setVariable ["lmf_ai_isRushing", true];

		{_x disableAI "AUTOCOMBAT"} count (units _grp);
		_grp setBehaviour "AWARE";
		{_x setUnitPos "AUTO"} count units _grp;

		[_grp, 0] setWaypointPosition [ATLToASL _rushPos, -1];
		[_grp, 1] setWaypointPosition [ATLToASL _rushPos, -1];
		{_x doMove _rushPos} count units _grp;

		if ( ((leader _grp) distance2D _rushPos) < 35 ) then {
			if (50 > random 100) then {_grp setFormation "DIAMOND";};
		} else {_grp setFormation selectRandom ["WEDGE","LINE"];};
};

lmf_ai_infantryDefault = {
	params ["_grp","_rushPos"];
		_grp setVariable ["lmf_ai_isRushing", false];

		{_x enableAI "AUTOCOMBAT"} count (units _grp);
		{_x setUnitPos "AUTO"} count units _grp;

		if ( ((leader _grp) distance2D _rushPos) < 35 ) then {
			if (50 > random 100) then {_grp setFormation "DIAMOND";};
		} else {_grp setFormation selectRandom ["WEDGE","LINE"];};
};

// START THE HUNT SCRIPT //////////////////////////////////////////////////////////////////////////
while {{alive _x} count (units _grp) > 0} do {
	private _tracker = leader _grp;
	private _nearestdist = _range;
	private _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
	private _nearest = objNull;

	//CHOOSE CLOSEST TARGET
	{
		private _dist = vehicle _x distance2D _tracker;
		if ((_dist < _nearestdist) && {(side _x != civilian) && {((getposATL _x) select 2 < 25) && {isPlayer _x}}}) then {
			_nearest = _x;
			_nearestdist = _dist;
		};
	} forEach _availabletargets;

	// ORDERS ///////////////////////////////////////////////////////////////////////////////////////
	if !(isNull _nearest) then {
		_assaultPos = getPosATL _nearest;
		_pause = 30 + (random 30);

		//DISMOUNT VEHICLES
		if !(isNull objectParent leader _grp) then {
			{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
			private _wp1 =_grp addWaypoint [getPos leader _grp, 0];
			_wp1 setWaypointType "GETOUT";
			private _wp2 =_grp addWaypoint [getPos leader _grp, 0];
			_wp2 setWaypointType "GUARD";
			sleep 10;
		};

		if (waypoints _grp isEqualTo []) then {
			private _wp =_grp addWaypoint [getPos leader _grp, 0];
			_wp setWaypointType "GUARD";
		};

		//CLOSE
		if (_nearestdist < _assaultRange) then {
			_grp enableIRLasers true;
			_grp enableGunLights "ForceOn";

			if (_tracker knowsAbout _nearest > 1) then {
				[_grp,_assaultPos,_pause] spawn {
					params ["_grp","_assaultPos","_pause"];
					[_grp,_assaultPos] call lmf_ai_infantryRush;
					sleep _pause;
					[_grp,_assaultPos] call lmf_ai_infantryDefault;
				};
			};
		};

		//MEDIUM
		if (_nearestdist < _randDist && {_nearestdist > _assaultRange}) then {
			_grp enableIRLasers true;
			_grp enableGunLights "ForceOff";
			if (20 > (random 100)) then {_grp enableGunLights "ForceOn"};

			if (_tracker knowsAbout _nearest > 1 && {40 > (random 100)}) then {
					[_grp,_assaultPos,_pause] spawn {
						params ["_grp","_assaultPos","_pause"];
						[_grp,_assaultPos] call lmf_ai_infantryRush;
						sleep _pause;
						[_grp,_assaultPos] call lmf_ai_infantryDefault;
					};
			};
		};

		//FAR
		if (_nearestdist > _randDist && {_nearestdist < _range}) then {
			_grp enableIRLasers false;
			if (20 > (random 100)) then {_grp enableIRLasers true};
			_grp enableGunLights "ForceOff";

			if (_tracker knowsAbout _nearest > 1 && {20 > (random 100)}) then {
				[_grp,_assaultPos,_pause] spawn {
					params ["_grp","_assaultPos","_pause"];
					[_grp,_assaultPos] call lmf_ai_infantryRush;
					sleep _pause;
					[_grp,_assaultPos] call lmf_ai_infantryDefault;
				};
			};
		};

		//IF GROUP KNOWS ABOUT TARGET
		if (_tracker knowsAbout _nearest > 1 && {_nearestdist < _range}) then {
			if ((_assaultPos select 2) > 25) exitWith {};
			_grp setFormation selectRandom ["WEDGE","LINE"];
			[_grp, 0] setWaypointPosition [ATLToASL _assaultPos, -1];
			[_grp, 1] setWaypointPosition [ATLToASL _assaultPos, -1];
			{_x doMove _assaultPos} count units _grp;
		};

		_cycle = _nearestdist/8;

    	//DEBUG
    	if (var_debug) then {systemChat format ["DEBUG: taskAssault: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
    } else {
		_cycle = 60;
		if (waypoints _grp isEqualTo []) then {
			private _wp =_grp addWaypoint [getPos leader _grp, 0];
			_wp setWaypointType "GUARD";
		};
		_grp enableIRLasers false;
		_grp enableGunLights "ForceOff";
		{_x enableAI "AUTOCOMBAT"} count units _grp;
		{_x setUnitPos "AUTO"} count units _grp;
		_grp setFormation "STAG COLUMN";
	};

  	//WAIT
  	if (_cycle < 30) then {_cycle = 30};
  	if (_cycle > 180) then {_cycle = 180};
  	sleep _cycle;
};