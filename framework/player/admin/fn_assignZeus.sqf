// ASSIGN ZEUS FUNCTION ///////////////////////////////////////////////////////////////////////////
/*
	- Function to assign zeus.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//CREATE AND ASSIGN ZEUS IF UNIT DOES NOT ALREADY HAVE ONE
if (isNull (getAssignedCuratorLogic _unit)) exitWith {
	private _grp = createGroup [sideLogic, true];
	private _curator = _grp createUnit ["ModuleCurator_F",[0,0,0],[],0,"NONE"];
	_curator setVariable ["Addons",3,true];

	_curator addCuratorEditableObjects [(allMissionObjects "Man"), false];
	_curator addCuratorEditableObjects [(allMissionObjects "Air"), true];
	_curator addCuratorEditableObjects [(allMissionObjects "Car"), true];
	_curator addCuratorEditableObjects [(allMissionObjects "Ammo"), false];
	_curator setVariable ["birdType",""];
	_curator setvariable ["owner","objnull"];
	_curator setVariable ["showNotification",false];
	_curator setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"];
	[_curator, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes;

	_unit assignCurator _curator;
};