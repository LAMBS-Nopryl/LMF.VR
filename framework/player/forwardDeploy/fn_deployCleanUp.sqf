// FORWARD DEPLOY CLEANUP FUNCTION ////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Clean up forward deploy hashtable and updates marker test in case of callsign change.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Example:
	* [] call lmf_player_fnc_deployCleanUp;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(isServer) exitWith {};

private _hashgroups = [lmf_fD_hash] call CBA_fnc_hashKeys;


// CLEAN UP INVALID GROUPS AND MARKERS ////////////////////////////////////////////////////////////
{
	private _key = [lmf_fD_hash,_x] call CBA_fnc_hashGet;
	private _vics = _key select 2;
	private _mrk =_key select 0;
	private _unitAmount = count units _x;

	//IF GROUP EMPTY RELEASE VICS AND DELETE
	if (_unitAmount isEqualTo 0) then {
		{
			_x setVariable ["lmf_deploy_unowned",true,true];
		} forEach _vics;
		[lmf_fD_hash,_x] call CBA_fnc_hashRem;
		deleteMarker _mrk;
	};

	//IF WARMUP HAS ENDED DO THE SAME TO MARKERLESS GROUPS
	if !(lmf_warmup) then {
		if (_mrk isEqualTo "") then {
			{
				_x setVariable ["lmf_deploy_unowned",true,true];
			} forEach _vics;
			[lmf_fD_hash,_x] call CBA_fnc_hashRem;
		};
	};

	//IF MARKER 'ID' DOESN'T MATCH GROUPID UPATE TEXT (ONLY IF KEY STILL EXISTS)
	if !(([lmf_fD_hash,_x] call CBA_fnc_hashGet) isEqualType true) then {
		private _groupID = groupid _x;
		private _mrkID = _mrk select [11,count _mrk]; // 11 as in leave away the mrk_deploy_ part

		if (!(_mrk isEqualTo "") && {!(_groupID isEqualTo _mrkID)}) then {
			private _mrkPos = markerPos _mrk;
			private _mrkDir = markerDir _mrk;
			private _mrkType = markerType _mrk;
			deleteMarker _mrk;

			private _mrkName = format ["mrk_deploy_%1",_groupID];
			private _deploymarker = createMarker [_mrkName,_mrkPos];
			_deploymarker setMarkerType _mrkType;
			_deploymarker setMarkerSize [0.75, 0.75];
			_deploymarker setMarkerColor "ColorWest";
			//_deploymarker setMarkerText format ["%1, Units: %2, Vehicles: %3",_groupID, _unitAmount, count _vics];
			_deploymarker setMarkerText format ["%1",_groupID];
			_deploymarker setMarkerDir _mrkDir;

			[lmf_fD_hash,_x,[_mrkName,_mrkDir,_vics]] call CBA_fnc_hashSet;
		} else {
			//_mrk setMarkerText format ["%1, Units: %2, Vehicles: %3",_groupID, _unitAmount, count _vics];
			_mrk setMarkerText format ["%1",_groupID];
		}
	};

	//REMOVE MARKER ON MISSION START
	if !(lmf_warmup) then {
		[{deleteMarker format ["mrk_deploy_%1",groupId (_this select 0)];},[_x],10] call CBA_fnc_waitAndExecute;
	};
} forEach _hashgroups;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////