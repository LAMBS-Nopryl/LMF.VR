// RETURN SPAWNER FUNCTION  ///////////////////////////////////////////////////////////////////////
/*
	- This function handles who gets to spawn the AI spawning functions.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
_isSpawner = false;
private _headless = (count entities "HeadlessClient_F") > 0;

if (_headless && {isMultiplayer}) then {
    if (typeOf player == "HeadlessClient_F") then {
        _isSpawner = true;
    };
} else {
    if (isServer) then {
        _isSpawner = true;
    };
};
_isSpawner