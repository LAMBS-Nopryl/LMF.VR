// VEHICLE SERVICE ////////////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny (Heavily borrowed from Xeno), rewritten by Diwako and then revised by
	  Drgn V4karian.
	- This function rearms, repairs and refuels vehicles that call it.

	- USAGE: This function is usually called via trigger like so:
		1) Create trigger big enough to fit vehicle.
		2) Set trigger to be activated by anybody, present and tick "repeatable".
		3) Condition: ("Air" countType thislist > 0) && {((getpos (thislist select 0)) select 2 < 1)}
		4) On activation: [(thislist select 0)] spawn lmf_player_fnc_vehicleService;
	- It is important to note that "Air" in step 3) can be replaced by other types to for example
	  affect ground vehicles instead of air vehicles.
	- Also important to note is that a second parameter in the form of number can be passed to the
	  function to make the whole process slower or faster.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {time > 30};
params [["_object",objNull,[objNull]],["_sleep",4,[1]]];
if (!local _object || {!alive _object}) exitWith {};

private _type = typeof _object;
private _type_name = getText (configFile >> "CfgVehicles" >> typeOf _object >> "displayName");
if (_object isKindOf "ParachuteBase") exitWith {};

//MAKE STATIONARY
_object setFuel 0;
_object engineOn false;


// RELOAD WEAPONS /////////////////////////////////////////////////////////////////////////////////
_object setVehicleAmmo 1;
_object vehicleChat format ["Servicing %1... Please stand by...", _type_name];
private _magazines = getArray (configFile >> "CfgVehicles" >> _type >> "magazines");

if (count _magazines > 0) then {
	private _removed = [];
	{
		private _index = _removed pushBackUnique _x;
		if (_index > -1) then {
			_object removeMagazines _x;
		};
	} forEach _magazines;
	{
		if !(alive _object) exitWith {};
		_object vehicleChat format ["Reloading %1", _x];
		sleep _sleep;
		_object addMagazine _x;
	} forEach _magazines;
};
if !(alive _object) exitWith {};

//RELOAD TURRETS
private _count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		scopeName "xx_reload2_xx";
		private _config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
		private _magazines = getArray (_config >> "magazines");
		private _removed = [];
		{
			private _index = _removed pushBackUnique _x;
			if (_index > -1) then {
				_object removeMagazines _x;
			};
		} forEach _magazines;
		{
			if !(alive _object) then {breakOut "xx_reload2_xx"};
			_object vehicleChat format ["Reloading %1", _x];
			sleep (_sleep * 2);
			_object addMagazine _x;
		} forEach _magazines;

		//CHECK IF MAIN TURRET HAS OTHER TURRETS
		private _count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				private _config2 = (_config >> "Turrets") select _i;
				private _magazines = getArray (_config2 >> "magazines");
				private _removed = [];
				{
					private _index = _removed pushBackUnique _x;
					if (_index > -1) then {
						_object removeMagazines _x;
					};
				} forEach _magazines;
				{
					if !(alive _object) then {breakOut "xx_reload2_xx"};
					_object vehicleChat format ["Reloading %1", _x];
					sleep (_sleep * 2);
					_object addMagazine _x;
				} forEach _magazines;
			};
		};
	};
};
_object setVehicleAmmo 1;


// REPAIR /////////////////////////////////////////////////////////////////////////////////////////
sleep _sleep;
if !(alive _object) exitWith {};
_object vehicleChat "Repairing...";
_object setDamage 0;


// REFUEL AND GOOD TO GO //////////////////////////////////////////////////////////////////////////
sleep _sleep;
if !(alive _object) exitWith {};
_object vehicleChat "Refueling...";
sleep _sleep;
if !(alive _object) exitWith {};
_object vehicleChat format ["%1 is ready...", _type_name];
_object setFuel 1;