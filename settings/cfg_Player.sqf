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
private _ACRE_MMR = "ACRE_PRC117F"; //Backpack Radio
private _ACRE_ITR = "ACRE_PRC148"; //Long Range Radio
private _ACRE_PRR = "ACRE_PRC343"; //Short Range Radio

//INFANTRY UNIFORM
private _Uniform = ["U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_leader"]; // Uniform
private _Vest = ["V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli"]; // Vest
private _Headgear = ["H_Bandanna_gry","H_Bandanna_cbr","H_Bandanna_khk","H_Bandanna_camo","H_Booniehat_oli","H_Booniehat_tan","H_Booniehat_dgtl","H_Cap_blk","H_Cap_grn","H_Cap_oli","H_Cap_blk_Raven"]; // Headgear
private _Goggles = [""]; // Goggles

//PILOT UNIFORM
private _Heli_Uniform = ["U_C_WorkerCoveralls"]; // Pilot Uniform
private _Heli_Vest = ["V_BandollierB_blk"]; // Pilot Vest
private _Heli_Headgear = ["H_HeadSet_black_F"]; // Heli Pilot Headgear
private _Heli_Headgear_C = ["H_HeadSet_black_F"]; // Heli Crew Headgear
private _Heli_Goggles = ["G_Aviator"]; // Goggles

private _Plane_Uniform = ["U_I_pilotCoveralls"]; // Plane Uniform
private _Plane_Vest = ["V_Rangemaster_belt"]; // Plane Vest
private _Plane_Headgear = ["H_PilotHelmetFighter_I"]; // Plane Headgear
private _Plane_Goggles = ["G_Aviator"]; // Goggles

//VEHICLE CREW UNIFORM
private _Crew_Uniform = ["U_BG_leader"]; // Crew Uniform
private _Crew_Vest = ["V_BandollierB_rgr"]; // Crew Vest
private _Crew_Headgear = ["H_HelmetCrew_I"]; // Crew Headgear
private _Crew_Goggles = [""]; // Goggles

//BACKPACKS
private _Backpack_Leader = ["B_LegStrapBag_black_F","B_LegStrapBag_coyote_F"]; // Plt.Lead, Plt.Sgt, Squad Leader
private _Backpack_RTO = ["B_RadioBag_01_digi_F"]; // RTO, FAC
private _Backpack_Medic = ["B_Messenger_Black_F"]; // Medic
private _Backpack_MAT = ["B_Carryall_oli"]; // MAT, MAT Assistant
private _Backpack_AR_MMG = ["B_TacticalPack_oli"]; // AR/MMG, AR/MMG assistant
private _Backpack_Crew = ["B_LegStrapBag_black_F"]; // Vehicle crew
private _Backpack_Pilot = ["B_LegStrapBag_black_F"]; // Pilots
private _Backpack_Light = ["B_LegStrapBag_black_F","B_LegStrapBag_coyote_F"]; // Everyone else if given backpacks

//FLARE GUN
private _FlareGun = "hgun_Pistol_Signal_F"; // Flaregun
private _FlareGun_Ammo = "6Rnd_GreenSignal_F"; // Flaregun Ammo

//PISTOL
private _Pistol = "hgun_ACPC2_F"; // Pistol
private _Pistol_Ammo = "9Rnd_45ACP_Mag"; // Pistol Ammo
private _Pistol_Attach1 = ""; // Pistol Attachment #1
private _Pistol_Attach2 = ""; // Pistol Attachment #2

//SMG (Used by: Vehicle Crew, Helicopter Pilot)
private _SMG = "SMG_03C_black"; // SMG
private _SMG_Ammo = "50Rnd_570x28_SMG_03"; // SMG Ammo
private _SMG_Optic = ""; // SMG Scope
private _SMG_Attach1 = ""; // SMG Attachment #1
private _SMG_Attach2 = ""; // SMG Attachment #2
private _SMG_Bipod = ""; // SMG Bipod

//CARBINE (Used by: Medic, MMG Assistant, MAT Gunner & Assistant)
private _Carbine = "arifle_Mk20C_F"; // Carbine
private _Carbine_Ammo = "30Rnd_556x45_Stanag"; // Carbine Ammo
private _Carbine_Ammo_T = "30Rnd_556x45_Stanag_Tracer_Yellow"; // Carbine Tracer Ammo
private _Carbine_Optic = ""; // Carbine Optic
private _Carbine_Attach1 = "acc_flashlight"; // Carbine Attachment #1
private _Carbine_Attach2 = ""; // Carbine Attachment #2
private _Carbine_Bipod = ""; // Carbine Bipod

