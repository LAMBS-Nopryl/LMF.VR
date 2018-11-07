// TEAM COLOR SCRIPT //////////////////////////////////////////////////////////////////////////////
/*
	- by Alex2k, revised by Drgn V4karian.
	- In here colors are assigned to players.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {time > 5};

private _unitStr = str player;
if ((_unitStr find "_RED") != -1) exitWith {
	player assignTeam "RED";
};

if ((_unitStr find "_BLUE") != -1) exitWith {
	player assignTeam "BLUE";
};

if ((_unitStr find "_GREEN") != -1) exitWith {
	player assignTeam "GREEN";
};

if ((_unitStr find "_YELLOW") != -1) exitWith {
	player assignTeam "YELLOW";
};

if ((_unitStr find "_WHITE") != -1) exitWith {
	player assignTeam "MAIN";
};