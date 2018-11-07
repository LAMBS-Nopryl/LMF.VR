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
_grp setBehaviour "SAFE";

//DO THE HUNTING
while {count units _grp > 0} do {
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
		private _units = units _grp;
		{
			private _targetPos = getposATL _nearest;
			private _number = _nearestdist/4;
			private _rallypoint = [(_targetPos select 0) - (_number/2) + random _number, (_targetPos select 1) - (_number/2) + random _number, _targetPos select 2];
			_x doMove _rallypoint;
			_x disableAI "AUTOCOMBAT";
		} count _units;

		_grp setBehaviour "AWARE";
		_grp setSpeedMode "FULL";

		_cycle = _nearestdist/8;

		//DEBUG
		if (var_debug) then {systemChat format ["DEBUG: taskHunt: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
	} else {
		_cycle = 120;
	};

	//WAIT
	_cycle = _cycle min 300;
	_cycle = _cycle max 30;
	sleep _cycle;
};