//RIFLE (Used by: Plt.Lead, Plt.Sgt, Rifleman, RTO)
private _Rifle = "arifle_Mk20C_F"; // Rifle
private _Rifle_Ammo = "30Rnd_556x45_Stanag"; // Rifle Ammo
private _Rifle_Ammo_T = "30Rnd_556x45_Stanag_Tracer_Yellow"; // Rifle Tracer Ammo
private _Rifle_Optic = ""; // Rifle Optic
private _Rifle_Attach1 = "acc_flashlight"; // Rifle Attachment #1
private _Rifle_Attach2 = ""; // Rifle Attachment #2
private _Rifle_Bipod = ""; // Rifle Bipod

//RIFLE GL (Used by: Squad Leader, Assistant Squad Leader, Grenadier, FAC)
private _Rifle_GL = "arifle_Mk20_GL_F"; // GL Rifle
private _Rifle_GL_Ammo = "30Rnd_556x45_Stanag"; // GL Rifle Ammo
private _Rifle_GL_Ammo_T = "30Rnd_556x45_Stanag_Tracer_Yellow"; // GL Rifle Tracer Ammo
private _Rifle_GL_HE = "1Rnd_HE_Grenade_shell"; // GL 40mm HE
private _Rifle_GL_Flare = "ACE_40mm_Flare_white"; // GL 40mm Flare
private _Rifle_GL_Smoke_Grn = "1Rnd_Smoke_Grenade_shell"; // GL 40mm Smoke Green
private _Rifle_GL_Smoke_Red = "1Rnd_Smoke_Grenade_shell"; // GL 40mm Smoke Red
private _Rifle_GL_Optic = ""; // GL Rifle Optic
private _Rifle_GL_Attach1 = "acc_flashlight"; // GL Rifle Attachment #1
private _Rifle_GL_Attach2 = ""; // GL Rifle Attachment #2
private _Rifle_GL_Bipod = ""; // GL Rifle Bipod

//LIGHT MACHINE GUN (Used by: Automatic Rifleman)
private _LMG = "LMG_Mk200_F"; // LMG
private _LMG_Ammo = "200Rnd_65x39_cased_Box"; // LMG Ammo
private _LMG_Ammo_T = "200Rnd_65x39_cased_Box"; // LMG Tracer Ammo
private _LMG_Optic = ""; // LMG Optic
private _LMG_Attach1 = "acc_flashlight"; // LMG Attachment #1
private _LMG_Attach2 = ""; // LMG Attachment #2
private _LMG_Bipod = ""; // LMG Bipod

//MEDIUM MACHINE GUN (Used by: Machine Gunner)
private _MMG = "MMG_02_black_F"; // MMG
private _MMG_Ammo = "130Rnd_338_Mag"; // MMG Ammo
private _MMG_Optic = ""; // MMG Optic
private _MMG_Attach1 = "bipod_03_F_blk"; // MMG Attachment #1
private _MMG_Attach2 = ""; // MMG Attachment #2
private _MMG_Bipod = ""; // MMG Bipod

//LIGHT ANTI-TANK (Used by: Rifleman)
private _LAT = ""; // LAT
private _LAT_Ammo = ""; // LAT Ammo

//MEDIUM ANTI-TANK (Used by: AT Gunner)
private _MAT = "launch_MRAWS_olive_rail_F"; // MAT
private _MAT_Ammo = "MRAWS_HEAT_F"; // MAT Ammo
private _MAT_Optic = ""; // MAT Optic

//GRENADES
private _Grenade = "MiniGrenade"; // HE Grenade
private _Grenade_Smoke = "SmokeShell"; // Smoke Grenade
private _Grenade_Smoke_Alt = "SmokeShellOrange"; // Smoke grenade alt. (FAC, Plt.Lead, Plt.Sgt, RTO, Squad Leader, Assistant Squad Leader)

//MISC
private _Binocular = "Binocular"; // Binocular Item
private _NVG = ""; // NVG Item
private _NVG_Pilot = ""; // NVG Item for Pilots


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