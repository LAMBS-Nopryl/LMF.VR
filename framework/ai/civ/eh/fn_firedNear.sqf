// CIV FIRED NEAR EH //////////////////////////////////////////////////////////////////////////////
/*
	- EH code that handles what happens if someone fires near a civ.

	To make selected unit ignore this feature add the variable "lmf_ai_civ_cannotPanic" with value true to them
	e.g. this setVariable ["lmf_ai_civ_cannotPanic",true] in init field
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_civ"];
if (_civ getVariable ["ACE_isUnconscious",false]) exitWith {};
//REMOVE EH TO PREVENT SPAMMING
_civ removeEventHandler ["FiredNear", _civ getVariable ["lmf_ai_civ_fired_near_EH", -1]];

//EXIT IF CIV IS DEAD OR A HARDASS IN THE FACE OF DANGER
if (!(alive _civ) || {(random 100) < 25 || {_civ getVariable ["lmf_ai_civ_cannotPanic",false] || {_civ getVariable ["ace_captives_isSurrendering",false] || {_civ getVariable ["ace_captives_isHandcuffed",false]}}}}) exitWith {};
_civ setVariable ["lmf_ai_civ_paniced", true, true];
[_civ] spawn {
	params ["_civ"];
	private _radius = 350;
	private _nearHouses = nearestObjects [_civ, ["House"], _radius];

	private _housePosition = nil;

	for "_i" from 1 to ((count _nearHouses) * 2) do {
		//PICK OBJECT FROM NEARESTOBJECTS ARRAY
		private _house = selectRandom _nearHouses;
		if (isNil "_house") exitWith {};
		//FIND LIST OF ALL AVAILABLE BUILDING POSITIONS IN SAID HOUSE
		private _housePositions = _house buildingPos -1;

		//PICK A BUILDING POSITION FROM THE AVAILABLE BUILDING POSITIONS
		_housePosition = selectRandom _housePositions;
		if !(isNil "_housePosition") exitWith {};
	};

	sleep (0.5 + random 1);
	if (!(alive _civ) || {_civ getVariable ["ACE_isUnconscious",false]}) exitWith {};

	[_civ, ["ApanPercMstpSnonWnonDnon_G01","ApanPknlMstpSnonWnonDnon_G01"] select (floor random 2)] remoteExec ["switchMove", 0, false];

	sleep (0.75 + random 1);
	group _civ setSpeedMode "FULL";

	//ORDERS THE CIVILIAN TO MOVE TO THE BUILDING POSITION
	if (isNil "_housePosition") then {
		if (count _nearHouses == 0) then {
			_housePosition = [_civ, _radius] call CBA_fnc_randPos;
		} else {
			_housePosition = getPosATL (selectRandom _nearHouses);
		};
	};

	_civ doMove _housePosition;
};