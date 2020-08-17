// MEDICAL HELP MESSAGE ///////////////////////////////////////////////////////////////////////////
/*
	- By Alex2k
	- Displays text when your being medically treated by someone.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////

["lmf_medicalHelpMessage", {
	params ["_medic","_patient"];
	if (lifeState _patient == "INCAPACITATED") then {
		private _text1 = format ["<t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.15' align='center'>Someone is helping you</t>"];
		"lmf_medical_feedback_layer_1" cutText [_text1,"PLAIN DOWN",1,true,true];
	} else {
		private _text2 = format ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.15' align='center'>%1 </t><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.15' align='center'>is helping you</t>",name _medic];
		"lmf_medical_feedback_layer_1" cutText [_text2,"PLAIN DOWN",1,true,true];
	};
	[{(_this select 0) setVariable ["lmf_helpMsgActive", false, true];}, [_patient], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

["ace_treatmentSucceded", {
	params ["_medic","_patient"];
	if (_medic == _patient) exitWith {};
	if (!alive _patient) exitWith {};
	if (!isNull findDisplay 38580) exitWith {};
	if !(_patient getVariable ["lmf_helpMsgActive",false]) then {
		["lmf_medicalHelpMessage", [_medic,_patient], _patient] call CBA_fnc_targetEvent;
		_patient setVariable ["lmf_helpMsgActive", true, true];
	};
}] call CBA_fnc_addEventHandler;

["ace_medicalMenuOpened", {
	params ["_medic","_patient"];
	if (_medic == _patient) exitWith {};
	if (!alive _patient) exitWith {};

	private _codeToRun = {
		params ["_medic","_patient"];
			if !(_patient getVariable ["lmf_helpMsgActive",false]) then {
				["lmf_medicalHelpMessage", [_medic,_patient], _patient] call CBA_fnc_targetEvent;
				_patient setVariable ["lmf_helpMsgActive", true, true];
			};
	};
	private _parameters = [_medic,_patient];
	private _exitCode = {};
	private _condition = { !isNull findDisplay 38580 };
	private _delay = 0;
	[{
    	params ["_args", "_handle"];
    	_args params ["_codeToRun", "_parameters", "_exitCode", "_condition"];

    	if (_parameters call _condition) then {
        	_parameters call _codeToRun;
    	} else {
        	_handle call CBA_fnc_removePerFrameHandler;
        	_parameters call _exitCode;
    	};
	}, _delay, [_codeToRun, _parameters, _exitCode, _condition]] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;





/*
["lmf_medicalHelpMessage", lmf_mhm_msg] call CBA_fnc_removeEventHandler;
["ace_treatmentSucceded", lmf_mhm_ts] call CBA_fnc_removeEventHandler;
["ace_medicalMenuOpened", lmf_mhm_mmo] call CBA_fnc_removeEventHandler;

lmf_mhm_msg = ["lmf_medicalHelpMessage", {
	params ["_medic","_patient"];
	if (lifeState _patient == "INCAPACITATED") then {
		private _text1 = format ["<t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.25' align='center'>Someone is helping you</t>"];
		"lmf_medical_feedback_layer_1" cutText [_text1,"PLAIN DOWN",1,true,true];
	} else {
		private _text2 = format ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.25' align='center'>%1 </t><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.25' align='center'>is helping you</t>",name _medic];
		"lmf_medical_feedback_layer_1" cutText [_text2,"PLAIN DOWN",1,true,true];
	};
	[{(_this select 0) setVariable ["lmf_helpMsgActive", false, true];}, [_patient], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

lmf_mhm_ts = ["ace_treatmentSucceded", {
	params ["_medic","_patient"];
	if (_medic == _patient) exitWith {};
	if (!isNull findDisplay 38580) exitWith {};
	if !(_patient getVariable ["lmf_helpMsgActive",false]) then {
		["lmf_medicalHelpMessage", [_medic,_patient], _patient] call CBA_fnc_targetEvent;
		_patient setVariable ["lmf_helpMsgActive", true, true];
	};
}] call CBA_fnc_addEventHandler;

lmf_mhm_mmo = ["ace_medicalMenuOpened", {
	params ["_medic","_patient"];
	if (_medic == _patient) exitWith {};

	private _codeToRun = {
		params ["_medic","_patient"];
			if !(_patient getVariable ["lmf_helpMsgActive",false]) then {
				["lmf_medicalHelpMessage", [_medic,_patient], _patient] call CBA_fnc_targetEvent;
				_patient setVariable ["lmf_helpMsgActive", true, true];
			};
	};
	private _parameters = [_medic,_patient];
	private _exitCode = {};
	private _condition = { !isNull findDisplay 38580 };
	private _delay = 0;
	[{
    	params ["_args", "_handle"];
    	_args params ["_codeToRun", "_parameters", "_exitCode", "_condition"];

    	if (_parameters call _condition) then {
        	_parameters call _codeToRun;
    	} else {
        	_handle call CBA_fnc_removePerFrameHandler;
        	_parameters call _exitCode;
    	};
	}, _delay, [_codeToRun, _parameters, _exitCode, _condition]] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;