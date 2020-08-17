// SUPPLY DROP ////////////////////////////////////////////////////////////////////////////////////
/*
	- Originally by Alex2k, 'revised' by G4rrus
	- Creates events and ace actions around being able to call in a plane or helicopter to drop a
	  supply drop at a specified clicked location. Works together with supply crate system.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//SERVER
if (isServer) then {
	if (markerColor "respawn" isEqualTo "") then {
		systemChat "LMF Supply Drop: 'respawn' marker required!";
	};

	lmf_remainingSuppDrops = var_supplyDropLimit;
	publicVariable "lmf_remainingSuppDrops";

	["lmf_supplyDropEventServer", {
		if (missionNamespace getVariable ["lmf_SupplyDropActive",false]) exitWith {};
		params ["_dropPos","_crate"];

		private _plane = var_suppDropPlane;

		//CALCULATE SPAWNPOS
		private _initPos = getMarkerPos "respawn";
		private _dir = _dropPos getDir _initPos;
		_spawnPos = _initPos getPos [random 5000,_dir];
		if (_spawnPos distance2D _dropPos < 5000) then {
			_spawnPos = _initPos getPos [5000,_dir];
		};

		[_spawnPos,_dropPos,_plane,_crate] spawn lmf_ai_fnc_supplyDrop;

		lmf_SupplyDropActive = true;
		publicVariable "lmf_SupplyDropActive";
		lmf_remainingSuppDrops = lmf_remainingSuppDrops - 1;
		publicVariable "lmf_remainingSuppDrops";

		if (lmf_remainingSuppDrops isEqualTo 0) then {
			["lmf_supplyDropEventClient",[]] call CBA_fnc_globalEvent;
		};

		//ARBITRARY 60 SECOND COOLDOWN
		[{lmf_SupplyDropActive = false; publicVariable "lmf_SupplyDropActive"},[],60] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_addEventHandler;
};

//PLAYER
if !(hasInterface) exitWith {};

//JIP
waitUntil {!isNil "lmf_remainingSuppDrops"};
if (lmf_remainingSuppDrops isEqualTo 0) exitWith {};

["lmf_supplyDropEventClient", {
	if !(var_supLarge isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop","lmf_supp_ammoLarge"]] call ace_interact_menu_fnc_removeActionFromObject;};
	if !(var_supSmall isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop","lmf_supp_ammoSmall"]] call ace_interact_menu_fnc_removeActionFromObject;};
	//if !(var_supSpecial isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop","lmf_supp_ammoSpecial"]] call ace_interact_menu_fnc_removeActionFromObject;};
	if !(var_supExplosives isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop","lmf_supp_ammoExplosive"]] call ace_interact_menu_fnc_removeActionFromObject;};
	if !(var_supMedical isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop","lmf_supp_ammoMedic"]] call ace_interact_menu_fnc_removeActionFromObject;};
	//[player,1,["ACE_SelfActions","parentSupplyDrop","lmf_supp_ammoMedic"]] call ace_interact_menu_fnc_removeActionFromObject;	
	[player,1,["ACE_SelfActions","parentSupplyDrop"]] call ace_interact_menu_fnc_removeActionFromObject;
}] call CBA_fnc_addEventHandler;


// ACE ACTIONS ////////////////////////////////////////////////////////////////////////////////////
private _statement = {
    params ["_target","_player","_params"];

	//EXIT IF NOT READY
	if !("ItemMap" in (assignedItems player)) exitWith {
		//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>You need a map to call supplies!</t>","PLAIN",0.3,false,true];
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>UNAVAILABLE</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>You need a map</t>", "PLAIN", 0.3, false, true];
	};

	private _radios = ["ACRE_PRC148","ACRE_PRC152","ACRE_PRC77","ACRE_PRC117F","ACRE_SEM70"];
	if (_radios findIf {[player, _x] call acre_api_fnc_hasKindOfRadio} == -1) exitWith {
		//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>You need a long-range radio to call supplies!</t>","PLAIN",0.3,false,true];
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>UNAVAILABLE</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>You need a long-range radio</t>", "PLAIN", 0.3, false, true];
	};

	if (missionNamespace getVariable ["lmf_SupplyDropActive", false]) exitWith {
		//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>Supply drop currently active!</t>","PLAIN",0.3,false,true];
		titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>UNAVAILABLE</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Supply drop already in progress</t>", "PLAIN", 0.3, false, true];
	};

	//OPEN MAP AND INFORM
	openMap true;
	private _mapText = format ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6' align='left'>SUPPLY DROP</t><br/><t shadow='2' color='#D7DBD5' size='1.2' align='left'>- Click map to select drop zone for supplies.</t><br/><t shadow='2' color='#D7DBD5' size='1.2' align='left'>- Close map to exit 'deploy-mode'.</t>"];
	"lmf_suppLayer_1" cutText [_mapText,"PLAIN",1.5,true,true];

	//GLOBAL VAR FOR CURRENT SUP (only way to get it into the map EH)
	lmf_chosenSuppDrop = _params select 0;

	//MAP CLICK EH
	private _mapClickEH_SupplyDrop = addMissionEventHandler ["MapSingleClick",{
		params ["_units","_pos"];

		//MARKER AT POS
		private _deploymarker = createMarkerLocal ["lmf_marker_suppDrop",_pos];
		_deploymarker setMarkerTypeLocal "selector_selectedMission";
		_deploymarker setMarkerSizeLocal [0.75, 0.75];
		_deploymarker setMarkerColorLocal "ColorOrange";

		[_thisEventHandler,_pos] spawn {
			params ["_thisEventHandler","_pos"];

			//DISTANCE CALC
			private _distance = _pos distance2D (getMarkerPos "respawn");

			//TIME CALC (72 = traveltime for 5km at 250km/h, 69.44 = m/s at 250km/H) (5km will be the minimum but also the max random additional distance)
			private _time = 72 + (_distance/69.44);

			//CONFIRMATION MESSAGE BOX
			private _delayText = [_time,"MM"] call BIS_fnc_secondsToString;
			private _confirmText = format ["Call supply drop to this position?<br/> - ETA: %1 minute(s).<br/> - %2x supply drop(s) available.",_delayText,lmf_remainingSuppDrops];
			private _result = [_confirmText,"CONFIRM","YES","NO"] call BIS_fnc_guiMessage;

			//EXIT IF CONFIRMED
			if (_result) exitWith {
				//EXIT IF IN THE MEANWHILE SOMEONE WAS FASTER
				if (missionNamespace getVariable ["lmf_SupplyDropActive",false]) exitWith {
					//titleText ["<t font='PuristaBold' shadow='2' color='#FFBA26' size='1.6'>Supply drop already active!</t>","PLAIN",0.3,true,true];
					titleText ["<t font='PuristaBold' shadow='2' color='#F2513C' size='2'>UNAVAILABLE</t><br/><t font='PuristaBold' shadow='2' color='#FFFFFF' size='1.5'>Supply drop already in progress</t>", "PLAIN", 0.3, false, true];
					deleteMarkerLocal "lmf_marker_suppDrop";
					openMap false;
				};

				removeMissionEventHandler ["MapSingleClick",_thisEventHandler];

				["lmf_supplyDropEventServer",[_pos,lmf_chosenSuppDrop]] call CBA_fnc_serverEvent;
				"lmf_suppLayer_1" cutText ["","PLAIN",0.01,true];

				[{deleteMarkerLocal "lmf_marker_suppDrop"},[],10] call CBA_fnc_waitAndExecute;
			};

			//DELETE MARKER OTHERWISE
			deleteMarkerLocal "lmf_marker_suppDrop";
		};
	}];

	//IF MAP WAS CLOSED REMOVE EH
	[{
		!visibleMap
	},{
		removeMissionEventHandler ["MapSingleClick",(_this select 0)];
		"lmf_suppLayer_1" cutText ["","PLAIN",0.01,true];
	},[
		_mapClickEH_SupplyDrop
	]] call CBA_fnc_waitUntilAndExecute;
};

private _parentSupplyDrop = ["parentSupplyDrop","Call Supply Drop","",{true},{!visibleMap && {player isEqualTo (leader group player)}}] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions"],_parentSupplyDrop] call ace_interact_menu_fnc_addActionToObject;

private _dropLarge = ["lmf_supp_ammoLarge","Supplies Large","\A3\ui_f\data\map\vehicleicons\iconCrateAmmo_ca.paa",_statement,{true},{},[var_supLarge]] call ace_interact_menu_fnc_createAction;
private _dropSmall = ["lmf_supp_ammoSmall","Supplies Small","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",_statement,{true},{},[var_supSmall]] call ace_interact_menu_fnc_createAction;
//private _dropSpec = ["lmf_supp_ammoSpecial","Crate Special","\A3\modules_f\data\portraitModule_ca.paa",_statement,{true},{},[var_supSpecial]] call ace_interact_menu_fnc_createAction;
private _dropExplo = ["lmf_supp_ammoExplosive","Explosives","\A3\ui_f\data\map\vehicleicons\pictureExplosive_ca.paa",_statement,{true},{},[var_supExplosives]] call ace_interact_menu_fnc_createAction;
private _dropMed = ["lmf_supp_ammoMedic","Medical Supplies","\A3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa",_statement,{true},{},[var_supMedical]] call ace_interact_menu_fnc_createAction;

if !(var_supLarge isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop"],_dropLarge] call ace_interact_menu_fnc_addActionToObject;};
if !(var_supSmall isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop"],_dropSmall] call ace_interact_menu_fnc_addActionToObject;};
//if !(var_supSpecial isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop"],_dropSpec] call ace_interact_menu_fnc_addActionToObject;};
if !(var_supExplosives isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop"],_dropExplo] call ace_interact_menu_fnc_addActionToObject;};
if !(var_supMedical isEqualTo "") then {[player,1,["ACE_SelfActions","parentSupplyDrop"],_dropMed] call ace_interact_menu_fnc_addActionToObject;};
//[player,1,["ACE_SelfActions","parentSupplyDrop"],_dropMed] call ace_interact_menu_fnc_addActionToObject;