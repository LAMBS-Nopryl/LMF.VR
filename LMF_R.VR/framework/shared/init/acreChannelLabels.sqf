// ACRE CHANNEL LABELS ////////////////////////////////////////////////////////////////////////////
/*
    - File that sets the channel labels for selected acre LR radios.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _radios = ["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"];

{
	[_x, "default", 1, "label", "1PLT NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 2, "label", "2PLT NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 3, "label", "3PLT NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 4, "label", "CONVOY NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 5, "label", "VEH NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 6, "label", "AIR NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 7, "label", "CAS NET"] call acre_api_fnc_setPresetChannelField;
	[_x, "default", 8, "label", "COY NET"] call acre_api_fnc_setPresetChannelField;
} forEach _radios;

{
	[_x, "default"] call acre_api_fnc_setPreset;
} forEach _radios;