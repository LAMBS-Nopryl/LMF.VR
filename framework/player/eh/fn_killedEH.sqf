// PLAYER KILLED EH ///////////////////////////////////////////////////////////////////////////////
/*
	- This function spawned by the player killed EH handles what happens on a players death.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

//CALCULATE RESPAWNTIME
if (typename var_respawnType == "STRING") then {

	if (var_respawnType == "WAVE") then {
		setPlayerRespawnTime (var_respawnTime - ((floor CBA_missionTime) % var_respawnTime));
	};

	if (var_respawnType == "OFF") then {
		setPlayerRespawnTime 1000000;
	};

	if (var_respawnType != "WAVE" && var_respawnType != "OFF") then {
		setPlayerRespawnTime 1000000;
	};

};

if (typename var_respawnType == "SCALAR") then {
	setPlayerRespawnTime var_respawnType;
};

if (playerRespawnTime < 10) then {
	setPlayerRespawnTime 10;
};

//REINFORCEMENT GROUP (FIRST DEAD PLAYER CREATES GROUP)
if (isNil "grpReinforcements") then {
    grpReinforcements = createGroup [playerSide,false];
    grpReinforcements setGroupIdGlobal ["Reinforcements"];
};

sleep 3;

//BLACK OUT ///////////////////////////////////////////////////////////////////////////////////////
cutText ["","BLACK OUT",4,true];

//SLEEP FOR A WHILE
sleep 6;

//MESSAGE TO DEAD PLAYERS
_deadPlayers = [] call ace_spectator_fnc_players;
_msgPool = [
	" is dead as a doornail",
	" became a frag for the other team",
	" sleeps with the fishes",
	" came, saw, died",
	"'s healthbar reached zero",
	" kicked the bucket",
	" is pushing up daisies",
	" has become living-challenged",
	" is definitely done dancing",
	" flatlined",
	" has become worm food",
	" is taking a dirt nap",
	" bit the dust",
	" went belly up",
	" is dead as a dodo",
	" was killed in action",
	" shuffled off this mortal coil",
	" is six feet under",
	"'s earthly career ended",
	" kicked the oxygen habit",
	" has gone the way of all flesh",
	" was annihilated",
	" crossed the river Styx",
	" was fragged",
	" ceased to be",
	" met an untimely end",
	" walked the plank",
	" went to the happy hunting grounds",
	", available now with 100% less life",
	" forgot to drink a health-potion",
	" returns home on their shield",
	" gets to meet the eternal shepherd",
	" has been sheared for the last time",
	" joins the great flock"
];
_txt = parseText format [
    "<t font='PuristaBold' size='0.5' shadow='2' color='#FFBA26'>%1<t color='#FFFFFF'>%2",
    name player,
	selectRandom _msgPool
];
{[_txt,0,0.9,8,0,1,random 9999] remoteExec ["BIS_fnc_dynamicText",_x,false]} forEach _deadPlayers;

//ACE SPECTATOR INTERFACE
[true] call ace_spectator_fnc_setSpectator;

// SPECTATOR SETTINGS /////////////////////////////////////////////////////////////////////////////
0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;

//FADE IN
cutText ["","BLACK IN",4,true];