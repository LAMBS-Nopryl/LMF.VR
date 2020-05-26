// WARMUP SCRIPT //////////////////////////////////////////////////////////////////////////////////
/*
    - Originally by nkenny. Revised by Drgn V4karian.
    - File makes players go through intro, and if enabled warmup.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//DO THE INTRO
waitUntil {time > 0};
cutText  ["", "BLACK FADED", 10, true];
player enableSimulation false;
private _date = str (date select 0);
private _time = [daytime,"HH:MM"] call BIS_fnc_timeToString;
sleep 4;
private _tile = parseText format ["<t font='PuristaBold' color='#FFBA26' size='2' align='Right'>%1, </t><t font='PuristaBold'color='#D7DBD5' size='2' align='Right'>%2",var_location,_date];
[_tile, true, nil, 6, 0.7, 0] spawn BIS_fnc_textTiles;
sleep 8;
waitUntil {!isNil "lmf_warmup"};
cutText  ["", "BLACK IN", 10, true];

player enableSimulation true;

//EXIT IF NO WARMUP OR WARMUP HAS ALREADY ENDED (JIP)
if !(lmf_warmup) exitWith {};

// WARMUP /////////////////////////////////////////////////////////////////////////////////////////
//DISABLE WEAPONS AND DISALLOW DAMAGE
waitUntil {simulationEnabled player};
[true] call lmf_admin_fnc_playerSafety;

//DISPLAY CONTROL
//USE PROFILE SETTINGS FROM CFGUIGRIDS.HPP
private _xPos = profilenamespace getVariable ["IGUI_GRID_ACE_displayText_X", ((safezoneX + safezoneW) - (10 *(((safezoneW / safezoneH) min 1.2) / 10)) - 2.9 *(((safezoneW / safezoneH) min 1.2) / 40))];
private _yPos = profilenamespace getVariable ["IGUI_GRID_ACE_displayText_Y", safeZoneY + 0.175 * safezoneH];
private _wPos =  (14 *(((safezoneW / safezoneH) min 1.2) / 40));
private _hPos = 4.35 * (2 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));

// Ensure still in bounds for large width/height
_xPos = safezoneX max (_xPos min (safezoneX + safezoneW - _wPos));
_yPos = safeZoneY max (_yPos min (safeZoneY + safezoneH - _hPos));

private _ctrl = (findDisplay 46) ctrlCreate ["RscStructuredText", -2];
_ctrl ctrlSetPosition [_xPos,_yPos,_wPos,_hPos];
_ctrl ctrlSetBackgroundColor [0, 0, 0, 0.10];
_ctrl ctrlCommit 0;

//PLAY INFO LOOP
while {lmf_warmup} do {
	private _title = "<t shadow='2' font='PuristaBold' color='#FFBA26' size='1.5' align='Center'>PLANNING STAGE</t><br/>";
	private _txt = format ["<t shadow='2' align='Center'>Safe start enabled  </t><t shadow='2' align='Center' color='#FFBA26'>(%1)</t>",[time, "MM:SS"] call BIS_fnc_secondsToString];
	private _br = format ["<br/>"];

	//BLUE FORCE TRACKER
	private _bft = format ["<t shadow='2' color='#FFBA26' size='1.0'align='left'>Blue Force Tracker:  </t> <t shadow='2' color='#D7DBD5' size='1.0'align='right'>%1</t><br/>",["Off", "Available"] select var_groupTracker];

	//GET MAP
	private _map = "";
	if (var_playerMaps == 0) then {_map = "Everyone";};
	if (var_playerMaps == 1) then {_map = "Leaders";};
	if (var_playerMaps == 2) then {_map = "Nobody";};
	private _maps = format ["<t shadow='2' color='#ffba26' size='1.0'align='left'>Maps:  </t> <t shadow='2' color='#D7DBD5' size='1.0'align='right'>%1</t><br/>",_map];

	//PERSONAL RADIO
	private _radios = format ["<t shadow='2' color='#ffba26' size='1.0'align='left'>Short Range Radios:  </t> <t shadow='2' color='#D7DBD5' size='1.0'align='right'>%1</t><br/>",["Nobody", "Everyone"] select var_personalRadio];

	//KEEP ROLE AFTER RESPAWN
	private _keepRole = format ["<t shadow='2' color='#FFBA26' size='1.0'align='left'>Keep Role On Respawn:  </t> <t shadow='2' color='#D7DBD5' size='1.0'align='right'>%1</t><br/>",["No", "Yes"] select var_keepRole];

	//RESPAWN TYPE
	private _respawn = "";
	if (typename var_respawnType == "SCALAR") then {
		_respawn = format ["<t shadow='2' color='#ffba26' size='1.0'align='left'>Respawn:  </t> <t shadow='2' color='#54f13b' size='1.0'align='right'>Yes (%1s)</t><br/>",var_respawnType];
	} else {
		if (var_respawnType == "OFF") then {
			_respawn = format ["<t shadow='2' color='#ffba26' size='1.0'align='left'>Respawn:  </t> <t shadow='2' color='#f2513c' size='1.0'align='right'>Off</t><br/>"];
		};
		if (var_respawnType == "WAVE") then {
			private _respTime = format ["<t shadow='2' color='#3bc6f0'>%1",[var_respawnTime, "MM"] call BIS_fnc_secondsToString];
			_respawn = format ["<t shadow='2' color='#ffba26' size='1.0'align='left'>Respawn:  </t> <t shadow='2' color='#3bc6f0' size='1.0'align='right'>Wave (%1m)</t><br/>",_respTime];
		};
		if (var_respawnType != "WAVE" && var_respawnType != "OFF") then {
			_respawn = format ["<t shadow='2' color='#ffba26' size='1.0'align='left'>Respawn: </t> <t shadow='2' color='#3bc6f0' size='1.0'align='right'>%1</t><br/>",var_respawnType];
		};
	};

	//DISPLAY IT
	_ctrl ctrlSetStructuredText parsetext (_title + _txt + _br + _br + _bft + _radios + _maps  + _respawn + _keepRole);
	sleep 1;
};

//WAIT UNTIL WARMUP IS OVER
waitUntil {!lmf_warmup};

//COUNTDOWN
_ctrl ctrlSetPosition [_xPos,_yPos,0.42,0.042];
_ctrl ctrlCommit 0;
for "_i" from 0 to 10 do {
	_ctrl ctrlSetStructuredText parsetext format ["<t shadow='2' color='#FFBA26' size='1.0'align='left'>Mission live in: </t><t shadow='2' color='#D7DBD5' size='1.0'align='right'>%1s</t><br/>",10 -_i];
	sleep 1;
};
ctrlDelete _ctrl;

//START MISSION ///////////////////////////////////////////////////////////////////////////////////
//ENABLE WEAPONS AND ALLOW DAMAGE
[false] call lmf_admin_fnc_playerSafety;

//MISSION INTRO
[
	[
		[format ["'%1'", briefingName],"align = 'center' shadow = '2' size = '1.3' font='PuristaBold'","#FFBA26"],
		["","<br/>"],
		[format ["by: "],"align = 'center' shadow = '2' size = '0.55' font='PuristaBold'","#FFBA26"],
		[format ["%1", var_author],"align = 'center' shadow = '2' size = '0.55' font='PuristaBold'","#FFFFFF"],
		["","<br/>"]
	],safeZoneX+0.0,safeZoneY+0.8
] spawn BIS_fnc_typeText2;