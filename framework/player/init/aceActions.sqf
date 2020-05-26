// ACE ACTIONS ////////////////////////////////////////////////////////////////////////////////////
/*
	- Adds ace actions to framework vehicle spawners and framework loadout selectors.
	- Relevant variable names are:
	  - ammoSpawner (object the action is added to)
	  - groundSpawner (object the action is added to)
	  - airSpawner (object the action is added to)
	  - ammoPad (object item is spawned on)
	  - groundPad (object item is spawned on)
	  - airPad (object item is spawned on)
	  - crateGearSquad (object the action is added to)
	  - crateGearPlt (object the action is added to)
	  - crateGearCrew (object the action is added to)
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
lmf_spawnerCreateObject = {
	params ["_vehType",["_spawnPad",objNull,[objNull]]];

	if (rank ace_player == "PRIVATE" || {rank ace_player == "CORPORAL"}) exitWith {
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>NOT QUALIFIED</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Must be NCO or Officer.</t>", "PLAIN", 0.3, false, true];
	};

	if (count (_spawnPad nearEntities [["Man", "Air", "Land", "Ship"], 7]) > 0) exitWith {
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>WARNING!</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Spawn pad occupied!</t>", "PLAIN", 0.3, false, true];
	};

	private _vehicle = _vehType createVehicle getPosATL _spawnPad;
	private _dir = getDir _spawnPad;
	_vehicle setDir _dir;
	private _conditionRemove = {true};
	if (_vehicle isKindOf "Thing") then {_conditionRemove = {_target distance2D ammoPad < 10}};
	if (_vehicle isKindOf "Land") then {_conditionRemove = {_target distance2D groundPad < 10}};
	if (_vehicle isKindOf "Air") then {_conditionRemove = {_target distance2D airPad < 10}};

	private _vehDelete = ["vehDelete","Remove from Pad","\a3\ui_f_curator\data\cfgmarkers\kia_ca.paa",{deleteVehicle _target},_conditionRemove] call ace_interact_menu_fnc_createAction;
	[_vehicle,0,["ACE_MainActions"],_vehDelete] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, _vehicle];
};


// AMMOSPAWNER ////////////////////////////////////////////////////////////////////////////////////
if !(isNil "ammoSpawner") then {
	private _ammoLarge = ["ammoLarge","Supplies Large","\A3\ui_f\data\map\vehicleicons\iconCrateAmmo_ca.paa",{[var_supLarge, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoSmall = ["ammoSmall","Supplies Small","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{[var_supSmall, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoSpecial = ["ammoSpecial","Supplies Special","\A3\modules_f\data\portraitModule_ca.paa",{[var_supSpecial, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoExplosive = ["ammoExplosive","Explosives","\A3\ui_f\data\map\vehicleicons\pictureExplosive_ca.paa",{[var_supExplosives, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoMedic = ["ammoMedic","Medical Supplies","\A3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa",{[var_supMedical, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _spareWheel = ["spareWheel","Spare Wheel","",{["ACE_Wheel", ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _spareTrack = ["spareTrack","Spare Track","",{["ACE_Track", ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;

	if (var_supLarge != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammolarge] call ace_interact_menu_fnc_addActionToObject;};
	if (var_supSmall != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoSmall] call ace_interact_menu_fnc_addActionToObject;};
	//if (var_supSpecial != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoSpecial] call ace_interact_menu_fnc_addActionToObject;};
	if (var_supExplosives != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoExplosive] call ace_interact_menu_fnc_addActionToObject;};
	if (var_supMedical != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoMedic] call ace_interact_menu_fnc_addActionToObject;};
	[ammoSpawner, 0, ["ACE_MainActions"], _spareWheel] call ace_interact_menu_fnc_addActionToObject;
	[ammoSpawner, 0, ["ACE_MainActions"], _spareTrack] call ace_interact_menu_fnc_addActionToObject;
};


// GROUND VEHICLE SPAWNER /////////////////////////////////////////////////////////////////////////
if !(isNil "groundSpawner") then {
	private _vehType1 = getText (configFile >> "CfgVehicles" >> var_vic1 >> "displayName");
	private _vehType2 = getText (configFile >> "CfgVehicles" >> var_vic2 >> "displayName");
	private _vehType3 = getText (configFile >> "CfgVehicles" >> var_vic3 >> "displayName");
	private _vehType4 = getText (configFile >> "CfgVehicles" >> var_vic4 >> "displayName");

	private _groundVeh1 = ["veh1",_vehType1,"",{[var_vic1, groundPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _groundVeh2 = ["veh2",_vehType2,"",{[var_vic2, groundPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _groundVeh3 = ["veh3",_vehType3,"",{[var_vic3, groundPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _groundVeh4 = ["veh4",_vehType4,"",{[var_vic4, groundPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;

	if (var_vic1 != "") then {[groundSpawner, 0, ["ACE_MainActions"], _groundVeh1] call ace_interact_menu_fnc_addActionToObject;};
	if (var_vic2 != "") then {[groundSpawner, 0, ["ACE_MainActions"], _groundVeh2] call ace_interact_menu_fnc_addActionToObject;};
	if (var_vic3 != "") then {[groundSpawner, 0, ["ACE_MainActions"], _groundVeh3] call ace_interact_menu_fnc_addActionToObject;};
	if (var_vic4 != "") then {[groundSpawner, 0, ["ACE_MainActions"], _groundVeh4] call ace_interact_menu_fnc_addActionToObject;};
};


// AIR VEHICLE SPAWNER ////////////////////////////////////////////////////////////////////////////
if !(isNil "airSpawner") then {
	private _heliType1 = getText (configFile >> "CfgVehicles" >> var_air1 >> "displayName");
	private _heliType2 = getText (configFile >> "CfgVehicles" >> var_air2 >> "displayName");
	private _heliType3 = getText (configFile >> "CfgVehicles" >> var_air3 >> "displayName");
	private _heliType4 = getText (configFile >> "CfgVehicles" >> var_air4 >> "displayName");

	private _airVeh1 = ["heli1",_heliType1,"",{[var_air1, airPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _airVeh2 = ["heli2",_heliType2,"",{[var_air2, airPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _airVeh3 = ["heli3",_heliType3,"",{[var_air3, airPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _airVeh4 = ["heli4",_heliType4,"",{[var_air4, airPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;

	if (var_air1 != "") then {[airSpawner, 0, ["ACE_MainActions"], _airVeh1] call ace_interact_menu_fnc_addActionToObject;};
	if (var_air2 != "") then {[airSpawner, 0, ["ACE_MainActions"], _airVeh2] call ace_interact_menu_fnc_addActionToObject;};
	if (var_air3 != "") then {[airSpawner, 0, ["ACE_MainActions"], _airVeh3] call ace_interact_menu_fnc_addActionToObject;};
	if (var_air4 != "") then {[airSpawner, 0, ["ACE_MainActions"], _airVeh4] call ace_interact_menu_fnc_addActionToObject;};
};


// GEAR SELECTION SYSTEM //////////////////////////////////////////////////////////////////////////
if !(isNil "crateRoles") then {
	//MAIN ACTIONS
	private _parentInfantry = ["parentInfantry","Infantry","a3\ui_f_curator\Data\Displays\RscDisplayCurator\modeUnits_ca.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
	private _parentHQ = ["parentHQ","Headquarters","\A3\ui_f\data\map\markers\nato\b_hq.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
	private _parentSquad = ["parentSquad","Squad","\A3\ui_f\data\map\markers\nato\b_inf.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
	private _parentAirCrew = ["parentAirCrew","Air Vehicle Crew","\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
	private _parentGroundCrew = ["parentGroundCrew","Ground Vehicle Crew","\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa",{true;},{true}] call ace_interact_menu_fnc_createAction;
	//private _resetGear = ["resetGear","Reset Gear","",{[player] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;

	[crateRoles, 0, ["ACE_MainActions"], _parentInfantry] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry"], _parentHQ] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry"], _parentSquad] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions"], _parentAirCrew] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions"], _parentGroundCrew] call ace_interact_menu_fnc_addActionToObject;
	//[crateRoles, 0, ["ACE_MainActions"], _resetGear] call ace_interact_menu_fnc_addActionToObject;


	//SUB ACTIONS
	//INFANTRY HQ
	private _pltLead = ["platoonLeader","Platoon Leader","\A3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa",{[player] call lmf_loadout_fnc_platoonLeader},{true}] call ace_interact_menu_fnc_createAction;
	private _pltSgt = ["platoonSergeant","Platoon Sergeant","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player] call lmf_loadout_fnc_platoonSergeant},{true}] call ace_interact_menu_fnc_createAction;
	private _medic = ["medic","Medic","\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa",{[player] call lmf_loadout_fnc_medic},{true}] call ace_interact_menu_fnc_createAction;
	private _rto = ["rto","RTO","\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa",{[player] call lmf_loadout_fnc_rto},{true}] call ace_interact_menu_fnc_createAction;
	private _fac = ["fac","FAC","\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa",{[player] call lmf_loadout_fnc_fac},{true}] call ace_interact_menu_fnc_createAction;

	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentHQ"], _pltLead] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentHQ"], _pltSgt] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentHQ"], _medic] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentHQ"], _rto] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentHQ"], _fac] call ace_interact_menu_fnc_addActionToObject;

	//INFANTRY SQUAD
	private _squadLeader = ["squadLeader","Squad Leader","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player] call lmf_loadout_fnc_squadLeader},{true}] call ace_interact_menu_fnc_createAction;
	private _squad2ic = ["squad2ic","Assistant Squad Leader","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player] call lmf_loadout_fnc_teamLeader},{true}] call ace_interact_menu_fnc_createAction;
	private _autorifleman = ["autorifleman","Automatic Rifleman","\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa",{[player] call lmf_loadout_fnc_autorifleman},{true}] call ace_interact_menu_fnc_createAction;
	private _grenadier = ["genadier","Grenadier","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_grenadier},{true}] call ace_interact_menu_fnc_createAction;
	private _rifleman = ["rifleman","Rifleman","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_rifleman},{true}] call ace_interact_menu_fnc_createAction;
	private _mmgG = ["mmgGunner","Machine Gunner","\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa",{[player] call lmf_loadout_fnc_machineGunner},{true}] call ace_interact_menu_fnc_createAction;
	private _mmgA = ["mmgAssistant","Assistant Machine Gunner","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_machineGunnerAssistant},{true}] call ace_interact_menu_fnc_createAction;
	private _matG = ["matGunner","AT Gunner","\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa",{[player] call lmf_loadout_fnc_atGunner},{true}] call ace_interact_menu_fnc_createAction;
	private _matA = ["matAssistant","Assistant AT Gunner","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_atAssistant},{true}] call ace_interact_menu_fnc_createAction;

	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _squadLeader] call ace_interact_menu_fnc_addActionToObject;
	//[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _squad2ic] call ace_interact_menu_fnc_addActionToObject;
	//[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _autorifleman] call ace_interact_menu_fnc_addActionToObject;
	//[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _grenadier] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _rifleman] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _mmgG] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _mmgA] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _matG] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentInfantry","parentSquad"], _matA] call ace_interact_menu_fnc_addActionToObject;


	//GROUND VEHICLE CREW
	private _vehPltCmd = ["vehPlatoonLeader","Vehicle Platoon Leader","\A3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa",{[player] call lmf_loadout_fnc_crewLeader},{true}] call ace_interact_menu_fnc_createAction;
	private _vehPltSgt = ["vehPlatoonSergeant","Vehicle Platoon Sergeant","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player] call lmf_loadout_fnc_crewSgt},{true}] call ace_interact_menu_fnc_createAction;
	private _vehCommander = ["vehCommander","Vehicle Commander","A3\ui_f\data\igui\cfg\commandbar\imageCommander_ca.paa",{[player] call lmf_loadout_fnc_crewSgt},{true}] call ace_interact_menu_fnc_createAction;
	private _vehGunner = ["vehGunner","Vehicle Gunner","A3\ui_f\data\igui\cfg\commandbar\imageGunner_ca.paa",{[player] call lmf_loadout_fnc_crew},{true}] call ace_interact_menu_fnc_createAction;
	private _vehDriver = ["vehDriver","Vehicle Driver","A3\ui_f\data\igui\cfg\commandbar\imageDriver_ca.paa",{[player] call lmf_loadout_fnc_crew},{true}] call ace_interact_menu_fnc_createAction;

	[crateRoles, 0, ["ACE_MainActions","parentGroundCrew"], _vehPltCmd] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentGroundCrew"], _vehPltSgt] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentGroundCrew"], _vehCommander] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentGroundCrew"], _vehGunner] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentGroundCrew"], _vehDriver] call ace_interact_menu_fnc_addActionToObject;

	//AIR VEHICLE CREW
	private _heli = ["heli","Helicopter Pilot","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_heloPilot},{true}] call ace_interact_menu_fnc_createAction;
	private _heliCrew = ["heliCrew","Helicopter Crew","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_heloCrew},{true}] call ace_interact_menu_fnc_createAction;
	private _fighter = ["fighter","Fighter Pilot","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player] call lmf_loadout_fnc_pilot},{true}] call ace_interact_menu_fnc_createAction;

	[crateRoles, 0, ["ACE_MainActions","parentAirCrew"], _heli] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentAirCrew"], _heliCrew] call ace_interact_menu_fnc_addActionToObject;
	[crateRoles, 0, ["ACE_MainActions","parentAirCrew"], _fighter] call ace_interact_menu_fnc_addActionToObject;
};