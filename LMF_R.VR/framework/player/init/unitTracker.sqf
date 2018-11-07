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
		_marker setMarkerColorLocal var_markerSide;
		_marker setMarkerTypeLocal "mil_dot_noshadow";
		_marker setmarkerSizeLocal [0.4,0.4];
		lmf_player_tracklist pushbackunique _unit;
	};
	while {true} do {
		{
			if (_x in lmf_player_tracklist) then {} else {0 =[_x,""] call _fnc_addUnitMarker;};
			false
		} count (playableunits + switchableunits - entities "Headless_F");
		sleep 20;
	};
};


// TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////
while {true} do {
	waitUntil {count lmf_player_tracklist > 0};
	{
		private _marker = ("nk_m_"+ str(_x));
		_marker setmarkerposlocal getposASL _x;
		if (isNull _x) then {
			lmf_player_tracklist = lmf_player_tracklist - [_x];
			deleteMarkerLocal _marker;
		};
	} count lmf_player_tracklist;
	sleep 5;
};