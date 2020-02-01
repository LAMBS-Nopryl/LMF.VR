// XEH POST INIT //////////////////////////////////////////////////////////////////////////////////
/*
    - Big thanks to diwako for the help with assembling most of the more complicated code in here.
    - File that handles what happens post init.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
// EVERYONE ///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//DISABLE VARIOUS
enableSentences false;
enableEnvironment [false, true];
enableSaving [false,false];

//ZEUS PINGED EH
["ModuleCurator_F", "initPost", {
    params ["_module"];
    _module addEventHandler ["CuratorPinged", {
        params ["_curator", "_unit"];
        private _zeus = getAssignedCuratorUnit _curator;
        if (isNull _zeus) then {
            unassignCurator _curator;
            deleteVehicle _curator;
        } else {
            if (_zeus == player) then {
                systemChat format ["%1 just pinged", name _unit];
                format ["Ping received by %1!",name player] remoteExec ["systemChat", _unit];
            };
        };
    }];
}, false, [], true] call CBA_fnc_addClassEventHandler;

//ACRE CHANNEL LABLES
[] execVM "framework\shared\init\acreChannelLabels.sqf";

//UNCONSCIOUS EH
["ace_unconscious", {
    params [["_unit", objNull],["_state", false]];
    if (!_state || {!(local _unit)}) exitWith {};

    //PLAYER ONLY
    if (isPlayer _unit) then {
        [{ace_player setUnitTrait ["camouflageCoef",var_camoCoef];}, [], 30] call CBA_fnc_waitAndExecute;
    };

    //PLAYER AND AI (note: This does not work as unconscious state is dependent on vitals. Need a way to FORCE wake up.)
    /*
    [_unit] spawn {
        params [["_unit", objNull]];
        while {alive _unit && {_unit getVariable ["ACE_isUnconscious", false]}} do {
            sleep 5;
            if (30 > random 100) exitWith {
                [_unit, false] call ace_medical_fnc_setUnconscious;
            };
        sleep 10;
        };
    };
    */

}] call CBA_fnc_addEventHandler;



///////////////////////////////////////////////////////////////////////////////////////////////////
// SERVER /////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
if (isServer) then {
    //BROADCAST WARMUP IF ENABLED
    if (var_warmup) then {
        lmf_warmup = true;
        publicVariable "lmf_warmup";
        [] execVM "framework\server\init\resetDate.sqf";
    } else {
        lmf_warmup = false;
        publicVariable "lmf_warmup";
    };

    //CREATE VARIOUS MARKERS
    [] execVM "framework\server\init\markers.sqf";

    //VARIABLE FOR INITPLAYERSAFETY
	lmf_isSafe = false;

    //CREATE A RADIO CHANNEL FOR CHAT COMMANDS
    lmf_chatChannel = radioChannelCreate [[0.9,0.1,0.1,1], "Chat", "Chat", [], true];
    publicVariable "lmf_chatChannel";    
};



///////////////////////////////////////////////////////////////////////////////////////////////////
// AI /////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//'APPLY EVENTHANDLERS' EVENT (To avoid problems with locality change. (thanks Diwako))
["lmf_ai_listener", {
    //PARAMS INITIALLY PASSED FROM LOCAL EVENT IN INITMAN.SQF
    params ["_unit", ["_getSuppression", false]];

    //KILLED EH
    private _id = _unit addEventHandler ["Killed", {
        _this call lmf_ai_fnc_killedEH;
    }];
    _unit setvariable ["lmf_ai_killed_EH", _id];


    //SUPPRESSION EH
    if (_getSuppression) then {
        private _id = _unit addEventHandler ["Fired", {
            _this call lmf_ai_fnc_suppressEH;
        }];
        _unit setvariable ["lmf_ai_suppression_EH", _id];
    };
    _unit setvariable ["lmf_ai_suppression",_getSuppression];

    //LOKAL EH (To remove and reapply all EHs if locality changes.)
    private _id = _unit addEventHandler ["Local", {
        params ["_unit"];
        _unit removeEventHandler ["killed", _unit getVariable ["lmf_ai_killed_EH", -1]];
        if (_unit getVariable ["lmf_ai_suppression_EH" ,-1] >= 0) then {
            _unit removeEventHandler ["Fired", _unit getVariable ["lmf_ai_suppression_EH" ,-1]];
        };
        _unit removeEventHandler ["Local", _unit getVariable ["lmf_ai_local_EH" ,-1]];
        //REAPPLY EHS
        ["lmf_ai_listener", [_unit, _unit getVariable ["lmf_ai_suppression" ,false]], _unit] call CBA_fnc_targetEvent;
    }];
    _unit setvariable ["lmf_ai_local_EH", _id];
}] call CBA_fnc_addEventHandler;

["lmf_ai_civ_listener", {
    params ["_unit"];
    [_unit] call lmf_ai_civ_fnc_initCiv;
}] call CBA_fnc_addEventHandler;

