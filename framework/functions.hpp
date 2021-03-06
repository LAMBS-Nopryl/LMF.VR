class common {
    tag = "lmf_common";
    class functions {
        file = "framework";
        class sortUnits {};
        class sortGroundVics {};
        class sortAirVics {};
        class sortSupplies {};
    };
};
class ai {
    tag = "lmf_ai";
    class functions {
        file = "framework\ai";
        class initMan {};
        class initVic {};
        class initAir {};
    };
    class eventhandlers {
        file = "framework\ai\eh";
        class killedEH {};
        class suppressEH {};
    };
	class aitasks {
		file = "framework\ai\task";
        class taskSuppress {};
        class taskAssault {};
		class taskAssault_b {};
        class taskUpdateWP {};
        class taskHunt {};
		class taskStatic {};
	};
    class spawning {
        file = "framework\ai\spawning";
        class returnSpawner {};
        class patrol {};
        class garrison {};
        class infantryQRF {};
        class infantryHunter {};
        class vehicleQRF {};
        class paraQRF {};
		class staticQRF {};
		class supplyDrop {};
    };
};
class ai_civ {
    tag = "lmf_ai_civ";
    class functions {
        file = "framework\ai\civ";
        class initCiv {};
    };
    class eventhandlers {
        file = "framework\ai\civ\eh";
        class firedNear {};
    };
};
class player {
	tag = "lmf_player";
	class functions {
		file = "framework\player";
        class initPlayerGear {};
        class initPlayerAir {};
        class initPlayerVic {};
        class initPlayerSupp {};
        class vehicleService {};
        class jipChooseTarget {};
        class jipEmptySeat {};
        class loadoutBriefing {};
        class toeBriefing {};
	};
    class eventhandlers {
		file = "framework\player\eh";
        class explosionEH {};
        class hitEH {};
        class killedEH {};
        class respawnEH {};
	};
	class player_deploy {
		file = "framework\player\forwardDeploy";
		class attachChute {};
		class deployCleanUp {};
		class forwardDeployTroops {};
	};
};
class admin {
	tag = "lmf_admin";
	class functions {
		file = "framework\player\admin";
        class endWarmup {};
        class initPerformance {};
        class performanceCheck {};
        class assignZeus {};
        class respawnWave {};
        class playerSafety {};
        class initPlayerSafety {};
        class endMission {};
        class adminTP {};
        class initAdminTP {};
	};
};
class chat {
    tag = "lmf_chat";
    class functions {
        file = "framework\player\chat";
        class getPlayer {};
        class sendChatMessage {};
    };
};
class diwako_unknownwp {
  tag="diwako_unknownwp";
  class functions {
    file = "framework\shared\diw_unknownwp";
    class init {postInit = 1;};
    class firedEh {};
    class jammedEh {};
    class reloadedEh {};
  };
};
class loadouts {
	tag = "lmf_loadout";
	class functions {
		file = "framework\player\loadouts";
		class platoonLeader {};
		class platoonSergeant {};
        class medic {};
		class rto {};
		class fo {};
		class squadLeader {};
		class teamLeader {};
        class autorifleman {};
		class grenadier {};
		class rifleman {};
		class machineGunner {};
		class machineGunnerAssistant {};
		class atGunner {};
		class atAssistant {};
        class crewLeader {};
        class crewSgt {};
		class crew {};
		class heloPilot {};
		class heloCrew {};
		class pilot {};
	};
};