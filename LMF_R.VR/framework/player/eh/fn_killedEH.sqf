// PLAYER KILLED EH ///////////////////////////////////////////////////////////////////////////////
/*
	- This function spawned by the player killed EH handles what happens on a players death.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];


//BLACK OUT ///////////////////////////////////////////////////////////////////////////////////////
cutText  ["", "BLACK OUT", 4, true];
[false] call ace_common_fnc_setVolume;

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



//SET ACRE SPECTATOR
sleep 1;
[true] call acre_api_fnc_setSpectator;
sleep 4;


// INITIALIZE SPECTATOR ///////////////////////////////////////////////////////////////////////////
["Initialize", [_unit, [], false, true, true, false, false, false, false, true]] call BIS_fnc_EGSpectator;
[true] call ace_common_fnc_setVolume;


//ADD CUSTOM CHAT CHANNEL AND NOTIFY PLAYER
[_unit,true] remoteExec ["lmf_server_fnc_spectatorChannel", 2];

sleep 1;

0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;


//FADE IN
cutText  ["", "BLACK IN", 4, true];

//RESPAWN COUNTER
[] spawn {
	private _nk_fnc_timemagic = {
		params ["_number"];
		if (_number < 10) then {_number = format ["0%1",_number]};
		_number
	};

	waitUntil {playerRespawnTime < 4000};

	while {playerRespawnTime > 0 && {!alive player}} do {
		//IF WAVE
		if (typename var_respawnType == "STRING") then {
			if (var_respawnType == "WAVE") then {
				private _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call _nk_fnc_timemagic,[(playerRespawnTime mod 60)] call _nk_fnc_timemagic];
				private _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
				hintSilent parsetext (_time);
				uiSleep 1;
			};
			//IF OFF
			if (var_respawnType == "OFF") then {
				private _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call _nk_fnc_timemagic,[(playerRespawnTime mod 60)] call _nk_fnc_timemagic];
				private _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
				hintSilent parsetext (_time);
				uiSleep 1;
			};
		};
		//IF NUMBER
		if (typename var_respawnType == "SCALAR") then {
			private _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call _nk_fnc_timemagic,[(playerRespawnTime mod 60)] call _nk_fnc_timemagic];
			private _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
			hintSilent parsetext (_time);
			uiSleep 1;
		};
	};
	//END IT WHEN RESPAWN
	hintSilent "";
};