///////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER /////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//MAKE SURE ITS REALLY A PLAYER
if !(hasinterface) exitWith {};
waitUntil {!isNull player};

//GROUP MARKERS
if (var_groupTracker && {!(missionNamespace getVariable ["ace_map_BFT_Enabled",false])}) then {
    [] execVM "framework\player\init\groupTracker.sqf";
};

//UNIT TRACKER
if (var_unitTracker) then {[] execVM "framework\player\init\unitTracker.sqf";};

//TEAM COLORS
[] execVM "framework\player\init\teamColors.sqf";

//PLAYER RATING
player addEventHandler ["HandleRating", {0}];

//EXPLOSION EFFECT
player addEventHandler ["Explosion", {
	_this spawn lmf_player_fnc_explosionEH;
}];

//HIT EFFECT
player addEventHandler ["Hit", {
	_this spawn lmf_player_fnc_hitEH;
}];

//KILLED EH
player addEventHandler ["Killed", {
	_this spawn lmf_player_fnc_killedEH;
}];

//KILLED MESSAGES
["acex_killtracker_death",{
    params ["_killerName", "_killInfo"];
    [{titleText [format ["Died: %1 %2", _this select 0, _this select 1], "PLAIN", 0.5, true,true];}, [_killerName,_killInfo], 4] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

//RESPAWN EH
player addEventHandler ["Respawn", {
    _this spawn lmf_player_fnc_respawnEH;
}];

//DISABLE WAYPOINT MARKERS
if !(var_playerGear) then {
    if ((roleDescription player) find "Helicopter Pilot" >= 0 || {(roleDescription player) find "Fighter Pilot" >= 0}) then {}
    else {
        onMapSingleClick "_shift";
    };
};

//BRIEFING
[] execVM "framework\player\init\briefing.sqf";

//PLAYER GEAR
if (var_playerGear) then {
    [player] call lmf_player_fnc_initPlayerGear;
    player addEventHandler ["InventoryClosed", {
	    params ["_unit", "_container"];
        [_unit,""] call bis_fnc_setUnitInsignia;
	    [_unit,player_insignia] call bis_fnc_setUnitInsignia;
    }];
};

//PLAYER CAMOCOEF
[{player setUnitTrait ["camouflageCoef",var_camoCoef];}, [], 5] call CBA_fnc_waitAndExecute;

//ACE ACTIONS
[] execVM "framework\player\init\aceActions.sqf";

//ARSENAL
if (var_personalArsenal) then {
    [] execVM "framework\player\init\personalArsenal.sqf";
};

//JIP
if (CBA_missionTime > 5*60) then {
    [] execVM "framework\player\init\jipTeleport.sqf";
};

//INTRO + WARMUP
[] execVM "framework\player\init\warmup.sqf";

//ZEUS MODULES
if !(isNil "zen_custom_modules_fnc_register") then {
	[] execVM "framework\player\init\zenModules.sqf";
};

//ARES MODULES
if !(isnil "Ares_fnc_RegisterCustomModule") then {
    [] execVM "framework\player\init\achillesModules.sqf";
};

//CHAT COMMANDS
["lmf_chatMessage", {
    params ["_sender", "_msg", "_type", "_receiver", ["_ping", true]];

    private _args = switch (toLower _type) do {
        case "zeus": {
            [{!(profileName isEqualTo _sender) && !isNull (getAssignedCuratorLogic player)}, format ["(Zeus) %1:", _sender]];
        };
        case "whisper": {
            [{profileName isEqualTo _receiver}, format ["Whisper from %1:", _sender]];
        };
        default {
            [{true}, format ["Notice (%1):", _sender]];
        };
    };
    _args params ["_condition", "_text"];

    if ([] call _condition) then {
        lmf_chatChannel radioChannelAdd [ACE_player];
        lmf_chatChannel radioChannelSetCallsign _text;
        ACE_player customChat [lmf_chatChannel, _msg];
        lmf_chatChannel radioChannelRemove [ACE_player];
        playSound "3DEN_notificationWarning";
    };
}] call CBA_fnc_addEventHandler;

[] execVM "framework\player\init\chatCommands.sqf";

//CHANNEL SETUP
0 enableChannel false;
1 enableChannel true;
2 enableChannel false;
3 enableChannel true;
4 enableChannel false;
5 enableChannel false;

//APPLY TEXTURES TO LAPTOPS
if !(isNil "ammoSpawner") then {ammoSpawner setObjectTexture [0, "framework\fx\supplies.jpg"];};
if !(isNil "airSpawner") then {airSpawner setObjectTexture [0, "framework\fx\airVehicles.jpg"];};
if !(isNil "crateRoles") then {crateRoles setObjectTexture [0, "framework\fx\roles.jpg"];};
if !(isNil "groundSpawner") then {groundSpawner setObjectTexture [0, "framework\fx\groundVehicles.jpg"];};