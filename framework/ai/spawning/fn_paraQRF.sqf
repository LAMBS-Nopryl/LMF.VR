// AI PARA QRF ////////////////////////////////////////////////////////////////////////////////////
/*
	- Originally by Alex2k.
	- Revised by Drgn V4karian.
	- File to spawn a helicopter QRF that paradrops AI units, flies away and despawns.

	- USAGE:
		1) Spawn Position.
		2) Spawn Tickets [OPTIONAL] (default: 1)
		3) Respawn Timer [OPTIONAL] (default: 300)

	- EXAMPLE: 0 = [this,1] spawn lmf_ai_fnc_paraQRF;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_tickets", 1],["_respawnTime", 300]];
private _range = 1000;
private _dir = random 360;
if !(_spawnPos isEqualType []) then {_dir = getDir _spawnPos;};
_spawnPos = _spawnPos call CBA_fnc_getPos;


// PREPARE AND SPAWN //////////////////////////////////////////////////////////////////////////////
private _initTickets = _tickets;

while {_initTickets > 0} do {

	//CHECK AIR PROXIMITY
	if ([_spawnPos,_range] call _proximityChecker isEqualTo "airClose") then {
		//IF TOO CLOSE, WAIT UNTIL IT'S FINE, OR UNTIL GROUND PROXIMITY BREAKS
		waitUntil {sleep 5; [_spawnPos,_range] call _proximityChecker isEqualTo "airDistance" || {[_spawnPos,_range] call _proximityChecker isEqualTo "groundClose"}};
	};
	//EXIT IF GROUND PROXIMITY LIMIT HAS BEEN BROKEN
	if ([_spawnPos,_range] call _proximityChecker isEqualTo "groundClose") exitWith {};

	//IF PROXIMITY IS FINE
	private _veh = createVehicle [selectRandom _heli_Transport, _spawnPos, [], 0, "CAN_COLLIDE"];
	_veh setDir _dir;

	//CREW
	private _grp = [_spawnPos,var_enemySide,_heliCrew] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;
	_grp setGroupIDGlobal [format ["Para QRF: Heli crew (%1)", groupId _grp]];
	_grp addVehicle _veh;
	{_x moveInAny _veh} forEach units _grp;

	//PASSENGERS
	private _type = selectRandom _squad;
	private _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
	_grp2 deleteGroupWhenEmpty true;
	_grp2 setGroupIDGlobal [format ["Para QRF: Paratroopers (%1)", groupId _grp2]];
	{_x moveInCargo _veh} count units _grp2;
	_grp2 enableIRLasers false;
	_grp2 enableGunLights "ForceOff";

	//ORDERS
	private _wp = _grp addWaypoint [getPos _veh,0];
	_wp setWaypointType "GUARD";
	{_x disableAI "AUTOCOMBAT"; _x disableAI "FSM"; _x setBehaviour "CARELESS";} count units _grp;
	_veh flyInHeight (300 + random 300);

	//WAIT UNTIL THEY SHALL DEPLOY
	waitUntil {sleep 2; allPlayers findIf {_x distance2D _veh < 400 + random 800} != -1 || {{alive _x} count units _grp < 1 || {!alive _veh}}};
	waitUntil {sleep 3; !(position _veh isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []) || {{alive _x} count units _grp < 1 || {!alive _veh}}};


	//DEPLOY THE PARATROOPS IF VEHICLE AND TROOPERS ARE ALIVE
	if (alive _veh && {count units _grp2 > 0}) then {
		private _flyDir = getDir _veh;
		{
			if !(alive _veh) exitWith {};
			private _unit = _x;
			private _bag = backpack _unit;
			private _bagItems = backpackItems _unit;
			removeBackpack _unit;
			_unit addBackpack "ACE_NonSteerableParachute";
			sleep 1;
			_unit action ["openParachute", vehicle _unit];
			sleep 1;
			_unit addBackpack _bag;
			{_unit addItem _x} forEach _bagItems;
		} forEach units _grp2;

		//CBA WAITUNTIL AND EXECUTE THE TASK ASSAULT
		[
			{
				{isTouchingGround _x} count units (_this select 0) > 0 || {{alive _x} count units (_this select 0) < 1}
			},{
				_grp2 = _this select 0;
				private _pos = getPosATL leader _grp2;
				private _wp2 = _grp2 addWaypoint [[_pos#0,_pos#1,0],0];
				_wp2 setWaypointType "GUARD";
				0 = [_grp2] spawn lmf_ai_fnc_taskAssault;
			}, [_grp2], 300, {}
		] call CBA_fnc_waitUntilAndExecute;
		_grp2 leaveVehicle _veh;

		//EXIT IF VEHICLE OR CREW IS NOT ALIVE ANYMORE
		if (!alive _veh || {count units _grp < 1}) exitWith {};

		//MAKE HELICOPTER FLY AWAY AND DESPAWN ONCE OUT OF SIGHT
		{deleteWaypoint ((waypoints _grp) select 0)} count waypoints _grp;
		_veh doMove (_veh getPos [25000,_flyDir - 180]);
		waitUntil {sleep 1; allPlayers findIf {_x distance2D _veh < 5000} == -1 || {!alive _veh || {count units _grp < 1}}};
		if (alive _veh && {count units _grp > 0}) then {
			{_veh deleteVehicleCrew _x} count crew _veh;
			deleteVehicle _veh;
		};
	};

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL EVERYONE DEAD OR GROUND PROXIMITY HAS BEEN BROKEN
		waitUntil {sleep 5; {alive _x} count units _grp < 1 || {!alive _veh} || {[_spawnPos,_range] call _proximityChecker isEqualTo "groundClose"}};
	};

    //SUBTRACT TICKET
    _initTickets = _initTickets - 1;
};