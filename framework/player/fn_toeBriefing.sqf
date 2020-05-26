// TO/E BRIEFING SCRIPT ///////////////////////////////////////////////////////////////////////////
/*
	- Function that figures out player team composition and returns it in formated text.
	- originally by nkenny (adapted by G4rrus)
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _grp2 = grpNull;
private _brf_platoon = "";

{
	//GET INFO
	private _grp = group _x;
	private _id = groupID group _x;

	//IF NEW GROUP
	if (_grp != _grp2) then {
		_brf_platoon = _brf_platoon + "<br/><font face='PuristaBold' color='#FFBA26' size='16'>" + _id + "<br/></font>";
	};

	private _icon = "";
	if ((squadParams _x #0 #1) == "LAMBS") then { _icon = "\a3\Modules_F_Curator\Data\portraitAnimalsSheep_ca.paa"; };
	private _color = "#abab00";
	//private _color2 = selectRandom ["#8f090f","#7d3fbf","#317dcc","#36940c","#abab00"];
	if ((squadParams _x #0 #5) == "Officer") then {_color = "#a11017"};
	if ((squadParams _x #0 #5) == "Sergeant") then {_color = "#8a4acf"};
	if ((squadParams _x #0 #5) == "Corporal") then {_color = "#317dcc"};
	if ((squadParams _x #0 #5) == "Grunt") then {_color = "#36940c"};

	//ENTRY FOR SOLDIER
	_brf_platoon = _brf_platoon + format ["<img image='%1' color='%2' width='16' height='16'/>",_icon,_color];
	_brf_platoon = _brf_platoon + format [" <img image='\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa' color='#D7DBD5' width='16' height='16'/>",toLower rank _x];
	if (_x == player) then {
		if (squadParams _x isEqualTo []) then {
			_brf_platoon = _brf_platoon + " <font color='#FFBA26'> " +  name _x + " (Recruit/no XML)" + "</font><br/>";
		} else {
			if ((squadParams _x #0 #1) == "LAMBS") then {
				_brf_platoon = _brf_platoon + " <font color='#FFBA26'> " +  name _x + "</font><br/>";
			} else {
				_brf_platoon = _brf_platoon + " <font color='#FFBA26'> " +  name _x + " (Recruit/no XML)" + "</font><br/>";
			};
		};
	} else {
		if (squadParams _x isEqualTo []) then {
			_brf_platoon = _brf_platoon + " <font color='#D7DBD5'> " +  name _x + " (Recruit/no XML)" + "</font><br/>";
		} else {
			if ((squadParams _x #0 #1) == "LAMBS") then {
				_brf_platoon = _brf_platoon + " <font color='#D7DBD5'> " +  name _x + "</font><br/>";
			} else {
				_brf_platoon = _brf_platoon + " <font color='#D7DBD5'> " +  name _x + " (Recruit/no XML)" + "</font><br/>";
			};
		};
	};

	//UPDATE OLD
	_grp2 = _grp;
} foreach ([] call CBA_fnc_players);

//REMOVE LAST LINEBREAK
_brf_platoon = _brf_platoon select [0,count _brf_platoon - 5];

//GET ROLE NAME
private _lobbyName = if !((lmf_currentRole find "@") isEqualto -1) then {(lmf_currentRole splitString "@") select 0} else {lmf_currentRole};
if (_lobbyName isEqualto "") then {_lobbyName = getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName")};

private _text = format ["
<br/><font face='PuristaBold' color='#FFBA26' size='16'>OVERVIEW</font><br/>
<font color='#D7DBD5'>
	- You are a <font color='#FFBA26'>%3<font color='#D7DBD5'> in <font color='#FFBA26'>%4<font color='#D7DBD5'>.<br/>
	- Your rank is <font color='#FFBA26'>%5<font color='#D7DBD5'>.<br/><br/>
</font color>
%2
",count ([] call CBA_fnc_players),_brf_platoon,_lobbyName,groupID group player,rank player];

_text