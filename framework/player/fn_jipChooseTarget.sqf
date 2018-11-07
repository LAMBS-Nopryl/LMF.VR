// JIP TELEPORT TARGET SELECT /////////////////////////////////////////////////////////////////////
/*
	- Function that returns JIP teleportation target.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _tpTarget = objNull;
private _partGroup = units group player;

//IF THE PLAYER IS NOT THE LEADER AND THE LEADER IS ALIVE THEN LEADER IS TARGET
if (player != leader group player && {alive leader group player}) then {
	_tpTarget = leader group player;
};

//IF PLAYER IS LEADER OR LEADER IS DEAD THEN PICK NEXT BEST ONE
if (player == leader group player || {!alive leader group player}) then {
	_partGroup = _partGroup - [(leader group player)];
	_tpTarget = _partGroup select (_partGroup findIf {alive _x});
};

//RETURN TARGET
_tpTarget