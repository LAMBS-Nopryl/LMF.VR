// PLAYER BRIEFING ////////////////////////////////////////////////////////////////////////////////
/*
	- Minimally rewritten by Drgn V4karian, most code originally by nkenny.
	- File that handles player briefing. Collects data from cfg_Briefing.sqf.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\settings\cfg_Briefing.sqf"

//FUNCTION TO COLLECT AND FORMAT STRING FROM CFG_BRIEFING CORRECLTY
private _collect = {
	_lines = _this;
	private _newline = "";
	{
		_newline = _newline + " - " + _x + "</font><br/>";
	} foreach _lines;
	_newline
};


// ADMIN TOOLS (only added after map screen) //////////////////////////////////////////////////////
[] spawn {
	sleep 5;
	player createDiarySubject ["Admin","LMF"];

	player creatediaryrecord ["Admin",["Info", format ["
	<font face='PuristaBold' color='#FFBA26' size='16'>LAMBS MISSION FRAMEWORK</font><br/>
	<font color='#D7DBD5'>Version: %1</font color><br/>
	", var_version]]];

	player creatediaryrecord ["Admin",["Admin", format ["
	<font face='PuristaBold' color='#FFBA26' size='16'>ADMIN TOOLS</font><br/>
	<font color='#D7DBD5'>This will only work if you are an admin or whitelisted as one.</font color><br/><br/>

	<font color='#A3FFA3'>START MISSION:</font><br/>
	<execute expression='[player] call lmf_admin_fnc_endWarmup'> - Press here to start the mission</execute><br/><br/>

	<font color='#66CBFF'>RESPAWN:</font><br/>
	<execute expression='[player] call lmf_admin_fnc_respawnWave'> - Press here to trigger a respawn wave</execute><br/><br/>

	<font color='#66CBFF'>ZEUS:</font><br/>
	<execute expression='[player] remoteExec [""lmf_admin_fnc_assignZeus"",2]'> - Press here to get zeus access</execute><br/><br/>

	<font color='#66CBFF'>PERFORMANCE:</font><br/>
	<execute expression='[player] remoteExec [""lmf_admin_fnc_initPerformance"",2]'> - Press here to check server/headless FPS</execute><br/><br/>

	<font color='#db4343'>END MISSION:</font><br/>
	<execute expression='[player, true] call lmf_admin_fnc_endMission'> - Press here to end mission: COMPLETED</execute><br/>
	<execute expression='[player, false] call lmf_admin_fnc_endMission'> - Press here to end mission: FAILED</execute>
	"]]];
};


// TESTERS ////////////////////////////////////////////////////////////////////////////////////////
if (_testers != "") then {
player createDiaryrecord ["Diary",["  Credits",format ["
<font color='#D7DBD5'>%1</font color>
",_testers]]];
};


// TO/E ///////////////////////////////////////////////////////////////////////////////////////////
//INIT
private _grp2 = grpNull;
private _brf_platoon = "";

{
	//GET INFO
	private _grp = group _x;
	private _id = groupID group _x;
	private _role = roleDescription _x;
	if (_role find "@" >= 0) then {
		private _indexToAt = ([_role, "@"] call CBA_fnc_find) - 1;
		_role = [_role, 0, _indexToAt] call CBA_fnc_substring;
	};

	//IF NEW GROUP
	if (_grp != _grp2) then {
		_brf_platoon = _brf_platoon + "<br/><font face='PuristaBold' color='#66CBFF'>" + _id + "<br/></font>";
	};

	//ENTRY FOR SOLDIER
	_brf_platoon = _brf_platoon + " <font color='#D7DBD5'>- " + _role + ": " +  name _x + "</font><br/>";

	//UPDATE OLD
	_grp2 = _grp;

} foreach (playableUnits + switchableUnits);

//APPLY
player creatediaryrecord ["Diary",["  TO/E",format ["
<font face='PuristaBold' color='#FFBA26' size='16'>OVERVIEW</font><br/>
<font color='#D7DBD5'>
	- This page is only accurate at mission start.<br/>
	- Unit strength is <font color='#FFBA26'>%1<font color='#D7DBD5'> pax.<br/><br/>
</font color>
<font face='PuristaBold' color='#FFBA26' size='16'>ELEMENTS</font>
%2<br/>
",count (switchableUnits + playableUnits - entities 'HeadlessClient_F'),_brf_platoon]]];

/*
// SIGNALS ////////////////////////////////////////////////////////////////////////////////////////
player createDiaryrecord ["Diary",["  Signals",format ["
<font face='PuristaBold' color='#FFBA26' size='16'>LONG RANGE NETS</font><br/>
<font color='#A3FFA3'>Channel 01:		</font> <font color='#D7DBD5'>1st Platoon</font color><br/>
<font color='#A3FFA3'>Channel 02:		</font> <font color='#D7DBD5'>2nd Platoon</font color><br/>
<font color='#A3FFA3'>Channel 03:		</font> <font color='#D7DBD5'>3rd Platoon</font color><br/>
<font color='#A3FFA3'>Channel 04:		</font> <font color='#D7DBD5'>Company</font color><br/>
<font color='#A3FFA3'>Channel 06:		</font> <font color='#D7DBD5'>Air</font color><br/>
<br/>

<font face='PuristaBold' color='#FFBA26' size='16'>SHORT RANGE: 1st Platoon</font><br/>
<font color='#A3FFA3'>Channel 06:		</font color> <font color='#D7DBD5'>Platoon HQ</font color><br/>
<font color='#A3FFA3'>Channel 01:		</font color> <font color='#D7DBD5'>1st Squad</font color><br/>
<font color='#A3FFA3'>Channel 02:		</font color> <font color='#D7DBD5'>2nd Squad</font color><br/>
<font color='#A3FFA3'>Channel 03:		</font color> <font color='#D7DBD5'>3rd Squad</font color><br/>

<font face='PuristaBold' color='#FFBA26' size='16'>SHORT RANGE: 2nd Platoon</font><br/>
<font color='#A3FFA3'>Channel 06:		</font color> <font color='#D7DBD5'>Platoon HQ</font color><br/>
<font color='#A3FFA3'>Channel 01:		</font color> <font color='#D7DBD5'>1st Squad</font color><br/>
<font color='#A3FFA3'>Channel 02:		</font color> <font color='#D7DBD5'>2nd Squad</font color><br/>
<font color='#A3FFA3'>Channel 03:		</font color> <font color='#D7DBD5'>3rd Squad</font color><br/>

<font face='PuristaBold' color='#FFBA26' size='16'>SHORT RANGE: 3rd Platoon</font><br/>
<font color='#A3FFA3'>Channel 06:		</font color> <font color='#D7DBD5'>Platoon HQ</font color><br/>
<font color='#A3FFA3'>Channel 01:		</font color> <font color='#D7DBD5'>1st Squad</font color><br/>
<font color='#A3FFA3'>Channel 02:		</font color> <font color='#D7DBD5'>2nd Squad</font color><br/>
<font color='#A3FFA3'>Channel 03:		</font color> <font color='#D7DBD5'>3rd Squad</font color>
"]]];
*/

// BRIEFING ///////////////////////////////////////////////////////////////////////////////////////
player creatediaryrecord ["Diary",[format ["OPORD"],format ["
<font face='PuristaBold' color='#FFBA26' size='16'>SITUATION:</font><br/>
%1
<br/><br/><font face='PuristaBold' color='#D7DBD5'>Enemy Forces:</font><br/>
%2
<br/><font face='PuristaBold' color='#D7DBD5'>Friendly Forces:</font><br/>
%3
<br/><font face='PuristaBold' color='#D7DBD5'>Other Considerations:</font><br/>
%4
<br/><font face='PuristaBold' size='16' color='#FFBA26'>MISSION:</font><br/>
%5
<br/><br/><font face='PuristaBold' size='16' color='#FFBA26'>EXECUTION:</font><br/>
%6
<br/><font face='PuristaBold' size='16' color='#FFBA26'>ADMINISTRATION:</font><br/>
%7
",_brf_situation,_brf_enemy call _collect,_brf_friend call _collect,_brf_remarks call _collect,_brf_mission,_brf_execution call _collect,_brf_administration call _collect]]];