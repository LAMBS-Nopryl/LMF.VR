// AI VEHICLE QRF /////////////////////////////////////////////////////////////////////////////////
/*
    - Originally by nkenny.
	- Revised by Drgn V4karian.
	- File to spawn a vehicle that functions as QRF. Some have additional infantry as passengers loaded,
      others like the tank will move in on players alone.
	- It is important to note that the player proximity check for spawning will only occur if spawn tickets
	  are set to a higher number than 1. The same goes for the respawn timer.

	- USAGE:
		1) Spawn Position.
		2) Vehicle Type [OPTIONAL] ("CAR", "CARARMED", "TURCK","APC","TANK", "HELITRANSPORT" or "HELIATTACK") (default: "TURCK")
		3) Spawn Tickets [OPTIONAL] (default: 1)
        4) Respawn Timer [OPTIONAL] (default: 300)

	- EXAMPLE: 0 = [this,"TRUCK",1,300] spawn lmf_ai_fnc_vehicleQRF;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_vicType", "TRUCK"],["_tickets", 1],["_respawnTime", 300]];
private _range = 1000;
private _dir = random 360;
if !(_spawnPos isEqualType []) then {_dir = getDir _spawnPos;};
_spawnPos = _spawnPos call CBA_fnc_getPos;
toUpper _vicType;


// PREPARE AND SPAWN //////////////////////////////////////////////////////////////////////////////
private _initTickets = _tickets;
private _grp = grpNull;

while {_initTickets > 0} do {

    //IF THE INITAL TICKETS WERE HIGHER THAN ONE
    if (_tickets > 1) then {
        //WAIT UNTIL PROXIMTY IS FINE
        waitUntil {sleep 5; [_spawnPos,_range] call _proximityChecker isEqualTo false};
    };

    //IF PROXIMITY IS FINE
    private _veh = objNull;

    //IF CAR
    if (_vicType == "CAR") then {
        _veh = createVehicle [selectRandom _car, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _team;
        _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        0 = [_grp] spawn lmf_ai_fnc_taskAssault;
    };

    //IF CARARMED
    if (_vicType == "CARARMED") then {
        _veh = createVehicle [selectRandom _carArmed, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _sentry;
        _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        _grp setBehaviour "AWARE";
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF TRUCK
    if (_vicType == "TRUCK") then {
        _veh = createVehicle [selectRandom _truck, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _squad;
        _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        0 = [_grp] spawn lmf_ai_fnc_taskAssault;
    };

    //IF APC
    if (_vicType == "APC") then {
        _veh = createVehicle [selectRandom _apc, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = [_spawnPos,var_enemySide,_vehicleCrew] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //PASSENGERS
        private _type = selectRandom [selectRandom _squad,selectRandom _team];
        private _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp2 deleteGroupWhenEmpty true;
        {_x moveInCargo _veh;} forEach units _grp2;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        waitUntil {sleep 3; !(position _veh isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);};
        doStop driver _veh;
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 2; speed _veh > 0 || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        private _wp = _grp2 addWaypoint [getPos _veh,0];
        _wp setWaypointType "GUARD";
        0 = [_grp2] spawn lmf_ai_fnc_taskAssault;
        sleep 15;
        driver _veh doFollow leader _grp;
    };

    //IF TANK
    if (_vicType == "TANK") then {
        _veh = createVehicle [selectRandom _tank, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = [_spawnPos,var_enemySide,_vehicleCrew] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        _grp setBehaviour "AWARE";
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF HELICOPTER TRANSPORT
    if (_vicType == "HELITRANSPORT") then {
        _veh = createVehicle [selectRandom _heli_Transport, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = [_spawnPos,var_enemySide,_heliCrew] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //PASSENGERS
        private _type = selectRandom _squad;
        private _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp2 deleteGroupWhenEmpty true;
        {_x moveInCargo _veh;} forEach units _grp2;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 1; isTouchingGround _veh || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        private _wp = _grp2 addWaypoint [getPos _veh,0];
        _wp setWaypointType "GUARD";
        0 = [_grp2] spawn lmf_ai_fnc_taskAssault;
    };

    //IF ATTACK HELICOPTER
    if (_vicType == "HELIATTACK") then {
        _veh = createVehicle [selectRandom _heli_Attack, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = createGroup var_enemySide;
        [_veh, _grp, false, "",_Pilot] call BIS_fnc_spawnCrew;
        _grp deleteGroupWhenEmpty true;

        //TASK
        _grp setBehaviour "AWARE";
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF THE INITAL TICKETS WERE HIGHER THAN ONE
    if (_tickets > 1) then {
        //WAIT UNTIL EVERYONE DEAD
        waitUntil {sleep 5; !alive _veh || {{alive _x} count units _grp < 1}};
        sleep _respawnTime;
    };

    //SUBTRACT TICKET
    _initTickets = _initTickets - 1;
};