// PLAYER HIT EFFECT EH ///////////////////////////////////////////////////////////////////////////
/*
	- This function applies a ppEffect if the player is hit.
	- Effect by Drgn V4karian and Alex2k.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

//EXIT IF NOT ALIVE
if !(alive _unit) exitWith {};

//APPLY EFFECT
private _blur = ppEffectCreate ["dynamicBlur", 401];
_blur ppEffectEnable true;
_blur ppEffectAdjust [7];
_blur ppEffectCommit 0;
_blur ppEffectAdjust [0.0];
_blur ppEffectCommit 1.25;

if (50 > random 100) then {
	private _blink = ppEffectCreate ["colorCorrections", 1501];
	_blink ppEffectEnable true;
	_blink ppEffectAdjust [1,1,0,[0,0,0,1],[1,1,1,1],[0.33,0.33,0.33,0],[0.25,0.25,0,0,0,0,4]];
	_blink ppEffectCommit 0;

		private _h1 = 0.24;
		private _h2 = 0.24;
		for "_i" from 0 to 75 step 1 do {
			_h1 = _h1 + 0.01;
			_h2 = _h2 + 0.01;
			_blink ppEffectAdjust [1,1,0,[0,0,0,1],[1,1,1,1],[0.33,0.33,0.33,0],[_h1,_h2,0,0,0,0,4]];
			_blink ppEffectCommit 0;
			sleep 0.01;
		};
	_blink ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
	_blink ppEffectCommit 0;
};