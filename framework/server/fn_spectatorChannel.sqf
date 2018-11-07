// SPECTATOR CHANNEL FUNCTION /////////////////////////////////////////////////////////////////////
/*
	- This function adds or removes players from the spectator channel.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",ObjNull,[ObjNull]],["_state",false,[false]]];

//EXIT IF NOT SERVER OR NO UNIT
if !(isServer) exitWith {};
if (isNull _unit) exitWith {};

//ADD OR REMOVE DEPENDING ON STATE
if (_state) then {
	radio_channel_1 radioChannelAdd [_unit];
};

if !(_state) then {
	radio_channel_1 radioChannelRemove [_unit];
};