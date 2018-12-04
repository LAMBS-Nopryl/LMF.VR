// ACRE SIGNAL CALC by diwako ////////////////////////////////////////////////////////////////////////////
/*
    Enables custom signal strength setting mid mission.
	Example:
	Exec this globally in debug console to boost receive or send power times 2
	There is still a max range as this just feeds new values into the original acre function

	player setVariable ["acre_send_power",2,true];
	player setVariable ["acre_receive_power",2,true];

	Of course you can crank up that number as much as you like
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if(!hasInterface) exitWith {};

private _customSignalFunc = {
	params ["_f", "_mW", "_receiverClass", "_transmitterClass"];

	private _count = missionNamespace getVariable [_transmitterClass + "_running_count", 0] max 0;
	if (_count == 0) then {
		private _mWnew = _mW;
		private _txAntennas = [_transmitterClass] call acre_sys_components_fnc_findAntenna;
		private _sender = _txAntenna select 0 select 1;

		if(!isNil "_sender" && {!isNull _sender}) then {
			_mWnew = _mWnew * (_sender getVariable ["acre_send_power",1]);
		} else {
			if (_mW > 0) then {
				diag_log "Warning possible ACRE error: Could not find sender!";
				diag_log format["_transmitterClass: %1 | _receiverClass: %2 | _frequency: %3 | _mW: %4",_transmitterClass,_receiverClass,_f,_mW];
			};
		};

		_mWnew = _mWnew * (acre_player getVariable ["acre_receive_power",1]);

		/*==== begin ACRE2 base logic ====*/

		private _rxAntennas = [_receiverClass] call acre_sys_components_fnc_findAntenna;
		//private _txAntennas = [_transmitterClass] call acre_sys_components_fnc_findAntenna;

		{
			private _txAntenna = _x;
			{
				private _rxAntenna = _x;
				_count = _count + 1;
				private _id = format["%1_%2_%3_%4", _transmitterClass, (_txAntenna select 0), _receiverClass, (_rxAntenna select 0)];
				[
					"process_signal",
					[
						_id,
						(_txAntenna select 2),
						(_txAntenna select 3),
						(_txAntenna select 0),
						(_rxAntenna select 2),
						(_rxAntenna select 3),
						(_rxAntenna select 0),
						_f,
						_mWnew, // custom radio power
						acre_sys_signal_terrainScaling,
						diag_tickTime,
						ACRE_SIGNAL_DEBUGGING,
						acre_sys_signal_omnidirectionalRadios
					],
					true,
					acre_sys_signal_fnc_handleSignalReturn,
					[_transmitterClass, _receiverClass]
				] call acre_sys_core_fnc_callExt;
			} forEach _rxAntennas;
		} forEach _txAntennas;
		missionNamespace setVariable [_transmitterClass + "_running_count", _count];
	};

	private _maxSignal = missionNamespace getVariable [_transmitterClass + "_best_signal", -992];
	private _Px = missionNamespace getVariable [_transmitterClass + "_best_px", 0];

	if (ACRE_SIGNAL_DEBUGGING > 0) then {
		private _signalTrace = missionNamespace getVariable [_transmitterClass + "_signal_trace", []];
		_signalTrace pushBack _maxSignal;
		missionNamespace setVariable [_transmitterClass + "_signal_trace", _signalTrace];
	};

	[_Px, _maxSignal]
};
[_customSignalFunc] call acre_api_fnc_setCustomSignalFunc;