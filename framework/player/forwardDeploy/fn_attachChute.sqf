// ATTACH PARACHUTE ///////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus (I mean really the code is a combo between what BI does and what ACE does)
	* ^ BIS_fnc_curatorObjectEdited and ace_cargo_fnc_paradropItem
	* Spawn a parachute depending on if its a soldier or 'object' and move target into the parachute or attach
	  item to the parachute. Also CBA waitUntil until the object is almost at the ground then attach passed
	  optional item onto the object (also detach object from parachute cuz additional safety won't hurt).
	* Note: Needs to be called on the Server.
	*
	* Arguments:
	* 0: Object <OBJECT>
	* 1: Position <ARRAY>
	* 2: Direction <NUMBER>
	* 3: Item <STRING>
	*
	* Example:
	* [cursorObject,[0,0,0],0,"SmokeshellYellow"] call lmf_player_fnc_attachChute;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [
	["_object",objNull,[objNull]],
	["_pos",[0,0,0],[[]],3],
	["_dir",0,[123]],
	["_attachedItem","",[""]]
];

if (!isServer || {isNull _object}) exitWith {};


// DEPLOY /////////////////////////////////////////////////////////////////////////////////////////
//PLAYER (don't use setPos when it comes to parachute stuff as they close!)
if (_object isKindOf "CAManBase") exitWith {
	private _parachute = createVehicle ["Steerable_Parachute_F",_pos,[],0,"CAN_COLLIDE"];
	_parachute setDir _dir;

	_object moveInAny _parachute;
};

//OBJECTS
private _attachPoint = [[0,0,(abs ((boundingbox _object select 0) select 2))],[0,0,1]] select (_object isKindOf "ReammoBox_F");
private _parachute = createVehicle ["B_Parachute_02_F",_pos,[],0,"CAN_COLLIDE"];
_parachute setDir _dir;
private _velocity = velocity _object;

_object attachto [_parachute,_attachPoint];
_parachute setVelocity _velocity;

[{
	private _object = _this select 0;
	(getPosATL _object) select 2 < 1 || {isNull _object}
},{
	params ["_object","_item"];

	if (isNull _object) exitWith {};

	detach _object;

	if !(_item isEqualTo "") then {
		private _pos = getPosATL _object;
		private _thing = createVehicle [_item,[_pos select 0,_pos select 1,0],[],0,"CAN_COLLIDE"];
	};
},[
	_object,_attachedItem
],600] call CBA_fnc_waitUntilAndExecute;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////