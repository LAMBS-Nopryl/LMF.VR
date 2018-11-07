// AI TASK ASSAULT FUNCTION ///////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny with some changes by Alex2k. Revised by Drgn V4karian with some help
	  from Diwako.
	- This function assigns the AI with a task to assault targets rather aggressively if in range.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]],["_range",500,[0]]];
private _cycle = 30;


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
		if (_nearestdist < 200) then {
			//DISMOUNT VEHICLES
			if !(isNull objectParent leader _grp) then {
				{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
				private _wp1 =_grp addWaypoint [getPos leader _grp, 0];
				_wp1 setWaypointType "GETOUT";
				private _wp2 =_grp addWaypoint [getPos leader _grp, 0];
				_wp2 setWaypointType "GUARD";
			};
			//CROUCH SOMETIMES
			if (50 > random 100) then {
				{_x setUnitPos "MIDDLE";} count units _grp;
			} else {
				{_x setUnitPos "AUTO";} count units _grp;
			};

			sleep 10;

			//MOVE IN
			if (_tracker knowsAbout _nearest > 1) then {
				{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
				{_x doMove (getposATL _nearest);} count units _grp;
				{_x enableAttack false;} count units _grp;
			};
		};

		//AGGRESSIVE WHEN CLOSE
		if (_nearestdist < 50) then {
			{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
			{_x doMove (getposATL _nearest);} count units _grp;
			{_x disableAI "AUTOCOMBAT";} count units _grp;
			_grp setBehaviour "AWARE";
			{_x setUnitPos "AUTO";} count units _grp;
			{_x enableAttack false;} count units _grp;
		};

		//REGULAR WHEN FURTHER OUT
		if (_nearestdist > 200) then {
			{_x enableAI "AUTOCOMBAT";} count units _grp;
			_grp setBehaviour "AWARE";
			{_x setUnitPos "AUTO";} count units _grp;
			{_x enableAttack true;} count units _grp;
			if (waypoints _grp isEqualTo []) then {
				private _wp =_grp addWaypoint [getPos leader _grp, 0];
				_wp setWaypointType "GUARD";
			};
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
		{_x enableAI "AUTOCOMBAT";} count units _grp;
		_grp setBehaviour "AWARE";
		{_x setUnitPos "AUTO";} count units _grp;
	};

  	//WAIT
  	if (_cycle < 30) then {_cycle = 30};
  	if (_cycle > 180) then {_cycle = 180};
  	sleep _cycle;
};