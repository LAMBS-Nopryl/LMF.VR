// AI EQUIPMENT DEFINITIONS ///////////////////////////////////////////////////////////////////////
/*
	- In this file you can define most AI related definitions such as:
		1) Their Equipment
 		2) Their Vehicles (These vehicles will be used for spawning, futhermore they will be affected by other script components.)
		3) Their Infantry (Defined Classnames will become special roles such as Grenadiers and AR Gunners)
	- All placed AI soldiers that do not fall under the defined classnames below (as long as they are from var_enemySide)
	  will get a random Loadout (excluding AA).
 	- If you define several different weapons in the same category that use incompatible magazines, e.g.: _Rifle = ["Ak47", "M16"];
	  leave the array for magazines empty as such: private _Rifle_Ammo = [""];
	- The Ammo Blacklist affects all vehicles defined in this file.
	- The Camos can obviously only be applied if they exist for said vehicle, which means if you define multiple trucks and only
	  one of them has a black camouflage, then it will not work for the trucks that don't have it.
	- If you set var_enemyGear to false, you can skip anything below it until the // VEHICLES section.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
//GENERAL SETTINGS
private _var_enemySkill = 1; // What skill does the enemy have? (0=UNTRAINED, 1=REGULAR, 2=ELITE) (default: 1)
private _var_enemyNVG = false; // Should AI get NVGs? (default: false)
private _var_enemyGear = true; // Should AI get custom gear? (default: true)
private _var_enemyGoodies = false; // Give additional medical supplies? (default: false) (only taking effect if _var_enemyGear = true;)


// CLOTHING ///////////////////////////////////////////////////////////////////////////////////////
private _Uniform = ["U_I_CombatUniform","U_I_CombatUniform_shortsleeve"]; // Uniform(s)
private _Vest = ["V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl"]; // Vest(s)
private _Headgear = ["H_HelmetIA"]; // Headgear(s)
private _Goggles = [""]; // Facewear(s)

//BACKPACKS
private _Backpack_Light = ["B_AssaultPack_dgtl"]; // Backpack(s)
private _Backpack_Heavy = ["B_Carryall_oli"]; // Backpack(s) used for MMG, MAT and AA
private _Backpack_HMG_Gun = ["I_HMG_02_high_weapon_F"]; // HMG Gunbag
private _Backpack_HMG_Pod = ["I_HMG_02_support_high_F"]; // HMG Podbag
private _Backpack_MORTAR_Gun = ["I_Mortar_01_weapon_F"]; // MORTAR Gunbag
private _Backpack_MORTAR_Pod = ["I_Mortar_01_support_F"]; // MORTAR Podbag
private _Backpack_HAT_Gun = ["I_AT_01_weapon_F"]; // HAT Gunbag
private _Backpack_HAT_Pod = ["I_HMG_01_support_high_F"]; // HAT Podbag

//HELICOPTER CREW AND PILOTS
private _Heli_Uniform = ["U_I_HeliPilotCoveralls"]; // Same as Uniform(s) but for Pilots
private _Heli_Vest = ["V_BandollierB_oli"]; // Same as Vest(s) but for Pilots
private _Heli_Headgear = ["H_PilotHelmetHeli_I"]; // Same as Headgear(s) but for Pilots

//VEHICLE CREW
private _Crew_Uniform = ["U_Tank_green_F"]; // Same as Uniform(s) but for Pilots
private _Crew_Vest = ["V_Rangemaster_belt"]; // Same as Vest(s) but for Pilots
private _Crew_Headgear = ["H_HelmetCrew_I"]; // Same as Headgear(s) but for Pilots


// WEAPONS ////////////////////////////////////////////////////////////////////////////////////////
private _Pistol = ["hgun_ACPC2_F"]; // Pistol(s)
private _Pistol_Ammo = ["9Rnd_45ACP_Mag"]; // Pistol Magazine(s)

private _Carbine = ["arifle_Mk20C_F"]; // Carbine(s)
private _Carbine_Ammo = ["30Rnd_556x45_Stanag"]; // Carbine Magazine(s)

private _Rifle = ["arifle_Mk20C_F"]; // Rifle(s)
private _Rifle_Ammo = ["30Rnd_556x45_Stanag"]; // Rifle Magazine(s)

private _Rifle_GL = ["arifle_Mk20_GL_F"]; // Rifle(s) with Underslungs
private _Rifle_GL_Ammo = ["30Rnd_556x45_Stanag"]; // Rifle Magazine(s)
private _Rifle_GL_Smoke = ["1Rnd_Smoke_Grenade_shell"]; // Underslung Smoke(s)
private _Rifle_GL_Flare = ["ACE_40mm_Flare_white"]; // Underslung Flare(s)

private _DMR = ["srifle_EBR_F"]; // Designated Marksman Rifle(s)
private _DMR_Ammo = [""]; // DNR Magazine(s)

private _LMG = ["LMG_Mk200_F"]; // Light Machine Gun(s)
private _LMG_Ammo = ["200Rnd_65x39_cased_Box"]; // LMG Magazine(s)

private _MMG = ["LMG_Mk200_F"]; // Medium Machine Gun(s)
private _MMG_Ammo = ["200Rnd_65x39_cased_Box"]; // MMG Magazine(s)

private _LAT = ["launch_NLAW_F"]; // Light Anti-Tank(s)
private _LAT_Ammo = [""]; // LAT Magazine(s)

private _MAT = ["launch_MRAWS_olive_rail_F"]; // Medium Anti-Tank(s)
private _MAT_Ammo = ["MRAWS_HEAT_F"]; // MAT Magazine(s)

private _AA = ["launch_I_Titan_F"]; // Anti-Air(s)
private _AA_Ammo = ["Titan_AA"]; // AA Magazine(s)

private _Grenade = ["MiniGrenade","HandGrenade"]; // HE Grenade(s)
private _Grenade_Smoke = ["SmokeShell"]; // Smoke Grenade(s)

private _Attach = ["acc_flashlight"]; // Weapon Attachement(s)
private _Optic = ["optic_ACO_grn"]; // Weapon Optic(s)


// VEHICLES ///////////////////////////////////////////////////////////////////////////////////////
private _car =  ["I_MRAP_03_hmg_F"]; // Car(s)
private _carArmed =  ["I_MRAP_03_hmg_F"]; // Armed Car(s)
private _truck =  ["I_Truck_02_covered_F"]; // Truck(s)
private _apc =  ["I_APC_tracked_03_cannon_F"]; // APC(s)
private _tank =  ["I_MBT_03_cannon_F"]; // Tank(s)
private _heli_Transport =  ["I_Heli_Transport_02_F"]; // Transport Helo(s)
private _heli_Attack =  ["I_Heli_light_03_dynamicLoadout_F"]; // Attack Helo(s)

//CAMOS  (Applied to all defined vehicles that are spawned. Leave empty if no camo.)
private _car_Camo =  [""]; // camo(s) for car(s)
private _carArmed_Camo =  [""]; // camo(s) for armed car(s)
private _truck_Camo =  [""]; // camo(s) for truck(s)
private _apc_Camo =  [""]; // camos(s) for apc(s)
private _tank_Camo =  [""]; // camo(s) for tank(s)
private _heli_Transport_Camo =  [""]; // camo(s) for helo(s)
private _heli_Attack_Camo =  [""]; // camo(s) for attack helo(s)

//AMMO BLACKLIST
private _ammoBlacklist = [""];


// DEFINE AI UNITS ////////////////////////////////////////////////////////////////////////////////
// BLUFOR (configure if var_enemySide = WEST;)
private _Autorifleman = "B_Soldier_AR_F";
private _Crew = "B_crew_F";
private _Grenadier = "B_Soldier_GL_F";
private _MMG_Gunner = "B_HeavyGunner_F";
private _Marksman = "B_soldier_M_F";
private _AA_Gunner = "B_soldier_AA_F";
private _MAT_Gunner = "B_Soldier_AT_F";
private _Officer = "B_officer_F";
private _Pilot = "B_Helipilot_F";
private _Rifleman = "B_Soldier_F";
private _Rifleman_AT = "B_Soldier_LAT_F";
private _Squad_Leader = "B_Soldier_SL_F";

//OPFOR (configure if var_enemySide = EAST;)
if (var_enemySide == EAST) then {
	_Autorifleman = "O_Soldier_AR_F";
	_Crew = "O_crew_F";
	_Grenadier = "O_Soldier_GL_F";
	_MMG_Gunner = "O_HeavyGunner_F";
	_Marksman = "O_soldier_M_F";
	_AA_Gunner = "O_Soldier_AA_F";
	_MAT_Gunner = "O_Soldier_AT_F";
	_Officer = "O_officer_F";
	_Pilot = "O_helipilot_F";
	_Rifleman = "O_Soldier_F";
	_Rifleman_AT = "O_Soldier_LAT_F";
	_Squad_Leader = "O_Soldier_SL_F";
};

//INDEPENDENT (configure if var_enemySide = INDEPENDENT;)
if (var_enemySide == INDEPENDENT) then {
	_Autorifleman = "I_Soldier_AR_F";
	_Crew = "I_crew_F";
	_Grenadier = "I_Soldier_GL_F";
	_MMG_Gunner = "I_Soldier_unarmed_F";
	_Marksman = "I_Soldier_M_F";
	_AA_Gunner = "I_Soldier_AA_F";
	_MAT_Gunner = "I_Soldier_AT_F";
	_Officer = "I_officer_F";
	_Pilot = "I_helipilot_F";
	_Rifleman = "I_soldier_F";
	_Rifleman_AT = "I_Soldier_LAT_F";
	_Squad_Leader = "I_Soldier_SL_F";
};