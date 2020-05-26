// PLAYER BRIEFING TEXT ///////////////////////////////////////////////////////////////////////////
/*
	- In this file you write the briefing for your mission. Most of it is pretty self-explanatory.
	  Category specific behaviour is explained at the beginnig of each category. Things such as
	  linking markers are supported.
*/
// INIT /////////////////////////////////////////////////////////////////////////////////////////// //You can <marker name='respawn'>LINK</marker> to map markers in the briefing.
//SITUATION
private _brf_situation = "
The situation section is meant to provide essential information on the status/disposition of enemy and friendly forces.
Contains 2 subparagraphs: Enemy Forces, Friendly Forces.
";

//ENEMY FORCES (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_enemy = [
	"All intelligence provided by higher commander/mission maker on the enemy that pertains to the accomplishment of the mission.",
	"SALUTE: Size of the enemy force, Activity, known Location(s), Unit type, Time of last observation, Equipment possessed.",
	"MLCOA: Most Likely Course Of Action.",
	"MDCOA: Most Dangerous Course Of Action"
];

//FRIENDLY FORCES (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_friend = [
	"Information provided by higher commander/mission maker on missions and locations of higher, adjacent and supporting units relevant to the accomplishment of the mission.",
	"HAS: Higher unit mission, Adjacent unit mission, Supporting unit mission."
];

//MISSION DESCRIPTION
private _brf_mission = "
The mission statement should be a concise statement of what the unit is meant to accomplish.(Who,What,When,Where,Why)<br/>
Example: At 0800h(When), 1PLT(Who) will assault radar station(What) on top of Hill 247(Where) in order to disrupt enemy communication(Why).
";

//EXECUTION (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_execution = [
	"The execution paragraph describes how to conduct the operation.",
	"Big picture description of how all subordinate units will conduct the plan.",
	"Initial formation, attack formation, fire support plan, reorganization plan."
];

//LOGISTICS (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_administration = [
	"Beans, Bullets, Band-aids and Badguys",
	"Initial plan for supplies/resupplies.",
	"Medevac plan, platoon medic location.",
	"HVT/Prisoner/Hostage handling procedures/evac plan."
];

//SPECIAL THANKS (if you don't want this in your briefing leave the "" empty.)
private _testers = "";