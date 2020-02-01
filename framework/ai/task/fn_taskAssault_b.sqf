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
private _assaultRange = 50 + (random 50);
private _randDist = _assaultRange + (50 + (random 100));
_grp enableIRLasers false;
_grp enableGunLights "ForceOff";
_grp setSpeedMode "FULL";
_grp setCombatMode "RED";
_grp allowFleeing 0;
_grp enableAttack false;
{_x setSkill ["courage", 1];} count units _grp;
{doStop _x} count units _grp;

// START THE HUNT SCRIPT //////////////////////////////////////////////////////////////////////////
while {count units _grp > 0} do {
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

			_newGroup = createGroup [var_enemySide, true];
			(units _grp) joinSilent _newGroup;
			_newGroup deleteGroupWhenEmpty true;

			_newGroup setVariable ["lambs_danger_dangerAI","disabled"];
			{_x setVariable ["lambs_danger_disableAI",true]} count units _newGroup;
			{_x disableAI "AUTOCOMBAT"} count units _newGroup;
			_newGroup setBehaviourStrong "AWARE";
			_newGroup enableAttack false;
			_newGroup allowFleeing 0;

			0 = [_newGroup,1000] spawn lmf_ai_fnc_taskHunt;
		};

		//MEDIUM
		if (_nearestdist < _randDist && _nearestdist > _assaultRange) then {
			_grp enableIRLasers true;
			if (20 > (random 100)) then {_grp enableGunLights "ForceOn"};
			_grp setFormation "WEDGE";
			_grp setBehaviourStrong "AWARE";
		};

		//FAR
		if (_nearestdist > _randDist) then {
			if (20 > (random 100)) then {_grp enableIRLasers true};
			_grp enableGunLights "ForceOff";
			_grp setFormation "LINE";
		};

		//ANY DISTANCE
		if (_tracker knowsAbout _nearest > 1) then {
			[_grp, 0] setWaypointPosition [getPosASL _nearest, -1];
			[_grp, 1] setWaypointPosition [getPosASL _nearest, -1];
			{_x doMove (getposATL _nearest)} count units _grp;
		};

		_cycle = _nearestdist/8;

    	//DEBUG
    	if (var_debug) then {systemChat format ["DEBUG: taskAssault: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
    } else {
		_cycle = 90;
		if (waypoints _grp isEqualTo []) then {
			private _wp =_grp addWaypoint [getPos leader _grp, 0];
			_wp setWaypointType "GUARD";
		};
		_grp enableIRLasers false;
		_grp enableGunLights "ForceOff";
		_grp setFormation "STAG COLUMN";
		_grp setBehaviourStrong "AWARE";
	};

  	//WAIT
  	if (_cycle < 30) then {_cycle = 30};
  	if (_cycle > 180) then {_cycle = 180};
  	sleep _cycle;
};