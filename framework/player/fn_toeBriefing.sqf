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
	private _role = roleDescription _x;
	if (_role find "@" >= 0) then {
		private _indexToAt = ([_role, "@"] call CBA_fnc_find) - 1;
		_role = [_role, 0, _indexToAt] call CBA_fnc_substring;
	};

	//IF NEW GROUP
	if (_grp != _grp2) then {
		_brf_platoon = _brf_platoon + "<br/><font face='PuristaBold' color='#A3E0FF'>" + _id + "<br/></font>";
	};

	//ENTRY FOR SOLDIER
	_brf_platoon = _brf_platoon + " <font color='#D7DBD5'>- " + _role + ": " +  name _x + "</font><br/>";

	//UPDATE OLD
	_grp2 = _grp;
} foreach (playableUnits + switchableUnits);

private _text = format ["
<font face='PuristaBold' color='#FFBA26' size='16'>OVERVIEW</font><br/>
<font color='#D7DBD5'>
	- Unit strength is <font color='#FFBA26'>%1<font color='#D7DBD5'> pax.<br/><br/>
</font color>
<font face='PuristaBold' color='#FFBA26' size='16'>ELEMENTS</font>
%2<br/>
",count (switchableUnits + playableUnits - entities 'HeadlessClient_F'),_brf_platoon];

_text