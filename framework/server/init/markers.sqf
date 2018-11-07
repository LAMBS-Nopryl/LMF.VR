// ENTITY MARKERS /////////////////////////////////////////////////////////////////////////////////
/*
    - This file makes the server create markers for special entities that are part of the framework
	  given that they actually exist.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (getMarkerColor "respawn" != "") then {
	_rspMkr = createMarker ["mrk_respawn_inf", getMarkerPos "respawn"];
	_rspMkr setMarkerType "respawn_inf";
	_rspMkr setMarkerSize [0.75,0.75];
	_rspMkr setMarkerColor "ColorBlack";
	_rspMkr setMarkerText "";
	_rspMkr setMarkerAlpha 1;

	"respawn" setMarkerAlpha 0;
};

if !(isNil "crateGearPlt") then {
	_gearSelectMkr = createMarker ["mrk_gearSelect", getPosASL crateGearPlt];
	_gearSelectMkr setMarkerType "b_inf";
	_gearSelectMkr setMarkerSize [0.75,0.75];
	_gearSelectMkr setMarkerColor var_markerSide;
	_gearSelectMkr setMarkerText "";
	_gearSelectMkr setMarkerAlpha 1;
};

if !(isNil "ammoSpawner") then {
	_crateSpawnMkr = createMarker ["mrk_crateSpawn", getPosASL ammoSpawner];
	_crateSpawnMkr setMarkerType "b_service";
	_crateSpawnMkr setMarkerSize [0.75,0.75];
	_crateSpawnMkr setMarkerColor var_markerSide;
	_crateSpawnMkr setMarkerText "";
	_crateSpawnMkr setMarkerAlpha 1;
	};

if !(isNil "groundSpawner") then {
	_vehSpawnMkr = createMarker ["mrk_vehSpawn", getPosASL groundSpawner];
	_vehSpawnMkr setMarkerType "b_motor_inf";
	_vehSpawnMkr setMarkerSize [0.75,0.75];
	_vehSpawnMkr setMarkerColor var_markerSide;
	_vehSpawnMkr setMarkerText "";
	_vehSpawnMkr setMarkerAlpha 1;
};

if !(isNil "airSpawner") then {
	_vehSpawnMkr = createMarker ["mrk_airSpawn", getPosASL airSpawner];
	_vehSpawnMkr setMarkerType "b_air";
	_vehSpawnMkr setMarkerSize [0.75,0.75];
	_vehSpawnMkr setMarkerColor var_markerSide;
	_vehSpawnMkr setMarkerText "";
	_vehSpawnMkr setMarkerAlpha 1;
};

if !(isNil "RRR") then {
	_RRRMkr = createMarker ["mrk_RRR", getPosASL RRR];
	_RRRMkr setMarkerType "b_maint";
	_RRRMkr setMarkerSize [0.75,0.75];
	_RRRMkr setMarkerColor var_markerSide;
	_RRRMkr setMarkerText "";
	_RRRMkr setMarkerAlpha 1;
};

if !(isNil "LAMBS_Hospital") then {
	_HospMkr = createMarker ["mrk_hospital", getPosASL LAMBS_Hospital];
	_HospMkr setMarkerType "b_med";
	_HospMkr setMarkerSize [0.75,0.75];
	_HospMkr setMarkerColor var_markerSide;
	_HospMkr setMarkerText "";
	_HospMkr setMarkerAlpha 1;
};