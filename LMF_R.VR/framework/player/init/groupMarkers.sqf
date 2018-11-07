// GROUP MARKER SCRIPT ////////////////////////////////////////////////////////////////////////////
/*
    - Inspired by the F3 Framework component for group markers, since edited by Drgn V4karian
      with great help from Diwako.
    - File handles group markers + function that are ment to track player groups.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasInterface) exitWith {};

//FUNCTION
private _fnc_group_markers = {
	private _mrks = [];
	{
		//PARAMS
		_x params ["_group",["_color","ColorWEST"],["_txt",""],["_type","b_unknown"],["_size",[1,1]]];

		//CREATE MARKERS
		private _mrk = createMarkerLocal [format ["marker_%1",_group],getPosASL leader _group];
		_mrk setMarkerTypeLocal _type;
		_mrk setMarkerColorLocal _color;
		_mrk setMarkerTextLocal _txt;
		_mrk setmarkerSizeLocal _size;
		_mrk setMarkerAlphaLocal 0;
		if (count units _group > 0) then {_mrk setMarkerAlphaLocal 1;};
		_mrks pushBack [_group,_mrk];
	} forEach _this;

	//UPDATE MARKERS
	for "_i" from 0 to 1 step 0 do {
		{
			_x params ["_group","_mrk"];
			if (count units _group > 0) then {
				_mrk setMarkerPosLocal (getPosASL leader _group);
				_mrk setMarkerAlphaLocal 1;
			};
		} count _mrks;
		sleep 10;
	};
};

private _chooseMarker = {
	private _exists = isClass (configFile >> "CfgMarkers" >> _this#1);
	(_this select _exists)
};

//COLLECT MARKERS
private _markers = [];


// WHICH GROUPS GET TRACKED ///////////////////////////////////////////////////////////////////////
//FOX PLATOON
if !(isNil "Grp_FOX_6") then {_markers pushBack [Grp_FOX_6,var_markerSide,"",["b_hq","LAMBS_FOX_6"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FOX_1") then {_markers pushBack [Grp_FOX_1,var_markerSide,"",["b_inf","LAMBS_FOX_1"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FOX_2") then {_markers pushBack [Grp_FOX_2,var_markerSide,"",["b_inf","LAMBS_FOX_2"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FOX_3") then {_markers pushBack [Grp_FOX_3,var_markerSide,"",["b_inf","LAMBS_FOX_3"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FOX_4") then {_markers pushBack [Grp_FOX_4,var_markerSide,"",["b_inf","LAMBS_FOX_4"] call _chooseMarker,[1,1]]};

//WOLF PLATOON
if !(isNil "Grp_WOLF_6") then {_markers pushBack [Grp_WOLF_6,var_markerSide,"",["b_hq","LAMBS_WOLF_6"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_WOLF_1") then {_markers pushBack [Grp_WOLF_1,var_markerSide,"",["b_inf","LAMBS_WOLF_1"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_WOLF_2") then {_markers pushBack [Grp_WOLF_2,var_markerSide,"",["b_inf","LAMBS_WOLF_2"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_WOLF_3") then {_markers pushBack [Grp_WOLF_3,var_markerSide,"",["b_inf","LAMBS_WOLF_3"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_WOLF_4") then {_markers pushBack [Grp_WOLF_4,var_markerSide,"",["b_inf","LAMBS_WOLF_4"] call _chooseMarker,[1,1]]};

//ARMOR
if !(isNil "Grp_DGR1") then {_markers pushBack [Grp_DGR1,var_markerSide,"",["b_motor_inf","LAMBS_ARMOR_DAGGER_1"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_DGR2") then {_markers pushBack [Grp_DGR2,var_markerSide,"",["b_motor_inf","LAMBS_ARMOR_DAGGER_2"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_DGR3") then {_markers pushBack [Grp_DGR3,var_markerSide,"",["b_motor_inf","LAMBS_ARMOR_DAGGER_3"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_DGR4") then {_markers pushBack [Grp_DGR4,var_markerSide,"",["b_motor_inf","LAMBS_ARMOR_DAGGER_4"] call _chooseMarker,[1,1]]};

if !(isNil "Grp_SWD1") then {_markers pushBack [Grp_SWD1,var_markerSide,"",["b_mech_inf","LAMBS_ARMOR_SWORD_1"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_SWD2") then {_markers pushBack [Grp_SWD2,var_markerSide,"",["b_mech_inf","LAMBS_ARMOR_SWORD_2"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_SWD3") then {_markers pushBack [Grp_SWD3,var_markerSide,"",["b_mech_inf","LAMBS_ARMOR_SWORD_3"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_SWD4") then {_markers pushBack [Grp_SWD4,var_markerSide,"",["b_mech_inf","LAMBS_ARMOR_SWORD_4"] call _chooseMarker,[1,1]]};

if !(isNil "Grp_HMR1") then {_markers pushBack [Grp_HMR1,var_markerSide,"",["b_armor","LAMBS_ARMOR_HAMMER_1"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_HMR2") then {_markers pushBack [Grp_HMR2,var_markerSide,"",["b_armor","LAMBS_ARMOR_HAMMER_2"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_HMR3") then {_markers pushBack [Grp_HMR3,var_markerSide,"",["b_armor","LAMBS_ARMOR_HAMMER_3"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_HMR4") then {_markers pushBack [Grp_HMR4,var_markerSide,"",["b_armor","LAMBS_ARMOR_HAMMER_4"] call _chooseMarker,[1,1]]};

//AIR
if !(isNil "Grp_FLC1") then {_markers pushBack [Grp_FLC1,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FLC2") then {_markers pushBack [Grp_FLC2,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FLC3") then {_markers pushBack [Grp_FLC3,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_FLC4") then {_markers pushBack [Grp_FLC4,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};

if !(isNil "Grp_CDR1") then {_markers pushBack [Grp_CDR1,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_CDR2") then {_markers pushBack [Grp_CDR2,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_CDR3") then {_markers pushBack [Grp_CDR3,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_CDR4") then {_markers pushBack [Grp_CDR4,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};

if !(isNil "Grp_HWK1") then {_markers pushBack [Grp_HWK1,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_HWK2") then {_markers pushBack [Grp_HWK2,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_HWK3") then {_markers pushBack [Grp_HWK3,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_HWK4") then {_markers pushBack [Grp_HWK4,var_markerSide,"",["b_air","LAMBS_HELI"] call _chooseMarker,[1,1]]};

if !(isNil "Grp_EGL1") then {_markers pushBack [Grp_EGL1,var_markerSide,"",["b_plane","LAMBS_PLANE"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_EGL2") then {_markers pushBack [Grp_EGL2,var_markerSide,"",["b_plane","LAMBS_PLANE"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_EGL3") then {_markers pushBack [Grp_EGL3,var_markerSide,"",["b_plane","LAMBS_PLANE"] call _chooseMarker,[1,1]]};
if !(isNil "Grp_EGL4") then {_markers pushBack [Grp_EGL4,var_markerSide,"",["b_plane","LAMBS_PLANE"] call _chooseMarker,[1,1]]};

// EXECUTE FUNCTION ///////////////////////////////////////////////////////////////////////////////
_markers spawn _fnc_group_markers;