// WARMUP SCRIPT //////////////////////////////////////////////////////////////////////////////////
/*
    - Originally by nkenny. Revised by Drgn V4karian.
    - File makes players go through intro and if enabled warmup.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//DO THE INTRO
waitUntil {time > 0};
cutText  ["", "BLACK FADED", 10, true];
player enableSimulation false;
private _date = str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0) + " " + str (date select 3) + ":" + str (date select 4);
sleep 4;
titleText [format ["<t color='#FFBA26' size='5'>%1</t><br/><t color='#D7DBD5' size='3'>%2</t><br/><t color='#D7DBD5' size='2'>%3</t>",briefingName,_date,var_location], "PLAIN", 1.2, true,true];
sleep 8;
waitUntil {!isNil "lmf_warmup"};
cutText  ["", "BLACK IN", 10, true];

player enableSimulation true;

//EXIT IF NO WARMUP OR WARMUP HAS ALREADY ENDED (JIP)
if !(lmf_warmup) exitWith {};


// WARMUP /////////////////////////////////////////////////////////////////////////////////////////
//DISABLE WEAPONS AND DISALLOW DAMMAGE
waitUntil {simulationEnabled player};
[true] call lmf_admin_fnc_playerSafety;


//DISPLAY CONTROL
//SIZE VARIATION
private _hValue = 3.7;
if (typename var_respawnType == "SCALAR") then {_hValue = 4.2;} else {if (var_respawnType == "WAVE") then {_hValue = 4.2;}};

// Use profile settings from CfgUIGrids.hpp
private _xPos = profilenamespace getVariable ["IGUI_GRID_ACE_displayText_X", ((safezoneX + safezoneW) - (10 *(((safezoneW / safezoneH) min 1.2) / 10)) - 2.9 *(((safezoneW / safezoneH) min 1.2) / 40))];
private _yPos = profilenamespace getVariable ["IGUI_GRID_ACE_displayText_Y", safeZoneY + 0.175 * safezoneH];
private _wPos =  (14 *(((safezoneW / safezoneH) min 1.2) / 40));
private _hPos = _hValue * (2 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));

// Ensure still in bounds for large width/height
_xPos = safezoneX max (_xPos min (safezoneX + safezoneW - _wPos));
_yPos = safeZoneY max (_yPos min (safeZoneY + safezoneH - _hPos));

private _ctrl = (findDisplay 46) ctrlCreate ["RscStructuredText", -2];
_ctrl ctrlSetPosition [_xPos,_yPos,_wPos,_hPos];
_ctrl ctrlSetBackgroundColor [0, 0, 0, 0.10];
_ctrl ctrlCommit 0;

//PLAY INFO LOOP
while {lmf_warmup} do {
	private _title = "<t font='PuristaBold' color='#FFBA26' size='1.3' align='Center'>Briefing Stage</t><br/>";
	private _txt = format ["<t align='Center'>Safe start enabled  (%1)",[time, "MM:SS"] call BIS_fnc_secondsToString];
	private _br = format ["<br/>"];

	private _arsenal = "";
	if (var_personalArsenal) then {_arsenal = "On";} else {_arsenal = "Off";};
	private _personalArsenal = format ["<t color='#FFBA26' size='1.0'align='left'>PERSONAL ARSENAL:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_arsenal];

	private _map = "";
	if (var_playerMaps == 0) then {_map = "All";};
	if (var_playerMaps == 1) then {_map = "Leaders";};
	if (var_playerMaps == 2) then {_map = "None";};
	private _maps = format ["<t color='#ffba26' size='1.0'align='left'>MAPS:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_map];

	private _radio = "";
	if (var_personalRadio) then {_radio = "All";};
	if (!var_personalRadio) then {_radio = "None";};
	private _radios = format ["<t color='#ffba26' size='1.0'align='left'>SQUAD RADIOS:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_radio];

	private _kRole = "";
	private _keepRole = "";
	if (var_keepRole) then {_kRole = "Yes";} else {_kRole = "No";};
	if (typename var_respawnType == "SCALAR") then {
		_keepRole = format ["<t color='#FFBA26' size='1.0'align='left'>KEEP ROLE:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_kRole];
	} else {
		if (var_respawnType == "WAVE") then {
			_keepRole = format ["<t color='#FFBA26' size='1.0'align='left'>KEEP ROLE:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_kRole];
		};
	};

	private _respawn = "";
	private _resp = "";
	private _respT = "";
	if (typename var_respawnType == "STRING") then {
		if (var_respawnType == "OFF") then {
			 _resp = "None";
			 _respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_resp];
		};
		if (var_respawnType == "WAVE") then {
			 _resp = "Wave";
			 _respT = format ["<t color='#ffffff'>%1",[var_respawnTime, "MM"] call BIS_fnc_secondsToString];
			 _respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#ffffff' size='1.0'align='right'>%1 (%2m)</t><br/>",_resp,_respT];
		};
	};
	if (typeName var_respawnType == "SCALAR") then {
		 _resp = "Yes";
		 _respT = var_respawnType;
		 _respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#ffffff' size='1.0'align='right'>%1 (%2s)</t><br/>",_resp,_respT];
	};

	//DISPLAY IT
	_ctrl ctrlSetStructuredText parsetext (_title + _txt + _br + _br + _personalArsenal + _radios + _maps + _respawn + _keepRole);
	sleep 1;
};

//WAIT UNTIL WARMUP IS OVER
waitUntil {!lmf_warmup};

//START MISSION ///////////////////////////////////////////////////////////////////////////////////
//DELETE DISPLAY CONTROL
ctrlDelete _ctrl;

//CLEAR HINT LOOP
hintSilent "";

//COUNTDOWN
for "_i" from 1 to 10 do
{
	systemChat format ["Mission live in %1s",10-_i];
	sleep 1;
};

//ENABLE WEAPONS AND ALLOW DAMAGE
[false] call lmf_admin_fnc_playerSafety;

//MISSION INTRO
lmf_randomColor = selectRandom ["#F09595","#F095E4","#BC95F0","#95C7F0","#95EEF0","#95F0CA","#A9F095","#D6F095","#F0F095","#F0C495"];
[
	[
		[format ["%1", briefingName],"align = 'center' shadow = '1' size = '1.3' font='PuristaBold'","#FFBA26"],
		["","<br/>"],
		[format ["by: "],"align = 'center' shadow = '1' size = '0.55' font='PuristaBold'","#D7DBD5"],
		[format ["%1", var_author],"align = 'center' shadow = '1' size = '0.55' font='PuristaBold'",lmf_randomColor],
		["","<br/>"]
	],safeZoneX+0.0,safeZoneY+0.8
] spawn BIS_fnc_typeText2;