// SORTING FUNCTION FOR CAMANBASE UNITS ///////////////////////////////////////////////////////////
/*
	- File that handles what happens to CAManBase related objects.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _unit = _this select 0;

//EXIT IF NOT LOCAL
if !(local _unit) exitWith {};

//SORT
if  !(isPlayer _unit) then {
	if (side group _unit != var_enemySide) exitWith {};
	[_unit] call lmf_ai_fnc_initMan;
    group _unit deleteGroupWhenEmpty true;
}
else {
    if( _unit == player) then {};
};