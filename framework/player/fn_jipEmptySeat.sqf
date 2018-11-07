// JIP TELEPORT EMPTY SEAT BOOLEAN ////////////////////////////////////////////////////////////////
/*
	- Function that returns boolean if vehicle has free seat.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_target",objNull]];
private _freeSeat = false;
private _hasDriver = vehicle _target emptyPositions "driver";
private _hasCommander = vehicle _target emptyPositions "commander";
private _hasGunner = vehicle _target emptyPositions "gunner";
private _hasTurret = vehicle _target emptyPositions "turret";
private _hasCargo = vehicle _target emptyPositions "cargo";
if (_hasDriver > 0 || {_hasCommander > 0 || {_hasGunner > 0 || {_hasTurret > 0 || {_hasCargo > 0}}}}) then {_freeSeat = true;};

//RETURN IF TRUE OR FALSE
_freeSeat