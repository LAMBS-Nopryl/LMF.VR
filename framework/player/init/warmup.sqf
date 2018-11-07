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
//USE PROFILE SETTINGS FROM CFGUIGRIDS.HPP
private _xPos = profilenamespace getVariable ["IGUI_GRID_ACE_displayText_X", ((safezoneX + safezoneW) - (10 *(((safezoneW / safezoneH) min 1.2) / 10)) - 2.9 *(((safezoneW / safezoneH) min 1.2) / 40))];
private _yPos = profilenamespace getVariable ["IGUI_GRID_ACE_displayText_Y", safeZoneY + 0.175 * safezoneH];
private _wPos =  (14 *(((safezoneW / safezoneH) min 1.2) / 40));
private _hPos = 4.2 * (2 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));

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

	//PERSONAL ARSENAL
	private _personalArsenal = format ["<t color='#FFBA26' size='1.0'align='left'>PERSONAL ARSENAL:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",["Off", "On"] select var_personalArsenal];

	//GET MAP
	private _map = "";
	if (var_playerMaps == 0) then {_map = "All";};
	if (var_playerMaps == 1) then {_map = "Leaders";};
	if (var_playerMaps == 2) then {_map = "None";};
	private _maps = format ["<t color='#ffba26' size='1.0'align='left'>MAPS:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",_map];

	//PERSONAL RADIO
	private _radios = format ["<t color='#ffba26' size='1.0'align='left'>SQUAD RADIOS:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",["None", "All"] select var_personalRadio];

	//KEEP ROLE AFTER RESPAWN
	private _keepRole = format ["<t color='#FFBA26' size='1.0'align='left'>KEEP ROLE:  </t> <t color='#ffffff' size='1.0'align='right'>-</t><br/>"];
	if (typeName var_respawnType == "SCALAR" || {var_respawnType == "WAVE"}) then {
		_keepRole = format ["<t color='#FFBA26' size='1.0'align='left'>KEEP ROLE:  </t> <t color='#ffffff' size='1.0'align='right'>%1</t><br/>",["No", "Yes"] select var_keepRole];
	};

	//RESPAWN TYPE
	private _respawn = "";
	if (typename var_respawnType == "SCALAR") then {
		_respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#ffffff' size='1.0'align='right'>Yes (%1s)</t><br/>",var_respawnType];
	} else {
		if (var_respawnType == "OFF") then {
			_respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#ffffff' size='1.0'align='right'>None</t><br/>"];
		};
		if (var_respawnType == "WAVE") then {
			private _respTime = format ["<t color='#ffffff'>%1",[var_respawnTime, "MM"] call BIS_fnc_secondsToString];
			_respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#ffffff' size='1.0'align='right'>Wave (%1m)</t><br/>",_respTime];
		};
	};

	//DISPLAY IT
	_ctrl ctrlSetStructuredText parsetext (_title + _txt + _br + _br + _personalArsenal + _radios + _maps + _respawn + _keepRole);
	sleep 1;
};

//WAIT UNTIL WARMUP IS OVER
waitUntil {!lmf_warmup};


//START MISSION ///////////////////////////////////////////////////////////////////////////////////
//DELETE DISPLAY CONTROL WITH BRIEFING INTRO
ctrlDelete _ctrl;

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