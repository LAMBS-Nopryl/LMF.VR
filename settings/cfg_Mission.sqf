// MISSION RELEVANT SETTINGS //////////////////////////////////////////////////////////////////////
/*
	- In this file you define mission relevant settings. It is important these settings are
	  configured properly.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
//VARIOUS
var_author = "Alex2k"; // Your name, which shows up at the end of the warmup.
var_location = "Altis"; // Location where scenario takes place, which can be seen in intro.
var_debug = false; // For mission testing, will turn on some debug options. (default: false)
var_warmup = true; // Start mission with warmup? (default: true)
var_jipTP = true; // Allow players that JIP to teleport? (default: true)
var_enemySide = EAST; // What side is the enemy? (WEST,EAST,INDEPENDENT) (default: EAST)
var_civPanic = true; // Will civs panic when there is a firefight? (default: true)

//RESPAWN
var_respawnType = "OFF"; // What type of Respawn? ("WAVE", "OFF", number in seconds or "Custom string") (default: "OFF")
var_respawnTime = 1500; // Respawn countdown in seconds in case of "WAVE". (default: 1500)


// PLAYERS ////////////////////////////////////////////////////////////////////////////////////////
var_playerGear = true; // Should players get custom gear? (default: true)
var_camoCoef = 1; // How easy should players be spotted by AI? Higher number = easier spotted (default: 1)

//VEHICLES AND CRATES
var_vic1 = "B_G_Offroad_01_F"; // Ground Spawnpad Vehicle
var_vic2 = "B_G_Offroad_01_AT_F"; // Ground Spawnpad Vehicle
var_vic3 = "B_G_Offroad_01_armed_F"; // Ground Spawnpad Vehicle
var_vic4 = "B_G_Quadbike_01_F"; // Ground Spawnpad Vehicle

var_air1 = ""; // Air Spawnpad Vehicle
var_air2 = ""; // Air Spawnpad Vehicle
var_air3 = ""; // Air Spawnpad Vehicle
var_air4 = ""; // Air Spawnpad Vehicle

var_supSmall = "Box_NATO_Equip_F"; // Supply Spawnpad small supplies
var_supLarge = "B_supplyCrate_F"; // Supply Spawnpad large supplies
var_supSpecial = "Box_NATO_WpsSpecial_F"; // Supply Spawnpad special supplies
var_supExplosives = "Box_NATO_AmmoOrd_F"; // Supply Spawnpad explosives supplies
var_supMedical = "ACE_medicalSupplyCrate"; // Supply Spawnpad medical supplies

//SUPPLY DROP
var_supplyDropLimit = 3; // How many supply drops should team leaders be able to call in?
var_suppDropPlane = "C_Plane_Civil_01_F"; // What plane should do the supply drop?

//FORWARD DEPLOY (check framework\shared\init\forwardDeploy.sqf for info)
var_forwardDeploy = true; // Should group leaders be able to register for a forward deployment during warmup?
var_deployHeight = 0; // At what height should players forward deploy? 0 = ground (everything higher than 0 but lower than 200 will become 200)

//PLAYER GEAR (Only relevant if var_playerGear = true;)
var_personalArsenal = true; // Give players access to a limited arsenal during briefing stage. (default: true)
var_personalRadio = true; // Does everyone get a short range radio (AN/PRC 343)? (default: true)
var_backpacksAll = true; // Give all players backpacks? (Certain roles will have backpacks regardless) (default: true)
var_pistolAll = false; // Give all players sidearms? (default: false)
var_playerNVG = 2; // Who gets NVGs? (0=ALL, 1=PILOTS, 2=NONE) (default: 2)
var_playerMaps = 0; // Who gets Maps? (0=ALL, 1=LEADERS, 2=NONE) (default: 0)
var_keepRole = false; // Should players keep their role upon respawn? (default: false)

// BLUE FORCE TRACKING ////////////////////////////////////////////////////////////////////////////
var_groupTracker = true; // Use group-icons on map. (default: true)
var_unitTracker = false; // Use unit-icons on map. (default: false)