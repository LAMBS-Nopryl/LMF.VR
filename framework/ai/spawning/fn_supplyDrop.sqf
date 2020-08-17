// AI SUPPLY DROP  ////////////////////////////////////////////////////////////////////////////////
/*
	* Author: Alex2k, G4rrus
	* Civilian pilot with plane dropping a passed crate.
	* Note: Needs to be called on the Server.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Drop Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 2: Plane <STRING>
	* 3: Crate <STRING>
	*
	* Example:
	* [[0,0,0], player, "C_Plane_Civil_01_F", "B_supplyCrate_F"] spawn lmf_ai_fnc_supplyDrop;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(isServer) exitWith {};
waitUntil {CBA_missionTime > 0};

params [
	["_spawnPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
	["_dropPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
	["_type","C_Plane_Civil_01_F",[""]],
	["_crate","B_supplyCrate_F",[""]]
];

_spawnPos = _spawnPos call CBA_fnc_getPos;
_dropPos = _dropPos call CBA_fnc_getPos;

private _dir = _spawnPos getDir _dropPos;


// PREPARE AND SPAWN THE VEHICLE //////////////////////////////////////////////////////////////////
private _veh = createVehicle [_type,_spawnPos,[],0,"FLY"];
_veh setPos (_veh modelToWorld [0,0,600]);
_veh setDir _dir;
_veh setVelocityModelSpace [0,150,0];

//PREP PILOT
private _grp = [_spawnPos,WEST,["C_man_pilot_F"]] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;
_grp setCombatMode "BLUE";
_grp setBehaviourStrong "CARELESS";
_grp setGroupIDGlobal [format ["Supply Drop: %1", groupId _grp]];
_grp addVehicle _veh;

private _pilot = units _grp select 0;
_pilot setVariable ["lmf_ai_civ_cannotPanic",true];
_pilot setVariable ["acex_headless_blacklist",true];
//_pilot call lmf_loadout_fnc_heloPilot;
_pilot moveInAny _veh;
_pilot disableAI "CHECKVISIBLE";

//FLY AWAY
_veh flyInHeightASL [200,200,200];
_veh flyInHeight 200;
_veh doMove _dropPos;
_veh limitSpeed 250;

//LOAD CARGO
[_veh,100] call ace_cargo_fnc_setSpace;
private _crate = createVehicle [_crate,[0,0,0]];
[_crate,_veh,true] call ace_cargo_fnc_loadItem;

waitUntil {sleep 0.5; (_veh distance2D _dropPos) < 1000 || {!alive _veh}};
_veh limitSpeed 100;

waitUntil {sleep 0.5; (_veh distance2D _dropPos) < 150 || {!alive _veh}};
[_crate,_veh] call ace_cargo_fnc_paradropItem;
sleep 5;
_veh limitSpeed 250;
_veh doMove (_spawnPos getPos [(_spawnPos distance2D _dropPos) + 10000,_dir - 180]);


waitUntil {sleep 0.5; allPlayers findIf {_x distance2D _veh < 5000} == -1 || {!alive _veh}};
deleteVehicle _pilot;
deleteVehicle _veh;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////