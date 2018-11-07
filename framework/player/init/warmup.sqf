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
private _location = "Location: " + worldname;
sleep 4;
titleText [format ["<t color='#FFBA26' size='5'>%1</t><br/><t color='#D7DBD5' size='3'>%2</t><br/><t color='#D7DBD5' size='2'>%3</t>",briefingName,_date,_location], "PLAIN", 1.2, true,true];
sleep 8;
waitUntil {!isNil "lmf_warmup"};
cutText  ["", "BLACK IN", 10, true];

player enableSimulation true;

//EXIT IF NO WARMUP OR WARMUP HAS ALREADY ENDED (JIP)
if !(lmf_warmup) exitWith {};


// WAMRUP /////////////////////////////////////////////////////////////////////////////////////////
//DISABLE WEAPONS AND DISALLOW DAMMAGE
waitUntil {simulationEnabled player};
[true] call lmf_admin_fnc_playerSafety;


//PLAY INFO LOOP
while {lmf_warmup} do {
	private _title = "<t font='PuristaBold' color='#FFBA26' size='1.3' align='Center'>Mission Briefing Stage</t><br/>";
	private _txt = format ["<t align='Center'>Safe start enabled  (%1)",[time, "MM:SS"] call BIS_fnc_secondsToString];
	private _br = format ["<br/>"];

	private _jipTP = "";
	if (var_jipTP) then {_jipTP = "On";} else {_jipTP = "Off";};
	private _jipTeleport = format ["<t color='#FFBA26' size='1.0'align='left'>JIP TELEPORT:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_jipTP];

	private _grpMrk = "";
	if (var_groupMarkers) then {_grpMrk = "On";} else {_grpMrk = "Off";};
	private _groupMarkers = format ["<t color='#FFBA26' size='1.0'align='left'>GROUP MARKERS:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_grpMrk];

	private _unitMrk = "";
	if (var_unitTracker) then {_unitMrk = "On";} else {_unitMrk = "Off";};
	private _unitMarkers = format ["<t color='#FFBA26' size='1.0'align='left'>UNIT MARKERS:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_unitMrk];

	private _camoCoef = str var_camoCoef;
	private _camoCoefficient = format ["<t color='#FFBA26' size='1.0'align='left'>PLAYER CAMO-COEFF:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_camoCoef];

	private _resp = "";
	if (typename var_respawnType == "STRING") then {
		if (var_respawnType == "WAVE") then {_resp = "Wave";} else {_resp = "Off";};
	};
	if (typename var_respawnType == "SCALAR") then {_resp = var_respawnType};
	private _respawn = format ["<t color='#FFBA26' size='1.0'align='left'>RESPAWN:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_resp];


	//DISPLAY IT
	hintSilent parseText (_title + _txt + _br + _br + _respawn + _jipTeleport + _camoCoefficient + _groupMarkers + _unitMarkers);
	sleep 1;
};

//WAIT UNTIL WARMUP IS OVER
waitUntil {!lmf_warmup};

//START MISSION ///////////////////////////////////////////////////////////////////////////////////


//CLEAR HINT LOOP
hintSilent "";

//COUNTDOWN
for "_i" from 1 to 10 do
{
	systemChat format ["Mission live in %1s",10-_i];
	sleep 1;
};

//ENABLE WEAPONS AND ALLOW DAMMAGE
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