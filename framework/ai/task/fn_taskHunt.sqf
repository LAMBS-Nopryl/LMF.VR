// AI TASK HUNT ///////////////////////////////////////////////////////////////////////////////////
/*
  - Originally by nkenny (first mangled with by Alex2k).
	- Revised by Diwako and fine-tuned by Drgn V4karian.
	- The function is ment to make AI aggressively hunt down players. They know the players
	  position magically
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]],["_radius",500,[0]]];
private _cycle = 30;
private _assaultRange = 50 + (random 50);
private _randDist = _assaultRange + (50 + (random 100));
_grp enableIRLasers false;
_grp enableGunLights "ForceOff";
_grp setVariable ["lambs_danger_disableGroupAI", true];
_grp enableAttack false;
_grp setBehaviour "SAFE";
{doStop _x} count units _grp;
_grp allowFleeing 0;


//DISMOUNT VEHICLES
if !(isNull objectParent leader _grp) then {
	if (count waypoints _grp > 0) then {
		{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
		private _wp1 =_grp addWaypoint [getPos leader _grp, 0];
		_wp1 setWaypointType "GETOUT";
		private _wp2 =_grp addWaypoint [getPos leader _grp, 0];
		_wp2 setWaypointType "GUARD";
		sleep 10;
	} else {
		private _wp3 =_grp addWaypoint [getPos leader _grp, 0];
		_wp3 setWaypointType "GETOUT";
		sleep 10;
	};
};


//DO THE HUNTING
while {{alive _x} count (units _grp) > 0} do {
	private _tracker = leader _grp;
	private _nearestdist = _radius;
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

	//ORDERS
	if !(isNull _nearest) then {

		//DELETE ANY WAYPOINTS
		{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;

		private _units = units _grp;
		{
			private _targetPos = getposATL _nearest;
			private _number = _nearestdist/4;
			private _rallypoint = [(_targetPos select 0) - (_number/2) + random _number, (_targetPos select 1) - (_number/2) + random _number, _targetPos select 2];
			_x doMove _rallypoint;
			_x disableAI "AUTOCOMBAT";
			_x setVariable ["lambs_danger_disableAI",true];
		} count _units;

		_grp setBehaviour "AWARE";
		_grp setSpeedMode "FULL";

		{_x enableAI "AUTOCOMBAT"} count _units;

		//CLOSE
		if (_nearestdist < _assaultRange) then {
			_grp enableIRLasers true;
			_grp enableGunLights "ForceOn";
		};
		//MEDIUM
		if (_nearestdist < _randDist && _nearestdist > _assaultRange) then {
			_grp enableIRLasers true;
			if (20 > (random 100)) then {_grp enableGunLights "ForceOn"};
		};
		//FAR
		if (_nearestdist > _randDist) then {
			if (20 > (random 100)) then {_grp enableIRLasers true};
			_grp enableGunLights "ForceOff";
		};

		_cycle = _nearestdist/8;

		//DEBUG
		if (var_debug) then {systemChat format ["DEBUG: taskHunt: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
	} else {
		_cycle = 120;
		if (waypoints _grp isEqualTo []) then {
			private _wp =_grp addWaypoint [getPos leader _grp, 0];
			_wp setWaypointType "GUARD";
		};
	};

	//WAIT
	_cycle = _cycle min 300;
	_cycle = _cycle max 30;
	sleep _cycle;
};