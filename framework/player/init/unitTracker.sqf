// UNIT TRACKER SCRIPT ////////////////////////////////////////////////////////////////////////////
/*
	- by nkenny (edited by Drgn V4karian with help of Diwako).
	- Function that handles markers to track individual player units.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasinterface) exitWith {};
waitUntil {time > 1};

lmf_player_tracklist = [];


// ADD PLAYERS CYCLE //////////////////////////////////////////////////////////////////////////////
[] spawn {
	private _fnc_addUnitMarker =  {
		private _unit = _this select 0;
		private _marker = createMarkerLocal ["nk_m_"+str(_unit),getposASL _unit];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerTypeLocal "mil_triangle";
		_marker setmarkerSizeLocal [0.5,0.5];
		lmf_player_tracklist pushbackunique _unit;
	};

	while {true} do {
		//ADD PLAYERS FROM PLAYER GROUP TO LIST (MINUS GROUP LEADER)
		{
			if (_x in lmf_player_tracklist) then {} else {0 =[_x] call _fnc_addUnitMarker};
		} forEach (units group player - [leader group player]);

		//UPDATE THE MARKER COLOR
		{
			private _marker = ("nk_m_"+ str(_x));
			if (assignedTeam _x == "MAIN") then {_marker setMarkerColorLocal "ColorWhite"};
			if (assignedTeam _x == "RED") then {_marker setMarkerColorLocal "ColorRed"};
			if (assignedTeam _x == "GREEN") then {_marker setMarkerColorLocal "ColorGreen"};
			if (assignedTeam _x == "BLUE") then {_marker setMarkerColorLocal "ColorBlue"};
			if (assignedTeam _x == "YELLOW") then {_marker setMarkerColorLocal "ColorYellow"};

			//REMOVE FROM TRACKLIST IF LEFT GROUP OR BECAME GROUP LEADER OR BECAME OBJNULL
			if (group _x != group player || {_x == leader group player || {isNull _x}}) then {
				lmf_player_tracklist = lmf_player_tracklist - [_x];
				deleteMarkerLocal _marker;
			};
		} forEach lmf_player_tracklist;
		sleep 15;
	};
};


// TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////
while {true} do {
	waitUntil {count lmf_player_tracklist > 0};
	{
		private _marker = format ["nk_m_%1",_x];
		_marker setmarkerposlocal getposASL _x;
		_marker setMarkerDirLocal getDir _x;
	} count lmf_player_tracklist;
	sleep 0.5;
};