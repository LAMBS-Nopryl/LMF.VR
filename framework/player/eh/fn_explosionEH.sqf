// PLAYER EXPLOSION EFFECT EH /////////////////////////////////////////////////////////////////////
/*
	- This function applies a ppEffect if the player is injured by an explosion and lives.
	- Effect by Alex2k.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

//EXIT IF NOT ALIVE
if (vehicle _unit != _unit || {!alive _unit}) exitWith {};

//APPLY EFFECT
private _blur = ppEffectCreate ["dynamicBlur", 402];
_blur ppEffectEnable true;
_blur ppEffectAdjust [10];
_blur ppEffectCommit 0;
_blur ppEffectAdjust [0.0];
_blur ppEffectCommit 1.25;

private _blink = ppEffectCreate ["colorCorrections", 1501];
_blink ppEffectEnable true;
_blink ppEffectAdjust [1,1,0,[0,0,0,1],[1,1,1,1],[0.33,0.33,0.33,0],[0.25,0.25,0,0,0,0,4]];
_blink ppEffectCommit 0;

private _h1 = 0.34;
private _h2 = 0.04;
for "_i" from 0 to 75 step 1 do {
	_h1 = _h1 + 0.01;
	_h2 = _h2 + 0.01;
	_blink ppEffectAdjust [1,1,0,[0,0,0,0.95],[1,1,1,1],[0.33,0.33,0.33,0],[_h1,_h2,0,0,0,0,5]];
	_blink ppEffectCommit 0;
	sleep 0.01;
};
_blink ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,5]];
_blink ppEffectCommit 0;