// LOADOUT BRIEFING SCRIPT ////////////////////////////////////////////////////////////////////////
/*
	- Function that reads out the players gear and makes a fancy briefing entry about it.
	- originally by BlackHawk (adpated to fit LMF style)
	- https://github.com/unitedoperations/uo_briefingkit
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _textToDisplay = "";

//GET PICTURE FUNCTION
private _getPicture = {
	params ["_name", "_dimensions", ["_type", "CfgWeapons"]];
	if (_name isEqualto "") exitwith {""};
	if !(isText(configFile >> _type >> _name >> "picture")) exitwith {""};
	private _image = getText(configFile >> _type >> _name >> "picture");
	if (_image isEqualto "") then {_image = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";};
	if ((_image find ".paa") isEqualto -1) then {_image = _image + ".paa";};
	format ["<img image='%1' width='%2' height='%3'/>", _image, _dimensions select 0, _dimensions select 1]
};

//GET ROLE NAME
private _lobbyName = if !(((roleDescription player) find "@") isEqualto -1) then {((roleDescription player) splitString "@") select 0} else {roleDescription player};
if (_lobbyName isEqualto "") then {_lobbyName = getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName")};

//START ADDING TO THE BRIEFING TEXT (FIRST INFO LINE)
_textToDisplay = _textToDisplay +
	format ["<img image='\A3\Ui_f\data\GUI\Cfg\Ranks\%4_gs.paa' width='16' height='16'/> <font face='PuristaBold' color='#FFBA26' size='14'>%1 - %2</font><font color='#D7DBD5'> - %3kg</font><br/>",
		name player,
		_lobbyName,
		round ((loadAbs player) *0.1 * 0.45359237 * 10) / 10,
		toLower rank player
	];

//APPARAL PICTURE FUNCTION
private _getApparelPicture = {
	if !(_this isEqualto "") then {
		private _name  = getText(configFile >> "CfgWeapons" >> _this >> "displayName");
		if (_name isEqualto "") then {
			_name = getText(configFile >> "CfgVehicles" >> _this >> "displayName");
		};
		private _pic = [_this, [40, 40]] call _getPicture;
		if (_pic isEqualto "") then {
			_pic = [_this, [40, 40], "CfgVehicles"] call _getPicture;
		};
		_pic + format ["<execute expression='systemChat ""%1""'>*</execute>  ", _name]
	} else {
		""
	};
};

//ADD MORE TEXT TO DISPLAY (APPAREL)
{_textToDisplay = _textToDisplay + (_x call _getApparelPicture)} forEach [uniform player, vest player, backpack player, headgear player];

_textToDisplay = _textToDisplay + "<br/>";

//DISPLAY WEAPON + ATTACHMENTS
private _getWeaponPicture = {
	params ["_weaponName", "_weaponItems"];
	private _str = "";
	if !(_weaponName isEqualto "") then {
		_str = _str + ([_weaponName, [80, 40]] call _getPicture);
		{
			if !(_x isEqualto "") then {
				_str = _str + ([_x, [40, 40]] call _getPicture);
			};
		} forEach _weaponItems;
	};
	_str
};

//DISPLAY ARRAY OF MAGAZINES
private _displayMags = {
	_textToDisplay = _textToDisplay + "  ";
	{
		private _name = _x;
		private _itemCount = {_x isEqualto _name} count _allMags;
		private _displayName = getText(configFile >> "CfgMagazines" >> _name >> "displayName");
		_textToDisplay = _textToDisplay + ([_name, [32,32], "CfgMagazines"] call _getPicture) + format ["<execute expression='systemChat ""%2""'>x%1</execute> ", _itemCount, _displayName];
	} forEach _this;
	_textToDisplay = _textToDisplay + "<br/>";
};

//GET MAGAZINES FOR A WEAPON AND ITS MUZZLES
private _getMuzzleMags = {
	private _result = getArray(configFile >> "CfgWeapons" >> _this >> "magazines");
	{
		if (!(_x isEqualto "this") && {!(_x isEqualto "SAFE")}) then {
			{_result pushBackUnique _x} forEach getArray (configFile >> "CfgWeapons" >> _this >> _x >> "magazines");
		};
	} forEach getArray (configFile >> "CfgWeapons" >> _this >> "muzzles");
	_result = _result apply {toLower _x};
	_result
};

private _sWeaponName = secondaryWeapon player;
private _hWeaponName = handgunWeapon player;
private _weaponName = primaryWeapon player;

//PRIMARY WEAPON
if !(_weaponName isEqualto "") then {
	private _name = getText(configFile >> "CfgWeapons" >> _weaponName >> "displayName");
	_textToDisplay = _textToDisplay + format ["<font face='PuristaBold' color='#A3FFA3'>Primary: </font><font color='#D7DBD5'>%1</font><br/>", _name] + ([_weaponName, primaryWeaponItems player] call _getWeaponPicture);
};

private _allMags = magazines player;
_allMags = _allMags apply {toLower _x};
private _primaryMags = _allMags arrayIntersect (_weaponName call _getMuzzleMags);

_primaryMags call _displayMags;

//SECONDARY
private _secondaryMags = [];
if !(_sWeaponName isEqualto "") then {
	private _name = getText(configFile >> "CfgWeapons" >> _sWeaponName >> "displayName");
	_textToDisplay = _textToDisplay + format ["<font face='PuristaBold' color='#A3FFA3'>Launcher: </font><font color='#D7DBD5'>%1</font><br/>", _name];
	_textToDisplay = _textToDisplay + ([_sWeaponName, secondaryWeaponItems player] call _getWeaponPicture);
	_secondaryMags = _allMags arrayIntersect (_sWeaponName call _getMuzzleMags);
	_secondaryMags call _displayMags;
};

//HANDGUN
private _handgunMags = [];
if !(_hWeaponName isEqualto "") then {
	private _name = getText(configFile >> "CfgWeapons" >> _hWeaponName >> "displayName");
	_textToDisplay = _textToDisplay + format ["<font face='PuristaBold' color='#A3FFA3'>Sidearm: </font><font color='#D7DBD5'>%1</font><br/>", _name];
	_textToDisplay = _textToDisplay + ([_hWeaponName, handgunItems player] call _getWeaponPicture);
	_handgunMags = _allMags arrayIntersect (_hWeaponName call _getMuzzleMags);
	_handgunMags call _displayMags;
};

_allMags = _allMags - _primaryMags;
_allMags = _allMags - _secondaryMags;
_allMags = _allMags - _handgunMags;

private _radios = [];
private _allItems = items player;

{
	if !((toLower _x) find "acre_" isEqualto -1) then {
		_radios pushBack _x;
	};
} forEach _allItems;
_allItems = _allItems - _radios;

_textToDisplay = _textToDisplay + format ["<font face='PuristaBold' color='#A3FFA3'>Magazines and items: </font><font color='#D7DBD5'>(Click count for info.)</font><br/>"];

//DISPLAY RADIOS THEN MAGAZINES AND LAST INVENTORY AND ASSSIGNED ITEMS
{
	_x params ["_items", "_cfgType"];
	while {count _items > 0} do {
		private _name = _items select 0;
		private _itemCount = {_x isEqualto _name} count _items;
		private _displayName = getText(configFile >> _cfgType >> _name >> "displayName");
		_textToDisplay = _textToDisplay + ([_name, [32,32], _cfgType] call _getPicture) + format ["<execute expression='systemChat ""%2""'>x%1</execute>  ", _itemCount, _displayName];
		_items = _items - [_name];
	};
} forEach [[_radios, "CfgWeapons"], [_allMags, "CfgMagazines"], [_allItems, "CfgWeapons"], [(assignedItems player) - ["ItemRadioAcreFlagged"], "CfgWeapons"]];

//FINISH IT OFF WITH WARNING ABOUT ACCURACY
_textToDisplay = _textToDisplay + "<br/><br/></font><font color='#D7DBD5'>This page is only accurate at mission start.</font>";

player createDiaryRecord ["Diary",["  Starting Kit",_textToDisplay]];