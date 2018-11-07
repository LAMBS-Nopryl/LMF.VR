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
        class taskUpdateWP {};
        class taskHunt {};
	};
    class spawning {
        file = "framework\ai\spawning";
        class returnSpawner {};
        class patrol {};
        class garrison {};
        class infantryQRF {};
        class infantryHunter {};
        class vehicleQRF {};
    };
};
class server {
	tag = "lmf_server";
	class functions {
		file = "framework\server";
        class spectatorChannel {};
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
	};
    class eventhandlers {
		file = "framework\player\eh";
        class explosionEH {};
        class hitEH {};
        class killedEH {};
        class respawnEH {};
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