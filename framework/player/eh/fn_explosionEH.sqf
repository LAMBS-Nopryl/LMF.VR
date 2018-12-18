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
_blur ppEffectCommit 1.5;