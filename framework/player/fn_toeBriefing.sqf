// TO/E BRIEFING SCRIPT ///////////////////////////////////////////////////////////////////////////
/*
	- Function that figures out player team composition and returns it in formated text.
	- originally by nkenny (adapted by G4rrus) (...and mangled by Alex2k)
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _grp2 = grpNull;
private _brf_platoon = "";

private _allUniqueGroups = [];
{

    _allUniqueGroups pushBackUnique [(groupId (group _x)),(group _x)];
} forEach ([] call CBA_fnc_players);
_allUniqueGroups sort true;

{
	//GET INFO
	private _grp = _x select 1;
	private _id = groupID _grp;

	//IF NEW GROUP
	if (_grp != _grp2) then {
		_brf_platoon = _brf_platoon + "<br/><font face='PuristaBold' color='#FFBA26' size='16'>" + _id + "<br/></font>";
	};

	//ENTRY FOR SOLDIER
	{
		_brf_platoon = _brf_platoon + format ["<img image='\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa' color='#FFFFFF' width='16' height='16'/>",toLower rank _x];
		_brf_platoon = _brf_platoon + " <font color='#FFFFFF'> " +  name _x + "</font><br/>";
	} forEach (units _grp);

	//UPDATE OLD
	_grp2 = _grp;
} forEach _allUniqueGroups;

//REMOVE LAST LINEBREAK
_brf_platoon = _brf_platoon select [0,count _brf_platoon - 5];

//GET ROLE NAME
private _lobbyName = if !(( (player getVariable "lmf_currentRole") find "@") isEqualto -1) then {( (player getVariable "lmf_currentRole") splitString "@") select 0} else {(player getVariable "lmf_currentRole")};
if (_lobbyName isEqualto "") then {_lobbyName = getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName")};

private _text = format ["
<br/><font face='PuristaBold' color='#FFBA26' size='16'>OVERVIEW</font><br/>
<font color='#FFFFFF'>
Rank: <font color='#FFBA26'>%5<font color='#FFFFFF'><br/>
Role: <font color='#FFBA26'>%3<font color='#FFFFFF'><br/>
Group: <font color='#FFBA26'>%4<font color='#FFFFFF'><br/><br/>
</font color>
%2
",count ([] call CBA_fnc_players),_brf_platoon,_lobbyName,groupID group player,rank player,name player];

_text