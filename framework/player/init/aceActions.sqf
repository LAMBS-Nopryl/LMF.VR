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

	if (count (_spawnPad nearEntities [["Man", "Air", "Land", "Ship"], 10]) > 0) exitWith {
		private _title1 = "<t color='#FFBA26' size='1' >WARNING!</t><br/>";
		private _title2 = "<t color='#FFFFFF' size='1' >Spawn pad occupied!</t><br/>";
		[_title1 + _title2, 2, ace_player, 10] call ace_common_fnc_displayTextStructured;
	};

	if (rank ace_player == "PRIVATE" || {rank ace_player == "CORPORAL"}) exitWith {
		private _title1 = "<t color='#FFBA26' size='1' >WARNING!</t><br/>";
		private _title2 = "<t color='#FFFFFF' size='1' >Only NCOs and Officers may spawn supplies!</t><br/>";
		[_title1 + _title2, 2, ace_player, 14] call ace_common_fnc_displayTextStructured;
	};

    private _vehicle = _vehType createVehicle getPosATL _spawnPad;
    private _dir = getDir _spawnPad;
    _vehicle setDir _dir;
	private _conditionRemove = {true};
	if (_vehicle isKindOf "Thing") then {_conditionRemove = {_target distance2D ammoPad < 10}};
	if (_vehicle isKindOf "Land") then {_conditionRemove = {_target distance2D groundPad < 10}};
	if (_vehicle isKindOf "Air") then {_conditionRemove = {_target distance2D airPad < 10}};

    private _vehDelete = ["vehDelete","Remove from Pad","",{deleteVehicle _target},_conditionRemove] call ace_interact_menu_fnc_createAction;
    [_vehicle,0,["ACE_MainActions"],_vehDelete] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, _vehicle];
};


// AMMOSPAWNER ////////////////////////////////////////////////////////////////////////////////////
if !(isNil "ammoSpawner") then {
    private _ammoLarge = ["ammoLarge","Supplies Large","",{[var_supLarge, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoSmall = ["ammoSmall","Supplies Small","",{[var_supSmall, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoSpecial = ["ammoSpecial","Supplies Special","",{[var_supSpecial, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoExplosive = ["ammoExplosive","Explosives","",{[var_supExplosives, ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _ammoMedic = ["ammoMedic","Supplies Medical","",{["ACE_medicalSupplyCrate_advanced", ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _spareWheel = ["spareWheel","Spare Wheel","",{["ACE_Wheel", ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;
	private _spareTrack = ["spareTrack","Spare Track","",{["ACE_Track", ammoPad] call lmf_spawnerCreateObject;},{true}] call ace_interact_menu_fnc_createAction;

    if (var_supLarge != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammolarge] call ace_interact_menu_fnc_addActionToObject;};
	if (var_supSmall != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoSmall] call ace_interact_menu_fnc_addActionToObject;};
	if (var_supSpecial != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoSpecial] call ace_interact_menu_fnc_addActionToObject;};
	if (var_supExplosives != "") then {[ammoSpawner, 0, ["ACE_MainActions"], _ammoExplosive] call ace_interact_menu_fnc_addActionToObject;};
	[ammoSpawner, 0, ["ACE_MainActions"], _ammoMedic] call ace_interact_menu_fnc_addActionToObject;
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
//RESET GEAR ACTION
private _resetGear = ["resetGear","Reset Gear","",{[player] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;

//GEAR PLATOON COMMON
if !(isNil "crateGearSquad") then {
	private _squadLeader = ["squadLeader","Squad Leader","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player, "Squad Leader"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _squad2ic = ["squad2ic","Squad 2iC","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player, "Squad 2iC"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _grenadier = ["genadier","Grenadier","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player, "Grenadier"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _autorifleman = ["autorifleman","Autorifleman","\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa",{[player, "Autorifleman"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _rifleman = ["rifleman","Rifleman","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player, "Rifleman"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _mmgG = ["mmgGunner","MMG Gunner","\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa",{[player, "Machine Gunner"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _mmgA = ["mmgAssistant","MMG Assistant","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player, "Assistant Machine Gunner"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _matG = ["matGunner","MAT Gunner","\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa",{[player, "AT Gunner"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _matA = ["matAssistant","MAT Assistant","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player, "AT Assistant"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;

	[crateGearSquad, 0, ["ACE_MainActions"], _squadLeader] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _squad2ic] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _grenadier] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _autorifleman] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _rifleman] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _mmgG] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _mmgA] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _matG] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _matA] call ace_interact_menu_fnc_addActionToObject;
	[crateGearSquad, 0, ["ACE_MainActions"], _resetGear] call ace_interact_menu_fnc_addActionToObject;
};

//GEAR PLATOON
if !(isNil "crateGearPlt") then {
	private _pltLead = ["platoonLeader","Platoon Leader","\A3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa",{[player, "Platoon Leader"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _pltSgt = ["platoonSergeant","Platoon Sergeant","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player, "Platoon Sergeant"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _medic = ["medic","Medic","\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa",{[player, "Medic"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _rto = ["rto","RTO","\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa",{[player, "RTO"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _fac = ["fac","FAC","\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa",{[player, "FAC"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _heli = ["heli","Helicopter Pilot","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player, "Helicopter Pilot"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _heliCrew = ["heliCrew","Helicopter Crew","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player, "Helicopter Crew"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _fighter = ["fighter","Fighter Pilot","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{[player, "Fighter Pilot"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;

	[crateGearPlt, 0, ["ACE_MainActions"], _pltLead] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _pltSgt] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _medic] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _rto] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _fac] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _heli] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _heliCrew] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _fighter] call ace_interact_menu_fnc_addActionToObject;
	[crateGearPlt, 0, ["ACE_MainActions"], _resetGear] call ace_interact_menu_fnc_addActionToObject;
};

//GEAR CREW
if !(isNil "crateGearCrew") then {
	private _vehPltCmd = ["vehPlatoonLeader","Vehicle Platoon Commander","\A3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa",{[player, "Vehicle Platoon Commander"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _vehPltSgt = ["vehPlatoonSergeant","Vehicle Platoon 2iC","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{[player, "Vehicle Platoon 2iC"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _vehCommander = ["vehCommander","Vehicle Commander","A3\ui_f\data\igui\cfg\commandbar\imageCommander_ca.paa",{[player, "Vehicle Commander"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _vehGunner = ["vehGunner","Vehicle Gunner","A3\ui_f\data\igui\cfg\commandbar\imageGunner_ca.paa",{[player, "Vehicle Gunner"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;
	private _vehDriver = ["vehDriver","Vehicle Driver","A3\ui_f\data\igui\cfg\commandbar\imageDriver_ca.paa",{[player, "Vehicle Driver"] call lmf_player_fnc_initPlayerGear},{true}] call ace_interact_menu_fnc_createAction;

	[crateGearCrew, 0, ["ACE_MainActions"], _vehPltCmd] call ace_interact_menu_fnc_addActionToObject;
	[crateGearCrew, 0, ["ACE_MainActions"], _vehPltSgt] call ace_interact_menu_fnc_addActionToObject;
	[crateGearCrew, 0, ["ACE_MainActions"], _vehCommander] call ace_interact_menu_fnc_addActionToObject;
	[crateGearCrew, 0, ["ACE_MainActions"], _vehGunner] call ace_interact_menu_fnc_addActionToObject;
	[crateGearCrew, 0, ["ACE_MainActions"], _vehDriver] call ace_interact_menu_fnc_addActionToObject;
	[crateGearCrew, 0, ["ACE_MainActions"], _resetGear] call ace_interact_menu_fnc_addActionToObject;
};