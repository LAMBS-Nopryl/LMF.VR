// AI MOUNT STATICS ///////////////////////////////////////////////////////////////////////////////
/*
	- originally by nkenny
	- edited by Drgn V4karian with help of Diwako.
	- This function makes the group that calls it seek out and if available mount static weapons
	  or vehicle gunner seats.
	IMPORTANT: As this function was not in use when I rewrote the framework I did not ever test
	if the rewrite works properly!!!
*/
// Init ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp", grpNull],["_range", 100],["_vehicles", true]];
private _pos = getPosATL leader _grp;
if ({alive _x} count units _grp < 1) exitWith {};

//FIND CLOSE STATIC WEAPONS
private _types = ["StaticWeapon"];
if (_vehicles) then {_types pushBack "Tank"; _types pushBack "Car"};

private _glist = nearestObjects [_pos,_types,_range];
private _staticlist = [];
if (count _glist > 0) then {
	{
		if ((_x emptyPositions "Gunner") > 0) then {
			_staticlist = _staticlist append [_x];
		}
	} forEach _glist;
};

//MOVE UNITS INTO THE GUNNER SLOTS
private _men = units _grp;

{
	if (isNull (gunner _x)) then {
		(_men select 0) enableAI "MOVE";
		(_men select 0) assignAsGunner _x;
		[(_men select 0)] orderGetIn true;
		_men = _men - [_men select 0];
		if (count _men < 1) exitWith { if (var_debug) then {systemChat "DEBUG STATIC WEAPONS : No more troops"};};
	};
} forEach _staticlist;