// PLAYER KILLED EH ///////////////////////////////////////////////////////////////////////////////
/*
	- This function spawned by the player killed EH handles what happens on a players death.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];


//BLACK OUT ///////////////////////////////////////////////////////////////////////////////////////
cutText  ["", "BLACK FADED", 4, true];

//CALCULATE RESPAWNTIME
if (typename var_respawnType == "STRING") then {

	if (var_respawnType == "WAVE") then {
		setPlayerRespawnTime (var_respawnTime - ((floor CBA_missionTime) % var_respawnTime));
	};

	if (var_respawnType == "OFF") then {
		setPlayerRespawnTime 1000000;
	};

};

if (typename var_respawnType == "SCALAR") then {
	setPlayerRespawnTime var_respawnType;
};

//SLEEP FOR A WHILE
sleep 6;


// SPECTATOR SETTINGS /////////////////////////////////////////////////////////////////////////////
0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;

//FADE IN
cutText  ["", "BLACK IN", 4, true];