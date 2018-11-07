// PLAYER BRIEFING TEXT ///////////////////////////////////////////////////////////////////////////
/*
	- In this file you write the briefing for your mission. Most of it is pretty self-explanatory.
	  Category specific behaviour is explained at the beginnig of each category. Things such as
	  linking markers are supported.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//SITUATION
private _brf_situation = "
This is the Situation section of the briefing. It is ment to provide players with a general idea of whats going on.
";

//ENEMY FORCES (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_enemy = [
	"Enemy Army Unit:",
	"Possible Information #1",
	"Possible Information #2",
	"Possible Information #n",
	"Vehicle threats: vehicle threat #1, vehicle threat #n"
];

//FRIENDLY FORCES (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_friend = [
	"Friendly Army Unit (players)",
	"Possible Information #1",
	"Possible Information #2",
	"Possible Information #n",
	"Friendly Vehicles (players): vehicles #1, vehicles #n"
];

//OTHER REMARKS (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_remarks = [
	"These could be remarks about terrain.",
	"These could be remarks about weather.",
	"These could be remarks about anything really. "
];


//MISSION DESCRIPTION
private _brf_mission = "
Here you let the players know what their mission will be.
";

//EXECUTION (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_execution = [
	"Mission step #1.",
	"Mission step #2.",
	"Mission step #n."
];

//LOGISTICS (every line must start and end with a " and all but the last must have a , at the end.)
private _brf_administration = [
	"Could be a remark about available supplies.",
	"Could be a remark about available repairs.",
	"Could be any remark helpful in logistics or administration."
];

//SPECIAL THANKS (if you don't want this in your briefing leave the "" empty.)
private _testers = "
Thanks to name for the assets he provided and thanks to all my pals that helped me test this mission.
";