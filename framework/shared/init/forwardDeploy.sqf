// FORWARD DEPLOY /////////////////////////////////////////////////////////////////////////////////
/*
	- Originally by Alex2k, rewritten by G4rrus
	- Creates events and ace actions around being able to forward deploy troops and their marked assets.
	- Forward deploy will commence (with a slight delay) at the end of the warmup/briefing stage.
	- var_deployHeight determines if it is a ground forward deploy or an airdrop.
	- Assets that shall be claimable must be marked before this script executes (it executes post init)
	- You can mark assets to be claimable by for example putting 'this setVariable ["lmf_deploy_unowned",true];'
	  in their init in the editor.
	- This requires the briefing stage component.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(var_forwardDeploy) exitWith {};


// SERVER STUFF ///////////////////////////////////////////////////////////////////////////////////
if (isServer) then {
	//CREATE HASH TABLE ON SERVER
	lmf_fD_hash = [[],true] call CBA_fnc_hashCreate;

	//UPDATE HASH TABLE EVENT
	["lmf_deploy_updateHashEvent",{
		params [
			["_group",grpNull],
			["_mrkName",""],
			["_vehicle",objNull],
			["_isDelete",false]
		];

		private _key = [lmf_fD_hash,_group] call CBA_fnc_hashGet;
		private _vics = [];
		private _dir = markerDir _mrkName;

		if !(_key isEqualType true) then {
			_vics = _key select 2;
		};

		//UNREGISTER
		if (isNull _vehicle && {_isDelete}) exitWIth {
			{
				_x setVariable ["lmf_deploy_unowned",true,true];
			} forEach _vics;
			[lmf_fD_hash,_group] call CBA_fnc_hashRem;
			deleteMarker (_key select 0);
		};

		//VEHICLE
		if !(isNUll _vehicle) then {
			if !(_key isEqualType true) then { //asking again here to avoid overriding existing markers with "" in a zone registering.
				_mrkName = _key select 0;
				_dir = _key select 1;
			};
			if (_isDelete) then {
				_vics = _vics - [_vehicle];
				_vehicle setVariable ["lmf_deploy_unowned",true,true];
			} else {
				if (_vehicle getVariable ["lmf_deploy_unowned",true] isEqualType true) then {
					_vics pushBackUnique _vehicle;
					_vehicle setVariable ["lmf_deploy_unowned",_group,true];
				};
			};
		};

		//UPDATE KEY
		[lmf_fD_hash,_group,[_mrkName,_dir,_vics]] call CBA_fnc_hashSet;
	}] call CBA_fnc_addEventHandler;

	//CLEANUP LOOP
	[{
		[] call lmf_player_fnc_deployCleanUp;
		if !(lmf_warmup) then {
			[(_this select 1)] call CBA_fnc_removePerFrameHandler;
			["lmf_deploy_initiateDeploy",[]] call CBA_fnc_localEvent;
		};
	},5,[]] call CBA_fnc_addPerFrameHandler;

	["lmf_deploy_initiateDeploy", {
		["lmf_deploy_removeActions",[]] call CBA_fnc_globalEvent;

		//WORK OUT THE HASH DATA AND PASS IT TO FUNCTION
		private _hashgroups = [lmf_fD_hash] call CBA_fnc_hashKeys;
		private _paraParams = [];
		{
			private _key = [lmf_fD_hash,_x] call CBA_fnc_hashGet;
			private _info = [_x,_key];
			_paraParams pushBack _info;
		} forEach _hashgroups;
		[{
			[_this select 0,var_deployHeight] call lmf_player_fnc_forwardDeployTroops;
		},[_paraParams], 8] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_addEventHandler;
};


// PLAYER /////////////////////////////////////////////////////////////////////////////////////////
if !(hasInterface) exitWith {};

waitUntil {!isNil "lmf_warmup"};
if !(lmf_warmup) exitWith {};

//EVENTS
["lmf_deploy_removeActions", {
	cutText ["","BLACK OUT",4,true];

	[player,1,["ACE_SelfActions","lmf_deploy_register"]] call ace_interact_menu_fnc_removeActionFromObject;
	[player,1,["ACE_SelfActions","lmf_deploy_unregister"]] call ace_interact_menu_fnc_removeActionFromObject;
	{
		[_x,0,["ACE_MainActions","lmf_deploy_register_vic"]] call ace_interact_menu_fnc_removeActionFromObject;
		[_x,0,["ACE_MainActions","lmf_deploy_unregister_vic"]] call ace_interact_menu_fnc_removeActionFromObject;
	} forEach lmf_drop_vehiclesToRegister;

	[{
		cutText ["","BLACK IN",4,true];
		["vehicle",lmf_deploy_vehicleExitEH] call CBA_fnc_removePlayerEventHandler;
	}, [], 12] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

//GET OUT OF CLAIMED VEHICLE
lmf_deploy_vehicleExitEH = ["vehicle",{
    params ["_unit", "_newVehicle", "_oldVehicle"];
    private _variable = _newVehicle getVariable "lmf_deploy_unowned";
	if !(isNil "_variable") exitWith {
		moveOut player;
		//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>Cannot enter deployable vehicle yet!</t>","PLAIN",0.3,false,true];
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>WARNING</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Can't enter deployable vehicle yet</t>", "PLAIN", 0.3, false, true];
	};
},false] call CBA_fnc_addPlayerEventHandler;

//STATEMENTS PLAYER
private _statement_register = {
	//EXIT IF NOT READY
	if !("ItemMap" in (assignedItems player)) exitWith {
		//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>You need a map to enter the forward deploy menu!</t>","PLAIN",0.3,false,true];
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>UNAVAILABLE</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>You need a map to enter the deploy menu</t>", "PLAIN", 0.3, false, true];
	};

	//OPEN MAP AND INFORM
	openMap true;
	private _mapText = format ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6' align='left'>FORWARD DEPLOY</t><br/><t shadow='2' color='#D7DBD5' size='1.2' align='left'>- Left-click to register/move deploy position.</t><br/><t shadow='2' color='#D7DBD5' size='1.2' align='left'>- Shift + Left-Click to rotate zone towards cursor.<br/><t shadow='2' color='#D7DBD5' size='1.2' align='left'>- Exit Map to confirm placement."];
	"lmf_deploy_layer" cutText [_mapText,"PLAIN",1.5,true,true];

	//MAP CLICK EH
	private _mapClickEH_deploy = addMissionEventHandler ["MapSingleClick",{
		params ["_units","_pos","_alt","_shift"];

		private _grp = group player;
		if !(player isEqualTo leader _grp) exitWith {
			openMap false;
		};

		private _mrkName = format ["mrk_deploy_%1",player];
		private _grpID = groupId _grp;

		if (markerText _mrkName isEqualTo "") exitWith {
			private _mrkType = ["mil_arrow","mil_start"] select (var_deployHeight < 200);
			lmf_deploymarker = createMarker [_mrkName,_pos];
			lmf_deploymarker setMarkerType _mrkType;
			lmf_deploymarker setMarkerSize [0.75, 0.75];
			lmf_deploymarker setMarkerColor "ColorWest";
			lmf_deploymarker setMarkerText format ["%1",_grpID];
		};

		if !(_shift) then {
			lmf_deploymarker setMarkerPos _pos;
			lmf_deploymarker setMarkerText format ["%1",_grpID];
		} else {
			private _mrkPos = getMarkerPos lmf_deploymarker;
			lmf_deploymarker setMarkerDir (_mrkPos getDir _pos);
		};
	}];

	//IF MAP WAS CLOSED REMOVE EH (IF LEADERSHIP HAS CHANGED ACT ACCORDINGLY)
	[{
		!visibleMap
	},{
		removeMissionEventHandler ["MapSingleClick",(_this select 0)];
		"lmf_deploy_layer" cutText ["","PLAIN",0.01,true];
		if !(isNil "lmf_deploymarker") then {
			_grp = group player;
			if (player isEqualTo leader _grp) then {
				private _grpID = groupId _grp;
				private _mrkName = format ["mrk_deploy_%1",_grpID];
				private _mrkPos = markerPos lmf_deploymarker;
				private _mrkDir = markerDir lmf_deploymarker;
				private _mrkType = markerType lmf_deploymarker;
				deleteMarker lmf_deploymarker;
				private _lmf_deploymarkerR = createMarker [_mrkName,_mrkPos];
				_lmf_deploymarkerR setMarkerDir _mrkDir;
				_lmf_deploymarkerR setMarkerType _mrkType;
				_lmf_deploymarkerR setMarkerSize [0.75, 0.75];
				_lmf_deploymarkerR setMarkerColor "ColorWest";
				_lmf_deploymarkerR setMarkerText format ["%1",_grpID];

				["lmf_deploy_updateHashEvent",[_grp,_lmf_deploymarkerR,objNull,false]] call CBA_fnc_serverEvent;
				_grp setVariable ["lmf_deploy_unregistered",false,true];
				//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>Group registered for deployment.</t>","PLAIN",0.3,false,true];
				//titleText ["<t font='PuristaBold' shadow='2' color='#54f23c' size='2'>DEPLOY</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Group ready for deployment</t>", "PLAIN", 0.3, false, true];
				private _t1 = format ["<t font='PuristaBold' shadow='2' color='#54f23c' size='2'>DEPLOY</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>%1 ready for deployment</t>",_grpID];
				titleText [_t1, "PLAIN", 0.3, false, true];
			} else {
				deleteMarker lmf_deploymarker;
				//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>You are no longer the leader of your group!</t>","PLAIN",0.3,false,true];
				titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>WARNING</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>You are no longer the leader of your group</t>", "PLAIN", 0.3, false, true];
			};
		};
	},[
		_mapClickEH_deploy
	]] call CBA_fnc_waitUntilAndExecute;
};

private _statement_unregister = {
	private _grp = group player;
	["lmf_deploy_updateHashEvent",[_grp,"",objNull,true]] call CBA_fnc_serverEvent;
	_grp setVariable ["lmf_deploy_unregistered",true,true];
	private _t3 = format ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>DEPLOY</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>%1 will not be deployed</t>",groupID _grp];
	titleText [_t3, "PLAIN", 0.3, false, true];
};

//CONDITIONS PLAYER
private _condition_register = {
	player isEqualTo (leader group player) && {!visibleMap && {(group player) getVariable ["lmf_deploy_unregistered",true]}}
};

private _condition_unregister = {
	player isEqualTo (leader group player) && {!visibleMap && {!((group player) getVariable ["lmf_deploy_unregistered",true])}}
};

//PLAYER ACTIONS
private _icon = ["\A3\ui_f\data\map\vehicleicons\iconParachute_ca.paa","\A3\ui_f\data\map\vehicleicons\iconTruck_ca.paa"] select (var_deployHeight < 200);

private _registerGroup = ["lmf_deploy_register","Register Forward Deploy",_icon,_statement_register,_condition_register] call ace_interact_menu_fnc_createAction;
private _unregisterGroup = ["lmf_deploy_unregister","Unregister Forward Deploy",_icon,_statement_unregister,_condition_unregister] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions"],_registerGroup] call ace_interact_menu_fnc_addActionToObject;
[player,1,["ACE_SelfActions"],_unregisterGroup] call ace_interact_menu_fnc_addActionToObject;

//VEHICLE ACTIONS
lmf_drop_vehiclesToRegister = [];
{
	private _variable = _x getVariable "lmf_deploy_unowned";
	if !(isNil "_variable") then {
		lmf_drop_vehiclesToRegister pushBackUnique _x;
	};
} forEach vehicles;

//STATEMENTS VEHICLE
private _statement_register_vic = {
	params ["_target","_player","_params"];

	private _variable = _target getVariable ["lmf_deploy_unowned",true];
	if (_variable isEqualType true) then {
		//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>Vehicle registered.</t>","PLAIN",0.3,false,true];
		titleText ["<t font='PuristaBold' shadow='2' color='#54f23c' size='2'>VEHICLE DEPLOY</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Vehicle ready for deployment</t>", "PLAIN", 0.3, false, true];
		["lmf_deploy_updateHashEvent",[group player,"",_target,false]] call CBA_fnc_serverEvent;
	} else {
		private _text = format ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>UNAVAILABLE</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>This vehicle is already owned by %1</t>",groupId _variable];
		titleText [_text,"PLAIN",0.3,false,true];
	};
};

private _statement_unregister_vic = {
	["lmf_deploy_updateHashEvent",[group player,"",_target,true]] call CBA_fnc_serverEvent;
	//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>Vehicle unregistered.</t>","PLAIN",0.3,false,true];
	titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>VEHICLE DEPLOY</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Vehicle will not be deployed</t>", "PLAIN", 0.3, false, true];
};

//CONDITIONS VEHICLE
private _condition_register_vic = {
	player isEqualTo (leader group player) && {!((_target getVariable ["lmf_deploy_unowned",true]) isEqualTo (group player))}
};

private _condition_unregister_vic = {
	player isEqualTo (leader group player) && {((_target getVariable ["lmf_deploy_unowned",true]) isEqualTo (group player))}
};

private _registerVic = ["lmf_deploy_register_vic","Claim Vehicle",_icon,_statement_register_vic,_condition_register_vic] call ace_interact_menu_fnc_createAction;
private _unregisterVic = ["lmf_deploy_unregister_vic","Unclaim Vehicle",_icon,_statement_unregister_vic,_condition_unregister_vic] call ace_interact_menu_fnc_createAction;

{
	[_x,0,["ACE_MainActions"],_registerVic] call ace_interact_menu_fnc_addActionToObject;
	[_x,0,["ACE_MainActions"],_unregisterVic] call ace_interact_menu_fnc_addActionToObject;
} forEach lmf_drop_vehiclesToRegister;