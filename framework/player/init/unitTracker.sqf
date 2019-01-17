// UNIT TRACKER SCRIPT ////////////////////////////////////////////////////////////////////////////
/*
	- by Alex2k with help of Diwako and Drgn V4karian).
	- Function that handles markers to track individual player units.
	- No GPS support.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasinterface) exitWith {};
waitUntil {time > 1};


// TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////
private _trackingEH = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{
	if (!visibleMap || {(units group player - [leader group player]) isEqualTo []}) exitWith {};
	private _map = _this#0;
	{
		private _color = assignedTeam _x call {
			if (_this == "RED") exitwith {[1,0,0,1]};
			if (_this == "GREEN") exitwith {[0,1,0,1]};
			if (_this == "BLUE") exitwith {[0,0,1,1]};
			if (_this == "YELLOW") exitwith {[1,1,0,1]};
			[1,1,1,1]
		};
		(_map) drawIcon ["iconMan",[0,0,0,1],getPosASL _x,20,20,getDir _x];
		(_map) drawIcon ["iconMan",_color,(getPosASL _x),16,16,getDir _x];
	} count (units group player - [leader group player]);
}];