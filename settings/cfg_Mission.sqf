// MISSION RELEVANT SETTINGS //////////////////////////////////////////////////////////////////////
/*
	- In this file you define mission relevant settings. It is important these settings are
	  configured properly.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
//VARIOUS
var_author = "Author"; // Your name, which shows up at the end of the warmup.
var_location = "Virtual Reality"; // Location where scenario takes place, which can be seen in intro.
var_debug = false; // For mission testing, will turn on some debug options. (default: false)
var_warmup = true; // Start mission with warmup? (default: true)
var_jipTP = false; // Allow players that JIP to teleport? (default: false)
var_enemySide = EAST; // What side is the enemy? (WEST,EAST,INDEPENDENT) (default: EAST)

//RESPAWN
var_respawnType = "OFF"; // What type of Respawn? ("WAVE", "OFF" or number in seconds) (default: "OFF")
var_respawnTime = 1500; // Respawn countdown in seconds in case of "WAVE". (default: 1500)


// PLAYERS ////////////////////////////////////////////////////////////////////////////////////////
var_playerGear = true; // Should players get custom gear? (default: true)
var_camoCoef = 1; // How easy should players be spotted by AI? Higher number = easier spotted (default: 1)

//VEHICLES AND CRATES
var_vic1 = "B_Truck_01_covered_F"; // Ground Spawnpad Vehicle
var_vic2 = "B_APC_Wheeled_01_cannon_F"; // Ground Spawnpad Vehicle
var_vic3 = "B_MBT_01_TUSK_F"; // Ground Spawnpad Vehicle
var_vic4 = "B_AFV_Wheeled_01_up_cannon_F"; // Ground Spawnpad Vehicle

var_air1 = "B_Heli_Transport_01_F"; // Air Spawnpad Vehicle
var_air2 = "B_Heli_Light_01_dynamicLoadout_F"; // Air Spawnpad Vehicle
var_air3 = "B_Heli_Attack_01_dynamicLoadout_F"; // Air Spawnpad Vehicle
var_air4 = "B_Plane_Fighter_01_F"; // Air Spawnpad Vehicle

var_supSmall = "Box_NATO_Ammo_F"; // Supply Spawnpad small supplies
var_supLarge = "B_supplyCrate_F"; // Supply Spawnpad large supplies
var_supSpecial = "Box_NATO_WpsSpecial_F"; // Supply Spawnpad special supplies
var_supExplosives = "Box_NATO_AmmoOrd_F"; // Supply Spawnpad explosives supplies

//PLAYER GEAR (Only relevant if var_playerGear = true;)
var_personalArsenal = false; // Give players access to a limited arsenal during briefing stage. (default: false)
var_personalRadio = true; // Does everyone get a short range radio (AN/PRC 343)? (default: true)
var_backpacksAll = false; // Give all players backpacks? (Certain roles will have backpacks regardless) (default: false)
var_pistolAll = false; // Give all players sidearms? (default: false)
var_playerNVG = 2; // Who gets NVGs? (0=ALL, 1=PILOTS, 2=NONE) (default: 2)
var_playerMaps = 0; // Who gets Maps? (0=ALL, 1=LEADERS, 2=NONE) (default: 0)
var_keepRole = true; // Should players keep their role upon respawn? (default: true)


// MARKERS ////////////////////////////////////////////////////////////////////////////////////////
var_markerSide = "ColorWEST"; // What colorsheme should markers on playerside use? ("ColorWEST", "ColorEAST", "ColorGUER") (default: "ColorWEST")
var_groupMarkers = true; // Use group-icons on map. (default: true)
var_unitTracker = false; // Use unit-icons on map. (default: false)