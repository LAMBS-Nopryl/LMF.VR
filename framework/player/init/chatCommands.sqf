///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	Adds various CBA chat commands to player/registered admins.
	Originally made by cuel, altered by G4rrus.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//ADMIN COMMANDS
["heal", {
	params [["_name", ""]];
	private _unit = _name call lmf_chat_fnc_getPlayer;
	if (isNull _unit) exitWith {systemChat "Could not find unit"};

	[player] call ace_medical_treatment_fnc_fullHealLocal;
	_unit setDamage 0;
	systemChat format ["Fully healed %1.", name _unit];
}, "admin"] call CBA_fnc_registerChatCommand;

["goto", {
	params [["_name", ""]];
	private _unit = _name call lmf_chat_fnc_getPlayer;
	if (isNull _unit) exitWith {systemChat "Could not find unit"};

	moveOut ACE_player;
	ACE_player setPos (_unit modelToWorld [0, -2, 0]);
	systemChat format ["Teleported to %1.", name _unit];
}, "admin"] call CBA_fnc_registerChatCommand;

["bring", {
	params [["_name", ""]];
	private _unit = _name call lmf_chat_fnc_getPlayer;
	if (isNull _unit) exitWith {systemChat "Could not find unit"};

	moveOut _unit;
	_unit setVelocity [0,0,0];
	_unit setPos (ACE_player modelToWorld [0, 1, 0]);
	systemChat format ["Teleported %1 to you.", name _unit];
}, "admin"] call CBA_fnc_registerChatCommand;

//CLIENT COMMANDS
["w", {
    params [["_str", ""]];
    private _split = (_str splitString " ");
    private _to = _split param [0, ""];
    _split deleteAt 0;
    private _msg = _split joinString " ";
    if (_to isEqualTo "" || _msg isEqualTo "") exitWith {systemChat "Invalid arguments"};

    private _receiver = [_to] call lmf_chat_fnc_getPlayer;
    if (isNull _receiver) exitWith {systemChat "Could not find receiver"};
    [_msg, "whisper", name _receiver] call lmf_chat_fnc_sendChatMessage;
}, "all",false] call CBA_fnc_registerChatCommand;

["zeus", {
    params [["_msg", ""]];
    _msg = [_msg] call CBA_fnc_trim;
    if (_msg isEqualTo "") exitWith {};
    [_msg, "zeus"] call lmf_chat_fnc_sendChatMessage;
}, "all",false] call CBA_fnc_registerChatCommand;