// UNIT TRACKER SCRIPT ////////////////////////////////////////////////////////////////////////////
/*
	- by Alex2k with help of Diwako and Drgn V4karian).
	- Function that handles markers to track individual player units.
	- No GPS support.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasinterface) exitWith {};
waitUntil {time > 1};

lmf_player_tracklist = [];


// ADD PLAYERS CYCLE //////////////////////////////////////////////////////////////////////////////
[] spawn {
	private _fnc_addUnit =  {
		private _unit = _this#0;
		lmf_player_tracklist pushbackunique _unit;
	};

	while {true} do {
		//ADD PLAYERS FROM PLAYER GROUP TO LIST (MINUS GROUP LEADER)
		{
			if (_x in lmf_player_tracklist) then {} else {0 =[_x] call _fnc_addUnit};
		} forEach (units group player - [leader group player]);
		//REMOVE FROM TRACKLIST IF LEFT GROUP OR BECAME GROUP LEADER OR BECAME OBJNULL
		{
			if (group _x != group player || {_x == leader group player || {isNull _x}}) then {
				lmf_player_tracklist = lmf_player_tracklist - [_x];
			};
		} forEach lmf_player_tracklist;
		sleep 15;
	};
};


// TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////
private _trackingEH = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{
	if (!visibleMap || {lmf_player_tracklist isEqualTo []}) exitWith {};
	{
		private _color = [assignedTeam _x] call {
			if (_this#0 == "RED") exitwith {[1,0,0,1]};
			if (_this#0 == "GREEN") exitwith {[0,1,0,1]};
			if (_this#0 == "BLUE") exitwith {[0,0,1,1]};
			if (_this#0 == "YELLOW") exitwith {[1,1,0,1]};
			[1,1,1,1]
		};
		(_this#0) drawIcon ["iconMan",[0,0,0,1],getPosASL _x,20,20,getDir _x];
		(_this#0) drawIcon ["iconMan",_color,(getPosASL _x),16,16,getDir _x];
	} count lmf_player_tracklist;
}];