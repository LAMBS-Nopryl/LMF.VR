// PERFORMANCE CHECK FUNCTION /////////////////////////////////////////////////////////////////////
/*
	- Function to check performance of server and headless (if available).
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (hasinterface && {!isserver}) exitWith {};

params ["_unit"];

//GET FPS FROM SERVER AND HEADLESS
"Checking FPS" remoteExec ["SystemChat",_unit];

for "_i" from 1 to 10 do {
    (format ["%1 has %2 FPS (%3/10)", ["Headless client","Server"] select (isServer),round diag_fps,_i]) remoteExec ["SystemChat",_unit];
    sleep 5;
};