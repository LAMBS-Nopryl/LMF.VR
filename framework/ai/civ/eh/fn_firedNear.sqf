params ["_civ"];
if (_civ getVariable ["ACE_isUnconscious",false]) exitWith {};
//Remove the eventHandler to prevent spamming
_civ removeEventHandler ["FiredNear", _civ getVariable ["lmf_ai_civ_fired_near_EH", -1]];
_civ setVariable ["lmf_ai_civ_paniced", true, true];

// exit if civ is dead or is a hardass and does not panic in the face of danger!
if !(alive _civ || {(random 100) < 25}) exitWith {systemChat "Hardass detected!"};
[_civ] spawn {
	params ["_civ"];
	private _radius = 350;
	private _nearHouses = nearestObjects [_civ, ["House"], _radius];
	
	private _housePosition = nil;

	for "_i" from 1 to ((count _nearHouses) * 2) do {
		//Pick an object found in the above nearestObjects array
		private _house = selectRandom _nearHouses;
		if (isNil "_house") exitWith {};
		//Finds list of all available building positions in the selected building
		private _housePositions = _house buildingPos -1;

		//Picks a building position from the list of building positions
		_housePosition = selectRandom _housePositions;
		if !(isNil "_housePosition") exitWith {};
	};

	sleep (0.5 + random 1);
	if (!(alive _civ) || {_civ getVariable ["ACE_isUnconscious",false]}) exitWith {};

	[_civ, ["ApanPercMstpSnonWnonDnon_G01","ApanPknlMstpSnonWnonDnon_G01"] select (floor random 2)] remoteExec ["switchMove", 0, false];

	sleep (0.75 + random 1);
	group _civ setSpeedMode "FULL";

	//Orders the civilian to move to the building position
	if (isNil "_housePosition") then {
		if (count _nearHouses == 0) then {
			_housePosition = [_civ, _radius] call CBA_fnc_randPos;
		} else {
			_housePosition = getPosATL (selectRandom _nearHouses);
		};
	};

	_civ doMove _housePosition;
};