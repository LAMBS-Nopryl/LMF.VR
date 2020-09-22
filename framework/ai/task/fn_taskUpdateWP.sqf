// AI UPDATE WAYPOINT FUNCTION ////////////////////////////////////////////////////////////////////
/*
	- Originally by alex2k, revised by Drgn V4karian.
	- This function assigns the AI with a guard type waypoint each 180 seconds.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]]];

while {{alive _x} count (units _grp) > 0} do {

	if (count waypoints _grp > 0) then {
		{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
	};
	private _wp =_grp addWaypoint [getpos leader _grp, 0];
	_wp setWaypointType "GUARD";

	if ( !isNull ((leader _grp) findNearestEnemy (leader _grp)) ) then {
		private _movePos = getPosATL ((leader _grp) findNearestEnemy (leader _grp));
		if ((_movePos select 2) > 25) exitWith {};
		[_grp, 0] setWaypointPosition [_movePos, 25]; //getPosASL and -1 for exact position.
		[_grp, 1] setWaypointPosition [_movePos, 25]; //getPosASL and -1 for exact position.
	};

	sleep 180;
};