// PLAYER EQUIPMENT DEFINITIONS ///////////////////////////////////////////////////////////////////
/*
	- In this file you define player related gear components that are used in the players
	  custom gear.
	- The gear from this file also comes to use in player vehicles and supply crates defined
	  in cfg_Mission.sqf
	- If you don't use the custom gear component you can ingore this file.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
//RADIOS
private _ACRE_MMR = "ACRE_PRC117F"; // Backpack Radio
private _ACRE_ITR = "ACRE_PRC148"; // Long Range Radio
private _ACRE_PRR = "ACRE_PRC343"; // Short Range Radio

//INFANTRY UNIFORM
private _Uniform = ["U_B_CombatUniform_mcam_vest"]; // Uniform(s)
private _Vest = ["V_PlateCarrier2_rgr"]; // Vest(s)
private _Headgear = ["H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint2","H_HelmetSpecB_paint1","H_HelmetSpecB_sand","H_HelmetSpecB_snakeskin"]; // Headgear(s)
private _Headgear_A = ["H_HelmetSpecB_paint2","H_HelmetSpecB_paint1"]; // Headgear(s) (Available in Personal Arsenal)
private _Goggles = ["G_Balaclava_TI_G_blk_F"]; // Goggle(s)
private _Goggles_A = [""]; // Goggle(s) (Available in Perosnal Arsenal)

//PILOT UNIFORM
private _Heli_Uniform = ["U_B_HeliPilotCoveralls"]; // Pilot Uniform(s)
private _Heli_Vest = ["V_TacVest_blk"]; // Pilot Vest(s)
private _Heli_Headgear = ["H_PilotHelmetHeli_B"]; // Pilot Headgear(s)

private _Plane_Uniform = ["U_B_PilotCoveralls"]; // Plane Uniform(s)
private _Plane_Vest = ["V_Rangemaster_belt"]; // Plane Vest(s)
private _Plane_Headgear = ["H_PilotHelmetFighter_B"]; // Plane Headgear(s)

//VEHICLE CREW UNIFORM
private _Crew_Uniform = ["U_B_CombatUniform_mcam_tshirt"]; // Crew Uniform(s)
private _Crew_Vest = ["V_BandollierB_rgr"]; // Crew Vest(s)
private _Crew_Headgear = ["H_HelmetCrew_B"]; // Crew Headgear(s)

//BACKPACKS
private _Backpack_Leader = ["B_TacticalPack_mcamo"]; // PltLead, PltSgt, Squad Leader Backpack(s)
private _Backpack_RTO = ["B_Carryall_mcamo"]; // RTO, FAC Backpack(s)
private _Backpack_Medic = ["B_Kitbag_mcamo"]; // Medic Backpack(s)
private _Backpack_MAT = ["B_Carryall_mcamo"]; // MAT, MAT Assistant Backpack(s)
private _Backpack_AR_MMG = ["B_Carryall_mcamo"]; // AR/MMG, AR/MMG assistant Backpack(s)
private _Backpack_Crew = ["B_AssaultPack_mcamo"]; // Vehicle crew Backpack(s)
private _Backpack_Pilot = ["B_AssaultPack_mcamo"]; // Pilots Backpack(s)
private _Backpack_Light = ["B_AssaultPack_mcamo"]; // Everyone else if given Backpack(s)

//FLARE GUN
private _FlareGun = "hgun_Pistol_Signal_F"; // Flaregun
private _FlareGun_Ammo = "6Rnd_RedSignal_F"; // Flaregun Ammo

//PISTOL
private _Pistol = "hgun_P07_F"; // Pistol
private _Pistol_Ammo = "16Rnd_9x21_Mag"; // Pistol Ammo
private _Pistol_Attach1 = ""; // Pistol Attachement #1
private _Pistol_Attach2 = ""; // Pistol Attachement #2

//SMG (Used by: Vehicle Crew, Helicopter Pilot)
private _SMG = "hgun_PDW2000_F"; // SMG
private _SMG_Ammo = "30Rnd_9x21_Mag"; // SMG Ammo
private _SMG_Optic = ""; // SMG Scope
private _SMG_Attach1 = ""; // SMG Attachement #1
private _SMG_Attach2 = ""; // SMG Attachement #2
private _SMG_Bipod = ""; // SMG Bipod

//CARBINE (Used by: RTO, Medic, MMG Assistant, MAT Gunner & Assistant)
private _Carbine = "arifle_MXC_F"; // Carbine
private _Carbine_Ammo = "30Rnd_65x39_caseless_mag"; // Carbine Ammo
private _Carbine_Ammo_T = "30Rnd_65x39_caseless_mag_Tracer"; // Carbine Tracer Ammo
private _Carbine_Optic = "optic_aco"; // Carbine Optic
private _Carbine_Attach1 = "acc_pointer_ir"; // Carbine Attachement #1
private _Carbine_Attach2 = "muzzle_snds_h"; // Carbine Attachement #2
private _Carbine_Bipod = ""; // Carbine Bipod

//RIFLE (Used by: Plt.Lead, Plt.Sgt, Squad Leader, Rifleman)
private _Rifle = "arifle_MX_F"; // Rifle
private _Rifle_Ammo = "30Rnd_65x39_caseless_mag"; // Rifle Ammo
private _Rifle_Ammo_T = "30Rnd_65x39_caseless_mag_Tracer"; // Rifle Tracer Ammo
private _Rifle_Optic = "optic_aco"; // Rifle Optic
private _Rifle_Attach1 = "acc_pointer_ir"; // Rifle Attachement #1
private _Rifle_Attach2 = "muzzle_snds_h"; // Rifle Attachement #2
private _Rifle_Bipod = ""; // Rifle Bipod

//RIFLE GL (Used by: Assistant Squad Leader, Grenadier, FAC)
private _Rifle_GL = "arifle_MX_GL_F"; // GL Rifle
private _Rifle_GL_Ammo = "30Rnd_65x39_caseless_mag"; // GL Rifle Ammo
private _Rifle_GL_Ammo_T = "30Rnd_65x39_caseless_mag_Tracer"; // GL Rifle Tracer Ammo
private _Rifle_GL_HE = "1Rnd_HE_Grenade_shell"; // GL 40mm HE
private _Rifle_GL_Flare = "UGL_FlareRed_F"; // GL 40mm Flare
private _Rifle_GL_Smoke_Grn = "1Rnd_SmokeGreen_Grenade_shell"; // GL 40mm Smoke Green
private _Rifle_GL_Smoke_Red = "1Rnd_SmokeRed_Grenade_shell"; // GL 40mm Smoke Red
private _Rifle_GL_Optic = "optic_aco"; // GL Rifle Optic
private _Rifle_GL_Attach1 = "acc_pointer_ir"; // GL Rifle Attachement #1
private _Rifle_GL_Attach2 = "muzzle_snds_h"; // GL Rifle Attachement #2
private _Rifle_GL_Bipod = ""; // GL Rifle Bipod

//LIGHT MACHINE GUN (Used by: Automatic Rifleman)
private _LMG = "arifle_MX_SW_F"; // LMG
private _LMG_Ammo = "100Rnd_65x39_caseless_mag"; // LMG Ammo
private _LMG_Ammo_T = "100Rnd_65x39_caseless_mag_Tracer"; // LMG Tracer Ammo
private _LMG_Optic = "optic_aco"; // LMG Optic
private _LMG_Attach1 = "acc_pointer_ir"; // LMG Attachement #1
private _LMG_Attach2 = "muzzle_snds_h"; // LMG Attachement #2
private _LMG_Bipod = ""; // LMG Bipod

//MEDIUM MACHINE GUN (Used by: Machine Gunner)
private _MMG = "MMG_02_sand_F"; // MMG
private _MMG_Ammo = "130Rnd_338_Mag"; // MMG Ammo
private _MMG_Optic = "optic_aco"; // MMG Optic
private _MMG_Attach1 = "acc_pointer_ir"; // MMG Attachement #1
private _MMG_Attach2 = "muzzle_snds_338_black"; // MMG Attachement #2
private _MMG_Bipod = ""; // MMG Bipod

//LIGHT ANTI-TANK (Used by: Rifleman)
private _LAT = "launch_NLAW_F"; // LAT
private _LAT_Ammo = ""; // LAT Ammo

//MEDIUM ANTI-TANK (Used by: AT Gunner)
private _MAT = "launch_MRAWS_green_F"; // MAT
private _MAT_Ammo = "MRAWS_HEAT_F"; // MAT Ammo
private _MAT_Optic = ""; // MAT Optic

//GRENADES
private _Grenade = "MiniGrenade"; // HE Grenade
private _Grenade_Smoke = "SmokeShell"; // Smoke Grenade
private _Grenade_Smoke_Grn = "SmokeShellGreen";

//MISC
private _Binocular = "Binocular"; // Binocular Item
private _NVG = "NVGoggles"; // NVG Item
private _NVG_Pilot = "NVGoggles"; // NVG Item for Pilots


//ROLE DEFINITIONS (DO NOT USE THE SAME CLASSNAME TWICE)
//PLATOON
private _PlatoonLeader = "B_officer_F"; // Platoon Leader
private _PlatoonSgt = "B_Soldier_lite_F"; // Platoon Sergeant
private _Medic = "B_medic_F"; // Medic
private _RTO = "B_support_MG_F"; // RTO
private _FAC = "B_support_GMG_F"; // FAC

//SQUAD
private _SquadLeader = "B_Soldier_SL_F"; // Squad Leader
private _TeamLeader = "B_Soldier_TL_F"; // Assistant Squad Leader
private _Autorifleman = "B_soldier_AR_F"; // Automatic Rifleman
private _Grenadier = "B_Soldier_GL_F"; // Grenadier
private _Rifleman = "B_soldier_LAT_F"; // Rifleman

private _MachineGunner = "B_HeavyGunner_F"; // Machine Gunner
private _MgAssistant = "B_soldier_AAR_F"; // Asst. Machine Gunner
private _AntiTankGunner = "B_soldier_AT_F"; // Anti Tank Gunner
private _AtAssistant = "B_soldier_AAT_F"; // Asst. AT Gunner

//VEHICLE
private _CrewLeader = "B_soldier_repair_F"; // Vehicle Platoon Leader
private _CrewSgt = "B_engineer_F"; // Vehicle Platoon Sergeant, Vehicle Commander
private _Crew = "B_crew_F"; // Vehicle Driver , Vehicle Gunner

//AIR
private _HeloPilot = "B_Helipilot_F"; // Helicopter Pilot, Helicopter Co-Pilot
private _HeloCrew = "B_helicrew_F"; // Helicopter Crew
private _Pilot = "B_Pilot_F"; // Fighter Pilot